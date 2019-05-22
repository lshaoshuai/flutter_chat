import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:luotest/Bean/ChatBean.dart';
import 'package:luotest/ui/page/chatpage/chatpage.dart';
import 'package:luotest/ui/widgets/MyDivider.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'chatdrawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:luotest/utils/navigator_util.dart';


class ChatMainPage extends StatefulWidget {
  _ChatMainPageState createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage> {

  static int lastExitTime = 0;
  List<Widget> bodylist = List(); //创建一个非固定长度的widget列表
  List<ChatBean> ctlist= [];
  int _currentindex = 0;

  @override
  void initState() {
    print("initstate");
    super.initState();
    getDatas();
  }

  getDatas(){
    ctlist.add(new ChatBean(Icons.airline_seat_legroom_extra,"luo","12","在吗"));
    ctlist.add(new ChatBean(Icons.airline_seat_legroom_extra,"shao","99","在"));
    ctlist.add(new ChatBean(Icons.airline_seat_legroom_extra,"zui","99","在"));
    ctlist.add(new ChatBean(Icons.airline_seat_legroom_extra,"shao","99","在在在在在在在在在在在在在在在在在在在在在在"));
    ctlist.add(new ChatBean(Icons.airline_seat_legroom_extra,"zui","99","在"));
    ctlist.add(new ChatBean(Icons.airline_seat_legroom_extra,"zui","99","在"));
    ctlist.add(new ChatBean(Icons.airline_seat_legroom_extra,"zui","99","在"));
    ctlist.add(new ChatBean(Icons.airline_seat_legroom_extra,"zui","99","在"));
    ctlist.add(new ChatBean(Icons.airline_seat_legroom_extra,"zui","99","在")
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  _MainSliverBar();
  }

  ///
  /// 创建一个滑动的主页
  ///
  Widget _MainSliverBar() {
    return Scaffold(

      drawer: Drawer(
          child: ChatDrawer()
      ),
      appBar: AppBar(
        title: Text("Chat"),
        elevation: 1.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search,size: 27,),
            onPressed: () {
              print("sreach");
            },
          )
        ],
      ) ,
      body: getBody(),
    );
  }

  Future<Null> pullToRefresh() async {
    return null;
  }

  RefreshController _refreshController = new RefreshController();

  void _onRefresh(bool up) async{
    if(up){
      //headerIndicator callback
      new Future.delayed(const Duration(milliseconds: 1000))
          .then((val) {
        _refreshController.sendBack(true, RefreshStatus.failed);
      });
    }
    else{
      //footerIndicator Callback
    }
  }

  getBody() {
    if (ctlist.isEmpty) {
      // 加载菊花
      return CircularProgressIndicator();
    } else {
      return new Container(
        child: new SmartRefresher(
          enablePullDown: true,
          onRefresh: _onRefresh,
          controller: this._refreshController,   // 控制器
          onOffsetChange: (bool up, double offset) {},
          headerBuilder: (context, mode) {
            return new ClassicIndicator(
              mode: mode,
              height: 45.0,
              releaseText: '松开手刷新',
              refreshingText: '刷新中',
              completeText: '刷新完成',
              failedText: '刷新失败',
              idleText: '下拉刷新',
            );
          },
          child: GetListView(),
        ),
        alignment: FractionalOffset.topLeft,
      );
    }
  }

  GetListView(){
    return ListView.separated(

        itemCount: (ctlist == null)?0:ctlist.length,
        physics: new AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (content, index) {
          //Divide
          return MyDivider(color: Colors.black,indent: 82,width: 0.1,height: 0.0,);
        },
        itemBuilder: (BuildContext context,int position){
          final item = getItem(position).hashCode.toString();

          return Slidable(
            delegate: new SlidableDrawerDelegate(),
            actionExtentRatio: 0.25,
            child: getItem(position),
            actions: <Widget>[
              new IconSlideAction(
                caption: 'Archive',
                color: Colors.blue,
                icon: Icons.archive,
                onTap: () => print('s'),
              ),
              new IconSlideAction(
                caption: 'Share',
                color: Colors.indigo,
                icon: Icons.share,
                onTap: () => print('s'),
              ),
            ],
            secondaryActions: <Widget>[
              new IconSlideAction(
                caption: 'More',
                color: Colors.black45,
                icon: Icons.more_horiz,
                onTap: () => print('s'),
              ),
              new IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => print('s'),
              ),
            ],
          );
          /*return Dismissible(
                key: Key(item),
            onDismissed: (direction) {
              print("remove");
              ctlist.removeAt(position);
              //这个和Android的SnackBar差不多
              Scaffold.of(context).showSnackBar(
                  new SnackBar(content: new Text("$item dismissed")));
            },
            child: getItem(position),
            background: new Container(
                color: Colors.greenAccent,
                child: Text('luo'),
            ),
            secondaryBackground: new Container(
              color: Colors.red,
            ),
          );*/
        });
  }

  getItem(int position){
    return _Listitem(position);
  }

  void itemOnClick(){
    NavigatorUtil.pushPage(context, ChatPage(),pagename:"ChatPage");
  }

  Widget _Listitem(int position){
    ChatBean cb = ctlist[position];
    return new InkWell(
      onLongPress: (){
        print("longpress");
      },
      onTap: (){
        print("tap");
        itemOnClick();
      },
      child:  Container(
        height: 70,
        child: Padding(
            padding: new EdgeInsets.all(5.0),
            child: Row(
              children: <Widget>[

                Align(
                  child: Padding(
                      padding: new EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        radius: 30.0,
                        child:Image.asset(
                          'images/icon1.png',
                          width:65.0,
                          height: 65.0,
                        ),
                      )
                  ),
                  alignment: Alignment.center,
                ),

                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 8.0,top: 5.0,bottom: 5.0),
                          child: Align(
                              child:Text(
                                cb.chatname,
                                style: new TextStyle(fontSize: 20.0),
                              ),
                              alignment: Alignment.centerLeft
                          )
                      ),

                      Container(
                          margin: EdgeInsets.only(left: 8.0),
                          child:  Align(
                            child: Text(
                              cb.chat_mesg,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(fontSize: 15.0,color: Colors.grey),
                            ),
                            alignment: Alignment.bottomLeft,
                          )
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 8.0,top: 5.0,bottom: 8.0,right: 10.0),
                        child: Text(
                          '3月12号',
                        )
                    ),
                    Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: Align(
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 12.0,
                              child: Text(
                                cb.info_num,
                                style: TextStyle(color:Colors.white,fontSize: 10.0),
                              ),
                            ),
                            alignment: Alignment.centerRight
                        )
                    ),
                  ],
                )

              ],
            )
        ),

        /*decoration: BoxDecoration(
              border: Border(

                  bottom: BorderSide(width:0.3,color: Colors.grey,style: BorderStyle.values[1])
              )
          )*/
      ),
    );
  }
}