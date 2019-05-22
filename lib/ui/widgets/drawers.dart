import 'package:flutter/material.dart';

class DrawList extends StatefulWidget {
  _DrawState createState() => new _DrawState();
}

class _DrawState extends State<DrawList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
          child: Container(
            padding: EdgeInsets.all(5),
            color: Colors.greenAccent,
          ),
          preferredSize: Size.fromHeight(100),
      ),
    );;
  }
}
