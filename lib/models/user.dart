import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import '../userAuth/authController.dart';

class User {
  String id;
  String name;
  String email;
  String password;
  File? image;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.image,
  });

  factory User.fromMap(Map<String, dynamic> details, [File? profilePic]) {
    return User(
      id: details["id"] ?? "",
      name: details["name"] ?? "",
      email: details["email"] ?? "",
      password: details["password"] ?? "",
      image: profilePic,
    );
  }
}