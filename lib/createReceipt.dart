import 'package:cook_book/my_widgets/common_drawer.dart';
import 'package:flutter/material.dart';

class CreateReceipt extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CreateReceiptState();
  }
}

class CreateReceiptState extends State<CreateReceipt> {
  final List<TextEditingController> controllers = [];
  final List<String> keys = [];
  final List<Map<String, dynamic>> _steps = [];
  final Map<String, String> _general_desc = {
    'description_receipt': '',
    'title': '',
    'ingredients': '',
    'time': ''
  };
  int i = 0;
  TimeOfDay _timeOfDay;

  @override
  void initState() {
    super.initState();
    _timeOfDay = new TimeOfDay(hour: 0, minute: 0);
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey timed = GlobalKey();
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        drawer: getDrawer(context),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('создать рецепт'),
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _CreateRow('Введите заголовок', _general_desc['title']),
              Divider(),
              _CreateRow('Введите описание', _general_desc['decription'], 5),
              Divider(),
              _CreateRow('Введите ингредиенты', _general_desc['ingredients']),
              Divider(),
              GestureDetector(
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Время приготовления $_timeOfDay')),
                  onTap: selectTime),
              Divider(),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Text('Введите шаги: '),
                    Container(
                      padding: EdgeInsets.only(right: 80.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0)),
                        /*border: Border.all(width: 2.0, color: Colors.white)*/
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                        ),
                        border: Border.all(width: 1.0, color: Colors.black),
                      ),
                      child: InkWell(
                        child: Icon(Icons.add),
                        onTap: () {
                          setState(() {
                            controllers.add(new TextEditingController());
                            keys.add("value $i");
                            i++;
                          });
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        border: Border.all(width: 1.0, color: Colors.black),
                      ),
                      child: InkWell(
                        child: Icon(Icons.remove),
                        onTap: () {
                          //controllers.remove(new TextEditingControlle);
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  child: Wrap(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.photo_album,
                                            color: Colors.red),
                                        title: Text('Галлерея'),
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/camera');
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.photo,
                                          color: Colors.red,
                                        ),
                                        title: Text('Фото'),
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                );
                              });
                          keys.add("value $i");
                          i++;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                controller: ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                itemBuilder: _buildSteps,
                itemCount: i,
              ),
              RaisedButton(
                key: timed,
                color: Colors.white,
                onPressed: () => null,
                child: Text('Создать рецепт'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(this.context).size.height/2)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSteps(BuildContext context, int index) {
    Map<String, dynamic> data_step = {
      'description': "",
      'image': null,
    };
    _steps.add(data_step);

    return Dismissible(
      key: Key(keys[index]),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(color: Colors.red),
      ),
      onDismissed: (direction) {
        _deleteRow(keys[index], index);
      },
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(right: 8.0),
                height: MediaQuery.of(context).size.height / 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: Colors.black, width: 2.0)),
                child: IconButton(
                  icon: Icon(Icons.add),
                  alignment: Alignment.center,
                  onPressed: () => null,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                onChanged: (String value) {
                  data_step['description'] = value;
                },
                maxLines: 5,
                controller: controllers[index],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _deleteRow(String item, int index) {
    setState(() {
      _steps.removeAt(index);
      keys.remove(item);
      controllers.removeAt(index);
      i--;
    });
  }

  Widget _CreateRow(String title, String inf, [int maxLines = 1]) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(title),
            flex: 1,
          ),
          Expanded(
            flex: 2,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 10.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              maxLines: maxLines,
              onChanged: (String value) {
                setState(() => inf = value);
              },
            ),
          )
        ],
      ),
    );
  }

  Future<Null> selectTime() async {
    final TimeOfDay responce =
        await showTimePicker(context: context, initialTime: _timeOfDay);

    setState(() {
      if (responce != null) {
        _timeOfDay = responce;
      }
    });
  }
}
