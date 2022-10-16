import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String?> createExpense(
    String transactionName,
    String transactionAmount,
    String category,
    String mode,
    String currDate,
    String currTime,
    String transactionType) async {
  try {
    CollectionReference expenses =
        FirebaseFirestore.instance.collection("expenses");
    await expenses.add({
      'userEmail': FirebaseAuth.instance.currentUser!.email,
      'transactionName': transactionName,
      'transactionAmount': transactionAmount,
      'category': category,
      'mode': mode,
      'currDate': currDate,
      'currTime': currTime,
      'transactionType': transactionType
    });
  } on FirebaseException catch (err) {
    return "${err.message}";
  }
}

Future<Object?> getExpense(String email, String currDate) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    CollectionReference expenses =
        FirebaseFirestore.instance.collection("expenses");
    QuerySnapshot<Object?> fetchedExpenses = await expenses
        .where(
          "userEmail",
          isEqualTo: user.email,
        )
        .where("currDate", isEqualTo: currDate)
        .orderBy("currTime", descending: true)
        .get();

    return fetchedExpenses.docs.map((e) => {"id": e.id, ...e.data() as Map}).toList();
  } on FirebaseException catch (err) {
    print("${err.code}: ${err.message}");
  } on Exception catch (err) {
    print("${err}");
  }

  return null;
}

Future<String?> deleteExpense(String expenseId) async {
  try {
    final expense =
        FirebaseFirestore.instance.collection('expenses').doc(expenseId);
    expense.delete();
  } on FirebaseException catch (err) {
    print("${err.code}: ${err.message}");
  } on Exception catch (err) {
    print("${err}");
  }
}
