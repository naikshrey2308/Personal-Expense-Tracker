import "package:flutter/material.dart";

class MyExpenses extends StatelessWidget {
  const MyExpenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Expenses"),
      ),
    );
  }
}