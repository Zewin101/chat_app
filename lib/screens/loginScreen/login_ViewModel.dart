import 'package:chat_z/base.dart';
import 'package:chat_z/models/my_user.dart';
import 'package:chat_z/shared/shared/remote/DatabaseUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../shared/constants/constants.dart';
import 'login_Navigator.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  void Login_Account(String email, String password) async {
    try {
      navigator!.showLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      navigator!.hideLoading();
      navigator!.showMessage(FirebaseError.loginSuccessfully);
      MyUser? myUser =
          await DatabaseUtils.readUserFromFirestore(credential.user?.uid ?? '');
      if (myUser != null) {
        print(myUser);
        navigator!.hideLoading();
        navigator!.goToHome(myUser);

        return;
      }
    } on FirebaseAuthException catch (e) {
      navigator!.hideLoading();
      navigator!.showMessage(FirebaseError.wrongEmailOrPassword);
    } catch (e) {
      navigator!.hideLoading();
      navigator!.showMessage(e.toString());
    }
  }
}
