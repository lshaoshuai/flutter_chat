import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luotest/ui/widgets/MyDivider.dart';
import 'package:video_player/video_player.dart';
import 'package:luotest/delegate/sliver_appbar_delegate.dart';
import '../../../utils/device_util.dart';

class ChewieDemo extends StatefulWidget {
  ChewieDemo({this.title = 'Chewie Demo',this.video_url});

  final String title;
  final String video_url;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(widget.video_url);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: (){
          print('onWillPop');
          Navigator.of(context).pop();
          //dispose();
        },
        child: Scaffold(
          body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(

                ),
                SliverPadding(
                  padding: const EdgeInsets.all(0.0),
                  sliver: new SliverList(
                    delegate: new SliverChildListDelegate(
                      <Widget>[
                        Chewie(
                          controller: _chewieController,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 10,top: 10),
                              child: Image.asset('images/qidong.jpg',width: 80, height: 100,),
                            ),
                            Expanded(
                              child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text('name',style: TextStyle(fontSize: 30),),
                                  padding: EdgeInsets.only(left: 15),

                                ),
                                Container(
                                  child:  Text('ssssssssssssssssssss',style: TextStyle(fontSize: 15),),
                                  padding: EdgeInsets.only(left: 15,top: 10),
                                  alignment: Alignment.topLeft,
                                ),

                              ],
                            )
                            ),
                            Column(
                              children: <Widget>[
                                FlatButton(onPressed: null, child: Icon(Icons.search)),
                                Text('9',style: TextStyle(fontSize: 25),)
                              ],
                            )

                          ],
                        ),
                        MyDivider(),
                        const Text('C'),
                        const Text('D'),
                      ],
                    ),
                  ),
                ),

              ]
          ),
        ));
  }
}
