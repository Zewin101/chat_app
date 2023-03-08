import 'package:chat_z/base.dart';
import 'package:chat_z/models/room.dart';
import 'package:chat_z/screens/add_room/add_room_Naviagator.dart';
import 'package:chat_z/screens/add_room/add_room_View.dart';
import 'package:chat_z/shared/shared/remote/DatabaseUtils.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  void AddRoomToFirestor(String title, String description, String categoryId) {

    Room room =
        Room(title: title, description: description, categoryId: categoryId);
    DatabaseUtils.addRoomToFirestore(room).then((value) {

      navigator!.RoomCreated();
      print("room add");}).catchError((e) {});
  }
}
