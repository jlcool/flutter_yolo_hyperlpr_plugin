package com.example.flutter_yolo_hyperlpr_plugin;

import android.content.Context;
import android.view.View;
import android.widget.TextView;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class CameraView implements PlatformView, MethodChannel.MethodCallHandler {

    private final TextView myNativeView;

    CameraView(Context context, BinaryMessenger messenger, int id, Map<String, Object> params) {
        TextView myNativeView = new TextView(context);
        myNativeView.setText("我是来自Android的原生TextView");
        this.myNativeView = myNativeView;
        if (params.containsKey("myContent")) {
            String myContent = (String) params.get("myContent");
            myNativeView.setText(myContent);
        }
        MethodChannel methodChannel = new MethodChannel(messenger, "com.example.flutter_yolo_hyperlpr_plugin/cameraview_" + id);
        methodChannel.setMethodCallHandler(this);
    }
    @Override
    public View getView() {
        return myNativeView;
    }

    @Override
    public void dispose() {

    }
    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if ("setText".equals(methodCall.method)) {
            String text = (String) methodCall.arguments;
            myNativeView.setText(text);
            result.success(null);
        }
    }
}