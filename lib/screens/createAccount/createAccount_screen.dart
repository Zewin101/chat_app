import 'package:chat_z/base.dart';
import 'package:chat_z/models/my_user.dart';
import 'package:chat_z/screens/createAccount/createAccountNavigator.dart';

import 'package:chat_z/screens/createAccount/createAccount_VM.dart';
import 'package:chat_z/screens/home/home_view.dart';
import 'package:chat_z/screens/loginScreen/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../PROVIDER/myProvider.dart';
import '../../generated/assets.dart';
import '../../styles/colors.dart';

class CreateAccountScreen extends StatefulWidget {
  static const String routeName = 'CreateAccount';

  CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState
    extends BaseView<CreateAccountScreen, CreateAccountViewModel>
    implements CreateAccountNavigator {
  var userNameController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Image.asset(
            Assets.imagesBackground,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                MediaQuery.of(context).size.height * 0.30,
              ),
              child: AppBar(
                // toolbarHeight: MediaQuery.of(context).size.height * 0.30,
                title: Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.trim() == '') {
                            return 'Enter first name';
                          }
                          return null;
                        },
                        controller: firstNameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'first name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: CHATCOLOR),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: CHATCOLOR),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.trim() == '') {
                            return 'Enter last name';
                          }
                          return null;
                        },
                        controller: lastNameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'last name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: CHATCOLOR),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: CHATCOLOR),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.trim() == '') {
                            return 'Enter username';
                          }
                          return null;
                        },
                        controller: userNameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'username',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: CHATCOLOR),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: CHATCOLOR),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value == '') {
                            return 'Enter email';
                          }

                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (!emailValid) return 'Type the email correctly';
                          return null;
                        },
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'email',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: CHATCOLOR),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: CHATCOLOR),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value == '') {
                            return 'Enter password';
                          }
                          return null;
                        },
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isPassword,
                        decoration: InputDecoration(
                          labelText: 'password',
                          prefixIcon: isPassword
                              ? const Icon(Icons.lock)
                              : const Icon(Icons.lock_open),
                          suffixIcon: IconButton(
                            onPressed: () {
                              isPassword = !isPassword;
                              setState(() {});
                            },
                            icon: isPassword
                                ? const Icon(Icons.remove_red_eye)
                                : const Icon(Icons.remove_red_eye_outlined),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: CHATCOLOR),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: CHATCOLOR),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .07,
                        child: ElevatedButton(
                            onPressed: () {
                              CreateAccount();
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(CHATCOLOR),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  // side: BorderSide(color: CHATCOLOR)
                                ))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Create Account ",
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                Icon(Icons.double_arrow),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextButton(
                          onPressed: () {
                            goToLoginAccount();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "I Have an account ",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Icon(Icons.arrow_forward_outlined,
                                  color: CHATCOLOR),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void CreateAccount() async {
    if (formKey.currentState!.validate()) {
      viewModel.createAccountWithFirebaseAuth(
      email: emailController.text,
        lastName: lastNameController.text,
        firstName: firstNameController.text,
        password: passwordController.text,
        userName: userNameController.text

      );
    }
  }

  @override
  CreateAccountViewModel initViewModel() {
    return CreateAccountViewModel();
  }

  @override
  void goToHome(MyUser myUser) {
    Provider.of<MyProvider>(context,listen: false);
    Navigator.pushReplacementNamed(context, HomeView.routeName);
  }

  void goToLoginAccount() {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }
}
