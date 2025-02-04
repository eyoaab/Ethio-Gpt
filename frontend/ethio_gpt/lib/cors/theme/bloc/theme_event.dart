import 'package:equatable/equatable.dart';

/// Base class for all theme-related events.
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

/// Event to toggle between light and dark themes.
class ToggleThemeEvent extends ThemeEvent {}
