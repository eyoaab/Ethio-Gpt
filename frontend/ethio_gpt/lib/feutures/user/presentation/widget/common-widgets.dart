import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget commomSocialIcon(String label) {
  return Container(
    height: 70,
    width: 70,
    decoration: BoxDecoration(
      color: lightGray,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 4,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: Center(
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}

// Reusable Input Field
Widget commonInputField({
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
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
      style: GoogleFonts.inter(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: primaryColor),
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          color: abAb,
        ),
        border: InputBorder.none,
      ),
    ),
  );
}

Widget submitButton({
  required VoidCallback onPressed,
}) {
  return Container(
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 25),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF9643FF), // Starting color
          Color(0xFFFF00B8), // Ending color
        ],
      ),
    ),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Colors.transparent, // Make the button transparent to show gradient
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.transparent, // Remove shadow
      ),
      child: const Text(
        'Update',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Text color
        ),
      ),
    ),
  );
}
