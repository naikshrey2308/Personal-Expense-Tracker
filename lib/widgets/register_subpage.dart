import "package:flutter/material.dart";
import "../widgets/form_fields.dart";

class RegisterSubpage extends StatefulWidget {
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  String? helperText = '';
  Icon? icon;
  String? hint = '';
  bool obscureText = false;
  String? value;

  RegisterSubpage({
    Key? key,
    required this.onChanged,
    this.helperText,
    this.obscureText = false,
    this.hint,
    this.icon,
    this.validator,
    this.value,
  }) : super(key: key);

  @override
  State<RegisterSubpage> createState() => _RegisterSubpageState(
    onChanged: onChanged,
    helperText: helperText,
    obscureText: obscureText,
    hint: hint,
    icon: icon,
    validator: validator,
    value: value,
  );
}

class _RegisterSubpageState extends State<RegisterSubpage> {
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  String? helperText = '';
  Icon? icon;
  String? hint = '';
  bool obscureText = false;
  String? value;

  _RegisterSubpageState({
    required this.onChanged,
    this.helperText,
    this.obscureText = false,
    this.hint,
    this.icon,
    this.validator,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(0, 32, 0, 32),
      child: Column(
        children: [
          Text(
            helperText!,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ExpenseeTextField(
            onChanged: onChanged,
            hint: hint,
            icon: icon,
            validator: validator,
            value: value,
          )
        ],
      ),
    );
  }
}
