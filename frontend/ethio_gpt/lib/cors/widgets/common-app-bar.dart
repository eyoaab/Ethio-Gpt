import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar commonAppBar({
  required VoidCallback action,
}) =>
    AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('/images/backgroun.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      leading: IconButton(
        onPressed: action,
        icon: const Icon(Icons.menu, color: Colors.white),
      ),
      title: Text(
        'Ethio-Gpt',
        style: GoogleFonts.inter(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      actions: const [
        Icon(Icons.light_mode, color: Colors.white),
        SizedBox(width: 10),
      ],
    );
