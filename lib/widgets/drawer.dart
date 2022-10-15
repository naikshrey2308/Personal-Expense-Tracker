import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        "https://media-exp1.licdn.com/dms/image/C4D03AQFVusXo_vh-Xg/profile-displayphoto-shrink_200_200/0/1641293765284?e=2147483647&v=beta&t=01b9e9OXf3VBPJcvbaq2Hpsl9-2gTanR5QLtDQOus8k";
    return Drawer(
      backgroundColor: Colors.white,
      child: Container(
        // color: Colors.deepPurple,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: DrawerHeader(
                  padding: EdgeInsets.zero,
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Colors.white),
                    margin: EdgeInsets.zero,
                    accountName: Text(
                      "Krish Makadia",
                      style: TextStyle(color: Colors.black),
                    ),
                    accountEmail: Text("makadiakrish@gmail.com",
                        style: TextStyle(color: Colors.black)),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.home,
                  color: Colors.black,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(color: Colors.black),
                  textScaleFactor: 1.2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.profile_circled,
                  color: Colors.black,
                ),
                title: Text(
                  "Profile",
                  style: TextStyle(color: Colors.black),
                  textScaleFactor: 1.2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.mail,
                  color: Colors.black,
                ),
                title: Text(
                  "Email me",
                  style: TextStyle(color: Colors.black),
                  textScaleFactor: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
