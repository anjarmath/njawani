package com.anjarmath.njawani;

import android.app.Activity;
import android.content.Context;
import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;
import android.graphics.Bitmap;
import android.util.Log;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tflite.client.TfLiteInitializationOptions;
import com.google.android.gms.tflite.gpu.GpuDelegate;
import com.google.android.gms.tflite.gpu.support.TfLiteGpu;
import com.google.android.gms.tflite.java.TfLite;

import org.opencv.core.Point;
import org.opencv.core.Scalar;
import org.opencv.core.Size;
import org.opencv.imgproc.Imgproc;
import org.tensorflow.lite.InterpreterApi.Options.TfLiteRuntime;

import org.opencv.android.Utils;
import org.opencv.core.Core;
import org.opencv.core.Mat;
import org.tensorflow.lite.InterpreterApi;
import org.tensorflow.lite.gpu.GpuDelegateFactory;
import org.tensorflow.lite.gpu.*;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Array;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.concurrent.Executor;

public class objectDetectorClass<task> {
    private InterpreterApi interpreter;
    private List<String> labelList;
    private int INPUT_SIZE;
    private int PIXEL_SIZE = 3;
    private float IMAGE_MEAN = 127.5f;
    private float IMAGE_STD = 127.5f;
    private GpuDelegate gpuDelegate;
    private String TAG = "MainActivity";
    private String label = "Tak ada apapun";
    Context context;
    TextView tv;

    objectDetectorClass (Context mcontext, TextView textView, AssetManager assetManager, String modelpath, String labelpath, int inputSize) throws IOException {
        context = mcontext;
        INPUT_SIZE = inputSize;
        Task<Boolean> useGpuTask = TfLiteGpu.isGpuDelegateAvailable(context);

        Task<Void> initializeTask = useGpuTask.continueWithTask(task -> {
            boolean isGpuAvailable = task.getResult();
            TfLiteInitializationOptions.Builder builder = TfLiteInitializationOptions.builder();
            builder.setEnableGpuDelegateSupport(isGpuAvailable);
            TfLiteInitializationOptions initializationOptions = builder.build();

            return TfLite.initialize(context, initializationOptions);
        });


        initializeTask.addOnSuccessListener(task -> {
            Log.i(TAG, "INITIALIZE TF: SUCCESS");

            Task<InterpreterApi.Options> interpreterOptionTask = useGpuTask.continueWith(isUseGpu -> {
                InterpreterApi.Options options = new InterpreterApi.Options().setRuntime(TfLiteRuntime.FROM_SYSTEM_ONLY);
                if (isUseGpu.getResult()) {
                    options.addDelegateFactory(new GpuDelegateFactory());
                } else {
                    options.setNumThreads(4);
                }
                return options;
            });

            interpreterOptionTask.addOnCompleteListener(options -> {
               if (options.isSuccessful()) {
                   try {
                       interpreter = InterpreterApi.create(loadModelFile(assetManager, modelpath), options.getResult());
                       if (interpreter != null) {
                           Log.i(TAG, "CREATE INTERPRETER: SUCCESS");
                       } else {
                           // Failed to create the interpreter
                           Log.e(TAG, "Failed to create the interpreter");
                       }
                   } catch (IOException e) {
                       Log.e(TAG, e.getMessage());
                   }
               }
            });
        })
        .addOnFailureListener(e -> {
            Log.e("Interpreter", String.format("Cannot initialize interpreter: %s", e.getMessage()));
        });


        labelList = loadLabelList(assetManager,labelpath);
        textView.setText(label);
    }

    private List<String> loadLabelList(AssetManager assetManager, String labelpath) throws IOException {
        List<String> labelList = new ArrayList<>();
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(assetManager.open(labelpath)));
        String line;

