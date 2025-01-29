import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textRow(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Text(
      text,
      style: GoogleFonts.spaceGrotesk(fontSize: 16, color: Colors.white),
      textAlign: TextAlign.center,
    ),
  );
}
