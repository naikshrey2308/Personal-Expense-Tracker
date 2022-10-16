import 'package:flutter/material.dart';

/// Global variables are defined here.
///
/// They can be referenced anywhere in the application by importing necessary modules and referencing.
/// Example :-
/// ```dart
/// import "package:personal_expense_tracker/globalVars.dart" as globals;
/// Text("Hey there my name is Krish",style : TextStyle(color : globals.primary))
/// ```
final primary = Color(0xffff5757);
final primaryCode = 0xffff5757;

/// Returns the current device height and width of the type [double].
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
