import 'dart:io';
import "package:firebase_storage/firebase_storage.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

/// This methods signs the user in.
///
/// Returns a [Future] of [String] data type indicating the status of the operation.
/// Connects to the Firebase Authenication of the Google Firebase Database.
/// [email] and [password] are the required creadentials.
Future<String?> signIn(String email, String password) async {
  // The operation may be unsuccessful too leading to [Exceptions].
  // Therefore, we wrap the logic with a try block.
  try {
    // Wait for the Firebase Authentication service to perform required checks.
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    // User has been signed in successfully, so exit without any error message.
    return null;
  } 
  // Otherwise, handle the exceptions
  on FirebaseAuthException catch (err) {
    // Return an appropriate error message back to the user.
    return "${err.message}";
  }
}


/// This method is used to create a User object.
/// 
/// Returns a [Future] of [String] data type indicating the status of the operation.
/// Connects to:
/// 1. Firebase Authentication (for authentication)
/// 2. Firebase Firestore (for storing information)
/// 3. Firebase Storage (for storing images)
Future<String?> createUser(
    String name, String email, String password, XFile? image) async {
  // The operation may be unsuccessful too leading to [Exceptions].
  // Therefore, we wrap the logic with a try block. 
  try {
    // Wait for the Firebase Authentication to create the user using [email] and [password].
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    // Once the user is created, in order to use the application, user should be signed in.
    // Therefore, sign in the user to his/her account.
    signIn(email, password);

    // To store the additional User data, we use the Firebase Firestore
    // Obtain a reference to the `users` collection.
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    // Wait till the user document is added to the collection.
    await users.add({
      'id': FirebaseAuth.instance.currentUser!.uid,
      'name': name,
      'email': email,
      'password': password,
      'image': image!.name,
    });

    // After these steps, user's profile picture, if any, has to be uploaded.
    // Obtain a reference to the storage space on Firebase Storage.
    final StorageRef = FirebaseStorage.instance.ref();
    final usersRef = StorageRef.child("users/${email}");
    // Create or Locate appropriate file and save the image.
    await usersRef.putFile(File(image.path));

    // User account is successfully created hence the status is null.
    return null;
  } 
  // Otherwise, return the status (or error) of user creation.
  on FirebaseException catch (err) {
    return "${err.message}";
  }
}


/// This function fetches a particular user document from the Firestore database.
/// 
/// Returns a [Future] of [Object?] type referencing to the user record requested.
/// On error, [FirebaseException] can be thrown.
Future<Object?> getUser(String email) async {
  // The operation may be unsuccessful too leading to [Exceptions].
  // Therefore, we wrap the logic with a try block.  
  try {
    // Wait for the Firebase Authentication to check the authentication status of the current user
    final user = FirebaseAuth.instance.currentUser;
    // If no user is logged in, no need to run this function any further.
    if (user == null) return null;

    // Obtain a reference to the `users` collection of the Firestore database.
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    // Find a user whose email address is equal to the one requested.
    QuerySnapshot<Object?> fetchedUser = await users
        .where(
          "email",
          isEqualTo: email,
        )
        .get();

    // Return the fetched results.
    return fetchedUser.docs.first.data();
  } 
  // For any exceptions related to [FirebaseException]
  on FirebaseException catch (err) {
    print("${err.code}: ${err.message}");
  } 
  // For any other [Exceptions]
  on Exception catch (err) {
    print("${err}");
  }

  return null;
}


/// This function is used to fetch the image of a user from the Firebase Storage.
/// 
/// Returns a [Future] of [String] data type indicating the status of operation.
/// Errors like bad path and corrupted files can lead to [FirebaseException].
/// The email name must be the same as the file name on the database.
Future<String?> getUserImage(String email) async {
  // The operation may be unsuccessful too leading to [Exceptions].
  // Therefore, we wrap the logic with a try block.
  try {
    // Check for the authenticity of the current user.
    final user = FirebaseAuth.instance.currentUser;
    // If the user is not logged in, stop the operation right here.
    if (user == null) return null;

    // Obtain a reference to the Firebase Storage.
    final StorageRef = FirebaseStorage.instance.ref();
    // Obtain a reference to the image file of the user.
    final usersRef = StorageRef.child("users/${email}");

    // Generate a URL that can be accessed via the HTTP.
    // This reduces the downloading overhead and directly loads the image oveer HTTP.
    return usersRef.getDownloadURL();
  } 
  // Handle the [FirebaseException]
  on FirebaseException catch (err) {
    print("${err.code}: ${err.message}");
  }
  // Handle any other kind of [Exception]
  on Exception catch (err) {
    print("${err}");
  }

  return null;
}


/// This method updates the partial or entire user profile, except [email].
/// 
/// Returns a [Future] of [String] data type indicating the status of the operation.
/// On error, it throws the [FirebaseException].
Future<String?> updateUser(String name, String email, String password,
    XFile? image, String oldPass, bool imageChanged) async {
  // The operation may be unsuccessful too leading to [Exceptions].
  // Therefore, we wrap the logic with a try block.
  try {
    // Some operations are too headvy to be performed with little overhead.
    // Therefore, update the password which is spread across two collections only if needed.
    if (password != oldPass) {
      // Firebase requires the user to be currently signed in.
      // Only then would the Firebase Authentication table be updated.
      
      // Store the old state of the user.
      String? oldEmail = FirebaseAuth.instance.currentUser!.email;
      // Sign out the user.
      await FirebaseAuth.instance.signOut();
      // Login again using the old credentials.
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: oldEmail!, password: oldPass);

      // Now the user is recently signed in.
      // Therefore, wait till the password is updated in the Firebase Authentication.
      await FirebaseAuth.instance.currentUser!
          .updatePassword(password)
          .then((_) {
        print("Password changed!");
      }).catchError((err) {
        print("Password not changed! ${err}");
      });
    }

    // Obtain reference to the user's document.
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    // Fetch the complete record of the user.
    QuerySnapshot<Object?> fetchedUser = await users
        .where(
          "email",
          isEqualTo: email,
        )
        .get();

    print("Got user data");

    // Set the updated values of the user in the new document and store it in the collection.
    final details = fetchedUser.docs.first.data() as Map<String, dynamic>;
    print(fetchedUser.docs.first.id);
    // Wait till the record is updated.
    await users
        .doc(fetchedUser.docs.first.id)
        .update({
          'name': name,
          'password': password,
          'image': (!imageChanged) ? details["image"] : image!.name,
        })
        // Record is updated successfully.
        .then((value) => print("Updated"))
        // There is an error.
        .catchError((err) => print(err));

    print("Updated user data");

    // Reuploading an image takes a lot of overhead.
    // Therefore, change the image only if necessary. 
    if (!imageChanged) return null;

    // Obtain a reference to the Firebase Storage where the user image is stored.
    final StorageRef = FirebaseStorage.instance.ref();
    final usersRef = StorageRef.child("users/${email}");
    // Wait till the new image is uploaded.
    await usersRef.putFile(File(image!.path));

    print("Updated user pic");

    return null;
  } 
  // Handle exception if that occurs.
  on FirebaseException catch (err) {
    return "${err.message}";
  }
}