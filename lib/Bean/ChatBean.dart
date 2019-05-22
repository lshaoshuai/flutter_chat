/**
 * @Description  聊天消息实体类
 * @Author  luoshao
 * @Date 2018/10/26  14:35
 * @Version  1.0
 */
class ChatBean extends Object{

  var pic;
  var chatname;
  var info_num;
  var chat_mesg;

  ChatBean(var pic,var chatname,var info_num,var chat_mesg){

    this.pic= pic;
    this.chatname= chatname;
    this.info_num= info_num;
    this.chat_mesg= chat_mesg;

  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }

}