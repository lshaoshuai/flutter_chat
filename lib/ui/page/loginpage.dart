import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:luotest/config/application.dart';
import '../../route/routes.dart';
import 'package:luotest/ui/page/mainpage.dart';
import 'package:luotest/ui/widgets/shimmer.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

//import 'package:shimmer/shimmer.dart';
import 'package:luotest/ui/style/theme.dart' as Themes;

String _email, _password;
Color _eyeColor;
bool _isObscure = true;
List _loginMethod = [
  {"title": "facebook", "icon": GroovinMaterialIcons.wechat},
  {
    "title": "google",
    "icon": GroovinMaterialIcons.qqchat,
  },
  {
    "title": "twitter",
    "icon": GroovinMaterialIcons.school,
  },
];

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: loginbody(context),
    );
  }

  ///
  /// 主体
  Widget loginbody(BuildContext context) {
    return new Container(
        //color: const Color.fromRGBO(107, 107, 107, 0.35),
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('images/qidong.jpg'),
            fit: BoxFit.cover,
          ),
          //渐变色
          /*gradient: new LinearGradient(
                colors: [
                  Theme.Colors.loginGradientStart,
                  Theme.Colors.loginGradientEnd
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp
            )*/
        ),
        child: new ListView(
          children: <Widget>[
            loginTopImage(),
            TopLogo(context),
            new Container(
                margin: const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
                child: new Material(
                    color: const Color.fromRGBO(116, 117, 117, 0.2),
                    borderRadius: new BorderRadius.horizontal(
                        left: new Radius.circular(20.0),
                        right: new Radius.circular(20.0)),
                    child: new Column(
                      children: <Widget>[
                        loginSchoolInput(),
                        loginUserEditInput(),
                        loginPassword(context),
                      ],
                    ))),
            loginButton(context),
            SizedBox(height: 100.0),
            buttomLine(),
            ButtonLogo(context),
            buildOtherMethod(context),
            buildRegisterText(context),
          ],
        ));
  }

  ///
  /// 密码输入框
  ///
  Widget loginPassword(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
      child: new Stack(
        alignment: Alignment(1.0, 1.0),
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.all(5.0),
                child: new Icon(Icons.lock),
              ),
              new Expanded(
                  child: new TextFormField(
                //onSaved: (String value) => _password = value,
                obscureText: _isObscure,
                controller: passController,
                decoration: new InputDecoration(hintText: "请输入密码"),
              )),
            ],
          ),
          new IconButton(
              icon: new Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = _isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })
        ],
      ),
    );
  }
}

TextEditingController schoolController = new TextEditingController();
TextEditingController userController = new TextEditingController();
TextEditingController passController = new TextEditingController();

Widget ButtonLogo(BuildContext context) {
  return Container(
    margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
    child: TypewriterAnimatedTextKit(
      onTap: () {
        print("Tap Event");
      },
      text: [
        "the story of your university",
        "write down your beautiful memory",
        "Don't leave any regrets"
        "face life with a smile"
      ],
      textStyle: TextStyle(fontSize: 20.0, fontFamily: "lishu",color: Color.fromRGBO(116, 116, 116, 0.9)),
    ),
  );
}

Widget TopLogo(BuildContext context) {
  return SizedBox(
    height: 70,
    child: Shimmer.fromColors(
      baseColor: Color.fromRGBO(109, 39, 209, 0),
      highlightColor: Color.fromRGBO(212, 127, 66, 1.0),
      child: Text(
        '大学物语',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 65.0,
          fontFamily: 'lishu',
        ),
      ),
    ),
  );
}

///
Widget buildOtherMethod(BuildContext context) {
  return ButtonBar(
    alignment: MainAxisAlignment.center,
    children: _loginMethod
        .map((item) => Builder(
              builder: (context) {
                return IconButton(
                    icon: Icon(item['icon'], color: Colors.black),
                    onPressed: () {
                      //TODO : 第三方登录方法
                      Scaffold.of(context).showSnackBar(new SnackBar(
                        content: new Text("${item['title']}登录"),
                        action: new SnackBarAction(
                          label: "取消",
                          onPressed: () {},
                        ),
                      ));
                    });
              },
            ))
        .toList(),
  );
}

///
///
///
Widget buildRegisterText(BuildContext context) {
  return Align(
    alignment: Alignment.center,
    child: Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('没有账号？'),
          GestureDetector(
            child: Text(
              '点击注册',
              style: TextStyle(color: Colors.greenAccent),
            ),
            onTap: () {
              //TODO 跳转到注册页面
              print('去注册');
              //Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}

///
/// 底部分割线
///
Widget buttomLine() {
  return new Container(
    decoration: new UnderlineTabIndicator(
        borderSide: BorderSide(width: 1.0, color: Colors.black26),
        insets: EdgeInsets.fromLTRB(50, 0, 50, 10)),
  );
}

///
/// 顶部LOGO
///
Widget loginTopImage() {
  return new Padding(
      padding: EdgeInsets.all(5.0),
      child: Image.asset(
        'images/login_logo.png',
        height: 200,
        width: 200,
      ));
}

///
/// 学校输入框
///
Widget loginSchoolInput() {
  return new Padding(
    padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
    child: new Stack(
      alignment: Alignment(1.0, 1.0),
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.all(5.0),
              child: new Icon(Icons.school),
            ),
            new Expanded(
                child: new TextField(
              controller: schoolController,
              decoration: new InputDecoration(hintText: "请输入学校"),
            ))
          ],
        )
      ],
    ),
  );
}

///
/// 用户名输入框
///
Widget loginUserEditInput() {
  return new Padding(
    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    child: new Stack(
      alignment: Alignment(1.0, 1.0),
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.all(5.0),
              child: new Icon(Icons.perm_identity),
            ),
            new Expanded(
                child: new TextField(
              controller: userController,
              decoration: new InputDecoration(hintText: "请输入用户名"),
            )),
          ],
        ),
        new IconButton(
            icon: new Icon(Icons.clear),
            onPressed: () {
              userController.clear();
            })
      ],
    ),
  );
}

///
/// 登陆按钮
///
Widget loginButton(BuildContext context) {
  return new Container(
    padding: EdgeInsets.fromLTRB(70.0, 15.0, 70.0, 0.0),
    child: new FlatButton(
      color: const Color.fromRGBO(107, 107, 107, 0.35),
      child: new Padding(
        padding: EdgeInsets.all(8.0),
        child: new Text(
          "登录",
          style: new TextStyle(
              fontFamily: 'HanaleiFill', color: Colors.white, fontSize: 16.0),
        ),
      ),
      onPressed: () {
        _checkSub(context);
      },
    ),
  );
}

///
/// 登陆提交校验
///
void _checkSub(BuildContext context) {
  Navigator.pop(context);
}
