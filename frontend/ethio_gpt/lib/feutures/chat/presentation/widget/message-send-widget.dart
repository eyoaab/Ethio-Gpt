import 'package:easy_localization/easy_localization.dart';
import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget searchArea(
    {required TextEditingController controller,
    required VoidCallback action,
    required bool isDarkMod}) {
  return Container(
    padding: const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 15),
    decoration: BoxDecoration(
      color: isDarkMod ? darkGray : Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      //  create a box shadow
      boxShadow: const [
        BoxShadow(
          color: Colors.black38,
          blurRadius: 4,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        // Input Field Expanded to Avoid Shrinking
        Expanded(
          child: TextField(
            controller: controller,
            style: GoogleFonts.inter(
                color: isDarkMod ? Colors.white : Colors.black),
            decoration: InputDecoration(
              hintText: 'enterPrompt'.tr(),
              hintStyle: GoogleFonts.inter(
                  color: isDarkMod ? Colors.white30 : Colors.white60),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: isDarkMod ? inputField : Colors.grey[500],
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
