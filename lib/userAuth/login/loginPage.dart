import "package:flutter/material.dart";
import 'package:personal_expense_tracker/globalVars.dart' as globals;

import 'loginForm.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        "Hello \nThere",
                        style: TextStyle(
                          fontSize: 73,
                          letterSpacing: 2.5,
                        ),
                      ),
                      Text(
                        "\n.",
                        style: TextStyle(
                          fontSize: 73,
                          color: globals.primary,
                        ),
                      )
                    ],
                  ),
                ),
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
