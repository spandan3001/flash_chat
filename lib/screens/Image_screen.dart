import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/firebase_services/firestore_services.dart';
import 'package:flash_chat/model/chat_model.dart';
import 'package:flash_chat/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/input_box.dart';

import '../utils/show_alert.dart';

class ImageScreen extends StatefulWidget {
  static const id = 'image_screen';
  const ImageScreen({
    super.key,
    required this.userModel,
    required this.withUser,
    required this.withUserDocId,
    this.selectedImage,
  });

  final UserModel userModel;
  final String withUser;
  final String withUserDocId;
  final File? selectedImage;
  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final messageController = TextEditingController();
  late String textMessage;
  late ChatModel chatModel;
  String? imageUrl;

  Future<void> sendImage({required String userId}) async {
    DateTime time = DateTime.now();
    if (widget.selectedImage != null) {
      TaskSnapshot? taskSnapshot = await CloudStorage.upload(
          widget.selectedImage!, "$userId${time.millisecondsSinceEpoch}.jpg");
      imageUrl = await taskSnapshot?.ref.getDownloadURL();
    } else {
      showAlertDialog(context, text: "something went wrong", title: "status");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("IMAGE"),
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            if (widget.selectedImage != null)
              SizedBox(
                child: Image.file(
                  widget.selectedImage!,
                  fit: BoxFit.fill,
                ),
              ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: InputMessage(
                controller: messageController,
                onPressed: () {
                  if (messageController.text.trim().isNotEmpty) {
                    FieldValue fieldValue = FieldValue.serverTimestamp();
                    // CloudService.userCollection
                    //     .doc(widget.userModel.id)
                    //     .collection('messages')
                    //     .add(
                    //   {
                    //     'text': messageController.text.trim(),
                    //     'withUser': widget.withUser,
                    //     'timeStamp': fieldValue,
                    //     'withUserDocId': widget.withUserDocId,
                    //   },
                    // );
                    // CloudService.userCollection
                    //     .doc(widget.withUserDocId)
                    //     .collection('messages')
                    //     .add(
                    //   {
                    //     'text': messageController.text.trim(),
                    //     'withUser': widget.userModel.email,
                    //     'timeStamp': fieldValue,
                    //     'withUserDocId': widget.userModel.id,
                    //   },
                    // );
                  }
                  messageController.clear();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
