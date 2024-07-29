import 'package:chat_sphere/pages/home.dart';
import 'package:chat_sphere/pages/loginregister.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.hasData) {
        return HomeScreen();
      } else {
         return LoginOrRegister();
      }
      },  );
  }
}