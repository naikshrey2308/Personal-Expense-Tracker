import "package:flutter/material.dart";
import 'package:personal_expense_tracker/widgets/form_fields.dart';
import '../../controllers/authController.dart';

/// Register Form
/// 
/// Lets the user signup with the application in order to access the functionalities.

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _key = GlobalKey<FormState>();

  String email = ''; // Used to save the current state of the email entered by the user in the form.
  String password = ''; //Used to save the current state of the password entered by the user in the form.

// Animations applied on the form based on the value of the [changeButton].
  bool changeButton = false;
  String validationText = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _key,
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              Row(),
              //[ExpenseeTextField] is a custom widget defined inside the [/widgets/form_fields.dart].
              ExpenseeTextField(
                // Sets value of [email].
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
                // Simple mail icon
                icon: Icon(Icons.email),
                hint: "Email",
              ),
              SizedBox(
                height: 16.0,
              ),
              ExpenseeTextField(
                // Sets the value of the [password].
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                // Simple lock icon.
                icon: Icon(Icons.lock),
                hint: "Password",
                 // Entered password is not visible and the characteres entered are obscured.
                obscureText: true,
              ),
              SizedBox(
                height: 32.0,
              ),
              Center(
                child: Container(
                  child: Text(
                     // If [validationText] is not an empty string, it is thrown as an error message indicating what went wrong while validating the form.
                    validationText,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Center(
                child: Material(
                  // Changes the color of the button to green if the value of [changeButton] is true.
                  borderRadius: BorderRadius.circular(changeButton ? 50 : 50),
                   // InkWell widget is used here mainly to give animation and colors to the button.
                  color: changeButton ? Colors.green : Colors.redAccent,
                  child: InkWell(
                    onTap: () async {
                      String? status = await signIn(email, password);
                      if (status == null) {
                        setState(() {
                          // If form is validated successfully then the value of [changeButton] is set to true.
                          // Page is rerendered corresponding to the given conditions and the respective animations are applied.
                          changeButton = true;
                          // If value of [changeButton] is true then user will be directed towards the next page after 0.5 seconds.
                          Future.delayed(Duration(milliseconds: 500), () {
                            Navigator.of(context).pop();
                            // Navigator is used here to push the next route on the stack of rotues and redirect the user to the page corresponding to the pushed route.
                            Navigator.of(context)
                                .popAndPushNamed("/myExpenses");
                          });
                        });
                      } 
                      // If there are any issues validating the login form then the status in the form of [validationText] will be returned.
                      else {
                        print(status);
                        setState(() {
                          validationText = status;
                        });
                      }
                    },
                    // Used to give animation to the button
                    child: AnimatedContainer(
                      // Animations applied to the button if value of [changeButton] is true.
                      duration: Duration(milliseconds: 300),
                      width: changeButton ? 55 : 350,
                      height: 55,
                      alignment: Alignment.center,
                      // Changes the button icon based on the [changeButton] value.
                      child: changeButton
                          ? Icon(Icons.done, color: Colors.white)
                          : Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "OR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              // Redirects the user to the register page.
              GestureDetector(
                onTap: () {
                  Navigator.of(context).popAndPushNamed("/register");
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  color: Colors.grey[100],
                  child: Text(
                    "New here? Sign up and start saving.",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
