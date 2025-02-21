import 'package:easy_localization/easy_localization.dart';
import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:ethio_gpt/cors/widgets/bg-box-decoration.dart';
import 'package:ethio_gpt/cors/widgets/common-app-bar.dart';
import 'package:ethio_gpt/cors/widgets/common-drawer.dart';
import 'package:ethio_gpt/cors/widgets/common-submit-button.dart';
import 'package:ethio_gpt/feutures/meta-features/Privecy-Policy/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDevelopersScreen extends StatefulWidget {
  const AboutDevelopersScreen({super.key});

  @override
  _AboutDevelopersScreenState createState() => _AboutDevelopersScreenState();
}

class _AboutDevelopersScreenState extends State<AboutDevelopersScreen> {
  void showSide() {
    _scaffoldKey.currentState?.openDrawer();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
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
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: SingleChildScrollView(
            // profile part
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('aboutDeveloper'.tr(),
                    style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).scaffoldBackgroundColor ==
                                Colors.black
                            ? Colors.white
                            : Colors.black)),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/eyob.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Eyob Tariku',
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                const SizedBox(
                  height: 15,
                ),
                textRow(
                    'Eyob Tariku is a software engineer with a client-first approach. He develop mobile apps and websites to make peoples lives easier by helping them complete their tasks efficiently and securely.',
                    isDarkMod),
                textRow(
                    'Feel free to contact him you have any questions or need services such as website and mobile app development tailored to your requirements',
                    isDarkMod),
                const SizedBox(
                  height: 20,
                ),
                changeLanduadge(
                  onPressed: () => _launchURL('https://www.eyobtariku.tech'),
                  label: 'contactMe'.tr(),
                ),
                const SizedBox(
                  height: 30,
                ),
                // Container(
                //   height: 150,
                //   width: 150,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(100),
                //     image: const DecorationImage(
                //       image: AssetImage('assets/images/eyob.png'),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // Text(
                //   'Eyob Tariku',
                //   style: GoogleFonts.inter(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //       color: primaryColor),
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // textRow(
                //     'Your privacy is important to us. It is Brainstorming\'s policy to respect your privacy regarding any information we may collect from you across our website, and other sites we own and operate.',
                //     Theme.of(context).scaffoldBackgroundColor == Colors.black),
                // textRow(
                //     'We only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means, with your knowledge and consent. We also let you know why we’re collecting it and how it will be used.',
                //     Theme.of(context).scaffoldBackgroundColor == Colors.black),
                // const SizedBox(
                //   height: 30,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
