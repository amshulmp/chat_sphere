import 'package:chat_sphere/models/usermodel.dart';
import 'package:chat_sphere/pages/chat.dart';
import 'package:chat_sphere/pages/global.dart';
import 'package:chat_sphere/services/authservices.dart';
import 'package:chat_sphere/services/images.dart';
import 'package:chat_sphere/widgets/mydrawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = "";
  List<UserModel>? filteredUsers;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF4D2B73),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GlobalScreen(),
            ),
          );
        },
        child: Icon(
          Icons.account_circle_sharp,
          color: Color.fromARGB(255, 229, 217, 249),
        ),
      ),
      drawer: MyDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 193, 162, 243),
        title: Row(
          children: [
            Image.asset(
              "assets/communication.png",
              height: size * 0.06,
            ),
            Image.asset(
              "assets/InstaChat.png",
              height: size * 0.06,
            ),
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 229, 217, 249),
      body: Column(
        children: [
          Container(
            color: Color.fromARGB(255, 193, 162, 243),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: size * 0.015),
          Expanded(
            child: StreamBuilder<List<UserModel>>(
              stream: AuthServices().getusers(),
              builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("An unexpected error has occurred"));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  // return Center(child: CircularProgressIndicator());
                }

                if (snapshot.data!.isEmpty) {
                  return Center(child: Text("Currently there are no users"));
                }

                List<UserModel> users = snapshot.data!;
                filteredUsers = users.where((user) {
                  return user.username.toLowerCase().contains(searchQuery);
                }).toList();

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: size * 0.01),
                  child: ListView.builder(
                    itemCount: filteredUsers?.length ?? 0,
                    itemBuilder: (context, index) {
                      UserModel user = filteredUsers![index];

                      if (AuthServices().getcurrentuser() != user.email) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: size * 0.01),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                    image: user.profileImage,
                                    username: user.username,
                                    receiverEmail: user.email,
                                    receiverId: user.id,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              color: Colors.white,
                              child: SizedBox(
                                height: size * 0.09,
                                child: Center(
                                  child: ListTile(
                                    leading: Image.asset(imageFilenames[user.profileImage]),
                                    title: Text(user.username),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
