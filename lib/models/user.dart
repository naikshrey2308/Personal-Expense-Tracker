import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

/// [User] returns a user instance for the application.
/// 
/// Forms a base to better organize the user data.
/// To use it in your application, simply import it using:
/// ```
/// import 'package:personal_expense_tracker/models/user.dart';
/// ```
/// 
/// To start using it, simply call any of the one constructors as:
/// 1. 
/// ```dart
///   User(
///     id: (required),  
///     name: (required),  
///     email: (required),  
///     password: (required),  
///     image: <optional>,  
///   )
/// ```
/// 2.
/// ```dart
///   User.fromMap(
///     (Map<String, dynamic>) details,
///     (File?) profilePic (<optional>)
///   )
/// ```
/// 
class User {
  /// Unique [id] referencing to that of [FirebaseAuth.instance.currentUser.uid]
  /// Uniquely identifies every user in your database
  String id;
  // The name of the user
  String name;
  // The email of the user
  // Uniquely identifies every record in the [users] collection
  String email;
  /// Unique [token] which is needed to access the user account
  /// Refers to the password of account with id [FirebaseAuth.instance.currentUser.uid]
  String password;
  // The profile picture uploaded by the user.
  // Optional, since the user may choose not to do so, hence Nullable
  File? image; 

  // simple named constructor that builds the user instance 
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.image,
  });

  /// Factory constructor which returns a [User] object from a [Map<String,dynamic>] instance
  factory User.fromMap(Map<String, dynamic> details, [File? profilePic]) {
    return User(
      // ?? is the null-coalescing operator
      id: details["id"] ?? "",
      name: details["name"] ?? "",
      email: details["email"] ?? "",
      password: details["password"] ?? "",
      image: profilePic,
    );
  }
}