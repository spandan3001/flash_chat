import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/firebase_services/firestore_services.dart';
import 'package:flash_chat/model/chat_model.dart';
import 'package:flash_chat/model/user_model.dart';
import 'package:flash_chat/screens/Image_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flash_chat/input_box.dart';
import 'package:flash_chat/message_stream.dart';

class ChatScreen extends StatefulWidget {
  static const id = 'chat_screen';
  const ChatScreen({
    super.key,
    required this.userModel,
    required this.withUser,
    required this.withUserDocId,
  });

  final UserModel userModel;
  final String withUser;
  final String withUserDocId;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  late String textMessage;
  late ChatModel chatModel;

  @override
  void initState() {
    super.initState();
  }

  File? selectedImage;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leadingWidth: 70,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              const Icon(Icons.arrow_back),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: const Icon(
                  Icons.account_circle,
                  size: 40,
                  color: Colors.black12,
                ),
              ),
            ],
          ),
        ),
        titleSpacing: 0,
        title: Text(widget.withUser),
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(
              withUser: widget.withUser,
            ),
            InputMessage(
              controller: messageController,
              onImageSelect: () async {
                await pickImage();
                if (context.mounted) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageScreen(
                                userModel: widget.userModel,
                                withUser: widget.withUser,
                                withUserDocId: widget.withUserDocId,
                                selectedImage: selectedImage,
                              )));
                }
              },
              onPressed: () {
                if (messageController.text.trim().isNotEmpty) {
                  FieldValue fieldValue = FieldValue.serverTimestamp();
                  CloudService.userCollection
                      .doc(widget.userModel.id)
                      .collection('messages')
                      .add(
                    {
                      'text': messageController.text.trim(),
                      'withUser': widget.withUser,
                      'timeStamp': fieldValue,
                      'withUserDocId': widget.withUserDocId,
                      'isMe': true,
                    },
                  );
                  CloudService.userCollection
                      .doc(widget.withUserDocId)
                      .collection('messages')
                      .add(
                    {
                      'text': messageController.text.trim(),
                      'withUser': widget.userModel.email,
                      'timeStamp': fieldValue,
                      'withUserDocId': widget.userModel.id,
                      'isMe': false,
                    },
                  );
                }
                messageController.clear();
              },
            )
          ],
        ),
      ),
    );
  }
}
