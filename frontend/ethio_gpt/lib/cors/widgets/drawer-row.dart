import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget commonListTile(
    {required String title,
    required VoidCallback onTap,
    required IconData icon,
    required bool isSelected,
    required BuildContext context}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: isSelected
          ? primaryColor
          : Theme.of(context).scaffoldBackgroundColor == Colors.black
              ? darkGray
              : lightGray,
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      leading: Icon(
        icon,
        color: isSelected ? Colors.white : primaryColor,
        size: 24,
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).scaffoldBackgroundColor == Colors.black
              ? Colors.white
              : Colors.black,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}
