import 'dart:io';
import "package:firebase_storage/firebase_storage.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return null;
  } on FirebaseAuthException catch (err) {
    return "${err.message}";
  }
}

Future<String?> createUser(String name, String email, String password, XFile? image) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    signIn(email, password);

    CollectionReference users = FirebaseFirestore.instance.collection("users");
    await users.add({
      'id': FirebaseAuth.instance.currentUser!.uid,
      'name': name,
      'email': email,
      'password': password,
      'image': image!.name,
    });

    final StorageRef = FirebaseStorage.instance.ref();
    final usersRef = StorageRef.child("users/${email}");
    await usersRef.putFile(File(image.path));
    return null;
  } on FirebaseException catch (err) {
    return "${err.message}";
  }
}

Future<Object?> getUser(String email) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if(user == null)
      return null;

    CollectionReference users = FirebaseFirestore.instance.collection("users");
    QuerySnapshot<Object?> fetchedUser = await users.where(
      "email", isEqualTo: email,
    ).get();

    return fetchedUser.docs.first.data();
  }
  on FirebaseException catch(err) {
    print("${err.code}: ${err.message}");
  }
  on Exception catch(err) {
    print("${err}");
  }

  return null;
}

Future<String?> getUserImage(String email) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if(user == null)
      return null;

    final StorageRef = FirebaseStorage.instance.ref();
    final usersRef = StorageRef.child("users/${email}");
    return usersRef.getDownloadURL();
  }
  on FirebaseException catch(err) {
    print("${err.code}: ${err.message}");
  }
  on Exception catch(err) {
    print("${err}");
  }

  return null;
}