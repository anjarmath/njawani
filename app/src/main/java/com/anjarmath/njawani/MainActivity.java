package com.anjarmath.njawani;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.leanback.widget.HorizontalGridView;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.Manifest;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.os.Process;
import android.util.Log;
import android.view.View;
import android.widget.Adapter;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import org.opencv.android.OpenCVLoader;

import java.io.File;
import java.io.IOException;

public class MainActivity extends AppCompatActivity {

    static {
        if (OpenCVLoader.initDebug()){
            Log.d("MainActivity", "OpenCV is loaded");
        } else {
            Log.d("MainActivity", "Can't Load OpenCV");
        }
    }

    private String[] filePath;
    private File[] listFile;
    GridElementAdapter adapter;
    File file;
    public static Bitmap bmp = null;
    ImageView imageView;
    private RecyclerView gridView;
    Button btnGallery;
    Button btnCamera;
    Button btnExit;
    TextView noImage;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        int PERMISSION_ALL = 1;
        String[] PERMISSIONS = {
                Manifest.permission.WRITE_EXTERNAL_STORAGE,
                Manifest.permission.CAMERA
        };

        if (!hasPermissions(this, PERMISSIONS)) {
            ActivityCompat.requestPermissions(this, PERMISSIONS, PERMISSION_ALL);
        }

        if (!Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)){
            Toast.makeText(this, "Error! Penyimpanan tidak terdeteksi",Toast.LENGTH_LONG).show();
        } else {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.FROYO) {
                file = new File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES)
                        .getPath()+"/Njawani");
            }
            if (!file.exists()){
                file.mkdir();
            }
        }

        gridView = (RecyclerView) findViewById(R.id.grid_view);
        LinearLayoutManager layoutManager
                = new LinearLayoutManager(this, LinearLayoutManager.HORIZONTAL, false);
        gridView.setLayoutManager(layoutManager);
        noImage = (TextView) findViewById(R.id.no_image);

        if (file.isDirectory()){
            if (file.list().length==0) {
                gridView.setVisibility(View.INVISIBLE);
                noImage.setVisibility(View.VISIBLE);
            } else {
                listFile = file.listFiles();
                if (listFile.length<=3){
                    filePath = new String[listFile.length];
                    for (int i = 0; i < listFile.length ; i++){
                        filePath[i] = listFile[i].getAbsolutePath();
                    }
                } else {
                    filePath = new String[3];
                    for (int i = 0; i < 3 ; i++){
                        filePath[i] = listFile[i].getAbsolutePath();
                    }
                }

                float scale = getResources().getDisplayMetrics().density;
                int dpAsPixels = (int) (20*scale + 0.5f);

                adapter = new GridElementAdapter(this, this, filePath, dpAsPixels);
                gridView.setAdapter(adapter);
                gridView.setVisibility(View.VISIBLE);
                noImage.setVisibility(View.INVISIBLE);
            }
        }

        ItemClickSupport.addTo(gridView)
                .setOnItemClickListener(new ItemClickSupport.OnItemClickListener() {
                    @Override
                    public void onItemClicked(RecyclerView recyclerView, int position, View v) {
                        Intent intentPreviewGaleri = new Intent(MainActivity.this, PreviewGaleri.class);
                        intentPreviewGaleri.putExtra("url", filePath[position]);
                        startActivity(intentPreviewGaleri);
                    }
                });

        btnGallery = (Button) findViewById(R.id.button_selengkapnya);
        btnGallery.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent iGaleri = new Intent(MainActivity.this, Galeri.class);
                startActivity(iGaleri);
            }
        });

        btnCamera = (Button) findViewById(R.id.to_camera_button);
        btnCamera.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent iKamera = new Intent(MainActivity.this, CameraActivity.class);
                startActivity(iKamera);
            }
        });

        btnExit = (Button) findViewById(R.id.btn_exit);
        btnExit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(MainActivity.this);
                alertDialogBuilder.setTitle("Yakin ingin keluar?");
                alertDialogBuilder
                        .setCancelable(false)
                        .setPositiveButton("Ya",
                                new DialogInterface.OnClickListener() {
                                    public void onClick(DialogInterface dialog, int id) {
                                        moveTaskToBack(true);
                                        Process.killProcess(Process.myPid());
                                        System.exit(0);
                                    }
                                })

                        .setNegativeButton("Tidak", new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int id) {

                                dialog.cancel();
                            }
                        });

                AlertDialog alertDialog = alertDialogBuilder.create();
                alertDialog.show();
            }
        });
    }

    @Override
    public void onRestart()
    {
        super.onRestart();
        finish();
        startActivity(getIntent());
    }

    public static boolean hasPermissions(Context context, String... permissions) {
        if (context != null && permissions != null) {
            for (String permission : permissions) {
                if (ActivityCompat.checkSelfPermission(context, permission) != PackageManager.PERMISSION_GRANTED) {
                    return false;
                }
            }
        }
        return true;
    }
}