
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class FlutterYoloHyperlprPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_yolo_hyperlpr_plugin');

  static Completer<void> _creatingCompleter;
  static Future<PlateResult> lpr(
      List<Uint8List> byteList, int w, int h) async {
    _creatingCompleter = Completer<void>();
    final Map<String, dynamic> result = await _channel
        .invokeMapMethod<String, dynamic>("lpr",
            <String, dynamic>{"byteList": byteList, "width": w, "height": h});
    bool successed = result != null && result.isNotEmpty;
    String number;
    Uint8List bytes;
    if (successed) {
      number = result["number"];
      bytes = result["bytes"];
    }
    PlateResult plateResult =
        PlateResult(successed, number: number, bytes: bytes);

    _creatingCompleter.complete();
    return plateResult;
  }
}
class PlateResult {
  final bool successed;
  final Uint8List bytes;
  final String number;

  const PlateResult(this.successed, {this.bytes, this.number});

  @override
  String toString() {
    return "{successed:$successed,number:$number, bytes:$bytes}";
  }
}