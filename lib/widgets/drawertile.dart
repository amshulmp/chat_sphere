import 'package:flutter/material.dart';

class DrawerTiles extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback ontap;
  const DrawerTiles({
    super.key,
    required this.icon,
    required this.text, required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(left: size * 0.02),
      child: ListTile(
        onTap: ontap,
        leading: Icon(
          icon,
          size: size * 0.03,
        ),
        title: Text(
          text,
          style: TextStyle(
            
              letterSpacing: 6,
              fontSize: size * 0.02,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
