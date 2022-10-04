import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<String?> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return null;
  }
  on FirebaseAuthException catch(err) {
    return "${err.message}";
  }
}

Future<String?> createUser(String name, String email, String password) async {
  try {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.add({
      'name': name,
      'email': email,
      'password': password,
    });
    return null;
  }
  on FirebaseException catch(err) {
    return "${err.message}";
  }
}