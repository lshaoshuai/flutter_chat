import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../config/application.dart';
import '../../route/routes.dart';
import '../page/personal/personpage.dart';
import '../page/findpage/find_page.dart';
import '../page/chatpage/chatmainpage.dart';
import '../page/loginpage.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key) {
    print('new $key');
  }
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{

  static int lastExitTime = 0;
  bool isLogin = true;
  List<Widget> bodylist = List(); //创建一个非固定长度的widget列表
  int _currentindex = 0;

  @override
  void initState() {
    print("initstate");
    super.initState();
    bodylist..add(ChatMainPage())..add(FindPage())..add(PersonPage());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return WillPopScope(
        onWillPop: _onBackPressed,
        child:Scaffold(
          resizeToAvoidBottomPadding: false,
          body: bodylist[_currentindex],
          bottomNavigationBar: _MainBottomBar(),
        )
    );
  }

  Future<bool> _onBackPressed() async {
    int nowExitTime = DateTime.now().millisecondsSinceEpoch;
    if(nowExitTime - lastExitTime > 2000) {
      lastExitTime = nowExitTime;
      Fluttertoast.showToast(
          msg: "再按一次退出程序",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return await Future.value(false);
    }
    return await Future.value(true);
  }


  ///主页的底部导航栏
  ///
  Widget _MainBottomBar() {

    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      elevation: 1.0,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Colors.white70.withOpacity(0.8),
          icon: Icon(Icons.home, color: Colors.grey),
          activeIcon: Icon(Icons.home, color: Colors.black54,),
          title: Text(
            '主页',
            style: _currentindex == 0 ? TextStyle(color: Colors.black54,): TextStyle(color: Colors.grey),
          ),
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.white70.withOpacity(0.8),
          icon: Icon(Icons.camera, color: Colors.grey),
          activeIcon: Icon(Icons.camera, color: Colors.black54,),
          title: Text(
            '发现',
            style: _currentindex == 1 ? TextStyle(color: Colors.black54,): TextStyle(color: Colors.grey),
          ),
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.white70.withOpacity(0.8),
          icon: Icon(Icons.person, color: Colors.grey),
          activeIcon: Icon(Icons.person, color: Colors.black54,),
          title: Text(
            'ME',
            style: _currentindex == 2 ? TextStyle(color: Colors.black54,): TextStyle(color: Colors.grey),
          ),
        ),
      ],
      currentIndex: _currentindex,
      onTap: (int index) {
        setState(() {
          _currentindex = index;
        });
      },
    );
  }
}