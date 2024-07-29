import 'package:chat_sphere/pages/profile.dart';
import 'package:chat_sphere/services/authservices.dart';
import 'package:chat_sphere/widgets/drawertile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: Color.fromARGB(255, 211, 192, 243),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Image.asset(
                  "assets/communication.png",
                  height: size * 0.26,
                ),
              ),
              DrawerTiles(
                icon: Icons.home,
                text: 'HOME',
                ontap: () {
                  Navigator.pop(context);
                },
              ),
           
              DrawerTiles(
                icon: Icons.account_circle_rounded,
                text: 'PROFILE',
                ontap: () {
                   Navigator.pop(context);
                   Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen()
                                ),
                              );
                },
              ),
            ],
          ),
          Padding(
            padding:  EdgeInsets.only(bottom: size*0.01),
            child: DrawerTiles(
              icon: Icons.logout,
              text: 'LOGOUT',
              ontap: (){
            AuthServices().auth.signOut();
          },
            ),
          )
        ],
      ),
    );
  }
}
