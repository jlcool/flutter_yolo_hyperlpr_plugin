import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_yolo_hyperlpr_plugin/flutter_yolo_hyperlpr_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_yolo_hyperlpr_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterYoloHyperlprPlugin.platformVersion, '42');
  });
}
