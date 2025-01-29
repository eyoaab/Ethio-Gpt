import 'package:ethio_gpt/cors/widgets/common-app-bar.dart';
import 'package:ethio_gpt/cors/widgets/common-drawer.dart';
import 'package:ethio_gpt/feutures/meta-features/Privecy-Policy/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutDevelopersScreen extends StatefulWidget {
  const AboutDevelopersScreen({super.key});

  @override
  _AboutDevelopersScreenState createState() => _AboutDevelopersScreenState();
}

class _AboutDevelopersScreenState extends State<AboutDevelopersScreen> {
  void showSide() {
    _scaffoldKey.currentState?.openDrawer();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: commonAppBar(action: showSide),
      drawer: const CommonDrawer(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroun.png'),
            fit: BoxFit.cover,
          ),
        ),
        child:
            // whole page
            Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.05),
          child: SingleChildScrollView(
            // profile part
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('About Ethio-Gpt',
                    style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                textRow(
                  'Your privacy is important to us. It is Brainstorming\'s policy to respect your privacy regarding any information we may collect from you across our website, and other sites we own and operate.',
                ),
                textRow(
                  'We only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means, with your knowledge and consent. We also let you know why we’re collecting it and how it will be used.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
