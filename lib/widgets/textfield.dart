import 'package:flutter/material.dart';

class TextFieldWdget extends StatelessWidget {
  final String? placeholder;
  final String? subject;
  final Widget? sideIcon;
  final Widget? surIcon;
  final TextEditingController? fieldController;
  final bool isObscure;

  const TextFieldWdget(
      {super.key,
      this.placeholder,
      required this.isObscure,
      this.subject,
      this.surIcon,
      this.fieldController,
      this.sideIcon});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
      child: TextFormField(
        controller: fieldController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'please enter value';
          }
          return null;
        },
        obscureText: isObscure,
        style: const TextStyle(fontSize: 18),
        decoration: InputDecoration(
          hintText: placeholder,
          labelText: subject,
          labelStyle: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'PoetsenOne'),
          prefixIcon: sideIcon,
          suffixIcon: surIcon,
        ),
      ),
    ));
  }
}
