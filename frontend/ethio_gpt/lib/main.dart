import 'package:device_preview/device_preview.dart';
import 'package:ethio_gpt/cors/theme/bloc/theme_bloc.dart';
import 'package:ethio_gpt/cors/theme/bloc/theme_state.dart';
import 'package:ethio_gpt/feutures/chat/presentation/screens/make-caht-page.dart';
import 'package:ethio_gpt/feutures/feedback/presentation/screens/feedback-screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ethio_gpt/feutures/meta-features/setting/bloc/setting_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

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
            // BlocProvider<FaqBloc>(
            //   create: (context) => FaqBloc(),
            // ),
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
        home: const FeedbackScreen(),
      );
    });
  }
}
