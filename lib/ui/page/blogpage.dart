import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';

class BlogPage extends StatefulWidget {
  @override
  _MainState createState() => new _MainState();
}

class _MainState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: Test(),
    );
  }
}

Widget mianbody() {
  return new Container(
      child: ListView.builder(itemCount: typelist.length,itemBuilder: listbody)
  );

}

Widget Test(){

  String s = "Container(child: ListView.builder(itemCount: typelist.length,itemBuilder: listbody))";
  return s as Widget;

}

Widget CATK(){
  return SizedBox(
    width: 250.0,
    child: ColorizeAnimatedTextKit(
      onTap: () {
        print("Tap Event");
      },
      text: [
        "Larry Page",
        "Bill Gates",
        "Steve Jobs",
      ],
      textStyle: TextStyle(fontSize: 50.0, fontFamily: "Horizon"),
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
    ),
  );
}

var typelist = ['text','textfield'];

Widget listbody(BuildContext context,int count) {

  String type = typelist[count];
  return jsonwidget(type);

}

var i ;

Widget jsonwidget(String type) {

  switch(type) {
    case 'text':
      return new Container(
          height: 100,
          width: 100,
          color: Colors.greenAccent,
          margin: new EdgeInsets.all(8),
          child: new Text('luo')
      );
    case 'textfield':
      return new Container(
          height: 100,
          width: 100,
          color: Colors.greenAccent,
          margin: new EdgeInsets.all(8),
          child: new TextField()
      );
    default:
      return new Container(
          height: 100,
          width: 100,
          color: Colors.greenAccent,
          margin: new EdgeInsets.all(8),
          child: new Text('no')
      );
  }
}
