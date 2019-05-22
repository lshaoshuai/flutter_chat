import 'dart:async';
import 'package:luotest/blocbase/BlocBase.dart';

class composebloc extends BlocBase {
  final _controller =  StreamController<bool>();
  get _iscomposing => _controller.sink;
  get iscomposing => _controller.stream;

  void getiscomposing(bool value){
    _iscomposing.add(value);
  }


  void dispose(){
    _controller.close();
  }
}