import 'package:flutter/material.dart';

class ExpenseeTextField extends StatefulWidget {
  bool obscureText = false;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  String? hint = '';
  Icon? icon;
  String? value = '';

  ExpenseeTextField(
      {Key? key, this.obscureText = false, required this.onChanged, this.hint, this.icon, this.validator, this.value})
      : super(key: key);

  @override
  State<ExpenseeTextField> createState() => _ExpenseeTextFieldState(
        obscureText: obscureText,
        onChanged: onChanged,
        hint: hint,
        icon: icon,
        validator: validator,
        value: value,
      );
}

class _ExpenseeTextFieldState extends State<ExpenseeTextField> {
  bool obscureText = false;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  String? hint = '';
  Icon? icon;
  String? value = '';

  _ExpenseeTextFieldState({
    required this.obscureText,
    required this.onChanged,
    this.hint,
    this.icon,
    this.validator,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      initialValue: value,
      decoration: InputDecoration(
          fillColor: Colors.grey[200],
          hintText: hint,
          filled: true,
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.0),
          )),
    );
  }
}
