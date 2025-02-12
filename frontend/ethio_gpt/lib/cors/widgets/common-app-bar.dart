import 'package:ethio_gpt/cors/theme/bloc/theme_bloc.dart';
import 'package:ethio_gpt/cors/theme/bloc/theme_event.dart';
import 'package:ethio_gpt/cors/theme/bloc/theme_state.dart';
import 'package:ethio_gpt/cors/utility-functions/token-validation.dart';
import 'package:ethio_gpt/cors/widgets/bg-box-decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar commonAppBar({
  required VoidCallback action,
  required BuildContext context,
}) =>
    AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: bgBoxDecoration(
            Theme.of(context).scaffoldBackgroundColor == Colors.black),
      ),
      leading: IconButton(
        onPressed: action,
        icon: Icon(Icons.menu,
            color: Theme.of(context).scaffoldBackgroundColor == Colors.black
                ? Colors.white
                : Colors.black),
      ),
      title: Text(
        'Ethio-Gpt',
        style: GoogleFonts.inter(
          fontSize: 20,
          color: Theme.of(context).scaffoldBackgroundColor == Colors.black
              ? Colors.white
              : Colors.black,
        ),
      ),
      centerTitle: true,
      actions: [
        BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return IconButton(
              icon: Icon(
                state.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                color: state.isDarkMode ? Colors.white : Colors.black,
              ),
              onPressed: () async {
                context.read<ThemeBloc>().add(ToggleThemeEvent());
                TokenValidation tokenValidation = TokenValidation();

                if (state.isDarkMode) {
                  await tokenValidation.saveTheme('dark');
                } else {
                  await tokenValidation.saveTheme('light');
                }
              },
            );
          },
        ),
        const SizedBox(width: 10),
      ],
    );
