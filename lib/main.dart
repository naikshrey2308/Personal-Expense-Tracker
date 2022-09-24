import "package:flutter/material.dart";
import "./userAuth/login/loginPage.dart";
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      "/": (context) => LoginPage(),
    },
    theme: ThemeData(
      primarySwatch: MaterialColor(
        0xffff5757,
        {
          50: Color(0xffff5757),
          100: Color(0xffff5757),
          200: Color(0xffff5757),
          300: Color(0xffff5757),
          400: Color(0xffff5757),
          500: Color(0xffff5757),
          600: Color(0xffff5757),
          700: Color(0xffff5757),
          800: Color(0xffff5757),
          900: Color(0xffff5757),
        }
      ),
    ),
  ));
}