/**
 * 路由定义
 * Create by Songlcy
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../ui/page/loginpage.dart';
//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../ui/page/findpage/find_page.dart';
import '../ui/page/chatpage/chatpage.dart';
import '../ui/page/detail/video_detail_page.dart';
import '../models/pood/video_model.dart';
import '../ui/page/movie/moviepage.dart';
import '../ui/page/mainpage.dart';

var findpageRouteHandler = Handler(
  handlerFunc: (BuildContext context,Map<String, List<String>> params){
    return FindPage();
  }
);

var moviepageRouteHandler = Handler(
    handlerFunc: (BuildContext context,Map<String, List<String>> params){
      return MoviePage();
    }
);

var videoDetailRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params["id"]?.first;
      String timestamp = params["timestamp"]?.first;
      String thumbnail = params["thumbnail"]?.first;
      String name = params["name"]?.first;
      String latest = params["latest"]?.first;
      String generatedAt = params["generatedAt"]?.first;
      return VideoDetailPage(
          videoItem: VideoModel(
            id: id,
            generatedAt: generatedAt,
            name: name,
            latest: latest,
            thumbnail: thumbnail,
            timestamp: timestamp,
          )
      );
    }
);

var rootRouteHandler = Handler(
    handlerFunc: (BuildContext context,Map<String, List<String>> params){
      return MainPage();
    }
);

var loginpageRouteHandler = Handler(
    handlerFunc: (BuildContext context,Map<String, List<String>> params){
      return LoginPage();
    }
);

var chatpageRouteHandler = Handler(
    handlerFunc: (BuildContext context,Map<String, List<String>> params){
      return ChatPage();
    }
);

/*var webviewRouteHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String title = params["title"]?.first;
    String url = params["url"]?.first;
    return WebviewScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      url: url,
    );
  }
);*/