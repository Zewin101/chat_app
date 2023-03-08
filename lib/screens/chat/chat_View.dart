import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_z/PROVIDER/myProvider.dart';
import 'package:chat_z/base.dart';
import 'package:chat_z/models/message.dart';
import 'package:chat_z/screens/chat/chat-Naviagator.dart';
import 'package:chat_z/screens/chat/chat_ViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import '../../models/room.dart';
import '../../styles/colors.dart';
import '../loginScreen/login_view.dart';
import 'message_widget.dart';

class Chat_view extends StatefulWidget {
  static const String routeName = "chatView";

  @override
  State<Chat_view> createState() => _Chat_viewState();
}

class _Chat_viewState extends BaseView<Chat_view, Chat_ViewModel>
    implements Chat_Naviagator {
  var messageController=TextEditingController();
  var formKey=GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)?.settings.arguments as Room;
    viewModel.room=room;
    var provider=Provider.of<MyProvider>(context);
viewModel.myUser=provider.myUser!;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(children: [
        Image.asset(
          Assets.imagesBackground,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
        Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
              MediaQuery.of(context).size.height * 0.10,
            ),
            child: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      Logout();
                    },
                    icon: const Icon(Icons.logout))
              ],
              title: Text(
                room.title,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
          body: Container(
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3))
                ]),
            child: Column(
              children: [
                Expanded(child: StreamBuilder<QuerySnapshot<Message>>(
                  stream: viewModel.getMessage(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(color: CHATCOLOR,));
                    }
                    if(snapshot.hasError){
                      return Center(child: const Text('some thing went wrong '));
                    }
                    var messages=snapshot.data?.docs.map((e) => e.data()).toList()??[];
                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) => MessageWidget(messages[index]));
                  },
                )),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * .06,
                          child: TextFormField(
                            validator: (value) {
                              if(value!.isEmpty||value.trim()==''){
return"ddd";
                              }
                              else {
                                return null;
                              }
                            },
                            controller: messageController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.newline,
                            decoration: const InputDecoration(
                              hintText: " Type message",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.only(topRight: Radius.circular(15))),
                              enabledBorder:  OutlineInputBorder(
                            borderRadius:
                            BorderRadius.only(topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15)
                            )),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .06,
                            child: ElevatedButton(
                                onPressed: () {
                                  viewModel.sendMessage(messageController.text,);

                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(CHATCOLOR),
                                    foregroundColor: MaterialStateProperty.all<Color>(
                                        Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft:Radius.circular(15) ,
                                      bottomRight: Radius.circular(15)
                                      ),
                                      side: BorderSide(color: CHATCOLOR)
                                    ),
                                    ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                 Text(
                                      "Send",
                                      style: Theme.of(context).textTheme.headline1,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),

                                    Icon(Icons.send),
                                  ],
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Chat_ViewModel initViewModel() {
    return Chat_ViewModel();
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

  void sendMessageValid() {
    if(formKey.currentState!.validate()){
      viewModel.sendMessage(messageController.text,);
    }
  }

  @override
  void uploadMessageToFirestore() {
    messageController.clear();
    setState(() {

    });
  }
}
