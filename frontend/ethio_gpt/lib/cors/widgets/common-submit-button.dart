import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget changeLanduadge({
  required VoidCallback onPressed,
  required String label,
}) {
  return Container(
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 5),
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
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Text color
        ),
      ),
    ),
  );
}

Widget submitButton({
  required VoidCallback onPressed,
  required String label,
  required bool isLoading,
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
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Text color
              ),
            ),
    ),
  );
}
