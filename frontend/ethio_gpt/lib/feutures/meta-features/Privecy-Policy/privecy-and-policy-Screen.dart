import 'package:easy_localization/easy_localization.dart';
import 'package:ethio_gpt/cors/widgets/bg-box-decoration.dart';
import 'package:ethio_gpt/cors/widgets/common-app-bar.dart';
import 'package:ethio_gpt/cors/widgets/common-drawer.dart';
import 'package:ethio_gpt/feutures/meta-features/Privecy-Policy/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyAndPolicyScreen extends StatefulWidget {
  const PrivacyAndPolicyScreen({super.key});

  @override
  _PrivacyAndPolicyScreenState createState() => _PrivacyAndPolicyScreenState();
}

class _PrivacyAndPolicyScreenState extends State<PrivacyAndPolicyScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void showSide() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMod =
        Theme.of(context).scaffoldBackgroundColor == Colors.black;
    return Scaffold(
      key: _scaffoldKey,
      appBar: commonAppBar(action: showSide, context: context),
      drawer: const CommonDrawer(),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: bgBoxDecoration(
            Theme.of(context).scaffoldBackgroundColor == Colors.black),
        child: ListView(
          children: [
            Text(
              'privacyPolicy'.tr(),
              style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color:
                      Theme.of(context).scaffoldBackgroundColor == Colors.black
                          ? Colors.white
                          : Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            textRow(
                'Ethio GPT is a mobile application designed to help non-English speakers interact with AI in their native language, such as Amharic or other local languages. Your privacy is important to us, and this policy explains how we collect, use, and protect your information',
                isDarkMod),
            Text(
              '1.Information We Collect',
              style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:
                      Theme.of(context).scaffoldBackgroundColor == Colors.black
                          ? Colors.white
                          : Colors.black),
            ),
            textRow(
                'We may collect basic user data such as name, email, and language preference.The app may collect usage data to improve user experience.We do not store or share any conversations you have with the AI.',
                isDarkMod),
            Text(
              '2. How We Use Your Information',
              style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:
                      Theme.of(context).scaffoldBackgroundColor == Colors.black
                          ? Colors.white
                          : Colors.black),
            ),
            textRow(
                'To enhance AI interactions based on user preferences.To improve app performance and provide better services.We do not sell or share user data with third parties.',
                isDarkMod),
            Text(
              '3. Data Security',
              style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:
                      Theme.of(context).scaffoldBackgroundColor == Colors.black
                          ? Colors.white
                          : Colors.black),
            ),
            textRow(
                'We take appropriate security measures to protect user data.No sensitive personal information is required to use the app.',
                isDarkMod),
            Text(
              '4.  User Rights',
              style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:
                      Theme.of(context).scaffoldBackgroundColor == Colors.black
                          ? Colors.white
                          : Colors.black),
            ),
            textRow(
                'Users can request data deletion at any time.Users can update their language preferences within the app.',
                isDarkMod),
          ],
        ),
      ),
    );
  }
}
