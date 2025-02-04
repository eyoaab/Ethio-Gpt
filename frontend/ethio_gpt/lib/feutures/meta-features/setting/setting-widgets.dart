import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget settingRow(
    {required VoidCallback action,
    required String label,
    required Icon icon,
    required bool isDarkMod}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    decoration: BoxDecoration(
        color: isDarkMod ? darkBg : lightBg,
        border: Border(
          bottom: BorderSide(
            // color: lightGray,
            color: !isDarkMod ? darkGray : lightGray,
            width: 1,
          ),
        )),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.rubik(
            color: isDarkMod ? Colors.white : Colors.black,
            fontSize: 18,
          ),
        ),
        IconButton(
          onPressed: action,
          icon: icon,
          color: primaryColor,
        ),
      ],
    ),
  );
}
