import 'package:flutter/material.dart';

class ReceiptDescription extends StatefulWidget {
  final String title;
  final int index;

  ReceiptDescription(this.index, this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ReceiptDescriptionState(index, title);
  }
}

class ReceiptDescriptionState extends State<ReceiptDescription> {
  final String title;
  final int index;

  ReceiptDescriptionState(this.index, this.title);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//        appBar: AppBar(
//          title: Text(title),actions: <Widget>[IconButton(icon: Icon(Icons.edit), onPressed: (){})],
//        ),
        body:NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                actions: <Widget>[IconButton(icon: Icon(Icons.edit), onPressed: (){})],
                floating: true,
                pinned: false,
                title: Text(title),
//                flexibleSpace: FlexibleSpaceBar(
//                    centerTitle: true,
//                    title: Text(title,
//                        style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 16.0,
//                        )),),
              ),
//              SliverPersistentHeader(
//                delegate: _SliverAppBarDelegate(
//                  TabBar(
//                    labelColor: Colors.black87,
//                    unselectedLabelColor: Colors.grey,
//                    tabs: [
//                      Tab(icon: Icon(Icons.info), text: "Tab 1"),
//                      Tab(icon: Icon(Icons.lightbulb_outline), text: "Tab 2"),
//                    ],
//                  ),
//                ),
//                pinned: true,
//              ),
            ];
          },
          body: Column(
          children: <Widget>[
            Image(image: AssetImage("assets/food.jpg")),
            _Titles('Описание рецепта'),
            Text("Description of the receipt", textAlign: TextAlign.start,),
            _Titles('Ингредиенты'),
            Text('Список ингредиентов', textAlign: TextAlign.start,),
             Text(
              'Количество калорий 123',
              textAlign: TextAlign.end,
            ),
            _Titles('Шаги приготовления'),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: PageView.builder(
                itemBuilder: _itemPage,
                itemCount: 10,
                controller: PageController(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _Titles(String title) {
    return Opacity(
      opacity: 0.7,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Icon(Icons.description),
        Text(title, textAlign: TextAlign.center)
      ]),
    );
  }

  Widget _itemPage(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        Image(
          image: AssetImage("assets/food.jpg"),
        ),
        Text(
          'some data',
          style: TextStyle(fontSize: 15.0, color: Colors.grey),
        )
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
