import 'package:chat_z/PROVIDER/myProvider.dart';
import 'package:chat_z/screens/add_room/add_room_View.dart';
import 'package:chat_z/screens/chat/chat_View.dart';
import 'package:chat_z/screens/createAccount/createAccount_screen.dart';
import 'package:chat_z/screens/home/home_view.dart';
import 'package:chat_z/screens/loginScreen/login_view.dart';
import 'package:chat_z/styles/myTheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'layout/home_layout/home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyProvider(),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);
    return MaterialApp(
      initialRoute: provider.firebaseUser!=null?HomeView.routeName:LoginScreen.routeName,
      routes: {
        HomeLayout.routName: (context) => const HomeLayout(),
        CreateAccountScreen.routeName: (context) => CreateAccountScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeView.routeName: (context) => HomeView(),
        Add_Screen_View.routeName:(context) => Add_Screen_View(),
        Chat_view.routeName:(context) => Chat_view(),
      },
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}
