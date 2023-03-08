import 'package:chat_z/PROVIDER/myProvider.dart';
import 'package:chat_z/models/message.dart';
import 'package:chat_z/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  Message message;

  MessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return provider.myUser!.id == message.senderId
        ? SenderMessage(message)
        : ReceivedMessage(message);
  }
}

class SenderMessage extends StatelessWidget {
  Message message;

  SenderMessage(this.message);

  @override
  Widget build(BuildContext context) {
    int ts = message.dataTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);

    var date = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              // width: MediaQuery.of(context).,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: const BoxDecoration(
                color: CHATCOLOR2,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  message.content,
                  style: Theme.of(context).textTheme.headline1,
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(date.substring(12)),
          )
        ],
      ),
    );
  }
}

class ReceivedMessage extends StatelessWidget {
  Message message;

  ReceivedMessage(this.message);

  @override
  Widget build(BuildContext context) {
    int ts = message.dataTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);

    var date = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              // width: MediaQuery.of(context).,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: const BoxDecoration(
                color: CHATCOLOR3,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  message.content,
                  style: Theme.of(context).textTheme.headline1?.copyWith(color: CHATCOLOR),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(date.substring(12)),
          )
        ],
      ),
    );
  }
}
