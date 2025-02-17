import 'package:flutter/material.dart';

BoxDecoration bgBoxDecoration(bool isDarkMode) => BoxDecoration(
      image: DecorationImage(
        image: AssetImage(isDarkMode
            ? '/assets/images/backgroun.png'
            : '/assets/images/whitebg.png'),
        fit: BoxFit.cover,
      ),
    );
