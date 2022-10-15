import 'dart:io';
import "package:firebase_storage/firebase_storage.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

Future<String?> createUser(
    String name, String email, String password, XFile? image) async {
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
    if (user == null) return null;

    CollectionReference users = FirebaseFirestore.instance.collection("users");
    QuerySnapshot<Object?> fetchedUser = await users
        .where(
          "email",
          isEqualTo: email,
        )
        .get();

    return fetchedUser.docs.first.data();
  } on FirebaseException catch (err) {
    print("${err.code}: ${err.message}");
  } on Exception catch (err) {
    print("${err}");
  }

  return null;
}

Future<String?> getUserImage(String email) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final StorageRef = FirebaseStorage.instance.ref();
    final usersRef = StorageRef.child("users/${email}");
    return usersRef.getDownloadURL();
  } on FirebaseException catch (err) {
    print("${err.code}: ${err.message}");
  } on Exception catch (err) {
    print("${err}");
  }

  return null;
}

Future<String?> updateUser(String name, String email, String password,
    XFile? image, String oldPass, bool imageChanged) async {
  try {
    if (password != oldPass) {
      String? oldEmail = FirebaseAuth.instance.currentUser!.email;
      await FirebaseAuth.instance.signOut();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: oldEmail!, password: oldPass);

      await FirebaseAuth.instance.currentUser!
          .updatePassword(password)
          .then((_) {
        print("Password changed!");
      }).catchError((err) {
        print("Password not changed! ${err}");
      });
    }

    CollectionReference users = FirebaseFirestore.instance.collection("users");
    QuerySnapshot<Object?> fetchedUser = await users
        .where(
          "email",
          isEqualTo: email,
        )
        .get();

    print("Got user data");

    final details = fetchedUser.docs.first.data() as Map<String, dynamic>;
    print(fetchedUser.docs.first.id);
    await users
        .doc(fetchedUser.docs.first.id)
        .update({
          'name': name,
          'password': password,
          'image': (!imageChanged) ? details["image"] : image!.name,
        })
        .then((value) => print("Updated"))
        .catchError((err) => print(err));

    print("Updated user data");

    if (!imageChanged) return null;

    final StorageRef = FirebaseStorage.instance.ref();
    final usersRef = StorageRef.child("users/${email}");
    await usersRef.putFile(File(image!.path));

    print("Updated user pic");

    return null;
  } on FirebaseException catch (err) {
    return "${err.message}";
  }
}