        while ((line = bufferedReader.readLine())!= null){
            labelList.add(line);
        }
        bufferedReader.close();
        return labelList;
    }

    private ByteBuffer loadModelFile (AssetManager assetManager, String modelpath) throws  IOException {
        AssetFileDescriptor descriptor = assetManager.openFd(modelpath);
        FileInputStream inputStream = new FileInputStream(descriptor.getFileDescriptor());
        FileChannel fileChannel = inputStream.getChannel();
        long startOffset = descriptor.getStartOffset();
        long declaredLength = descriptor.getDeclaredLength();

        return fileChannel.map(FileChannel.MapMode.READ_ONLY, startOffset, declaredLength);
    }

    public Mat recognizeImage (Mat mat_image) {
        Mat rotated_mat_image = new Mat();
        Mat a = mat_image.t();
        Core.flip(a,rotated_mat_image, 1);
        a.release();

        Bitmap bitmap = null;
        bitmap = Bitmap.createBitmap(rotated_mat_image.cols(), rotated_mat_image.rows(), Bitmap.Config.ARGB_8888);
        Utils.matToBitmap(rotated_mat_image,bitmap);

        int height = bitmap.getHeight();
        int width = bitmap.getWidth();

        Bitmap scaledBitmap = Bitmap.createScaledBitmap(bitmap,INPUT_SIZE,INPUT_SIZE,false);

        ByteBuffer byteBuffer = convertBitmapToByteBuffer(scaledBitmap);
        Object[] input = new Object[1];
        input[0] = byteBuffer;

        Map<Integer, Object> output_map = new TreeMap<>();
        float[][][] boxes = new float[1][1][4];
        float[][] scores = new float[1][1];
        float[][] classes = new float[1][1];

        output_map.put(1, boxes);
        output_map.put(3, classes);
        output_map.put(0, scores);

        try {
            interpreter.runForMultipleInputsOutputs(input, output_map);
            Log.i(TAG, "recognizeImage: SUKSES COY");
        } catch (Exception e) {
            Log.e(TAG, "recognizeImage: "+e);
        }

        Object value = output_map.get(1);
        Object object_class = output_map.get(3);
        Object score = output_map.get(0);

        float class_value = (float) Array.get(Array.get(object_class, 0),0);
        float score_value = (float) Array.get(Array.get(score, 0),0);

        if (score_value > 0.38) {
            Object box1 = Array.get(Array.get(value, 0), 0);

            float top = (float) Array.get(box1, 0)*height;
            float left = (float) Array.get(box1, 1)*width;
            float bottom = (float) Array.get(box1, 2)*height;
            float right = (float) Array.get(box1, 3)*width;

            Imgproc.rectangle(rotated_mat_image, new Point(left, top),new Point(right, bottom), new Scalar(255, 100, 100), 2);

            label = labelList.get((int) class_value);
            int[] baseLine = new int[1];
            Size labelSize = Imgproc.getTextSize(label, Imgproc.FONT_HERSHEY_SIMPLEX, 0.8, 3, baseLine);
            Imgproc.rectangle(rotated_mat_image, new Point((right/2)-(labelSize.width/1.5), top - labelSize.height),
                    new Point((right/2)-(labelSize.width/2) + labelSize.width, top + baseLine[0]),
                    new Scalar(255, 100, 100), Imgproc.FILLED);
            Imgproc.putText(rotated_mat_image, labelList.get((int) class_value), new Point((right/2)-(labelSize.width/2), top),
                    Imgproc.FONT_HERSHEY_SIMPLEX, 0.6f, new Scalar(255, 255, 255), 2);
        }

        Mat b = rotated_mat_image.t();
        Core.flip(b, mat_image, 0);
        b.release();
        return mat_image;
    }

    public String getLabel () {
        return label;
    }

    private ByteBuffer convertBitmapToByteBuffer(Bitmap bitmap) {
        ByteBuffer byteBuffer;
        int quant = 1;
        int size_image = INPUT_SIZE;
        if (quant == 0) {
            byteBuffer = ByteBuffer.allocateDirect(1*size_image*size_image*3);
        } else {
            byteBuffer = ByteBuffer.allocateDirect(4*1*size_image*size_image*3);
        }
        byteBuffer.order(ByteOrder.nativeOrder());
        int[] intValues = new int[size_image*size_image];
        bitmap.getPixels(intValues, 0, bitmap.getWidth(), 0, 0, bitmap.getWidth(), bitmap.getHeight());
        int pixels = 0;
        for (int i = 0; i < size_image; i++) {
            for (int j = 0; j < size_image; j++) {
                final int val = intValues[pixels++];
                if (quant ==0){
                    byteBuffer.put((byte) ((val>>16)&0xFF));
                    byteBuffer.put((byte) ((val>>8)&0xFF));
                    byteBuffer.put((byte) (val&0xFF));
                } else {
                    byteBuffer.putFloat((((val >> 16)&0xFF))/255.0f);
                    byteBuffer.putFloat((((val >> 8)&0xFF))/255.0f);
                    byteBuffer.putFloat((((val) & 0xFF))/255.0f);
                }
            }
        }
        return byteBuffer;
    }
}
