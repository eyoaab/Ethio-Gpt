import 'package:easy_localization/easy_localization.dart';
import 'package:ethio_gpt/cors/widgets/bg-box-decoration.dart';
import 'package:ethio_gpt/cors/widgets/common-app-bar.dart';
import 'package:ethio_gpt/cors/widgets/common-drawer.dart';
import 'package:ethio_gpt/feutures/meta-features/Privecy-Policy/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutEthioGptScreen extends StatefulWidget {
  const AboutEthioGptScreen({super.key});

  @override
  _AboutEthioGptScreenState createState() => _AboutEthioGptScreenState();
}

class _AboutEthioGptScreenState extends State<AboutEthioGptScreen> {
  void showSide() {
    _scaffoldKey.currentState?.openDrawer();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bool isDarkMod =
        Theme.of(context).scaffoldBackgroundColor == Colors.black;
    return Scaffold(
      key: _scaffoldKey,
      appBar: commonAppBar(action: showSide, context: context),
      drawer: const CommonDrawer(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: bgBoxDecoration(isDarkMod),
        child:
            // whole page
            Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.05,
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: SingleChildScrollView(
            // profile part
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('aboutEthioGpt'.tr(),
                    style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).scaffoldBackgroundColor ==
                                Colors.black
                            ? Colors.white
                            : Colors.black)),
                textRow(
                    'Ethio GPT is a mobile application designed to enable users to interact with AI in their preferred language, including Amharic and English. Developed by software engineer Eyob Tariku, the app was created with the vision of making AI accessible to individuals who may face challenges due to language barriers',
                    isDarkMod),
                textRow(
                    'Recognizing that many people are unable to take full advantage of AI technology because it primarily operates in widely spoken languages, Eyob built this app to bridge that gap.',
                    isDarkMod),
                textRow(
                    'Ethio GPT empowers users by providing an intuitive and seamless AI experience in their native language, ensuring they can access information, assistance, and various AI-powered features without limitations.',
                    isDarkMod),
                textRow(
                    'This app aims to enhance accessibility and inclusivity, making AI technology more useful and beneficial for a broader audience.',
                    isDarkMod),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
