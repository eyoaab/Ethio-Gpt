import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget searchArea({
  required TextEditingController controller,
  required VoidCallback action,
}) {
  return Container(
    padding: const EdgeInsets.only(left: 12, right: 12, top: 30, bottom: 15),
    decoration: BoxDecoration(
      color: lightGray,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    child: Row(
      children: [
        // Input Field Expanded to Avoid Shrinking
        Expanded(
          child: TextField(
            controller: controller,
            style: GoogleFonts.inter(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Write your question here...',
              hintStyle: GoogleFonts.inter(color: Colors.white70),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: inputField,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ),

        const SizedBox(width: 10),

        // Send Button
        InkWell(
          onTap: action,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.send_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ],
    ),
  );
}
