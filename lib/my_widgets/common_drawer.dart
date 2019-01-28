import 'package:flutter/material.dart';

Widget getDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: <Widget>[
        AppBar(
          title: Text('Кулинарная книга'),
          automaticallyImplyLeading: false,
        ),
        ListTile(
          leading: Icon(Icons.add),
          title: Text('Созжать рецепт'),
          onTap: () {
            Navigator.pushNamed(context, '/Create');
          },
        ),
        Divider(),

//        ListTile(
//          leading: Icon(Icons.add),
//          title: Text('Созжать рецепт'),
//          onTap: () {
//            Navigator.pushNamed(context, '/camera');
//          },
//        ),
        ListTile(
          leading: Icon(Icons.local_grocery_store),
          title: Text('Рецепты'),
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Настройки'),
          onTap: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
        Divider(),
      ],
    ),
  );
}
