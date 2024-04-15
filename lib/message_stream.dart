import 'package:flash_chat/firebase_services/firestore_services.dart';
import 'package:flash_chat/model/message_model.dart';
import 'package:flash_chat/user_provider.dart';
import 'package:flash_chat/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'message_bubble.dart';
import 'model/user_model.dart';

class MessageStream extends StatelessWidget {
  const MessageStream({
    Key? key,
    required this.withUser,
  }) : super(key: key);

  final String withUser;

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).getUser();

    return Expanded(
      child: StreamBuilder(
          stream: CloudService.userCollection
              .doc(userModel.id)
              .collection('messages')
              .where('withUser', isEqualTo: withUser)
              .orderBy('timeStamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<MessageModel> msgModels = snapshot.data!.docs
                  .map((e) => MessageModel.fromSnapshot(e))
                  .toList();
              List<MessageBubble> messagesList = List.generate(
                msgModels.length,
                (index) => MessageBubble(
                  msgModel: msgModels[index],
                  isMe: msgModels[index].isMe,
                  imageUrl: msgModels[index].imageUrl,
                ),
              );
              return ListView.builder(
                reverse: true,
                itemCount: messagesList.length,
                itemBuilder: (context, index) => messagesList[index],
              );
            } else {
              return const Loading();
            }
          }),
    );
  }
}
