import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'dart:io';
import 'dart:async';

Permission permissionFromString(String value) {
  Permission permission;
  for (Permission item in Permission.values) {
    if (item.toString() == value) {
      permission = item;
      break;
    }
  }
  return permission;
}

class CameraApp extends StatefulWidget {
  List<CameraDescription> cameras;

  CameraApp(this.cameras);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CameraAppState();
  }
}

class CameraAppState extends State<CameraApp> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  Permission _permissionCamera;
  Permission _permissionStorage;

  CameraController controller;

  Future<void> startCamera() async {
    try {
      controller =
          new CameraController(widget.cameras[0], ResolutionPreset.high);
      controller.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
      await SimplePermissions.requestPermission(
          permissionFromString('Permission.WriteExternalStorage'));
      await SimplePermissions.requestPermission(
          permissionFromString('Permission.Camera'));
    } catch (e) {
      print('mistake');
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<String> saveImage() async {
    String timeStamp = new DateTime.now().millisecondsSinceEpoch.toString();
    String filePath = "/storage/emulated/0/Pictures/${timeStamp}.jpg";

    if (controller.value.isTakingPicture) return null;
    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      print(e.toString());
    }

    return filePath;
  }

  @override
  void initState() {
    super.initState();
    startCamera();

    _permissionCamera = permissionFromString('Permission.Camera');
    _permissionStorage =
        permissionFromString('Permission.WriteExternalStorage');
  }

  void takePicture() async {
    bool hasCamera = await SimplePermissions.checkPermission(_permissionCamera);
    bool hasStorage =
        await SimplePermissions.checkPermission(_permissionStorage);
    if (!hasStorage || !hasCamera) {}

    saveImage().then((String filePath) {
      if (mounted && filePath != null) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = (size.width+100) / (size.height);
    // TODO: implement build
    return Scaffold(
//      key: _key,
      body: Stack(children: <Widget>[
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        crossAxisAlignment: CrossAxisAlignment.center,

//          Row(
//            children: <Widget>[
//              RaisedButton(
//                onPressed: takePicture,
//                child: Text('Take picture'),
//              ),
//              RaisedButton(
//                onPressed: SimplePermissions.openSettings,
//                child: Text('Settings'),
//              )
//            ],
//          ),

        Transform.scale(
          scale: controller.value.aspectRatio / deviceRatio,
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),
        ),
//        GestureDetector(
//          onTap: takePicture,
//          child: Container(
//            padding: EdgeInsets.only(bottom: 10.0),
//            alignment: Alignment.bottomCenter,
//            child: CircleAvatar(
//              backgroundColor: Colors.white,
//              minRadius: 15.0,
//            ),
//          ),
//        )
      ]),
    );
  }
}
