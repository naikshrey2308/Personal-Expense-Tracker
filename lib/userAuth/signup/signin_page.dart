import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../authController.dart';
import '../../globalVars.dart' as globals;

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {

  int slide = 0;
  int maxSlide = 5;
  int minSlide = 0;

  String name = "";
  String email = "";
  String password = "";
  bool changeButton = false;
  File? image;
  final _formKey = GlobalKey<FormState>();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final tempImg = File(image.path);
      setState(() {
        this.image = tempImg;
      });
    } on PlatformException catch(err) {
      print("Failed to pick image: $err");
    }
  }

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      return null;
  }

// Make changes here, navigation changes, routes and stuff
  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String? status = await createUser(name, email, password);
      print(status);

      setState(() {
        changeButton = true;
      });

      await Future.delayed(Duration(milliseconds: 500));
      // await Navigator.pushNamed(context, MyRoutes.homeRoute);
      setState(() {
        // changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // height: 900,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.orangeAccent,
                  Colors.red,
                  globals.primary,
                ]
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await this.pickImage();
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 48, 0, 48),
                        child:
                        CircleAvatar(
                          radius: 100,
                          backgroundImage:
                          (image == null) ? 
                          AssetImage(
                            "assets/images/logos/logo_dark.png",
                          ) 
                          : Image(image: FileImage(image!)).image,
                        ),
                      ),
                    ),
                    
                    Row(),
                    
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 32.0, horizontal: 16),
                        child: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Name",
                                  // textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                )),
                            SizedBox(height: 8.0),
                            TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  name = val;
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: "John Doe",
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15.0),
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Name cannot be empty";
                                }
                                return null;
                              },
                            ),
            
                            SizedBox(
                              height: 24.0,
                            ),
            
                            Container(
                              padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Email",
                                // textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            TextFormField(
                              validator: (value) {
                                return validateEmail(value);
                              },
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: "xyz@abc.com",
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15.0),
                                  )),
                            ),
            
                            SizedBox(
                              height: 24.0,
                            ),
            
                            Container(
                              padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Password",
                                // textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: "",
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15.0),
                                    )),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password cannot be empty";
                                  } else if (value.length < 6) {
                                    return "Length of password cannot be less than 6";
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 24.0,
                            ),
            
                            Container(
                              padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Confirm Password",
                                // textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  name = val;
                                });
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "",
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15.0),
                                  )),
                              validator: (value) {
                                if (password != value) {
                                  return "Passwords don't match";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 48.0,
                            ),
                            Material(
                              borderRadius:
                                  BorderRadius.circular(changeButton ? 50 : 50),
                              color: changeButton ? Colors.green : Colors.redAccent,
                              child: InkWell(
                                onTap: () => moveToHome(
                                    context), //Make changes here if required
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  width: changeButton ? 50 : 350,
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: changeButton
                                      ? Icon(
                                          Icons.done,
                                          color: Colors.white,
                                        )
                                      : Text(
                                          "Signup",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "OR",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).popAndPushNamed("/login");
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Already have an account? Sign in.",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.blue
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 24.0,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
