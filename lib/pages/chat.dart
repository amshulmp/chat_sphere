import 'package:chat_sphere/models/chatmodel.dart';
import 'package:chat_sphere/services/chatservices.dart';
import 'package:chat_sphere/services/images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String username;
  final int image;
  final String receiverEmail;
  final String receiverId;

  const ChatScreen({
    Key? key,
    required this.username,
    required this.image,
    required this.receiverEmail,
    required this.receiverId,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  void sendMessage() async {
    if (messageController.text.trim().isNotEmpty) {
      await ChatServices().sendMessage(widget.receiverId, messageController.text.trim());
      messageController.clear();
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 229, 217, 249),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 193, 162, 243),
      
        title: Row(
          
          children: [
             Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(imageFilenames[widget.image],height: 40,),
        ),
        SizedBox(width: 15,),
            Text(
              widget.username,
              style: TextStyle(
                fontSize: size * 0.027,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ChatModel>>(
              stream: ChatServices().getMessages(
                FirebaseAuth.instance.currentUser!.uid,
                widget.receiverId,
              ),
              builder: (BuildContext context, AsyncSnapshot<List<ChatModel>> snapshot) {
               
                if (snapshot.hasError) {
                  return const Center(child: Text("An error occurred"));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Currently there are no messages"));
                }

                List<ChatModel> messages = snapshot.data!;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                });

                return ListView.builder(
                  controller: scrollController,
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    ChatModel message = messages[index];
                    bool isSentByCurrentUser = message.senderId == FirebaseAuth.instance.currentUser!.uid;
                    return Align(
                      alignment: isSentByCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                           
                            color: isSentByCurrentUser ? Colors.green : const Color.fromARGB(255, 207, 190, 234),
                            borderRadius: isSentByCurrentUser ? BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10),) :BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10),),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              
                              message.message,style: TextStyle(
                              fontSize: 17
                            ),),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: SearchBar(
                  controller: messageController,
                  hintText: "Enter the message",
                )
                ),
                const SizedBox(width: 8.0),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF4D2B73),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 6,
                        blurRadius: 10,
                        offset: const Offset(-4, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
