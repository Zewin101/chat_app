import 'package:chat_z/base.dart';
import 'package:chat_z/models/message.dart';
import 'package:chat_z/models/my_user.dart';
import 'package:chat_z/models/room.dart';
import 'package:chat_z/screens/chat/chat-Naviagator.dart';
import 'package:chat_z/shared/shared/remote/DatabaseUtils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat_ViewModel extends BaseViewModel<Chat_Naviagator> {
  late Room room;
  late MyUser myUser;

  void sendMessage(String content) {
    Message message = Message(
        content: content,
        dataTime: DateTime.now().millisecondsSinceEpoch,
        roomId: room.id,
        senderId: myUser.id,
        senderName: myUser.userName);
    DatabaseUtils.addMessageToFirestore(message)
        .then((value) => navigator!.uploadMessageToFirestore());
  }

  Stream<QuerySnapshot<Message>> getMessage() {
    return DatabaseUtils.readMessageFromFirestore(room.id);
  }
}
