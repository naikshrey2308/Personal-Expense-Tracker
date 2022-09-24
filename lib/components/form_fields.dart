import 'package:flutter/material.dart';

class ExpenseeTextField extends StatelessWidget {
  // const ExpenseeTextField({Key? key}) : super(key: key);

  ExpenseeTextField({
    this.labelText,
    this.hintText,
    required this.onChangedCallback,
    this.obscureText,
  });

  final void Function(String) onChangedCallback;
  final String? labelText;
  final String? hintText;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      onChanged: onChangedCallback,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
              borderSide: BorderSide()
          )
      ),
    );
  }
}
