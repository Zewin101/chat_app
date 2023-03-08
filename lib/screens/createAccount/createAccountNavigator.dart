import 'package:chat_z/base.dart';
import 'package:chat_z/models/my_user.dart';

abstract class CreateAccountNavigator extends BaseNavigator{
void goToHome(MyUser myUser);
}