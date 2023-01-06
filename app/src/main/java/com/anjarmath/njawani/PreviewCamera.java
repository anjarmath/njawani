package com.anjarmath.njawani;

import androidx.appcompat.app.AppCompatActivity;
import androidx.constraintlayout.widget.ConstraintLayout;

import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

public class PreviewCamera extends AppCompatActivity {

    ImageView preview;
    ConstraintLayout screenshotTarget;
    Button hapus;
    Button simpan;
    TextView nama;
    String src;
    File fileTemp;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_preview_camera);

        src = getIntent().getStringExtra("src");
        fileTemp = new File(src);

        preview = (ImageView) findViewById(R.id.image_preview_camera);
        preview.setImageURI(Uri.parse(src));

        nama = (TextView) findViewById(R.id.namaobjek);
        nama.setText(getIntent().getStringExtra("namaobjek"));

        hapus = (Button) findViewById(R.id.button_prev_hapus);
        hapus.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                fileTemp.delete();
                finish();
            }
        });

        screenshotTarget = (ConstraintLayout) findViewById(R.id.screenshoot_view);
        simpan = (Button) findViewById(R.id.button_prev_simpan);
        simpan.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                screenshotTarget.setDrawingCacheEnabled(true);
                screenshotTarget.buildDrawingCache(true);
                Bitmap b = Bitmap.createBitmap(screenshotTarget.getDrawingCache());
                screenshotTarget.setDrawingCacheEnabled(false);
                saveMediaToStorage(b);
            }
        });
    }

    private void saveMediaToStorage(Bitmap b) {
        File target = new File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES)
                .getPath()+"/Njawani/");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
        String currentDateAndTime = sdf.format(new Date());
        String filename = currentDateAndTime+ ".jpeg";
        OutputStream fos = null;
            try {
                fos = new FileOutputStream(target.getAbsolutePath()+"/"+filename);
                b.compress(Bitmap.CompressFormat.PNG, 100, fos);
                fos.flush();
                fos.close();
                Toast.makeText(getApplicationContext(),
                        "Tersimpan di " + target.getAbsolutePath() + "", Toast.LENGTH_SHORT).show();

                Log.e("ImageSave", "Saveimage");
            } catch (IOException e) {
                Log.e("GREC", e.getMessage(), e);
                Toast.makeText(getApplicationContext(), "Gambar tidak tersimpan!", Toast.LENGTH_SHORT).show();
            }

        Intent to_galery = new Intent(PreviewCamera.this, Galeri.class);
        startActivity(to_galery);
        finish();
    }
}