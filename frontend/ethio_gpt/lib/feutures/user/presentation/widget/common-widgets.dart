import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:ethio_gpt/feutures/user/presentation/screens/google-signin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget commomSocialIcon(String label, bool isDarkMod) {
  return GestureDetector(
    onTap: signInWithGoogle,
    child: Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMod ? darkGray : lightGray,
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
            color: isDarkMod ? Colors.white : Colors.black,
          ),
        ),
      ),
    ),
  );
}

// Reusable Input Field
Widget commonInputField(
    {required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required bool isDarkMod}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: isDarkMod ? darkGray : lightGray,
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
      style: GoogleFonts.inter(color: isDarkMod ? Colors.white : Colors.black),
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
