// import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/controllers/expenseController.dart';
import 'package:personal_expense_tracker/models/user.dart' as Models;
import 'package:personal_expense_tracker/controllers/authController.dart';
import 'package:personal_expense_tracker/widgets/drawer.dart';
import 'package:personal_expense_tracker/globalVars.dart' as globals;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Models.User? user;

  @override
  initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.of(context).pop();
    }
  }

  getCurrentUser() async {
    final docRef = await getUser(FirebaseAuth.instance.currentUser!.email!);
    final details = docRef as Map<String, dynamic>;
    user = Models.User.fromMap(details);
    // print(DateFormat("dd/MM/yyyy").format(_dateTime).toString());
    List<dynamic> expenses = await getExpense(
            user!.email, DateFormat("dd/MM/yyyy").format(_dateTime).toString())
        as List<dynamic>;
    print(expenses[0].data());
  }

  // const HomePage({super.key});
  String selectedCurrency = "INR";
  bool ans = true;
  late bool temp;
  List<String> values = <String>[
    'INR',
    'USD',
    'CAN',
    'EUR',
  ];

  TextEditingController dateInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCurrentUser(),
      builder: (context, snapshot) {
        if (user != null) {
          return Scaffold(
            drawer: MyDrawer(user: user),
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0.5,
              actions: [
                DropdownButton<String>(
                    underline: SizedBox(),
                    value: selectedCurrency,
                    items: List.generate(
                        values.length,
                        (index) => DropdownMenuItem(
                            value: values[index], child: Text(values[index]))),
                    onChanged: ((value) {
                      setState(() {
                        selectedCurrency = value!;
                        print(value);
                      });
                    }))
              ],
            ),
            body: SafeArea(
              child: Container(
                color: Colors.white,
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: Text(
                      "Your Balance",
                      textScaleFactor: 2.5,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
                    child: Text(
                      "$selectedCurrency 0.00",
                      textScaleFactor: 2,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green[100],
                              child: Icon(
                                Icons.keyboard_double_arrow_up,
                                color: Colors.green,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Income",
                                    textScaleFactor: 1.3,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Text(
                                    "Rs 0.00",
                                    style: TextStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.red[100],
                              child: Icon(
                                Icons.keyboard_double_arrow_down,
                                color: Colors.red,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Expense",
                                      textScaleFactor: 1.3,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      "Rs 0.00",
                                      style: TextStyle(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(15, 30, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Row(children: [
                              IconButton(
                                onPressed: _showDatePicker,
                                icon: Icon(Icons.calendar_month_rounded),
                              ),
                              Text(
                                _dateTime.day == DateTime.now().day
                                    ? "Today"
                                    : DateFormat.yMMMEd().format(_dateTime),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                              child: Column(children: [
                                Text(
                                  "You spent",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 15),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Text("Rs 1000"),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      )),
                ]),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/addExpense");
              },
              backgroundColor: globals.primary,
              child: Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  DateTime _dateTime = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2030))
        .then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }
}
