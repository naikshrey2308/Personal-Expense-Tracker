import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:personal_expense_tracker/pages/addExpense/addExpensePage.dart';
import 'package:personal_expense_tracker/pages/intro.dart';
import 'package:personal_expense_tracker/pages/home_page.dart';
import 'package:personal_expense_tracker/userAuth/login/loginPage.dart';
import 'package:personal_expense_tracker/userAuth/signup/profilePage.dart';
import 'package:personal_expense_tracker/userAuth/signup/registerPage.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/services.dart";

Future main() async {
  // Initialization code to connect firebase with flutter.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

// Sets the device orientation to portrait mode.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

// Get instance of the current user logged in.
// Returns [null] if no user is logged in currently.
  final user = FirebaseAuth.instance.currentUser;

  runApp(MaterialApp(
    //Used to remove the *Debug* icon floating on the top-right corner of the device.
    debugShowCheckedModeBanner: false,
    //Defines the initial route.
    //If the user is logged in, then he/she will be redirected towards the corresponding page.
    //If not logged in, he/she will be redirected towards the login page.
    initialRoute: (user == null) ? "/" : "/myExpenses",
    //All the routes and their corresponding Pages are defined here.
    routes: {
      "/": (context) => IntroScreen(),
      "/myExpenses": (context) => HomePage(),
      "/login": (context) => LoginPage(),
      "/register": (context) => RegisterPage(),
      "/profile": (context) => ProfilePage(),
      "/addExpense": (context) => AddExpense()
    },

    ///[ThemeData] is used to give theme to the entire application.
    ///
    ///[ThemeData.from], which creates a ThemeData from a [ColorScheme].
    ///[ThemeData.light], which creates a light blue theme.
    ///[ThemeData.dark], which creates dark theme with a teal secondary [ColorScheme] color.
    ///[ColorScheme.fromSeed], which is used to create a [ColorScheme] from a seed color.
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
