import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 0.0),
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(),
            Container(
              padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
              child: Text(
                "Email",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              decoration: InputDecoration(
                fillColor: Colors.grey[200],
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15.0),
                )
              ),
            ),
            SizedBox(height: 24.0),
            Container(
              padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
              child: Text(
                "Password",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15.0),
                  )
              ),
            ),
            SizedBox(height: 48.0),
            ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                )
              ),
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(height: 24.0),
            Container(
              alignment: Alignment.center,
              child: Text(
                "OR",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 24.0),
            Container(
              alignment: Alignment.center,
              child: Text(
                "New here? Sign up and start saving.",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.blue
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
