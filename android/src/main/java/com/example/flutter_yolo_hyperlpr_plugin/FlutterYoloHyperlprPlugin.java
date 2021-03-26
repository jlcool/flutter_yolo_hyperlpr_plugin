package com.example.flutter_yolo_hyperlpr_plugin;

import android.app.Activity;

import androidx.annotation.NonNull;

import java.util.HashMap;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** FlutterYoloHyperlprPlugin */
public class FlutterYoloHyperlprPlugin implements FlutterPlugin, ActivityAware, MethodCallHandler {
  private MethodChannel channel;
  private Activity activity;
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_yolo_hyperlpr_plugin");
    channel.setMethodCallHandler(this);
    flutterPluginBinding
            .getPlatformViewRegistry()
            .registerViewFactory("flutter_yolo_hyperlpr_plugin/cameraview", new CameraViewFactory(flutterPluginBinding.getBinaryMessenger()));
    LprHelper.initRecognizer(activity);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("lpr")) {
      new LprMain((HashMap<String, Object>) call.arguments).Scan(this.activity,result);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
  @Override
  public void onAttachedToActivity(ActivityPluginBinding activityPluginBinding) {
    this.activity = activityPluginBinding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding activityPluginBinding) {
    onAttachedToActivity(activityPluginBinding);
  }

  @Override
  public void onDetachedFromActivity() {

  }
}
