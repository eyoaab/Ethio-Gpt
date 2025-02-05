import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message, bool isSuccess) {
  final Color backgroundColor = isSuccess ? Colors.green : Colors.red;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    ),
  );
}
