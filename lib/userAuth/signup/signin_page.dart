import 'package:flutter/material.dart';
import '../authController.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  String name = "";
  String email = "";
  String password = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Image.asset(
                //   //Make changes here, logo image
                //   "assets/images/logos/main_logo_light.png",
                //   fit: BoxFit.cover,
                //   width: 300,
                //   height: 250,
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32),
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Name",
                            // textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 18.0,
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
                            fontSize: 18.0,
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
                            fontSize: 18.0,
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
                            fontSize: 18.0,
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
                            width: changeButton ? 50 : 150,
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
                                        fontSize: 18),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
