import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/pages/addExpense/addExpenseForm.dart';

/// Creates an expense and adds it to the user expenses list.
/// 
/// [AddExpense] provides a base for the [AddExpenseForm].
/// It is a [StatefulWidget] widget used to render the add expense page.
/// 
class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

/// Provides a state for the [AddExpense] class
class _AddExpenseState extends State<AddExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          "Add Transaction",
          style: TextStyle(color: Colors.black),
        ),
      ),

      /// [AddExpenseForm] is the child here. It does the main job of processing the add expense.
      body: AddExpenseForm(),
    );
  }
}
