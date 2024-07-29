import 'package:chat_sphere/services/authservices.dart';
import 'package:chat_sphere/widgets/alert.dart';
import 'package:chat_sphere/widgets/mybutton.dart';
import 'package:chat_sphere/widgets/textbox.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final dynamic ontap;
  const SignUpScreen({super.key,required this.ontap});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController repasswordcontroller = TextEditingController();

  void singnUp(){
if (passwordcontroller.text.trim()==repasswordcontroller.text.trim()) {
      AuthServices().SignUp(emailcontroller.text.trim(), passwordcontroller.text.trim(), context,usernamecontroller.text.trim());
} else {
   showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleAlertDialog(message: "passwords do not match");
        },
      );
}  }

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
                    textAlign: TextAlign.center,
                    "Let's create an account for you create account",
                    style: TextStyle(
                        color: Color(0xFF4D2B73),
                        
                        fontSize: size * 0.025),
                  ),
                ),
                Input(text: "Email", isobscure: false, controller: emailcontroller),
                SizedBox(height: size * 0.01),
                  Input(text: "Username", isobscure: false, controller: usernamecontroller),
                SizedBox(height: size * 0.01),
                Input(
                    text: "Password",
                    isobscure: true,
                    controller: passwordcontroller),
                    SizedBox(height: size * 0.01),
                Input(
                    text: "Confirm password",
                    isobscure: true,
                    controller: repasswordcontroller),
               SizedBox(height: size * 0.01),
                MyButton(
                  text: "SignUp", ontap: singnUp,
                ),
                SizedBox(
                  height: size * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a menber?"),
                    TextButton(onPressed:widget.ontap, child: Text("SignIn"))
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
