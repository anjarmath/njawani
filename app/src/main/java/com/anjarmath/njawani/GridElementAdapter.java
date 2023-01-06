package com.anjarmath.njawani;

import android.app.Activity;
import android.content.Context;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.media.Image;
import android.os.Environment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class GridElementAdapter extends RecyclerView.Adapter<GridElementAdapter.SimpleViewHolder> {
    private Context context;
    private Activity activity;
    private String[] filepath;
    public static LayoutInflater inflater = null;
    Bitmap bmp = null;
    private int dpAsPixels;

    public GridElementAdapter(Context context, Activity a, String[] fpath, int scale){
        this.context = context;
        activity = a;
        filepath = fpath;
        inflater = (LayoutInflater)activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        dpAsPixels = scale;
    }

    public static class SimpleViewHolder extends RecyclerView.ViewHolder {
        public final Button button;
        public final ImageView image;

        public SimpleViewHolder(View view) {
            super(view);
            button = (Button) view.findViewById(R.id.button);
            image = (ImageView) view.findViewById(R.id.image_view);
        }
    }

    @NonNull
    @Override
    public SimpleViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        final View view = LayoutInflater.from(this.context).inflate(R.layout.grid_element, parent, false);
        return new SimpleViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull SimpleViewHolder holder, int position) {
        int targetWidth = (int) (context.getResources().getDisplayMetrics().widthPixels*0.35);
        int targetHeight = (int) (context.getResources().getDisplayMetrics().widthPixels*0.35);
        BitmapFactory.Options bmpOptions = new BitmapFactory.Options();
        bmpOptions.inJustDecodeBounds = true;
        BitmapFactory.decodeFile(filepath[position], bmpOptions);
        int currHeight = bmpOptions.outWidth;
        int currWidth = bmpOptions.outWidth;
        int sampleSize = 1;
        if (currHeight > targetHeight || currWidth > targetWidth)
        {
            if (currWidth > currHeight)
                sampleSize = Math.round((float)currHeight
                        / (float)targetHeight);
            else
                sampleSize = Math.round((float)currWidth
                        / (float)targetWidth);
        }
        bmpOptions.inSampleSize = sampleSize;
        bmpOptions.inJustDecodeBounds = false;
        bmp = BitmapFactory.decodeFile(filepath[position], bmpOptions);
        holder.image.setImageBitmap(bmp);
//        if (position != 1) {
//            holder.image.setPadding(dpAsPixels, dpAsPixels, dpAsPixels, dpAsPixels);
//        }
        bmp = null;
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public int getItemCount() {
        return this.filepath.length;
    }
}


