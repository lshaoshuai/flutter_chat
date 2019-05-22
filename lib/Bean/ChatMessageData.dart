import 'dart:convert';
class ChatMessageData {
  final String id;
  final String msg;
  final DateTime created;
  final String name;
  final String role;
  ChatMessageData(
      this.id,
      this.msg,
      this.name,
      this.role,
      this.created,
      );
  static ChatMessageData formMap(Map map) => ChatMessageData(
      map['id'],
      map['msg'],
      map['name'],
      map['role'],
      DateTime.fromMicrosecondsSinceEpoch(map['created']));

  Map toMap() => {
    "id": id,
    "msg": msg,
    "name": name,
    "role":role,
    "created": created.millisecondsSinceEpoch
  };

  String toJson() => jsonEncode(toMap());
  @override
  String toString() => toMap().toString();
}