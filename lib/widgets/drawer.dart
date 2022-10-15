import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/globalVars.dart';
import 'package:personal_expense_tracker/controllers/authController.dart';
import '../models/user.dart' as Models;

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  Models.User? user;
  String imageUrl = '';

  MyDrawer({super.key, this.user});

  getImage() async {
    imageUrl = await getUserImage(user!.email) ?? '';
    print(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getImage(),
      builder: (context, snapshot) {
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
                          "",
                          style: TextStyle(color: Colors.black),
                        ),
                        accountEmail: Text(user!.email,
                            style: TextStyle(color: Colors.black)),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: NetworkImage((imageUrl == '')
                              ? 'https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg'
                              : imageUrl),
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
                GestureDetector(
                  onTap: () {
                    print("tapped");
                    Navigator.of(context).pushNamed("/profile");
                  },
                  child: Padding(
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
                SizedBox(height: deviceHeight(context) * 0.35),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).popAndPushNamed("/");
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100))),
                    child: Text("Logout"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
