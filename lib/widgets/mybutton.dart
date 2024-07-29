import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  const MyButton({super.key, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: size*0.074,
       decoration: BoxDecoration(
         color:  Color(0xFF4D2B73),
         borderRadius: BorderRadius.circular(15)
       ),
       child: Center(
        child: Text(text,style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: size*0.023
        ),),
       ),
      ),
    );
  }
}