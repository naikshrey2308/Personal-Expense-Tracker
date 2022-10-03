import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../authController.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  final _auth = FirebaseAuth.instance;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool changeButton = false;

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
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
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
              onChanged: (val) {
                setState(() {
                  password = val;
                });
              },
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
            // ElevatedButton(
            //   onPressed: () async {
            //     String? status = await signIn(email, password);
            //     print(status);
            //   },
            //   style: ElevatedButton.styleFrom(
            //     minimumSize: Size.fromHeight(50),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(15.0),
            //     )
            //   ),
            //   child: Text(
            //     "Login",
            //     style: TextStyle(
            //       fontSize: 18.0,
            //     ),
            //   ),
            // ),
            Center(
              child: Material(
                borderRadius: BorderRadius.circular(changeButton ? 50 : 15.0),
                color: changeButton ? Colors.green : Colors.redAccent,
                child: InkWell(
                  onTap: () async {
                    String? status = await signIn(email, password);
                    if(status == null) {
                      setState(() {
                        changeButton = true;
                      });
                    }
                    print(status);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: changeButton ? 50 : 250,
                    height: 50,
                    alignment: Alignment.center,
                    child:
                    changeButton ?
                    Icon(Icons.done, color: Colors.white) :
                    Text("Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
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
