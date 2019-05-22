import 'package:dio/dio.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'dart:io';

class Httputil {


  void httpconnect()async{

    Dio dio = new Dio();
    Response response = await dio.get("http://192.168.1.102:8080/sendToAll");
    print(response.data);
  }

}
