package com.anjarmath.njawani;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.io.File;

public class GaleriAdapter extends BaseAdapter {

    private Context context;
    private Activity activity;
    private String[] filepath;
    public static LayoutInflater inflater = null;
    private int dpAsPixels;
    private File[] listgambar;

    public GaleriAdapter (Context context, Activity a, String[] fpath, File[] listFile)
    {
        activity = a;
        filepath = fpath;
//        inflater = (LayoutInflater)activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        this.context = context;
        listgambar = listFile;
    }

    @Override
    public int getCount() {
        return filepath.length;
    }

    @Override
    public Object getItem(int position) {
        return filepath[position];
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @SuppressLint("InflateParams")
    @Override
    public View getView(int position, View convertView, ViewGroup parent) {

        View view = convertView;
        if (view == null) {
            view = LayoutInflater.from(this.context).inflate(R.layout.galeri_image, null);
            String namaFile = listgambar[position].getName();
            ImageView image = (ImageView)view.findViewById(R.id.my_image);
            TextView judul = (TextView)view.findViewById(R.id.judul);

            image.setImageURI(Uri.parse(filepath[position]));
            judul.setText(namaFile);
        }
        return view;
    }
}
