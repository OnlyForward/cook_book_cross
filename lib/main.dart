import 'package:camera/camera.dart';
import 'package:cook_book/CameraApp.dart';
import 'package:cook_book/DescriptionReceipt.dart';
import 'package:cook_book/TakePicture.dart';
import 'package:cook_book/createReceipt.dart';
import 'package:cook_book/my_app_settings.dart';
import 'package:cook_book/my_widgets/common_drawer.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras;

void main() async {
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
//        primarySwatch: Colors.blue,
        primaryColorDark: Color(0xFF388E3C),
        primaryColor: Color(0xFF4CAF50),
        primaryColorLight: Color(0xFFC8E6C9),
        accentColor: Color(0xFFFFEB3B),
        dividerColor: Color(0xFFBDBDBD)
      ),
      routes: {
        '/': (context) {
          return MyHomePage(
              title: new Text(
                  'Рецепты')); //CameraApp(cameras); //MyHomePage(title: new Text('Рецепты'));
        },
        '/Create': (context) {
          return CreateReceipt();
        },
        '/settings': (context) {
          return AppSettings();
        },
        '/camera': (context) {
          return TakePicture(cameras);
        }
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  ReceiptDescription(index, 'Receipt$index'));
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (context) {
            return MyHomePage(title: new Text('Рецепты'));
          },
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  Widget title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Icon search_icon = Icon(Icons.search);
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: getDrawer(context),
        appBar: AppBar(
          title: widget.title,
          actions: <Widget>[
            IconButton(
              icon: search_icon,
              onPressed: () {
                setState(() {
                  if (this.search_icon.icon == Icons.search) {
                    this.search_icon = new Icon(Icons.close);
                    widget.title = TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search....'),
                    );
                  } else {
                    this.search_icon = new Icon(Icons.search);
                    widget.title = new Text('ksalsal');
                  }
                });
              },
            )
          ],
        ),
        body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: itemGrid,
          itemCount: 23,
        ));
  }

  Widget itemGrid(BuildContext context, int index) {
    //Navigator.pushNamed<bool>(context, '/product/$index')
    return Card(
      child: Column(
        children: <Widget>[
          Image(
            image: AssetImage("assets/food.jpg"),
          ),
            ListTile(
              title: Text('Детали',textAlign: TextAlign.center,),
              onTap: () {
                Navigator.pushNamed<bool>(context, '/product/$index');
              },
          )
        ],
      ),
    );
  }
}
