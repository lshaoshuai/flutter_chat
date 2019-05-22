
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luotest/Bean/ChatMessageData.dart';


class ChatMessage extends StatelessWidget{

  final String msg_text;
  final AnimationController animationController;
  Future imageFile;
  bool msg_from_boolen = true;

  ChatMessage({this.msg_text,this.animationController,this.msg_from_boolen,this.imageFile});

  @override
  Widget build(BuildContext context) {

    //ScreenUtil.instance =  ScreenUtil(width: MediaQuery.of(context).size.width.floor()  ,height:MediaQuery.of(context).size.height.floor())..init(context);
    // TODO: implement build
    return SizeTransition(

      //应用曲线来产生线性动画
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child:Container(

            margin: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              mainAxisAlignment: msg_from_boolen ? MainAxisAlignment.start: MainAxisAlignment.end,
              children: GetMsgs(),

            )
        ));
  }

  Widget _previewImage() {
    return FutureBuilder<File>(
        future: imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
            return ClipOval(
              child: Container(
                  width: 70.0,
                  height: 70.0,
                  child: Card(
                      child:Image.file(snapshot.data, fit: BoxFit.cover)
                  )
              ),
            );
          }else{
            Container();
          }
        }
        );
  }

  Widget MsgCard(){
    return  Flexible(
        child: Card(
          child:  Column(
            crossAxisAlignment: msg_from_boolen ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                width: msg_text.length > 13 ? 13 * 15.0 : msg_text.length * 15.0,
                margin: EdgeInsets.all(8.0),
                child: Container(
                  //使用MediaQuery可以获取了解当前媒体的大小，我们可以从MediaQuery.of返回的MediaQueryData中读取MediaQueryData.size属性
                    child:Text(
                        msg_text,
                        style: TextStyle(fontSize: 15),
                        softWrap: true
                    )
                ),
              )
            ],
          ),
        )
    );
  }

  Widget ChatHead(){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
      child: CircleAvatar(child: new Text("luo"),
      ),
    );
  }

  List<Widget> GetMsgs(){
    if(msg_from_boolen){
      return [_previewImage(),ChatHead(),MsgCard()];
    }else{
      return [MsgCard(),ChatHead(),_previewImage()];
    }
  }
}