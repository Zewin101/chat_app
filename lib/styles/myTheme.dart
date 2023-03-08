import 'package:flutter/material.dart';

import 'colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
      primaryColor: CHATCOLOR,
      scaffoldBackgroundColor: Colors.transparent,
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: greenBackground,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: greenBackground,
          onBackground: primaryColor,
          surface: Colors.grey,
          onSurface: Colors.black),
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.only(
          //   bottomLeft: Radius.circular(20),
          //   bottomRight: Radius.circular(20),
          // )),
          // backgroundColor: MOVE_COLOR,
          iconTheme: IconThemeData(color: Colors.white)),
      textTheme: const TextTheme(
        headline1: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        subtitle1: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: CHATCOLOR),
        headline2: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: CHATCOLOR),
        subtitle2: TextStyle(
            fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: CHATCOLOR),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: CHATCOLOR,
          unselectedItemColor: Colors.grey));

  static ThemeData darkTheme = ThemeData(
      primaryColor: CHATCOLOR,
      scaffoldBackgroundColor: Colors.transparent,
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: greenBackground,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: greenBackground,
          onBackground: primaryColor,
          surface: Colors.grey,
          onSurface: Colors.black),
      appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.only(
          //   bottomLeft: Radius.circular(20),
          //   bottomRight: Radius.circular(20),
          // )),
          // backgroundColor: MOVE_COLOR,
          iconTheme: IconThemeData(color: Colors.white)),
      textTheme: const TextTheme(
        headline1: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        subtitle1: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: CHATCOLOR),
        subtitle2: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: CHATCOLOR),
      ),
      floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: CHATCOLOR),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: CHATCOLOR,
          unselectedItemColor: Colors.grey));

}
