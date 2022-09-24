import 'package:flutter/material.dart';
import '../components/form_fields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text("Expensee"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final _formkey = GlobalKey<FormState>();

  // const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  /// Login Form has 2 fields
  /// - Email that was used for registration
  /// - Corresponding password
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          children: [
            ExpenseeTextField(
              onChangedCallback: (val) {

              },
              hintText: "abc@xyz.com",
              labelText: "Email",
            ),
            SizedBox(height: 16.0),
            ExpenseeTextField(
                labelText: "Password",
                obscureText: true,
                onChangedCallback: (val) {

                },
            )
          ],
        ),
      ),
    );
  }
}

