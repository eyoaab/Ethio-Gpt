import 'package:device_preview/device_preview.dart';
import 'package:ethio_gpt/feutures/feedback/presentation/screens/feedback-screen.dart';
import 'package:ethio_gpt/feutures/user/presentation/screens/login-page.dart';
import 'package:ethio_gpt/feutures/user/presentation/screens/splash-screen.dart';
import 'package:ethio_gpt/feutures/user/presentation/screens/update-password-page.dart';
import 'package:ethio_gpt/feutures/user/presentation/screens/update-username-page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ethio-Gpt',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
