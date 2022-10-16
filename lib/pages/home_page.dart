import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/controllers/expenseController.dart';
import 'package:personal_expense_tracker/models/user.dart' as Models;
import 'package:personal_expense_tracker/controllers/authController.dart';
import 'package:personal_expense_tracker/widgets/drawer.dart';
import 'package:personal_expense_tracker/globalVars.dart' as globals;


/// Home page of the application
/// 
/// Loaded by default if the user is already signed in, else the user is prompted first to sign in.
/// Contains a graph which plots the user expense and income entries.
/// Shows a list of entries added by that user on the corresponding date, if no date is picked then by default entries added on the respective current date are showed.
/// User can delete entries based on his/her choice as well as new entries.
/// 
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Models.User? user;
  var expenses;

  num totalIncome = 0;
  num totalExpense = 0;

// List of points required to map the graph corresponding to expenses.
  List<double> plotters = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

// List of expense/incomes categories mapped to their respective icons.
  Map<String, dynamic> categories = {
    "Other": (Icons.attach_money_rounded),
    "Bills": (CupertinoIcons.doc),
    "Clothes": (Icons.shopping_bag),
    "Food": (Icons.local_pizza),
    "Education": (Icons.book),
    "Entertainment": (Icons.tv),
  };

  @override
  initState() {
    super.initState();
    //Checks whether the user is logged in or not by getting the current instance of the user.
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.of(context).pop();
    }
  }

  getCurrentUser() async {
    final docRef = await getUser(FirebaseAuth.instance.currentUser!.email!);
    final details = docRef as Map<String, dynamic>;
    user = Models.User.fromMap(details);

    // Get the list of expenses/incomes added by the user on the date specified.
    expenses = await getExpense(
        user!.email, DateFormat("dd/MM/yyyy").format(_dateTime).toString());

    // Keeps track of the totalIncome.
    totalIncome = 0;

    // Keeps track of the totalExpense.
    totalExpense = 0;

// This loop runs over the entire list of the expenses.
// If an item of the list has the [transactionType] of "Income",then it will be added to the [totalIncome].

    for (int index = 0; index < expenses.length; index++) {
      if (expenses[index]["transactionType"] == "Income") {
        totalIncome += num.parse(expenses[index]["transactionAmount"]);
      } 
      // If an item of the list has the [transactionType] of "Expense",then it will be added to the [totalExpense].
      else {
        totalExpense += num.parse(expenses[index]["transactionAmount"]);
      }
    }

    // Graph initializer
    var exps = await WeeklyExpensePlotter(user!.email, "${_dateTime.day}/${_dateTime.month}/${_dateTime.year}") as List;

    plotters = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

    for(int i=0; i < exps.length; i++) {
      var format = DateFormat("dd/MM/yyyy");
      var date1 = format.parse("${_dateTime.day}/${_dateTime.month}/${_dateTime.year}");
      date1 = date1.add(Duration(days: 1));
      var date2 = format.parse(exps[i]["currDate"]);
      int x = date1.difference(date2).inDays.abs();

      plotters[7 - x - 1] += ((exps[i]["transactionType"] == "Income") ? int.parse(exps[i]["transactionAmount"]) : -1 * int.parse(exps[i]["transactionAmount"]));

    }
  }

  String selectedCurrency = "INR";

// List of type of currencies.
  List<String> values = [
    "INR", "USA", "CAN", "EUR"
  ];

  // Currencies Mapped with their respective symbols.
