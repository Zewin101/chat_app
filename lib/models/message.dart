class Message {
  String id;
  String content;
  int dataTime;
  String roomId;
  String senderId;
  String senderName;
  static const String COLLECTION_NAME='message';
  Message(
      {this.id = '',
      required this.content,
      required this.dataTime,
      required this.roomId,
      required this.senderId,
      required this.senderName});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'dataTime': dataTime,
      'roomId': roomId,
      'senderId': senderId,
      'senderName': senderName,
    };
  }

  Message.formJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          content: json['content'],
          dataTime: json['dataTime'],
          roomId: json['roomId'],
          senderId: json['senderId'],
          senderName: json['senderName'],
        );
}
