import "package:flutter/material.dart";
import "../widgets/form_fields.dart";

// ignore: must_be_immutable

/// Renders the [RegisterForm] in chunks.
/// 
/// This is a [StatefulWidget] which is used to render the form field-by-field.
/// Each [RegisterSubpage] renders a specific form field onto the screen.
// ignore: must_be_immutable
class RegisterSubpage extends StatefulWidget {
  /// [onChanged] and [validator] are passed as arguments to the [ExpenseeTextField]
  void Function(String)? onChanged;
  String? Function(String?)? validator;

  // All of these variables are passed to the [ExpenseeTextField] as parameters.
  String? helperText = '';
  Icon? icon;
  String? hint = '';
  bool obscureText = false;
  String? value;

  // Non-const contructor for creating a [RegisterSubPage]
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
  // Creates a state that is rendered by the [StatefulWidget]
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

/// Provides the state to be used by the [RegisterSubpage] instance.
///
/// Contains the [build] widget responsible for rendering the subpage.
class _RegisterSubpageState extends State<RegisterSubpage> {
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  String? helperText = '';
  Icon? icon;
  String? hint = '';
  bool obscureText = false;
  String? value;

  // named constructor used to initialize the supplied values of the state variables
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
            height: 32,
          ),
          /// Returns [ExpenseeTextField] that renders a custom-styled Text Field
          ExpenseeTextField(
            onChanged: onChanged,
            hint: hint,
            icon: icon,
            validator: validator,
            value: value,
            obscureText: obscureText,
          )
        ],
      ),
    );
  }
}
