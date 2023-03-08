import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_z/base.dart';
import 'package:chat_z/screens/add_room/add_room_View.dart';
import 'package:chat_z/screens/home/home_naviagtor.dart';
import 'package:chat_z/screens/home/roomWidget.dart';
import 'package:chat_z/screens/loginScreen/login_view.dart';
import 'package:chat_z/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import 'home_ViewModel.dart';

class HomeView extends StatefulWidget {
  static const String routeName = 'homeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseView<HomeView, HomeViewModel>
    implements HomeNavigator {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    viewModel.readRooms();
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                goToRoomChat();
              },
              child: const Icon(Icons.add),
            ),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                MediaQuery.of(context).size.height * 0.10,
              ),
              child: AppBar(
                // toolbarHeight: MediaQuery.of(context).size.height * 0.30,
                actions: [
                  IconButton(
                      onPressed: () {
                        Logout();
                      },
                      icon: const Icon(Icons.logout))
                ],
                title: Text(
                  'Chat App',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 22,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.transparent)),

                child: Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: Consumer<HomeViewModel>(
                    builder: (context, homeViewModel, child) {
                      return GridView.builder(
                        itemCount: homeViewModel.rooms.length,
                        itemBuilder: (context, index) {
                          return RoomWidget(homeViewModel.rooms[index]);
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          childAspectRatio:MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.8),
                          mainAxisSpacing: 0


                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }

  void goToRoomChat() {
    Navigator.pushNamed(context, Add_Screen_View.routeName);
  }

  void Logout() {
    AwesomeDialog(
        barrierColor: CHATCOLOR,
        btnCancelColor: CHATCOLOR,
        btnOkColor: CHATCOLOR2,
        titleTextStyle: Theme.of(context).textTheme.subtitle1,
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        title: 'Do you want to SingOut ?',
        desc: '',
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }).show();
  }
}
