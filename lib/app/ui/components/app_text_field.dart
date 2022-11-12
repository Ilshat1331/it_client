import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
  });
  final String labelText;
  final bool obscureText;

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      //TODO validate email
      validator: validatePassword,
      maxLines: 1,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }

  String? validateEmail(String? value) {
    if (value?.isEmpty == true) {
      return 'Enter your Email address';
    }
    if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value!)) {
      return 'Enter a Valid Email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value?.isEmpty == true) {
      return "Required field";
    }
    return null;
  }
}
