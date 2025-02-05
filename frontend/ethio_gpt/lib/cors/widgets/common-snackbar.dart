import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message, bool isSuccess) {
  final Color backgroundColor = isSuccess ? Colors.green : Colors.red;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    ),
  );
}

void showCustomLoading(BuildContext context, String messange) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(color: primaryColor),
            const SizedBox(width: 16),
            Text(messange),
          ],
        ),
      );
    },
  );
}

void showCustomDissmisLoading(
  BuildContext context,
) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  }
}
