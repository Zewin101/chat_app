import 'package:chat_z/models/my_user.dart';
import 'package:chat_z/shared/shared/remote/DatabaseUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier{
    MyUser? myUser;
    User? firebaseUser;
    MyProvider(){
      firebaseUser=FirebaseAuth.instance.currentUser;
      if(firebaseUser!=null){
        initMyUser();
      }
    }
    void initMyUser()async{
      myUser=await DatabaseUtils.readUserFromFirestore(firebaseUser?.uid??"");
    }
}