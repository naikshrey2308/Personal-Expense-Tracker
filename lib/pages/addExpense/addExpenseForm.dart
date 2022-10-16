import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/controllers/expenseController.dart';
import 'package:personal_expense_tracker/globalVars.dart' as globals;

/// Add Expense form
///
/// Form with textfields and dropdowns, which are to be filled by user while keeping in note that it doesn't violate the form validation conditions.
/// Returns a form validation status, if the status is true then the entry is added to the database else form validation error has occured.
class AddExpenseForm extends StatefulWidget {
  AddExpenseForm({super.key});

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  String transactionName = "";
  String transactionAmount = "";
  String password = "";
  // Currentime in the format of "Hours:Minutes".
  String currTime = DateFormat("HH:mm").format(DateTime.now());
  // CurrentDate in the format of "Date/Month/Year".
  String currDate = DateFormat("dd/MM/yyyy").format(DateTime.now());
  bool enabled = false;

  List<String> transactionType = <String>["Expense", "Income"];
  static String selectedType = "Income";

// List of type of expense/income categories.
  List<String> categories = <String>[
    "Other",
    "Bills",
    "Clothes",
    "Food",
    "Education",
    "Entertainment"
  ];

  // Initial selectedCategory value.
  String selectedCategory = "Other";

  // List of types of transaction modes.
  List<String> modes = <String>[
    "Other",
    "Cash",
    "Credit Card",
    "Debit Card",
    "Net Banking",
    "Cheque"
  ];
  // Initial selected transaction mode.
  String selectedMode = "Other";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              // Add expense form
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
                            // Desing and implementation of textFormField for transactionName.
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
                              // Value of transactionName is changed.
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
                                  // Validation for the field.
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
                             // Desing and implementation of textFormField for transactionAmount.
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
                              // Validation for the field.
                              validator: (value) {
                                if (value!.isEmpty)
                                  return "Amount cannot be empty";
                                else
                                  return null;
                              },
                              // Value of tranasctionAmount is changed.
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
                            // Design and implementation of selection of category.
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
                              // [DropdownButtonFormField] takes a list of items as input in the form of [DropdownMenuItem] sets the respective values passed onChanged.
                              child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      )),
                                  // Initial value as selectedCategory.
                                  value: selectedCategory,
                                  items: List.generate(
                                      categories.length,
                                      (index) => DropdownMenuItem(
                                          value: categories[index],
                                          child: Text(categories[index]))),
                                  // Value of selectedCategory is changed.
                                  onChanged: ((value) {
                                    setState(() {
                                      selectedCategory = value! as String;
                                      print(value);
                                    });
                                  })),
                            ),
                            // Design and implementation of selection of mode.
                            Container(
                              padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Mode",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 16),
                              // [DropdownButtonFormField] takes a list of items as input in the form of [DropdownMenuItem] sets the respective values passed onChanged.
                              child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      )),
                                  // Initial value as selected mode.
                                  value: selectedMode,
                                  items: List.generate(
                                      modes.length,
                                      (index) => DropdownMenuItem(
                                          value: modes[index],
                                          child: Text(modes[index]))),
                                  // Value of selected mode is changed.
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
                                // Design and implementation of selection of transaction type i.e, Income or expense.
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
                                        // value of selectedType is changed as per user selection
                                        onChanged: ((value) {
                                          setState(() {
                                            selectedType = value!;
                                          });
                                        })),
                                  ],
                                ),
                                // Design and implementation of date selector
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: Text(
                                        "Date",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 110,
                                      child: TextField(
                                        // value of currDate is changed as per user selection.
                                        onChanged: (val) {
                                          setState(() {
                                            currDate = DateFormat("dd/MM/yyyy")
                                                .format(_dateTime)
                                                .toString();
                                          });
                                        },
                                        // User cannot type inside the textfield.
                                        readOnly: true,
                                        // The callback function is called to fetch the corresponding DateTime object.
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
                                // Design and implementation of time picker.
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
                                        // value of currTime is changed as per user selection.
                                        onChanged: (val) {
                                          setState(() {
                                            currTime = _time.format(context);
                                          });
                                        },
                                        // User cannot type inside the textfield.
                                        readOnly: true,
                                        // The callback function is called to fetch the corresponding time.
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
      // Design and implementation of the FLoatingActionButton, which adds the transaction entry.
      floatingActionButton: FloatingActionButton(
        // Form validation is carried out when the button is pressed, if any validation errors exist, they are returned and transaction is not added to database.
        onPressed: () async {
          // Form validation is carried out.
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            // createExpense is a method which adds the corresponding transaction and its corresponding fields to the database.
            await createExpense(
                transactionName,
                transactionAmount,
                selectedCategory,
                selectedMode,
                currDate,
                currTime,
                selectedType);
            Navigator.of(context).pop();
            // User redirected to the homePage on sucessfull addition of the transaction.
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

  /// Return the [DateTime] object when picked a date from the calendar.
  void _showDatePicker() {
    showDatePicker(
            context: context,
            // Sets the initial date in the range of dates.
            initialDate: DateTime.now(),

            // Sets the firstDate in the range of dates to choose from.Here the user cannot select date before the firstDate.
            firstDate: DateTime(2000),

            // Sets the last date to choose from. Here the user cannot select date beyond the currentDate.
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        // Sets the value of the currDate to the value.
        currDate = DateFormat("dd/MM/yyyy").format(value!);
      });
    });
  }

  TimeOfDay _time = TimeOfDay.now();

  /// Returns the [TimeOfDay] object when picked a time. If no time is picked by default the current time is returned.
  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      // Change the value of currTime if time is changed by the user.
      setState(() {
        _time = newTime;
        currTime = _time.format(context);
      });
    }
  }
}
