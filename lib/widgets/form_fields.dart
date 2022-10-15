import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExpenseeTextField extends StatefulWidget {
  bool obscureText = false;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  String? hint = '';
  Icon? icon;
  String? value = '';
  bool readonly = false;

  ExpenseeTextField(
      {Key? key,
      this.obscureText = false,
      required this.onChanged,
      this.hint,
      this.icon,
      this.validator,
      this.value,
      this.readonly = false})
      : super(key: key);

  @override
  State<ExpenseeTextField> createState() => _ExpenseeTextFieldState(
        obscureText: obscureText,
        onChanged: onChanged,
        hint: hint,
        icon: icon,
        validator: validator,
        value: value,
        readonly: readonly,
      );
}

class _ExpenseeTextFieldState extends State<ExpenseeTextField> {
  bool obscureText = false;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  String? hint = '';
  Icon? icon;
  String? value = '';
  bool readonly;

  _ExpenseeTextFieldState({
    required this.obscureText,
    required this.onChanged,
    this.hint,
    this.icon,
    this.validator,
    this.value,
    required this.readonly,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      initialValue: value,
      readOnly: readonly,
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
