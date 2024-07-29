import 'package:chat_sphere/services/authservices.dart';
import 'package:chat_sphere/services/images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isEditing = false;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 193, 162, 243),
        title: const Text("Profile"),
      ),
      backgroundColor: const Color.fromARGB(255, 229, 217, 249),
      body: Center(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(AuthServices().getcurrentuserid())
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text("An error occurred"));
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text("User data not found"));
            }

            var userData = snapshot.data!.data()!;
            var username = userData['username'] ?? 'N/A';
            var email = userData['email'] ?? 'N/A';
            var profileImage = userData['profileimage'] ?? 0;

            usernameController.text = username;
            emailController.text = email;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(imageFilenames[profileImage], height: 150),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                              color: Color(0xFF4D2B73), shape: BoxShape.circle),
                          child: IconButton(
                            icon: const Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                              size: 19,
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                    padding: const EdgeInsets.all(16.0),
                                    child: GridView.builder(
                                      itemCount: imageFilenames.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 10.0,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(AuthServices()
                                                    .getcurrentuserid())
                                                .update({
                                              "profileimage":
                                                  index
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Image.asset(
                                            imageFilenames[index],
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: usernameController,
                    readOnly: !isEditing,
                    decoration: InputDecoration(
                      labelText: "Username",
                      enabledBorder: InputBorder.none,
                      focusedBorder: isEditing
                          ? const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2.0),
                            )
                          : InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(isEditing ? Icons.check : Icons.edit),
                        onPressed: () {
                          if (isEditing) {
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(AuthServices().getcurrentuserid())
                                .update({"username": usernameController.text});
                          }
                          toggleEditing();
                        },
                      ),
                    ),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: emailController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
