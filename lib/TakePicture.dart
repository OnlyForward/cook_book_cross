import 'package:camera/camera.dart';
import 'package:cook_book/CameraApp.dart';
import 'package:cook_book/GalleryApp.dart';
import 'package:flutter/material.dart';

class TakePicture extends StatefulWidget {
  List<CameraDescription> cameras;

  TakePicture(this.cameras);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TakePictureState(cameras);
  }
}

class TakePictureState extends State<TakePicture>
    with SingleTickerProviderStateMixin {
  List<CameraDescription> cameras;
  TabController tabController;

  TakePictureState(this.cameras);

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Фото'),),
      bottomNavigationBar: TabBar(labelColor: Colors.black,
          controller: tabController, tabs: <Widget>[
        Tab(
          child: Text('Камера'),
        ),
        Tab(
          child: Text('Галлерея'),
        )
      ]),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[CameraApp(cameras), GalleryApp()],
      ),
    );
  }
}
