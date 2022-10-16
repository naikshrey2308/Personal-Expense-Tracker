import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_expense_tracker/widgets/form_fields.dart';
import '../../controllers/authController.dart';
import '../../globalVars.dart' as globals;
import "../../models/user.dart" as Models;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  Models.User? user;
  XFile? image;
  String? imageUrl;
  String? oldPass;

  // Track whether image is updated or not.
  bool imageChanged = false; 

  // Track whether any field updated or not.
  bool modified = false;

  // Checks if data is buffering or not.
  bool buffering = false;

  final _key = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.of(context).pop();
    }
  }

  getImage() async {
    imageUrl = await getUserImage(user!.email) ?? '';
  }

  getCurrentUser() async {
    if (user != null) return;
    final docRef = await getUser(FirebaseAuth.instance.currentUser!.email!);
    final details = docRef as Map<String, dynamic>;
    user = Models.User.fromMap(details);
    oldPass = user!.password;
  }

  getUserData() async {
    await getCurrentUser();
    if (!imageChanged) await getImage();
  }

  Future captureImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      setState(() {
        this.image = image;
        this.imageUrl = '';
        this.imageChanged = true;
        this.modified = true;
      });
    } on PlatformException catch (err) {
      print("Failed to pick image: $err");
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      setState(() {
        this.image = image;
        this.imageUrl = '';
        this.imageChanged = true;
        this.modified = true;
      });
    } on PlatformException catch (err) {
      print("Failed to pick image: $err");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserData(),
        builder: ((context, snapshot) {
          if (user != null) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                elevation: 0.5,
                actions: [
                  ButtonBar(
                    children: [
                      (modified == false)
                          ? Container()
                          : ElevatedButton(
                              onPressed: () async {
                                if (this._key.currentState!.validate()) {
                                  _key.currentState!.save();
                                  
                                  setState(() {
                                    buffering = true;
                                  });
                                  await updateUser(
                                      user!.name,
                                      user!.email,
                                      user!.password,
                                      image,
                                      oldPass!,
                                      imageChanged);
                                  }
                                  setState(() {
                                    buffering = false;
                                  });
                                Navigator.of(context).pop();
                                Navigator.of(context).popAndPushNamed("/myExpenses");
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                elevation: 0,
                              ),
                              child: (buffering == true) ? 
                                CircularProgressIndicator()
                               : Icon(
                                Icons.check,
                                color: Colors.black,
                              ))
                    ],
                  )
                ],
                title: Text(
                  "My Profile",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(),
                    Stack(
                      children: [
                        Container(
                          height: globals.deviceHeight(context) * 0.3,
                          color: globals.primary,
                        ),
                        Container(
                          height: globals.deviceHeight(context) * 0.4,
                          alignment: Alignment.bottomCenter,
                          child: Image(
                            image: AssetImage(
                                "assets/images/shapes/login-wave.png"),
                          ),
                        ),
                        (imageUrl != '')
                            ? Container(
                                height: globals.deviceHeight(context) * 0.35,
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundImage: NetworkImage(imageUrl!),
                                ),
                              )
                            : Container(
                                height: globals.deviceHeight(context) * 0.35,
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundImage: FileImage(File(image!.path)),
                                ),
                              ),
                        Container(
                          height: globals.deviceHeight(context) * 0.45,
                          alignment: Alignment(-0.5, 0.7),
                          child: GestureDetector(
                            onTap: () {
                              captureImage();
                            },
                            child: CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.grey,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: globals.deviceHeight(context) * 0.4,
                          alignment: Alignment(0.5, 1.05),
                          child: GestureDetector(
                            onTap: () {
                              pickImage();
                            },
                            child: CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.grey,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.photo,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                      child: Form(
                        key: _key,
                        child: Column(
                          children: [
                            ExpenseeTextField(
                              onChanged: (value) {
                                if (!this.modified) this.modified = true;
                                setState(() {
                                  user!.name = value;
                                });
                              },
                              hint: "Name",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Name cannot be empty.";
                                } else if (!RegExp(r"^[a-zA-Z ]+$")
                                    .hasMatch(value)) {
                                  return "Name contains invalid characters.";
                                }
                                return null;
                              },
                              icon: Icon(CupertinoIcons.person_fill),
                              value: user!.name,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            ExpenseeTextField(
                              onChanged: (value) {
                                if (!this.modified) this.modified = true;
                                setState(() {
                                  user!.email = value;
                                });
                              },
                              hint: "Email",
                              validator: (value) {
                                String pattern =
                                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                    r"{0,253}[a-zA-Z0-9])?)*$";
                                if (value!.isEmpty) {
                                  return "Email cannot be empty.";
                                } else if (!RegExp(pattern).hasMatch(value)) {
                                  return "Email contains invalid characters.";
                                }
                                return null;
                              },
                              icon: Icon(Icons.mail),
                              value: user!.email,
                              readonly: true,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            ExpenseeTextField(
                              onChanged: (val) {
                                if (!this.modified) this.modified = true;
                                setState(() {
                                  user!.password = val;
                                });
                              },
                              hint: "Password",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password cannot be empty.";
                                } else if (value.length < 6) {
                                  return "Password should contain atleast 6 characters.";
                                }
                                return null;
                              },
                              icon: Icon(Icons.lock),
                              value: user!.password,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 32, 0, 0),
                              child: Text(
                                "Expensee Services 2022-23",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }));
  }
}
