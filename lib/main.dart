import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:personal_expense_tracker/pages/addExpense/addExpensePage.dart';
import 'package:personal_expense_tracker/pages/intro.dart';
import 'package:personal_expense_tracker/pages/home_page.dart';
import 'package:personal_expense_tracker/userAuth/signup/newRegisterPage.dart';
import 'package:personal_expense_tracker/userAuth/signup/profilePage.dart';
import "./userAuth/login/newLoginPage.dart";
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/services.dart";
import 'package:personal_expense_tracker/pages/addExpense/addExpensePage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final user = FirebaseAuth.instance.currentUser;

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: (user == null) ? "/" : "/myExpenses",
    routes: {
      "/": (context) => IntroScreen(),
      "/myExpenses": (context) => HomePage(),
      "/login": (context) => LoginPage(),
      "/register": (context) => RegisterPage(),
      "/profile": (context) => ProfilePage(),
      "/addExpense": (context) => AddExpense()
    },
    theme: ThemeData(
      primarySwatch: MaterialColor(0xffff5757, {
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
      }),
    ),
  ));
}
