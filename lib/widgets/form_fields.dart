import 'package:flutter/material.dart';

/// Renders a custom [TextFormField] for the application
/// 
/// Logically extends a [TextFormField] component to give it a better style.
/// To use it anywhere in the application, import it using:
/// ```dart
/// import "package:personal_expense_tracker/widgets/form_fields.dart";
/// ``` 
/// 
/// To use it inside the application, call it as:
/// ```dart
/// ExpenseeFormField(
///   onChanged: (val) {
///     ...
///   }
///   ...
/// )
/// ```
/// 
/// May not work well if placed outside [Form] widget.
/// Therefore, recommended to have [Form] as an enclosing ancestor.
/// 
// ignore: must_be_immutable
class ExpenseeTextField extends StatefulWidget {
  /// [obscureText] hides the data typed into the [TextFormField],
  /// generally used to passwords or other encrypted data
  bool obscureText = false;

  /// [onChanged] sets the onChange method for the corresponding [TextFormField]
  void Function(String)? onChanged;
  /// [validator] serves as the function to the [validator] property of the [TextFormField]
  String? Function(String?)? validator;
  
  /// Shows placeholder text when [null] value is present inside the [TextFormField]
  String? hint = '';
  // Supporting [Icon] to helpm design the [TextFormField]
  Icon? icon;

  // holds the current value for the [TextFormField]
  String? value = '';

  // indicates whether the [TextFormField] is allowed to accept changes
  bool readonly = false;

  // named constructor to intialize the [ExpenseeTextField]
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


/// Provides the state for the [ExpenseeTextField] widget.
/// 
/// Private class, rather meant to be used as a state provider to [ExpenseeTextField].
/// Contains a [build] method which provides the actual [TextFormField] state.
/// 
class _ExpenseeTextFieldState extends State<ExpenseeTextField> {
  bool obscureText = false;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  String? hint = '';
  Icon? icon;
  String? value = '';
  bool readonly;

  // named constructor for initalizing the state to be provided to the [ExpenseeTextField]
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
      // enables validation checks on every minute user activity with the controller
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      initialValue: value,
      readOnly: readonly,
      decoration: InputDecoration(
          fillColor: Colors.grey[200],
          hintText: hint,
          filled: true,
          // [Icon] to be placed along with the [TextFormField]
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.0),
          )),
    );
  }
}
