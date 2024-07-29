import 'package:chat_sphere/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_sphere/widgets/alert.dart'; 

class AuthServices {
  var auth = FirebaseAuth.instance;
  var firestore=FirebaseFirestore.instance;
  dynamic getcurrentuser(){
    print( auth.currentUser?.email);
  return  auth.currentUser?.email;
  }
  dynamic getcurrentuserid(){
    print( auth.currentUser?.uid);
  return  auth.currentUser?.uid;
  }
  Future<UserCredential?> SignIn(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleAlertDialog(message: e.toString());
        },
      );
      return null; 
    }
  }
   Future<UserCredential?> SignUp(String email, String password, BuildContext context,String username) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      await firestore.collection("users").doc(userCredential.user?.uid).set({
     "id":userCredential.user?.uid,
     "email":email,
     "username":username,
      "profileimage":0,
      });
      return userCredential;
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleAlertDialog(message: e.toString());
        },
      );
      return null; 
    }
  }
 Stream<List<UserModel>> getusers() {
    return FirebaseFirestore.instance.collection("users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return UserModel(
          id: doc.id,
          email: data['email'],
          username: data['username'],
          profileImage: data['profileimage'] ?? 1, 
        );
      }).toList();
    });
  }

  signOut() {}
}
