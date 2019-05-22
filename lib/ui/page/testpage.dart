import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  List formList;

  void initState() {
    print("initState");
    // TODO: implement initState
    super.initState();
    setState(() {
      formList = [
        1,
        2,
        3,
        4,
        5,
      ];
    });


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  coursebody();
  }



  Widget coursebody() {

    List<Widget> titles = [];
    for(var item in formList){
      switch(item){
        case 1: titles.add(
            new Container(
              child: new Text("1"),
            )
        );
        break;
        case 2: titles.add(
            new Container(
              child: new Text("2"),
            )
        );
        break;
        case 3: titles.add(
            new Container(
              child: new Text("3"),
            )
        );
        break;
        case 4: titles.add(
            new Container(
              child: new Text("4"),
            )
        );
        break;
        case 5: titles.add(
            new Container(
              child: new Text("5"),
            )
        );
        break;
        case 6: titles.add(
            new Container(
              child: new Text("6"),
            )
        );
        break;
        default:
          titles.add(
            new Card(
              child: new Text("6"),
            )
          );
      }
    }

    return new Container(
        child: new Table(
          children: <TableRow>[
            new TableRow(
              children: titles,
            )
          ],
        ));
  }
}
