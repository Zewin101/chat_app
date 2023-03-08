import 'package:chat_z/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/my_user.dart';
import '../../../models/room.dart';

class DatabaseUtils {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.COLLECTION_NAME)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.formJson(snapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
  }

  static Future<void> addUserToFirestore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFirestore(String id) async {
    DocumentSnapshot<MyUser> user = await getUsersCollection().doc(id).get();
    var myUser = user.data();
    return myUser;
  }

  static CollectionReference<Room> getRoomsCollection() {
    return FirebaseFirestore.instance
        .collection(Room.COLLECTION_NAME)
        .withConverter<Room>(
          fromFirestore: (snapshot, options) => Room.formJson(snapshot.data()!),
          toFirestore: (room, options) => room.toJson(),
        );
  }

  static Future<void> addRoomToFirestore(Room room) {
    var collection = getRoomsCollection();
    var docRef = collection.doc();
    room.id = docRef.id;
    return docRef.set(room);
  }

  static Future<List<Room>> readRoomsFromFirestore() async {
    QuerySnapshot<Room> snapRoom = await getRoomsCollection().get();
    return snapRoom.docs.map((e) => e.data()).toList();
  }

  static CollectionReference<Message> getMessageCollection(String roomId) {
    return getRoomsCollection()
        .doc(roomId)
        .collection(Message.COLLECTION_NAME)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              Message.formJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static Future<void> addMessageToFirestore(Message message) {
    var docRef = getMessageCollection(message.roomId).doc();
    message.id = docRef.id;
    return docRef.set(message);
  }

  static Stream<QuerySnapshot<Message>> readMessageFromFirestore(
      String roomId) {
    return getMessageCollection(roomId).orderBy('dataTime',).snapshots();
  }
}
