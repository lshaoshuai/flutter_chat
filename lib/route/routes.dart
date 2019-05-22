/**
 * 路由配置
 * Create by Songlcy
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {
  static String root = "/";
  static String webview = "/webview";
  static String findpage = "/findpage";
  static String chatpage = "/chatpage";
  static String moviepage = "/moviepage";
  static String videoDetail = "/videoDetail";
  static String loginpage = "/loginpage";

  static void configureRoutes(Router router) {

    router.define(findpage, handler: findpageRouteHandler);
    router.define(moviepage, handler: moviepageRouteHandler);
    //router.define(webview, handler: webviewRouteHandler);
    router.define(videoDetail, handler: videoDetailRouteHandler);
    router.define(chatpage, handler: chatpageRouteHandler);
    router.define(root, handler: rootRouteHandler);
    router.define(loginpage, handler: loginpageRouteHandler);

    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
        });
  }
}
