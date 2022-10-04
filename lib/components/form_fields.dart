// import 'package:flutter/material.dart';
//
// class ExpenseeTextField extends StatelessWidget {
//   // const ExpenseeTextField({Key? key}) : super(key: key);
//
//   ExpenseeTextField({
//     this.labelText,
//     this.hintText,
//     required this.onChangedCallback,
//     this.obscureText,
//   });
//
//   final void Function(String) onChangedCallback;
//   final String? labelText;
//   final String? hintText;
//   final bool? obscureText;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       obscureText: obscureText ?? false,
//       onChanged: onChangedCallback,
//       decoration: InputDecoration(
//           labelText: labelText,
//           hintText: hintText,
//           border: OutlineInputBorder(
//               borderSide: BorderSide()
//           )
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField({Key? key}) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (val) {
        setState(() {
          // password = val;
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
    );
  }
}
