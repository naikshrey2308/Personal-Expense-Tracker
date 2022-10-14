import 'dart:io';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_expense_tracker/widgets/form_fields.dart';
import 'package:personal_expense_tracker/widgets/indicators.dart';
import 'package:personal_expense_tracker/widgets/register_subpage.dart';
import "./newRegisterForm.dart";
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
  File? image;
  final _formKey = GlobalKey<FormState>();

  bool enabled = false;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final tempImg = File(image.path);
      setState(() {
        this.image = tempImg;
      });
    } on PlatformException catch (err) {
      print("Failed to pick image: $err");
    }
  }

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
                  height: globals.deviceHeight(context) * 0.35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: globals.primary,
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 80, 0, 48),
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: (image == null)
                          ? AssetImage(
                              "assets/images/logos/logo_dark.png",
                            )
                          : Image(image: FileImage(image!)).image,
                    ),
                  ),
                ),

                /**
                 * Creates three waves with decreasing opacity
                 */
                Container(
                  height: globals.deviceHeight(context) * 0.45,
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    image: AssetImage("assets/images/shapes/login-wave.png"),
                  ),
                ),
                Opacity(
                  opacity: 0.25,
                  child: Container(
                    height: globals.deviceHeight(context) * 0.465,
                    alignment: Alignment.bottomCenter,
                    child: Image(
                      image: AssetImage("assets/images/shapes/login-wave.png"),
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.1,
                  child: Container(
                    height: globals.deviceHeight(context) * 0.48,
                    alignment: Alignment.bottomCenter,
                    child: Image(
                      image: AssetImage("assets/images/shapes/login-wave.png"),
                    ),
                  ),
                ),
                Container(
                  height: globals.deviceHeight(context) * 0.55,
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Welcome to Expensee!",
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
                                print(name);
                                name = value;
                              });
                            },
                            value: name,
                            helperText: "Tell us your name",
                            hint: "John Doe",
                            icon: Icon(Icons.star),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Name cannot be empty.";
                              } else if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(value)) {
                                return "Name contains invalid characters.";
                              } else {
                                enabled = true;
                              }
                              return null;
                            },
                          )
                        : Container(),

                      (slide == 1)
                        ? RegisterSubpage(
                            onChanged: (value) {
                              setState(() {
                                print(email);
                                email = value;
                              });
                            },
                            helperText: "${name}, what's your email?",
                            hint: "johndoe@gmail.com",
                            icon: Icon(Icons.email),
                            validator: (value) {
                              String pattern =
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                r"{0,253}[a-zA-Z0-9])?)*$";
                              if (value!.isEmpty) {
                                return "Email cannot be empty.";
                              } else if (!RegExp(pattern).hasMatch(value)) {
                                return "Email contains invalid characters.";
                              } else {
                                enabled = true;
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
                            helperText: "${email}, choose a password.",
                            obscureText: true,
                            icon: Icon(Icons.lock),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password cannot be empty.";
                              } else if (value.length < 6) {
                                return "Password should contain atleast 6 characters.";
                              } else {
                                enabled = true;
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
                            helperText: "Confirm your password",
                            obscureText: true,
                            icon: Icon(Icons.lock),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password cannot be empty.";
                              } else if (value != password) {
                                return "Passwords don't match";
                              } else {
                                enabled = true;
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
                                  : Image(image: FileImage(image!)).image,
                            ),
                          ),
                        )
                        : Container(),

                    Padding(
                      padding: EdgeInsets.fromLTRB(56, 0, 56, 24),
                      child: Indicators(size: maxSlide - minSlide + 1, active: slide),
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
                        )
                      ),
                      child: Text(
                        "Wait, Go Back!",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    SizedBox(height: 8,),

                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if(slide != maxSlide && enabled == true) {
                            slide ++;
                            enabled = false;
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        )
                      ),
                      child: Text(
                        "Continue",
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
