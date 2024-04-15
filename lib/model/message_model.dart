import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String withUser;
  final String? text;
  final bool isMe;
  final String withUserDocId;
  final Timestamp timeStamp;
  final String? imageUrl;

  const MessageModel({
    this.imageUrl,
    required this.withUser,
    required this.isMe,
    required this.withUserDocId,
    required this.text,
    required this.id,
    required this.timeStamp,
  });

  factory MessageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return MessageModel(
      id: document.id,
      withUser: data['withUser'],
      timeStamp: data['timeStamp'] ?? Timestamp.now(),
      imageUrl: data['imageUrl'],
      text: data['text'],
      withUserDocId: data['withUserDocId'],
      isMe: data['isMe'],
    );
  }
}
