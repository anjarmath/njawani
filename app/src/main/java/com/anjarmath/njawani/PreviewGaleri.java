package com.anjarmath.njawani;

import androidx.appcompat.app.AppCompatActivity;

import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Toast;

import java.io.File;
import java.io.IOException;

public class PreviewGaleri extends AppCompatActivity {

    ImageView imageGaleri;
    Button hapus;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_preview_galeri);

        String src = getIntent().getStringExtra("url");
        File file = new File(src);

        imageGaleri = (ImageView) findViewById(R.id.image_preview_galeri);
        imageGaleri.setImageURI(Uri.parse(src));

        hapus = (Button) findViewById(R.id.btn_hapus);
        hapus.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(file.delete()) {
                    Toast.makeText(getApplicationContext(), "Gambar dihapus", Toast.LENGTH_SHORT).show();
                }
                finish();
            }
        });
    }
}