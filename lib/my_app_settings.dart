import 'package:cook_book/editingImage.dart';
import 'package:cook_book/my_widgets/common_drawer.dart';
import 'package:flutter/material.dart';

class AppSettings extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AppSettingsState();
  }

}


class AppSettingsState extends State<AppSettings> {
  bool saveTime = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: getDrawer(context),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Настройки'),
      ),
      body: ListView(
          children: <Widget>[
            SwitchListTile(
              value: saveTime,
              title: Text('отображать время создания'),
              onChanged: (bool value) {
                saveTime = value;
              },
            ),
            GestureDetector(
              child: Text('dksadkaska;'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => editingImage()));
              },
            )
          ],
        )
    );
  }
}
