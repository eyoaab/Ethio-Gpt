import 'package:ethio_gpt/cors/theme/bloc/theme_bloc.dart';
import 'package:ethio_gpt/cors/theme/bloc/theme_event.dart';
import 'package:ethio_gpt/cors/theme/bloc/theme_state.dart';
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('/images/backgroun.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      leading: IconButton(
        onPressed: action,
        icon: const Icon(Icons.menu, color: Colors.white),
      ),
      title: Text(
        'Ethio-Gpt',
        style: GoogleFonts.inter(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return Icon(
                state.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                color: state.isDarkMode ? Colors.white : Colors.black,
              );
            },
          ),
          onPressed: () {
            context.read<ThemeBloc>().add(ToggleThemeEvent());
          },
        ),
        const SizedBox(width: 10),
      ],
    );
