import 'package:easy_localization/easy_localization.dart';
import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:ethio_gpt/cors/utility-functions/token-validation.dart';
import 'package:ethio_gpt/cors/widgets/bg-box-decoration.dart';
import 'package:ethio_gpt/cors/widgets/common-app-bar.dart';
import 'package:ethio_gpt/cors/widgets/common-drawer.dart';
import 'package:ethio_gpt/cors/widgets/common-snackbar.dart';
import 'package:ethio_gpt/feutures/meta-features/Privecy-Policy/privecy-and-policy-Screen.dart';
import 'package:ethio_gpt/feutures/meta-features/about-developers/about-developers-page.dart';
import 'package:ethio_gpt/feutures/meta-features/about-ethio-Gpt/about-ethio-gpt.dart';
import 'package:ethio_gpt/feutures/meta-features/setting/setting-widgets.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_bloc.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_event.dart';
import 'package:ethio_gpt/feutures/user/presentation/screens/login-page.dart';
import 'package:ethio_gpt/feutures/user/presentation/screens/update-password-page.dart';
import 'package:ethio_gpt/feutures/user/presentation/screens/update-username-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  void showSide() {
    _scaffoldKey.currentState?.openDrawer();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TokenValidation tokenValidation = TokenValidation();
  String email = '--';

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    String? token = await tokenValidation.getToken();
    if (token != null) {
      setState(() {
        email = tokenValidation.getUserEmail(token);
      });
    }
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
        height: double.infinity,
        width: double.infinity,
        decoration: bgBoxDecoration(isDarkMod),
        child:
            // whole page
            SingleChildScrollView(
          // profile part
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/eyob.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(email,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                      fontSize: 20,
                      color: Theme.of(context).scaffoldBackgroundColor ==
                              Colors.black
                          ? Colors.white
                          : Colors.black)),
              const SizedBox(
                height: 15,
              ),
              // for the black part
              Container(
                  padding: const EdgeInsets.only(top: 30, bottom: 40),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Theme.of(context).scaffoldBackgroundColor !=
                            Colors.black
                        ? Colors.white
                        : Colors.black,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text('accountSettings'.tr(),
                              textAlign: TextAlign.left,
                              style: GoogleFonts.rubik(
                                  fontSize: 18, color: primaryColor)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        settingRow(
                            isDarkMod: isDarkMod,
                            action: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UpdateUserNameScreen()));
                            },
                            label: 'changUsername'.tr(),
                            icon: const Icon(Icons.person)),
                        settingRow(
                            isDarkMod: isDarkMod,
                            action: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UpdatePasswordScreen()));
                            },
                            label: 'changePassword'.tr(),
                            icon: const Icon(Icons.lock)),
                        settingRow(
                            isDarkMod: isDarkMod,
                            action: () {
                              showQuestionDialog(context, 'sureToDelete'.tr(),
                                  () {
                                context.read<UserBloc>().add(UserDeleteEvent());
                              });
                            },
                            label: 'deleteAccount'.tr(),
                            icon: const Icon(Icons.delete)),
                        settingRow(
                            isDarkMod: isDarkMod,
                            action: () {
                              // emit a logout event to a user bloc
                              context.read<UserBloc>().add(UserLogoutEvent());
                              showQuestionDialog(
                                  context,
                                  'sureToLogOut'.tr(),
                                  () => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen())));
                            },
                            label: 'logout'.tr(),
                            icon: const Icon(Icons.logout_sharp)),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text('about'.tr(),
                              textAlign: TextAlign.left,
                              style: GoogleFonts.rubik(
                                  fontSize: 18, color: primaryColor)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        settingRow(
                            isDarkMod: isDarkMod,
                            action: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AboutEthioGptScreen()));
                            },
                            label: 'aboutEthioGpt'.tr(),
                            icon: const Icon(Icons.info)),
                        settingRow(
                            isDarkMod: isDarkMod,
                            action: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AboutDevelopersScreen()));
                            },
                            label: 'aboutDeveloper'.tr(),
                            icon: const Icon(Icons.code)),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text('more'.tr(),
                              textAlign: TextAlign.left,
                              style: GoogleFonts.rubik(
                                  fontSize: 18, color: primaryColor)),
                        ),
                        settingRow(
                            isDarkMod: isDarkMod,
                            action: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PrivacyAndPolicyScreen()));
                            },
                            label: 'privacyPolicy'.tr(),
                            icon: const Icon(Icons.privacy_tip)),
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
