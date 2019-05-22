import 'package:flutter/material.dart';
import '../../widgets/MyDivider.dart';

class ChatDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return drawerbuilder();
  }
}


drawerbuilder(){

  return new ListView(
      padding: const EdgeInsets.only(),
      children: <Widget>[
        Container(
          height: 200,
          color: Colors.blue,
          child: Column(
            children: <Widget>[
              Container(
                child:CircleAvatar(
                  child: Text('Luo',style: TextStyle(
                      fontSize: 25
                  ),
                  ),
                  radius: 38,
                ),
                padding: EdgeInsets.only(left:15, top:60),
                alignment: Alignment.centerLeft,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left:26, top:20),
                child: Text('Luo shao',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                  ),
                ),
              )
            ],
          ),
        ),
        new Container(
          height: 60,
          padding: EdgeInsets.only(top: 0),
          child: ListTile(
            leading: Icon(Icons.person,size: 30,),
            title: new Text('个人信息'),
            subtitle: new Text("Drawer item B subtitle"),
            onTap: () => {},
          ),
        ),
        new Container(
          height: 60,
          padding: EdgeInsets.only(top: 0),
          child: ListTile(
            leading: Icon(Icons.add_circle,size: 30,),
            title: new Text('新建频道'),
            subtitle: new Text("Drawer item B subtitle"),
            onTap: () => {},
          ),
        ),
        new Container(
          height: 60,
          padding: EdgeInsets.only(top: 0),
          child: ListTile(
            leading: Icon(Icons.people,size: 30,),
            title: new Text('新建群聊'),
            subtitle: new Text("Drawer item B subtitle"),
            onTap: () => {},
          ),
        ),
        MyDivider(),
        new Container(
          height: 60,
          padding: EdgeInsets.only(top: 0),
          child: ListTile(
            leading: Icon(Icons.account_box,size: 30,),
            title: new Text('联系人'),
            subtitle: new Text("Drawer item B subtitle"),
            onTap: () => {},
          ),
        ),
        new Container(
          height: 60,
          padding: EdgeInsets.only(top: 0),
          child: ListTile(
            leading: Icon(Icons.settings,size: 30,),
            title: new Text('设置'),
            subtitle: new Text("Drawer item B subtitle"),
            onTap: () => {},
          ),
        ),
        new Container(
          height: 60,
          padding: EdgeInsets.only(top: 0),
          child: ListTile(
            leading: Icon(Icons.announcement,size: 30,),
            title: new Text('大学物语'),
            subtitle: new Text("Drawer item B subtitle"),
            onTap: () => {},
          ),
        ),

      ]
  );
}
