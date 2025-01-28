import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Reusable feedback form
Widget feedbackForm({
  required TextEditingController controller,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: lightGray,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 4,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: TextField(
      controller: controller,
      maxLines: 15, // Allows multiple lines of text

      style: GoogleFonts.inter(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'add your  feedback\'s here.......  ',
        hintStyle: GoogleFonts.inter(
          color: abAb,
        ),
        border: InputBorder.none,
      ),
    ),
  );
}
