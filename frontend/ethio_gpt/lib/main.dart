import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ethio_gpt/feutures/chat/presentation/screens/chat-history-page.dart';
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
    return MaterialApp(
      title: 'Ethio-GPT',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      home: const ChatHistoryScreen(),
    );
  }
}
