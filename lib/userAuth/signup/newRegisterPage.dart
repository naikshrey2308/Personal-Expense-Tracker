import 'dart:io';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import "../authController.dart";
import 'package:personal_expense_tracker/widgets/register_subpage.dart';
import 'package:personal_expense_tracker/globalVars.dart' as globals;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int slide = 0;
  int maxSlide = 4;
  int minSlide = 0;

  String name = "";
  String email = "";
  String password = "";
  String cpasword = "";
  bool changeButton = false;
  XFile? image;
  final _formKey = GlobalKey<FormState>();

  bool enabled = false;
  Map<int, bool> enabledList = {
      0: false,
      1: false,
      2: false,
      3: false,
  };

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      setState(() {
        this.image = image;
      });
    } on PlatformException catch (err) {
      print("Failed to pick image: $err");
    }
  }

  List<Map<String, dynamic>> fieldTitles = [
    {
      "title": "What's your name?",
      "icon": Icon(
        Icons.person,
        size: 75,
        color: Colors.black,
      )
    },
    {
      "title": "What's your email?",
      "icon": Icon(
        Icons.email,
        size: 75,
        color: Colors.black,
      ),
    },
    {
      "title": "Secure your account",
      "icon": Icon(
        Icons.lock,
        size: 75,
        color: Colors.black,
      ),
    },
    {
      "title": "Secure your account",
      "icon": Icon(
        Icons.verified,
        size: 75,
        color: Colors.green,
      ),
    },
    {
      "title": "You're Almost There!",
      "icon": null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // So that the column occupies the whole device width
            Row(),

            // Stack for absolute positioning of elements
            Stack(
              children: [
                Container(
                  height: globals.deviceHeight(context) * 0.15,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: globals.primary,
                  ),
                ),

                /**
                 * Creates three waves with decreasing opacity
                 */
                Container(
                  height: globals.deviceHeight(context) * 0.25,
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    image: AssetImage("assets/images/shapes/login-wave.png"),
                  ),
                ),
                Opacity(
                  opacity: 0.25,
                  child: Container(
                    height: globals.deviceHeight(context) * 0.265,
                    alignment: Alignment.bottomCenter,
                    child: Image(
                      image: AssetImage("assets/images/shapes/login-wave.png"),
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.1,
                  child: Container(
                    height: globals.deviceHeight(context) * 0.28,
                    alignment: Alignment.bottomCenter,
                    child: Image(
                      image: AssetImage("assets/images/shapes/login-wave.png"),
                    ),
                  ),
                ),

                (fieldTitles[slide]["icon"] == null)
                    ? Container()
                    : Container(
                        height: globals.deviceHeight(context) * 0.35,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(),
                        child: CircleAvatar(
                          radius: 77,
                          backgroundColor: Colors.grey[600],
                          child: CircleAvatar(
                            radius: 75,
                            backgroundColor: Colors.white,
                            child: fieldTitles[slide]["icon"],
                          ),
                        )),

                // Container(
                //   height: globals.deviceHeight(context) * 0.44,
                //   alignment: Alignment.bottomCenter,
                //   child: Padding(
                //     padding: EdgeInsets.fromLTRB(56, 0, 56, 24),
                //     child:
                //         Indicators(size: maxSlide - minSlide + 1, active: slide),
                //   ),
                // ),

                Container(
                  height: globals.deviceHeight(context) * 0.45,
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    fieldTitles[slide]["title"],
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),

            Container(
              padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    (slide == 0)
                        ? RegisterSubpage(
                            onChanged: (value) {
                              setState(() {
                                name = value;
                              });
                            },
                            value: name,
                            helperText: "We would like to know your name.",
                            obscureText: false,
                            hint: "John Doe",
                            icon: Icon(Icons.star),
                            validator: (value) {
                              enabledList[0] = false;
                              if (value!.isEmpty) {
                                return "Name cannot be empty.";
                              } else if (!RegExp(r"^[a-zA-Z ]+$")
                                  .hasMatch(value)) {
                                return "Name contains invalid characters.";
                              } else {
                                enabledList[0] = true;
                              }
                              return null;
                            },
                          )
                        : Container(),
                    (slide == 1)
                        ? RegisterSubpage(
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            helperText:
                                "Dear ${name.split(" ").first}, your email helps us to keep your data synced whenever you login.",
                            hint: "johndoe@gmail.com",
                            value: email,
                            obscureText: false,
                            icon: Icon(Icons.email),
                            validator: (value) {
                              enabledList[1] = false;
                              String pattern =
                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                  r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                  r"{0,253}[a-zA-Z0-9])?)*$";
                              if (value!.isEmpty) {
                                return "Email cannot be empty.";
                              } else if (!RegExp(pattern).hasMatch(value)) {
                                return "Email contains invalid characters.";
                              } else {
                                enabledList[1] = true;
                              }
                              return null;
                            },
                          )
                        : Container(),
                    (slide == 2)
                        ? RegisterSubpage(
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            helperText: "Choose a password for your account.",
                            obscureText: true,
                            value: password,
                            icon: Icon(Icons.lock),
                            validator: (value) {
                              enabledList[2] = false;
                              if (value!.isEmpty) {
                                return "Password cannot be empty.";
                              } else if (value.length < 6) {
                                return "Password should contain atleast 6 characters.";
                              } else {
                                enabledList[2] = true;
                              }
                              return null;
                            },
                          )
                        : Container(),
                    (slide == 3)
                        ? RegisterSubpage(
                            onChanged: (value) {
                              setState(() {
                                cpasword = value;
                              });
                            },
                            helperText: "Retype your password.",
                            obscureText: true,
                            value: cpasword,
                            icon: Icon(Icons.lock),
                            validator: (value) {
                              enabledList[3] = false;
                              if (value!.isEmpty) {
                                return "Password cannot be empty.";
                              } else if (value != password) {
                                return "Passwords don't match";
                              } else {
                                enabledList[3] = true;
                              }
                              return null;
                            },
                          )
                        : Container(),
                    (slide == 4)
                        ? GestureDetector(
                            onTap: () async {
                              await this.pickImage();
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 48),
                              alignment: Alignment.center,
                              color: Colors.transparent,
                              child: CircleAvatar(
                                radius: 75,
                                backgroundImage: (image == null)
                                    ? AssetImage(
                                        "assets/images/logos/logo_dark.png",
                                      )
                                    : Image(image: FileImage(File(image!.path))).image,
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 32,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if(slide != minSlide) {
                            slide --;
                            enabled = true;
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          elevation: 0.25,
                          minimumSize: Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          )),
                      child: Text(
                        "Back",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if(slide == maxSlide) {
                            String? status = await createUser(name, email, password, image);
                            if(status == null) {
                              Navigator.of(context).popAndPushNamed("/myExpenses");
                            }
                            return null;
                        }
                        setState(() {
                          if (slide != maxSlide && enabledList[slide] == true) {
                            slide++;
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          )),
                      child: Text(
                        (slide == maxSlide) ? "Create My Account" : "Continue",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
