import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool loading;

  const SubmitButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      child: loading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(text),
    );
  }
}
