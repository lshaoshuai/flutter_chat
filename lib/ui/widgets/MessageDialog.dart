import 'package:flutter/material.dart';

class MessageDialog extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MessageDialogShow(context);
  }

  Widget MessageDialogShow(BuildContext context){
    return new AlertDialog(
      title: new Text('提示:'),
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            new Text('内容不能为空'),
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text('确定'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}