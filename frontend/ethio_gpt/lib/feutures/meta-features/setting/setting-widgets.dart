import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget settingRow({
  required VoidCallback action,
  required String label,
  required Icon icon,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    decoration: BoxDecoration(
        color: darkBg,
        border: Border(
          bottom: BorderSide(
            color: lightGray,
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
            color: Colors.white,
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
