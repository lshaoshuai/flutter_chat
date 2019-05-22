import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CoursePage extends StatefulWidget {
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {

  List formList;

  void _requesttest() async {

    Dio dio = new Dio();
    Response resp = await dio.get("http://baidu.com");
    print(resp);
  }


  void initState() {

    _requesttest();
    print("initState");
    // TODO: implement initState
    super.initState();
    setState(() {
      formList = [
        {"title": '车牌号'},
        {"title": '所有人'},
        {"title": '号牌颜色'},
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
      titles.add(
        new Card(
          child: new Text(item['title']),
        )
      );
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
