import 'package:chat_sphere/models/chatmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email ?? "";
    final Timestamp timestamp = Timestamp.now();

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    try {
      await _firestore
          .collection('chats')
          .doc(chatRoomId)
          .collection("messages")
          .add({
        'senderId': currentUserId,
        'senderEmail': currentUserEmail,
        'receiverId': receiverId,
        'message': message, 
        'timestamp': timestamp,
      });
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  Stream<List<ChatModel>> getMessages(String userId1, String userId2) {
    List<String> ids = [userId1, userId2];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatModel.fromMap({
                  'senderId': doc['senderId'],
                  'senderEmail': doc['senderEmail'],
                  'receiverId': doc['receiverId'],
                  'message': doc['message'], 
                  'timestamp': doc['timestamp'],
                }))
            .toList());
  }
}
