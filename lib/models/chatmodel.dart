import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  ChatModel({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      senderId: map['senderId'] as String,
      senderEmail: map['senderEmail'] as String,
      receiverId: map['receiverId'] as String,
      message: map['message'] as String,
      timestamp: map['timestamp'] as Timestamp,
    );
  }
}
