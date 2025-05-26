import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;

  const InputTextField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      obscureText: obscureText,
    );
  }
}
