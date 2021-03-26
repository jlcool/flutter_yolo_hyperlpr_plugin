import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter_yolo_hyperlpr_plugin/flutter_yolo_hyperlpr_plugin.dart';
import 'package:flutter/services.dart' show ByteData, StandardMessageCodec, rootBundle;

List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HyperLPR for flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  String plate = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Container(child: Text(plate)),
        RaisedButton(
          child: Text("查询"),
          onPressed: () async {
            ByteData bytes = await rootBundle.load('assets/images/plate.jpg');
            FlutterYoloHyperlprPlugin.lpr([
              bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes)
            ], 1080, 1920)
                .then((r) {
              if (r == null || !r.successed) {
              } else {
                print(r.number);
              }
            });
          },
        ),
        Expanded(child:  AndroidView(
          viewType: 'plugins.nightfarmer.top/myview',
          creationParams: {
            "myContent": "通过参数传入的文本内容",
          },
          creationParamsCodec: const StandardMessageCodec(),
        )),
      ],
    ));
  }
}
