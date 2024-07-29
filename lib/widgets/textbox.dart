
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String text;
  final bool isobscure;
  final TextEditingController controller;

  const Input({super.key, required this.text, required this.isobscure, required this.controller,});

  @override
  Widget build(BuildContext context) {
      var size = MediaQuery.of(context).size.height;
    return Container(
      height: size*0.074,
     decoration: BoxDecoration(
       color:  Color.fromARGB(255, 206, 183, 240),
       borderRadius: BorderRadius.circular(15)
     ),
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: isobscure,
        
          decoration: InputDecoration(
            
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:BorderSide(color: Color.fromARGB(255, 206, 183, 240),)
            ),
            focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(15),
              borderSide:BorderSide(color: Color.fromARGB(255, 206, 183, 240),  ),
            ),
            hintText: text,
            filled: true,
            fillColor:  Color.fromARGB(255, 206, 183, 240),
          ),
        ),
      ),
    );
  }
}