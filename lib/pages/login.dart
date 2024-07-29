import 'package:chat_sphere/services/authservices.dart';
import 'package:chat_sphere/widgets/alert.dart';
import 'package:chat_sphere/widgets/mybutton.dart';
import 'package:chat_sphere/widgets/textbox.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  final dynamic ontap;
  const SignInScreen({super.key, required this.ontap});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  void singnIn() {
    try {
      AuthServices()
          .SignIn(emailcontroller.text.trim(), passwordcontroller.text.trim(),context);
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleAlertDialog(message: e.toString());
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size * 0.01),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/communication.png",
                  height: size * 0.26,
                ),
                Padding(
                  padding: EdgeInsets.all(size * 0.02),
                  child: Text(
                    "Welcome back, we missed you",
                    style:
                        TextStyle(color: Color(0xFF4D2B73), fontSize: size * 0.025),
                  ),
                ),
                Input(text: "Email", isobscure: false, controller: emailcontroller),
                SizedBox(height: size * 0.01),
                Input(
                    text: "Password",
                    isobscure: true,
                    controller: passwordcontroller),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: Text("forgot password"))),
                MyButton(
                  text: "SignIn",
                  ontap: singnIn,
                ),
                SizedBox(
                  height: size * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a menber?"),
                    TextButton(onPressed: widget.ontap, child: Text("SignUp"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
