import 'package:ethio_gpt/cors/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_event.dart';
import 'theme_state.dart';

/// Bloc to handle theme switching between light and dark modes.
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(
          ThemeState(
            themeData: EthioGptTheme.lightTheme,
            isDarkMode: false,
          ),
        ) {
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  void _onToggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) {
    final isCurrentlyDark = state.isDarkMode;

    emit(ThemeState(
      themeData:
          isCurrentlyDark ? EthioGptTheme.lightTheme : EthioGptTheme.darkTheme,
      isDarkMode: !isCurrentlyDark,
    ));
  }
}
