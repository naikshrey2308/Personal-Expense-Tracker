import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

/// Used to add expense and income entries to the database.
/// 
/// Returns an instance of [FirebaseException] error message if error caught else returns [Null].
Future<String?>  createExpense(
    String transactionName, // Name of the transaction sent from the addExpenseForm.
    String transactionAmount, // Amount of transaction sent from the addExpenseForm.
    String category, // Category of the transaction E.g : Food.
    String mode, // Mode of currency involved E.g : Cash | Card | NetBanking etc
    String currDate, // Date at which transaction was recorded.
    String currTime, // Time at which transaction was recoreded.
    String transactionType // Type of transaction i.e Expense or Income.
    ) 
    async {
  try {
    // Returns an instance of collection named "expenses" to the variable named expenses.
    CollectionReference expenses =
        FirebaseFirestore.instance.collection("expenses");
        // Adding the corresponding fetched data from addExpenseForm to the database.
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
    // Return an error message if caught.
  } on FirebaseException catch (err) {
    return "${err.message}";
  }
  // Returns null if no error caught.
  return null;
}


/// Returns an instance of [List<Object>] which contains the expenses added by the user which is logged in right now.
///
/// It takes two parameters, [String] and [String].
/// If error is caught [Null] is returned and error code along with error message are printed on the console.

Future<Object?> getExpense(String email, String currDate) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    // Returns an instance of collection named "expenses" to the variable named expenses.
    CollectionReference expenses =
        FirebaseFirestore.instance.collection("expenses");
        //Filter expenses according to the criterias listed below.
    QuerySnapshot<Object?> fetchedExpenses = await expenses
        .where(
          "userEmail",
          isEqualTo: user.email,
        ) //userEmail should be equal to current user emails'
        .where("currDate", isEqualTo: currDate) 
        .orderBy("currTime", descending: true)
        .get();

    return fetchedExpenses.docs
        .map((e) => {"id": e.id, ...e.data() as Map})
        .toList();
  } 
  // Returns FirebaseException if error is caught. 
  on FirebaseException catch (err) {
    print("${err.code}: ${err.message}");
  } on Exception catch (err) {
    print("${err}");
  }

  return null;
}


/// Returns [List<Object>] and takes two parameters [String] and [String].
Future<Object?> WeeklyExpensePlotter(String email, String currDate) async {
  try {
    // Get the current user instance.
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    //Converting String to DateTime object using parse.
    DateTime today = DateFormat("dd/MM/yyyy").parse(currDate);

    //Getting date which is exactly a week before the current date.
    DateTime aWeekBefore = today.subtract(const Duration(days: 7));
    print("Today : " + "$today");
    print("A week before : " + "$aWeekBefore");

    // Get expenses from the database where the expenses matches with the corresponding email.
    CollectionReference expenses =
        FirebaseFirestore.instance.collection("expenses");
    QuerySnapshot<Object?> fetchedExpenses = await expenses
        .where(
          "userEmail",
          isEqualTo: user.email,
        )
        .where("currDate",
          isLessThanOrEqualTo: DateFormat("dd/MM/yyyy").format(today),
          isGreaterThanOrEqualTo: DateFormat("dd/MM/yyyy").format(aWeekBefore),
        )
        .get();
    // Returns a list of expenses.
    return fetchedExpenses.docs.map((e) => e.data() as Map).toList();
  } on FirebaseException catch (err) {
    print("${err.code}: ${err.message}");
  } on Exception catch (err) {
    print("${err}");
  }
  return null;
}


/// Delete expense from the database
/// 
/// Takes [String] as an input parameter and returns [Future<String>].
Future<String?> deleteExpense(String expenseId) async {
  try {
    // expense holds the document whose id matches with the one that is passed to the call.
    final expense =
        FirebaseFirestore.instance.collection('expenses').doc(expenseId);

    //Expense deleted.
    expense.delete();

  }  // Returns FirebaseException if error is caught.  
  on FirebaseException catch (err) {
    print("${err.code}: ${err.message}");
  } on Exception catch (err) {
    print("${err}");
  }
  return null;
}
