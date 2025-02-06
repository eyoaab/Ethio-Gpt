import 'package:flutter/material.dart';

BoxDecoration bgBoxDecoration(bool isDarkMode) => BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
            isDarkMode ? '/images/backgroun.png' : '/images/whitebg.png'),
        fit: BoxFit.cover,
      ),
    );
