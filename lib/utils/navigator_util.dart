import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';

class NavigatorUtil{

  static void pushPage(BuildContext context,Widget page,{String pagename}){
    if(context == null || page == null || ObjectUtil.isEmpty(pagename))
      return;
    Navigator.push(context, new CupertinoPageRoute(builder: (ctx) => page));

  }

}