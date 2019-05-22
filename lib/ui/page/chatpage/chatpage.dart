import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:luotest/ui/page/chatpage/chatmessage.dart';
import 'package:luotest/ui/widgets/MessageDialog.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:async';
import 'package:luotest/Bean/ChatMessageData.dart';
import 'package:luotest/blocbase/composebloc.dart';
import 'package:web_socket_channel/status.dart' as status;

class ChatPage extends StatefulWidget {
  _ChatPageState createState() => _ChatPageState(composebloc());
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _editingController = new TextEditingController();
  final composebloc cbloc;

  _ChatPageState(this.cbloc);

  IOWebSocketChannel channel;
  bool _isComposing = false;
  Future _imageFile;
  int changline = 1;

  //控制消息的发送
  final pub = StreamController<ChatMessageData>();

//当pub调用add(data)方法，该sub的listen会监听到
  //final Stream<ChatMessageData> sub = pub.stream.asBroadcastStream();

  @override
  void initState() {
    print("chatinitSate");
    cbloc.iscomposing.listen((_iscomposing) {
      setState(() {
        _isComposing = _iscomposing;
      });
    });
    channel = new IOWebSocketChannel.connect('ws://192.168.1.108:8080/websocket');
  }

  void _handleSendPressed(String text) {
    changline = 1;
    //判断输出是否为空
    if (text.trim() == "") {
      showDialog<Null>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return MessageDialog();
          });
    }
    _editingController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = new ChatMessage(
      msg_text: text,
      //动画控制器
      animationController: new AnimationController(
          duration: new Duration(milliseconds: 300), vsync: this),
      msg_from_boolen: false,
      imageFile: _imageFile,
    );
    message.animationController.forward();
    setState(() {
      //在index位置插入chatmessage对象
      _messages.insert(0, message);
    });
    _sendMessage(text);
  }

  void chatmsgcard(String text) {}

  void _handleSubmitted(String text) {
    _editingController.clear();
    setState(() {
      _isComposing = false;
    });
  }

  Future<bool> _requestPop() {
    dispose();
    Navigator.pop(context);
    return new Future.value(false);
  }

  @override
  // TODO: implement context
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      child: Scaffold(
        appBar: new AppBar(title: new Text('Chat')),
        body: _Body(),
      ),
      onWillPop: _requestPop,
    );
  }

  _TextInputBox() {

    return IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: Container(
          //height: 50,
            child:Row(
              children: <Widget>[
                Container(
                  child: IconButton(
                      icon: Icon(Icons.photo_camera),
                      onPressed: () => setState(() {
                        _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
                      }
                      )
                  ),
                ),
                new Flexible(
                    child: Container(
                        padding: EdgeInsets.only(top: 5,bottom: 5),
                        child:TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                              hintText: '广播',
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(vertical:5,horizontal: 5)
                          ),
                          maxLines: changline,
                          cursorWidth: 1.0,
                          style: TextStyle(
                              fontSize: 20
                          ),
                          controller: _editingController,
                          //当文本框被按下时
                          //onSubmitted: _handleSubmitted ,
                          //onChanged回调
                          onChanged: (String text) {
                            if(text.length >= 9){
                              setState(() {
                                changline = (text.length / 10).floor() + 1;
                                print(changline);
                              });
                            }
                            cbloc.getiscomposing(text.length > 0);
                            /*setState(() {
                      _isComposing = text.length > 0;
                    });*/
                          },
                        )
                    )
                ),
                Divider(
                  height: 1.0,
                ),
                Container(
                  margin: new EdgeInsets.only(left: 10.0),
                  child: Icon(Icons.insert_emoticon),
                ),
                Container(

                  margin: new EdgeInsets.only(left: 3.0,right: 3.0),
                  child: Theme.of(context).platform == TargetPlatform.iOS
                      ? new CupertinoButton(
                    child: new Text("Send"),
                    onPressed: _isComposing
                        ? () => _handleSendPressed(_editingController.text)
                        : null,
                  )
                      : new IconButton(
                      icon: _isComposing ? Icon(Icons.send) : Icon(Icons.add),
                      onPressed: _isComposing
                          ? () => _handleSendPressed(_editingController.text)
                          : null),
                ),
              ],
            )
        )
    );
  }

  _Body() {
    return new Container(
      //margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            Flexible(
              child: _Getmsg(),
            ),
            new Divider(height: 1.0),
            new Container(
              decoration: new BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _TextInputBox(),
            )
          ],
        )
    );
  }

  Widget _previewImage() {
    return FutureBuilder<File>(
        future: _imageFile,
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
  //由于setState会重新构建整个页面，导致StreamBuilder也重新构建。
  _Getmsg() {
    String _text;

    return StreamBuilder(
      stream: channel.stream,
      builder: (context, snapshot) {
        //网络不通会走到这
        if (snapshot.hasError) {
          _text = "网络不通...";
        } else if (snapshot.hasData) {
          _text = "echo: " + snapshot.data;
          List msglists = json.decode(snapshot.data);
          print("1:" + msglists.toString());
          List<ChatMessageData> cardbeanList = msglists.map((m) => ChatMessageData.formMap(m)).toList();
          ChatMessageData cmd = cardbeanList.first;
          print("2:" + cmd.toString());
          _messages.clear();

          for(ChatMessageData cmd in cardbeanList){
            print("1");
            ChatMessage message = new ChatMessage(
              msg_text: cmd.msg,
              //动画控制器
              animationController: new AnimationController(
                  duration: new Duration(milliseconds: 300), vsync: this),
              msg_from_boolen: false,
              imageFile: _imageFile,
            );
            _messages.add(message);
            if(cardbeanList.last == cmd)
            {
              message.animationController.forward();
            }
          }
        }
        return new ListView.builder(
          padding: new EdgeInsets.all(5.0),
          //从屏幕底部开始
          reverse: true,
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        );
      },
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  void _sendMessage(text) {
    if (text.isNotEmpty) {
      channel.sink.add(
          new ChatMessageData("1", text, "luo", "1", new DateTime.now())
              .toJson());
      print("send message completed");
    }
  }
}
