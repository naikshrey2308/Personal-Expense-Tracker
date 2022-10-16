import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/controllers/expenseController.dart';
import 'package:personal_expense_tracker/globalVars.dart' as globals;
import 'package:personal_expense_tracker/pages/addExpense/addExpensePage.dart';

class AddExpenseForm extends StatefulWidget {
  AddExpenseForm({super.key});

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  String transactionName = "";
  String transactionAmount = "";
  String password = "";
  String currTime = DateFormat("HH:mm").format(DateTime.now());
  String currDate = DateFormat("dd/MM/yyyy").format(DateTime.now());
  bool enabled = false;

  List<String> transactionType = <String>["Expense", "Income"];
  static String selectedType = "Income";

  List<String> categories = <String>[
    "Other",
    "Bills",
    "Clothes",
    "Food",
    "Education",
    "Entertainment"
  ];
  String selectedCategory = "Other";
  List<String> modes = <String>[
    "Other",
    "Cash",
    "Credit Card",
    "Debit Card",
    "Net Banking",
    "Cheque"
  ];
  String selectedMode = "Other";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // height: 900,
            decoration: BoxDecoration(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 32.0, horizontal: 16),
                        child: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Transaction Name",
                                  // textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                )),
                            SizedBox(height: 8.0),
                            TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  transactionName = val;
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: "Example : Groceries",
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15.0),
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Transaction name cannot be empty";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 24.0,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Transation Amount",
                                // textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            TextFormField(
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: false),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return "Amount cannot be empty";
                                else
                                  return null;
                              },
                              onChanged: (val) {
                                setState(() {
                                  transactionAmount = val;
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: "Example : 100",
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15.0),
                                  )),
                            ),
                            SizedBox(
                              height: 24.0,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Category",
                                // textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 16),
                              child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      )),
                                  value: selectedCategory,
                                  items: List.generate(
                                      categories.length,
                                      (index) => DropdownMenuItem(
                                          value: categories[index],
                                          child: Text(categories[index]))),
                                  onChanged: ((value) {
                                    setState(() {
                                      selectedCategory = value! as String;
                                      print(value);
                                    });
                                  })),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Mode",
                                // textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 16),
                              child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      )),
                                  value: selectedMode,
                                  items: List.generate(
                                      modes.length,
                                      (index) => DropdownMenuItem(
                                          value: modes[index],
                                          child: Text(modes[index]))),
                                  onChanged: ((value) {
                                    setState(() {
                                      selectedMode = value! as String;
                                      print(value);
                                    });
                                  })),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 18, 0, 10),
                                    ),
                                    DropdownButton<String>(
                                        underline: SizedBox(),
                                        value: selectedType,
                                        items: List.generate(
                                            transactionType.length,
                                            (index) => DropdownMenuItem(
                                                value: transactionType[index],
                                                child: Text(
                                                    transactionType[index]))),
                                        onChanged: ((value) {
                                          setState(() {
                                            selectedType = value!;
                                          });
                                        })),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: Text(
                                        "Date",
                                        // textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 110,
                                      child: TextField(
                                        onChanged: (val) {
                                          setState(() {
                                            // transactionName = val;
                                            currDate = DateFormat("dd/MM/yyyy")
                                                .format(_dateTime)
                                                .toString();
                                          });
                                        },
                                        readOnly: true,
                                        onTap: () {
                                          _showDatePicker();
                                        },
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                            hintText: currDate,
                                            fillColor: Colors.grey[200],
                                            filled: true,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: Text(
                                        "Time",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 110,
                                      child: TextField(
                                        onChanged: (val) {
                                          setState(() {
                                            currTime = _time.format(context);
                                          });
                                        },
                                        readOnly: true,
                                        onTap: () {
                                          _selectTime();
                                        },
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                            hintText: _time.format(context),
                                            fillColor: Colors.grey[200],
                                            filled: true,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            )),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 24.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // if (enabled == false) return;
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            await createExpense(
                transactionName,
                transactionAmount,
                selectedCategory,
                selectedMode,
                currDate,
                currTime,
                selectedType);
            Navigator.of(context).pop();
            Navigator.of(context).popAndPushNamed("/myExpenses");
          }
        },
        backgroundColor: globals.primary,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  DateTime _dateTime = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        currDate = DateFormat("dd/MM/yyyy").format(value!);
      });
    });
  }

  TimeOfDay _time = TimeOfDay.now();

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        currTime = _time.format(context);
      });
    }
  }
}
