import "package:flutter/material.dart";
import 'package:personal_expense_tracker/globalVars.dart' as globals;

import 'loginForm.dart';

///LoginPage outlet 
///
///[loginForm.dart] is embedded inside the the [loginPage.dart].

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Defined to occupy the whole coloumn width
            Row(),
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: globals.deviceHeight(context) * 0.4,
                  child: Image(
                    image: AssetImage("assets/images/elements/wallet.png"),
                  ),
                  decoration: BoxDecoration(
                    color: globals.primary,
                  ),
                ),
                /**
                 * Creates three waves with decreasing opacity
                 */
                Container(
                  height: globals.deviceHeight(context) * 0.5,
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    image: AssetImage("assets/images/shapes/login-wave.png"),
                  ),
                ),
                Opacity(
                  opacity: 0.25,
                  child: Container(
                    height: globals.deviceHeight(context) * 0.515,
                    alignment: Alignment.bottomCenter,
                    child: Image(
                      image: AssetImage("assets/images/shapes/login-wave.png"),
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.1,
                  child: Container(
                    height: globals.deviceHeight(context) * 0.53,
                    alignment: Alignment.bottomCenter,
                    child: Image(
                      image: AssetImage("assets/images/shapes/login-wave.png"),
                    ),
                  ),
                ),
                Container(
                  height: globals.deviceHeight(context) * 0.5,
                  alignment: Alignment(0, 0.4),
                  child: Text(
                    "Login to Expensee",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),

            Container(
              child: LoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}
