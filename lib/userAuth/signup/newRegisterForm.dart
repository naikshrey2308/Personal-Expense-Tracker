import "package:flutter/material.dart";
import 'package:personal_expense_tracker/widgets/form_fields.dart';
import "../authController.dart";

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _key = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool changeButton = false;
  String validationText = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _key,
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              Row(),
              ExpenseeTextField(
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
                icon: Icon(Icons.email),
                hint: "Email",
              ),
              SizedBox(
                height: 16.0,
              ),
              ExpenseeTextField(
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                icon: Icon(Icons.lock),
                hint: "Password",
                obscureText: true,
              ),
              SizedBox(
                height: 32.0,
              ),
              Center(
                child: Container(
                  child: Text(
                    validationText,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Center(
                child: Material(
                  borderRadius: BorderRadius.circular(changeButton ? 50 : 50),
                  color: changeButton ? Colors.green : Colors.redAccent,
                  child: InkWell(
                    onTap: () async {
                      String? status = await signIn(email, password);
                      if (status == null) {
                        setState(() {
                          changeButton = true;
                          Future.delayed(Duration(milliseconds: 500), () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .popAndPushNamed("/myExpenses");
                          });
                        });
                      } else {
                        print(status);
                        setState(() {
                          validationText = status;
                        });
                      }
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: changeButton ? 55 : 350,
                      height: 55,
                      alignment: Alignment.center,
                      child: changeButton
                          ? Icon(Icons.done, color: Colors.white)
                          : Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
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
                  Navigator.of(context).popAndPushNamed("/register");
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  color: Colors.grey[100],
                  child: Text(
                    "New here? Sign up and start saving.",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
