import 'package:flutter/material.dart';

class editingImage extends StatefulWidget {
  Image _image;

  editingImage();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return edititingImageState();
  }
}

class edititingImageState extends State<editingImage> {
  double _valueRotate;
  double _valueVisibility;
  int turns;
  double _x;
  double _y;
  double _z;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _valueRotate = 0.0;
    _valueVisibility = 0.0;
    turns = 0;
    _x = 0.0;
    _y = 0.0;
    _z = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактирование'),
      ),
      body: Column(
        children: <Widget>[
          Transform(
            transform: Matrix4.skewY(_y),
            child: Transform(
              transform: Matrix4.skewX(_x),
              child: Transform(
                transform: Matrix4.rotationZ(_z),
                child: RotatedBox(
                  quarterTurns: turns,
                  child: Opacity(
                    opacity: 1 - _valueVisibility,
                    child: Image(image: AssetImage("assets/food.jpg")),
                  ),
                ),
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              Slider(
                  value: _valueVisibility,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (double value) {
                    setState(() {
                      _valueVisibility = value;
                    });
                  }),
              Slider(
                  value: _valueRotate,
                  min: 0.0,
                  max: 4.0,
                  onChanged: (double value) {
                    setState(() {
                      _valueRotate = value;
                      turns = value.toInt();
                    });
                  }),
              Row(
                children: <Widget>[
                  Text('X'),
                  Slider(
                    value: _x,
                    onChanged: (double value) => setState(() => _x = value),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Y'),
                  Slider(
                    value: _y,
                    onChanged: (double value) => setState(() => _y = value),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Z'),
                  Slider(
                    value: _z,
                    onChanged: (double value) => setState(() => _z = value),
                  )
                ],
              )
            ],
          )
//          ListView(
//            children: <Widget>[
//
//            ],
//            scrollDirection: Axis.horizontal,
//          )
        ],
      ),
    );
  }
}
