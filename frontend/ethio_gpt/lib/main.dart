import 'package:device_preview/device_preview.dart';
import 'package:ethio_gpt/cors/theme/bloc/theme_bloc.dart';
import 'package:ethio_gpt/cors/theme/bloc/theme_state.dart';
import 'package:ethio_gpt/feutures/feedback/presentation/bloc/feedback_bloc.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/presentation/bloc/faq_bloc.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_bloc.dart';
import 'package:ethio_gpt/feutures/user/presentation/screens/splash-screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ethio_gpt/feutures/meta-features/setting/bloc/setting_bloc.dart';
import 'package:ethio_gpt/injection_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setUp();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('am', 'ET'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SettingBloc>(
              create: (context) => SettingBloc(),
            ),
            BlocProvider(create: (context) => ThemeBloc()),
            BlocProvider<UserBloc>(create: (context) => locator<UserBloc>()),
            BlocProvider<FeedbackBloc>(
              create: (context) => locator<FeedbackBloc>(),
            ),
            BlocProvider<FaqBloc>(create: (context) => locator<FaqBloc>()),
          ],
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return MaterialApp(
        title: 'Ethio-GPT',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: state.themeData,
        home: const SplashScreen(),
      );
    });
  }
}
