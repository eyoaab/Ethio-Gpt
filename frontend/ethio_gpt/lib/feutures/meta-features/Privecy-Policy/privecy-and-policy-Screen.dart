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
                'Your privacy is important to us. It is Brainstorming\'s policy to respect your privacy regarding any information we may collect from you across our website, and other sites we own and operate.',
                isDarkMod),
            textRow(
                'We only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means, with your knowledge and consent. We also let you know why we’re collecting it and how it will be used.',
                isDarkMod),
            textRow(
                'We only retain collected information for as long as necessary to provide you with your requested service. What data we store, we’ll protect within commercially acceptable means to prevent loss and theft, as well as unauthorized access, disclosure, copying, use or modification.',
                isDarkMod),
            textRow(
                'We don’t share any personally identifying information publicly or with third parties, except when required to by law.',
                isDarkMod),
          ],
        ),
      ),
    );
  }
}
