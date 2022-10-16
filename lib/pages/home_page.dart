// import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/controllers/expenseController.dart';
import 'package:personal_expense_tracker/models/user.dart' as Models;
import 'package:personal_expense_tracker/controllers/authController.dart';
import 'package:personal_expense_tracker/widgets/drawer.dart';
import 'package:personal_expense_tracker/globalVars.dart' as globals;
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Models.User? user;
  var expenses;

  num totalIncome = 0;
  num totalExpense = 0;

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
    expenses = await getExpense(
        user!.email, DateFormat("dd/MM/yyyy").format(_dateTime).toString());

    totalIncome = 0;
    totalExpense = 0;

    for (int index = 0; index < expenses.length; index++) {
      if (expenses[index]["transactionType"] == "Income") {
        totalIncome += num.parse(expenses[index]["transactionAmount"]);
      } else {
        totalExpense += num.parse(expenses[index]["transactionAmount"]);
      }
    }
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
            body: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  color: Colors.white,
                  child: Column(children: [
                    Stack(children: [
                      Container(
                        height: globals.deviceHeight(context) * 0.3,
                        color: globals.primary,
                      ),
                      Container(
                        height: globals.deviceHeight(context) * 0.28,
                        alignment: Alignment.center,
                        child: Text(
                          "You " +
                              ((totalExpense - totalIncome >= 0)
                                  ? "Spent"
                                  : "Gained"),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textScaleFactor: 2.5,
                        ),
                      ),
                      Container(
                        height: globals.deviceHeight(context) * 0.22,
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "$selectedCurrency ${(totalExpense - totalIncome).abs()}",
                          textScaleFactor: 2,
                          style: TextStyle(color: Colors.grey[350]),
                        ),
                      ),
                    ]),
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
                                      "Rs ${totalIncome}",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        "Rs ${totalExpense}",
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          ],
                        )),
                    Container(
                      color: Colors.white,
                      height: 500,
                      padding: EdgeInsets.fromLTRB(16, 48, 16, 0),
                      width: globals.deviceWidth(context),
                      child: ListView.builder(
                        itemCount: expenses.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.2, color: Colors.grey),
                                borderRadius: BorderRadius.circular(15),
                                color: (expenses[index]["transactionType"] ==
                                        "Income")
                                    ? Colors.green[50]
                                    : Colors.red[50],
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.local_pizza,
                                          color: (expenses[index]
                                                      ["transactionType"] ==
                                                  "Income")
                                              ? Colors.green
                                              : Colors.red,
                                        )),
                                    title: Text(
                                      expenses[index]["transactionName"],
                                    ),
                                    subtitle: Text(expenses[index]["category"]),
                                    trailing: Text(
                                      ((expenses[index]["transactionType"] ==
                                                  "Income")
                                              ? "+ "
                                              : "- ") +
                                          expenses[index]["transactionAmount"],
                                      style: TextStyle(
                                        color: (expenses[index]
                                                    ["transactionType"] ==
                                                "Income")
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    alignment: Alignment.center,
                                    width: globals.deviceWidth(context),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          expenses[index]["currDate"] +
                                              " " +
                                              expenses[index]["currTime"],
                                        ),
                                        GestureDetector(
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.grey[600],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ]),
                ),
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
