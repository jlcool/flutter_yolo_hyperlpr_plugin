
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterYoloHyperlprPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_yolo_hyperlpr_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
