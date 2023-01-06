package com.anjarmath.njawani;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.recyclerview.widget.RecyclerView;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.os.Environment;
import android.view.View;
import android.widget.AdapterView;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.Toast;

import java.io.File;
import java.io.FilenameFilter;

public class Galeri extends AppCompatActivity {

    private String[] filePathStrings;
    private File[] listFile;
    GridView grid;
    GaleriAdapter adapter;
    File file;
    public static Bitmap bmp = null;
    ImageView imageview;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_galeri);

        int permissionCheck = ContextCompat.checkSelfPermission(
                this, Manifest.permission.WRITE_EXTERNAL_STORAGE);
        if (permissionCheck != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE}, 225);
        }

        if (!Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)){
            Toast.makeText(this, "Error! Penyimpanan tidak terdeteksi",Toast.LENGTH_LONG).show();
        } else {
            file = new File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES).getPath()+"/Njawani");
        }
        if (file.isDirectory()){
            listFile = file.listFiles(new FilenameFilter() {
                public boolean accept(File dir, String name) {
                    return (name.endsWith(".jpg") || name.endsWith(".jpeg") || name.endsWith(".png"));
                }
            });
            filePathStrings = new String[listFile.length];
            for (int i = 0; i < listFile.length ; i++){
                    filePathStrings[i] = listFile[i].getAbsolutePath();
            }
        }

        float scale = getResources().getDisplayMetrics().density;
        int dpAsPixels = (int) (20*scale + 0.5f);

        grid = (GridView) findViewById(R.id.grid_view_galeri);
        adapter = new GaleriAdapter(getApplicationContext(), this, filePathStrings, listFile);
        grid.setAdapter(adapter);

        grid.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Intent intentPreviewGaleri = new Intent(Galeri.this, PreviewGaleri.class);
                intentPreviewGaleri.putExtra("url", filePathStrings[position]);
                startActivity(intentPreviewGaleri);
            }
        });
    }

    @Override
    protected void onRestart() {
        super.onRestart();
        finish();
        startActivity(getIntent());
    }
}