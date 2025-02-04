import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

/// State representing the current theme and mode (light or dark).
class ThemeState extends Equatable {
  final ThemeData themeData;
  final bool isDarkMode;

  const ThemeState({
    required this.themeData,
    required this.isDarkMode,
  });

  @override
  List<Object?> get props => [themeData, isDarkMode];
}