Map<String, dynamic> values2 = {
    "INR": '₹',
    "USA": '\$',
    "CAN": '\$',
    "EUR": '£',
};

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
              title: Text("My Expenses",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
              actions: [
                // [DropdownButton<String>] takes a list of items and represents them in the form of drop down list.
                DropdownButton<String>(
                    underline: SizedBox(),
                    value: selectedCurrency,
                    // List of items are generated.
                    items: List.generate(
                        values.length,
                        // A [DropdownMenuItem] is as passed as an single item to the [Dropdownbutton]
                        (index) => DropdownMenuItem(
                            value: values[index], child: Text(values[index]))),
                    onChanged: ((value) {
                      // Sets the value of the [selectedCurrency] to the new selected value.
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
                          padding: EdgeInsets.all(16),
                          color: globals.primary,
                          child: LineChart(
                            LineChartData(
                                gridData: FlGridData(
                                  show: true,
                                  getDrawingHorizontalLine: (value) {
                                    return FlLine(
                                      color: Colors.white60,
                                      strokeWidth: 1,
                                    );
                                  },
                                  getDrawingVerticalLine: (value) {
                                    return FlLine(
                                      color: Colors.white60,
                                      strokeWidth: 0,
                                    );
                                  },
                                ),
                                
                                // Represents the number of points on the x-axis of the graph.
                                maxX: 7,
                                minX: 1,
                                titlesData: FlTitlesData(
                                  show: true,
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    )
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    )
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    )
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 1.0,
                                      getTitlesWidget: (value, meta) {
                                        switch(value.toInt()) {
                                          case 6:
                                            return Text("Today",
                                             style: TextStyle(
                                               
                                                color: Colors.white, 
                                              ),
                                            );
                                        }
                                        return Text("");
                                      },
                                    )
                                  ),
                                ),
                                borderData: FlBorderData(
                                    show: true,
                                    border: Border(
                                      left: BorderSide.none,
                                      bottom: BorderSide(
                                        color: Colors.white,
                                      ),
                                      top: BorderSide.none,
                                      right: BorderSide.none,
                                    )),
                                lineBarsData: [
                                  LineChartBarData(
                                    // List of points in the form (x,y) which are to be plotted on the graph.
                                    spots: [
                                      FlSpot(1, plotters[0]),
                                      FlSpot(2, plotters[1]),
                                      FlSpot(3, plotters[2]),
                                      FlSpot(4, plotters[3]),
                                      FlSpot(5, plotters[4]),
                                      FlSpot(6, plotters[5]),
                                      FlSpot(7, plotters[6]),
                                      FlSpot(8, plotters[7]),
                                    ],
                                    belowBarData: BarAreaData(
                                        show: true,
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.white70,
                                              Colors.white10,
                                            ])),
                                    color: Colors.white,
                                    // Don't show dots on the graph
                                    dotData: FlDotData(
                                      show: false,
                                    ),
                                    isCurved: false,
                                  )
                                ]),
                          )),
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Design implementation of the [totalIncome] 
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.green[100],
                                // Double arrow up icon
                                child: Icon(
                                  Icons.keyboard_double_arrow_up,
                                  color: Colors.green,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Income",
                                      textScaleFactor: 1.3,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        // Income icon and entries are showed in green color.
                                        color: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      "${values2[selectedCurrency]} ${totalIncome}",
                                      style: TextStyle(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Design implementation of the [totalExpense]
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.red[100],
                                // Double arrow down icon
                                child: Icon(
                                  Icons.keyboard_double_arrow_down,
                                  // Expense icon and entries are shown in red color.
                                  color: Colors.red,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
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
                                        "${values2[selectedCurrency]} ${totalExpense}",
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
                    // Design and implementation of the date picker.
                    Container(
                        padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(children: [
                                // Calendar Icon
                                IconButton(
                                  onPressed: _showDatePicker,
                                  icon: Icon(Icons.calendar_month_rounded),
                                ),
                                Text(
                                // If selected date is today.
                                  _dateTime.day == DateTime.now().day
                                      ? "Today"
                                      : DateFormat.yMMMEd().format(_dateTime), // If selected date is any date occuring before current date. 
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                            ),
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // Prints according to whether expenes are more than incomes on the specified date or not.
                                  Text(
                                    "Your ${(totalExpense > totalIncome) ? "Spendings" : "Earnings"}",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  // To track the total amount spent/gained by the end of the day.
                                  Text("${values2[selectedCurrency]} ${(totalExpense - totalIncome).abs()}")
                                ],
                              ),
                            ),
                          ],
                        )),
                        Divider(
                          thickness: 1,
                        ),
                    Container(
                      color: Colors.white,
                      height: 500,
                      padding: EdgeInsets.fromLTRB(16, 48, 16, 0),
                      width: globals.deviceWidth(context),
                      // Creates a scrollable, linear array of widgets from an explicit [List].
                      // This constructor is appropriate for list views with a small number of
                      // children because constructing the [List] requires doing work for every
                      // child that could possibly be displayed in the list view instead of just
                      // those children that are actually visible.
                      // Like other widgets in the framework, this widget expects that
                      // the [children] list will not be mutated after it has been passed in here.
                      child: ListView.builder(
                        // Number of items in the list.
                        itemCount: expenses.length,

                        itemBuilder: (context, index) {
                          // Design implementation of each item passed to the listView builder.
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.2, color: Colors.grey),
                                borderRadius: BorderRadius.circular(15),
                                // Set color to red if transactionType is "Expense" 
                                color: (expenses[index]["transactionType"] ==
                                        "Income")
                                    ? Colors.green[50]
                                    : Colors.red[50],
                              ),
                              // Design implementation of category icon.
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        // Category Icon colored to green if transactionType is Income, else it is colred red.
                                        child: Icon(
                                          categories[expenses[index]
                                              ["category"]],
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
                                          (values2[selectedCurrency] + expenses[index]["transactionAmount"]),
                                      style: TextStyle(
                                        color: (expenses[index]
                                                    ["transactionType"] ==
                                                "Income")
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ),
                                  // Design implementation of the currentDate, currentTime and delete icon in the listView entry.
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
                                        // Design and placement of currentDate and currentTime.
                                        Text(
                                          expenses[index]["currDate"] +
                                              " " +
                                              expenses[index]["currTime"],
                                        ),
                                        GestureDetector(
                                          // Delete the respective listView entry on tapping the delete icon.
                                          onTap: () async {
                                            await deleteExpense(
                                                expenses[index]["id"]);
                                            setState(() {
                                              getCurrentUser();
                                            });
                                          },
                                          // Simple delete icon.
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
            // Button which leads to the form page of adding expense
            floatingActionButton: FloatingActionButton(
              // User is directed to the addExpense form when clicked on the button.
              onPressed: () {
                Navigator.of(context).pushNamed("/addExpense");
              },
              
              // Simple add Icon
              child: Icon(Icons.add),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        }
        // Show the ProgressIndicator while the addExpense form is being loaded. 
        else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
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
        // Sets the value of the _dateTime to the value.
        _dateTime = value!;
      });
    });
  }
}
