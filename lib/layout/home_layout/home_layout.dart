import 'package:flutter/material.dart';


class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);
  static const String routName = "HomeLayout";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: (){

          }),
      appBar: AppBar(),

    );
  }

}
