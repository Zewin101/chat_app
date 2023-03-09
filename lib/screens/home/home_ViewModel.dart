
import 'package:chat_z/base.dart';
import 'package:chat_z/screens/home/home_naviagtor.dart';
import 'package:chat_z/shared/shared/remote/DatabaseUtils.dart';

import '../../models/room.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator>{
  List<Room> rooms=[];
 readRooms()async{
 return await DatabaseUtils.readRoomsFromFirestore().then((value) {
   rooms=value;
 }).catchError((onError){
   navigator!.showLoading(message: onError.toString());
 });
}
}