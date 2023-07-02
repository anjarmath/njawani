package com.anjarmath.njawani;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.Manifest;
import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;
import android.view.SurfaceView;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.material.floatingactionbutton.FloatingActionButton;

import org.opencv.android.BaseLoaderCallback;
import org.opencv.android.CameraBridgeViewBase;
import org.opencv.android.LoaderCallbackInterface;
import org.opencv.android.OpenCVLoader;
import org.opencv.core.Core;
import org.opencv.core.CvType;
import org.opencv.core.Mat;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;
import org.w3c.dom.Text;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

public class CameraActivity extends AppCompatActivity implements CameraBridgeViewBase.CvCameraViewListener2 {
    private final String TAG = "MainActivity";


    private objectDetectorClass objectDetectorClass;

    private FloatingActionButton take_picture_button;
    private String tempImgSrc;
    private String label;
    private InputStream inputlatin;
    private InputStream inputaksara;
    private String[] labellatin = new String[91];
    private String[] labelaksara = new String[91];
    private int take_image=0;
    private Mat mRGBA;
    private Mat mGrey;
    private CameraBridgeViewBase mOpenCVCameraView;
    private TextView textView;
    private BaseLoaderCallback mLoaderCallBack = new BaseLoaderCallback(this) {
        @Override
        public void onManagerConnected(int status) {
            switch (status) {
                case LoaderCallbackInterface.SUCCESS:{
                    mOpenCVCameraView.enableView();
                    Log.i(TAG, "OpenCV is Loaded");
                }
                default: {
                    super.onManagerConnected(status);
                }
                break;
            }
        }
    };

    public CameraActivity () {
        Log.i(TAG, "CameraActivity: "+ this.getClass());
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        int permissionCheck2 = ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA);
        int MY_PERMISSIONS_REQUEST = 0;

        if (permissionCheck2 != PackageManager.PERMISSION_GRANTED){
            ActivityCompat.requestPermissions(this, new String[] {Manifest.permission.CAMERA}, MY_PERMISSIONS_REQUEST);
        } else {
            MY_PERMISSIONS_REQUEST = 1;
        }

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_camera);

        try {
            inputlatin = getApplicationContext().getResources().getAssets().open("labelmap.txt", Context.MODE_WORLD_READABLE);
            BufferedReader input = new BufferedReader(new InputStreamReader(inputlatin));
            String line = "";

            int pos = 0;
            while ((line = input.readLine()) != null) {
                labellatin[pos] = line;
                pos++;
            }
        } catch (Exception e) {
            Log.d(TAG, "onCreate: "+e);
        }

        try {
            inputaksara = getApplicationContext().getResources().getAssets().open("labelaksara.txt", Context.MODE_WORLD_READABLE);
            BufferedReader input = new BufferedReader(new InputStreamReader(inputaksara));
            String line = "";

            int pos = 0;
            while ((line = input.readLine()) != null) {
                labelaksara[pos] = line;
                pos++;
            }
        } catch (Exception e) {
            Log.d(TAG, "onCreate: "+e);
        }

        try {
            textView = (TextView) findViewById(R.id.outputaksara);
            objectDetectorClass = new objectDetectorClass(CameraActivity.this, textView, getAssets(), "ssd_mobilenet_v2_640.tflite", "labelmap.txt", 384);
            Log.d(TAG, "Model sukses dibuka");
        } catch (IOException e) {
            e.printStackTrace();
        }

        mOpenCVCameraView = (CameraBridgeViewBase) findViewById(R.id.camera_surface);
        mOpenCVCameraView.setCameraPermissionGranted();
        mOpenCVCameraView.setVisibility(SurfaceView.VISIBLE);
        mOpenCVCameraView.setMaxFrameSize(920,460);
        mOpenCVCameraView.setCvCameraViewListener(this);


        take_picture_button = findViewById(R.id.take_picture);
        take_picture_button.setOnClickListener(v -> {
            if (take_image==0){
                take_image=1;
            } else {
                take_image=0;
            }
        });
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (OpenCVLoader.initDebug()){
            Log.d(TAG, "OpenCV initialization done");
            mLoaderCallBack.onManagerConnected(LoaderCallbackInterface.SUCCESS);
        } else {
            Log.d(TAG, "OpenCV is not loader");
            OpenCVLoader.initAsync(OpenCVLoader.OPENCV_VERSION, this, mLoaderCallBack);
        }
    }

    @Override
    protected void onPause() {
        super.onPause();
        if (mOpenCVCameraView != null) {
            mOpenCVCameraView.disableView();
        }
    }

    @Override
    public void onRestart()
    {
        super.onRestart();
        finish();
        startActivity(getIntent());
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (mOpenCVCameraView != null) {
            mOpenCVCameraView.disableView();
        }
    }

    @Override
    public void onCameraViewStarted(int width, int height) {
        mRGBA = new Mat(height, width, CvType.CV_8UC4);
        mGrey = new Mat(height, width, CvType.CV_8UC1);
    }

    @Override
    public void onCameraViewStopped() {
        mRGBA.release();
    }

    @Override
    public Mat onCameraFrame(CameraBridgeViewBase.CvCameraViewFrame inputFrame) {

        mRGBA = inputFrame.rgba();
        objectDetectorClass.recognizeImage(mRGBA);
        label = objectDetectorClass.getLabel();
        runOnUiThread(() -> {
            if (Arrays.asList(labellatin).indexOf(label)==-1) {
                textView.setText("Tidak ada objek dikenal");
            } else {
                textView.setText(labelaksara[Arrays.asList(labellatin).indexOf(label)]+" ");
            }
        });

        take_image = take_picture_function_rgb(take_image,mRGBA, label);

        return mRGBA;
    }

    private int take_picture_function_rgb(int take_image, Mat mRGBA, String namaobjek) {
        if (take_image==1){
            Mat save_mat = new Mat();
            Core.flip(mRGBA.t(),save_mat,1);
            Imgproc.cvtColor(save_mat,save_mat,Imgproc.COLOR_RGBA2BGRA);
            File temp_folder = new File(this.getCacheDir().getPath()+"/tempImage");
            boolean succes = true;
            if (!temp_folder.exists()){
                succes = temp_folder.mkdirs();
            }
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
            String currentDateAndTime = sdf.format(new Date());
            tempImgSrc = this.getCacheDir().getPath()+"/tempImage/"+currentDateAndTime+ ".jpeg";
            Imgcodecs.imwrite(tempImgSrc, save_mat);

            Intent intentPreview = new Intent(CameraActivity.this, PreviewCamera.class).addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
            intentPreview.putExtra("src", tempImgSrc);
            intentPreview.putExtra("namaobjek", labelaksara[Arrays.asList(labellatin).indexOf(label)]);
            startActivity(intentPreview);

            take_image=0;
        }
        return take_image;
    }
}