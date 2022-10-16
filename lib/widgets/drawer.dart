import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/globalVars.dart';
import 'package:personal_expense_tracker/controllers/authController.dart';
import '../models/user.dart' as Models;

/// Returns the custom [Drawer] widget.
/// 
/// [MyDrawer] is a custom [Drawer] widget which is then referenced in other page.

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  Models.User? user;
  String imageUrl = ''; //Used to save the image path of the current user.A

  MyDrawer({super.key, this.user});

/// Fetches the profile image URL corresponding to the signed in user.
/// 
/// [getuserImage] returns a [Future<String?>] which is stored inside the [imageUrl].
  getImage() async {
    imageUrl = await getUserImage(user!.email) ?? '';
    print(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //Image of the currentUser logged in.
      future: getImage(),
      builder: (context, snapshot) {
        return Drawer(
          backgroundColor: Colors.white,
          child: Container(
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
                        //Displays current user's emailId.
                        accountEmail: Text(user!.email,
                            style: TextStyle(color: Colors.black)),
                        currentAccountPicture: CircleAvatar(
                          //Displays the current user's profile picture if imageUrl is not empty.
                          //Default picture will be loaded if imageUrl is empty.
                          backgroundImage: NetworkImage((imageUrl == '')
                              ? 'https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg' //Link for the default profile picture
                              : imageUrl),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: ListTile(
                    //A simple Home Icon.
                    leading: Icon(
                      CupertinoIcons.home,
                      color: Colors.black,
                    ),
                    title: Text(
                      "My Expenses",
                      style: TextStyle(color: Colors.black),
                      textScaleFactor: 1.2,
                    ),
                  ),
                ),
                GestureDetector(
                  //Redirected to the [profilePage.dart] page on tapping the button.
                  onTap: () {
                    print("tapped");
                    //Pushes the [profilePage.dart] on top of the current page.
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
                SizedBox(height: deviceHeight(context) * 0.45),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: ElevatedButton(
                    //Logs out the current user.
                    onPressed: () {
                      FirebaseAuth.instance.signOut(); 
                      Navigator.of(context).popAndPushNamed("/");
                    },
                    //Logout button.
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
