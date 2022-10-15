import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/pages/addExpense/addExpenseForm.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  List<String> transactionType = <String>["Expense", "Income"];
  String selectedValue = "Income";

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
          actions: [
            DropdownButton<String>(
                underline: SizedBox(),
                value: selectedValue,
                items: List.generate(
                    transactionType.length,
                    (index) => DropdownMenuItem(
                        value: transactionType[index],
                        child: Text(transactionType[index]))),
                onChanged: ((value) {
                  setState(() {
                    selectedValue = value!;
                    print(value);
                  });
                }))
          ]),
      body: AddExpenseForm(),
    );
  }
}
