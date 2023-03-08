import 'package:chat_z/base.dart';
import 'package:chat_z/models/my_user.dart';

import 'package:chat_z/shared/constants/constants.dart';
import 'package:chat_z/shared/shared/remote/DatabaseUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'createAccountNavigator.dart';

class CreateAccountViewModel extends BaseViewModel<CreateAccountNavigator> {
  void createAccountWithFirebaseAuth(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
     required String userName}) async {
    try {
      navigator?.showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      navigator!.hideLoading();
      navigator!.showMessage(FirebaseError.accountCreated);

      //--------------------------------------------------
      MyUser myUser = MyUser(
          id: credential.user!.uid,
          firstName: firstName,
          lastName: lastName,
          userName: userName,
          email: email);
      await DatabaseUtils.addUserToFirestore(myUser).then((value) {
        navigator!.hideLoading();
        navigator!.goToHome(myUser);

        return;
      });
      //----------------------------------------------------
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseError.weakPassword) {
        navigator!.hideLoading();
        navigator!.showMessage(FirebaseError.passwordWeak);
      } else if (e.code == FirebaseError.emailAlreadyInUse) {
        navigator!.hideLoading();
        navigator!.showMessage(FirebaseError.existsEmail);

      }
    } catch (e) {
      navigator!.hideLoading();
      navigator!.showMessage(e.toString());
    }
  }
}
