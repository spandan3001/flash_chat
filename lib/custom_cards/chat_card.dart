import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import '../model/message_model.dart';
import '../model/user_model.dart';

class ChatCard extends StatelessWidget {
  const ChatCard(
      {super.key,
      required this.userModel,
      required this.withUser,
      required this.lastChat});

  final String withUser;
  final UserModel userModel;
  final MessageModel lastChat;

  @override
  Widget build(BuildContext context) {
    // Color cardColor = Colors.transparent;
    //
    // Color splashColor = Colors.grey.shade400;
    String? lastMsg = lastChat.text;
    return InkWell(
      // onTap: () {
      //   onTapCardSelection();
      //   Navigator.pushNamed(context, ChatScreen.id);
      // },
      onLongPress: () {},
      //containedInkWell: true,
      //highlightShape: BoxShape.rectangle,
      //splashFactory: InkRipple.splashFactory,
      //splashColor: splashColor,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              userModel: userModel,
              withUser: withUser,
              withUserDocId: lastChat.withUserDocId,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: const Icon(
                    Icons.account_circle,
                    color: Colors.black12,
                    size: 50,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      withUser,
                      style: const TextStyle(fontSize: 15),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.done_all,
                          size: 20,
                          color: Colors.lightBlueAccent,
                        ),
                        const SizedBox(width: 5),
                        Text(lastMsg ?? ""),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Text("yesterday"),
          ],
        ),
      ),
    );
  }
}
