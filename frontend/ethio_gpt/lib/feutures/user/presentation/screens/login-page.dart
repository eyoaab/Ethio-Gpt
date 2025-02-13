import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:ethio_gpt/cors/utility-functions/email-validation.dart';
import 'package:ethio_gpt/cors/widgets/bg-box-decoration.dart';
import 'package:ethio_gpt/cors/widgets/common-snackbar.dart';
import 'package:ethio_gpt/feutures/chat/presentation/screens/make-caht-page.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_bloc.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_event.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_state.dart';
import 'package:ethio_gpt/feutures/user/presentation/screens/signup-page.dart';
import 'package:ethio_gpt/feutures/user/presentation/widget/common-widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  ValidateEmail validateEmail = ValidateEmail();

  void makeLogin() {
    if (isLoading) return;
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showCustomSnackBar(context, 'fillAllFields'.tr(), false);
      return;
    }
    if (!validateEmail.isValidEmail(emailController.text)) {
      showCustomSnackBar(context, 'enterValidEmail'.tr(), false);
      return;
    }
    BlocProvider.of<UserBloc>(context).add(UserLoginEvent(
        email: emailController.text, password: passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMod =
        Theme.of(context).scaffoldBackgroundColor == Colors.black;
    return BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoginSuccessState) {
            setState(() {
              isLoading = false;
            });
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => ChatScreen()));
          } else if (state is UserLoginLoadingState) {
            setState(() {
              isLoading = true;
            });
          } else if (state is UserLoginErrorState) {
            setState(() {
              isLoading = false;
            });
            showCustomSnackBar(context, state.message, false);
          }
        },
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: bgBoxDecoration(isDarkMod),
            child:
                // Content
                Padding(
              padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: MediaQuery.of(context).size.height / 10,
                  bottom: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Ethio-Gpt',
                      style: GoogleFonts.inter(
                        fontSize: 52,
                        color: isDarkMod ? Colors.white : Colors.black,
                        shadows: [
                          const Shadow(
                            blurRadius: 4.0,
                            color: Colors.black26,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "pleaseLogin".tr(),
                      style: GoogleFonts.inter(fontSize: 14, color: abAb),
                    ),
                    const SizedBox(height: 30),

                    // Social Authentication
                    SizedBox(
                      child:
                          commomSocialIcon('Google', isDarkMod), // Google Icon,
                    ),

                    const SizedBox(height: 20),

                    // OR Divider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          width: 75,
                          height: 1,
                          color: abAb,
                        ),
                        Text('or'.tr(),
                            style: GoogleFonts.inter(
                              color: abAb,
                            )),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          width: 75,
                          height: 1,
                          color: abAb,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Email Input
                    commonInputField(
                      isDarkMod: isDarkMod,
                      controller: emailController,
                      hintText: 'enterEmail'.tr(),
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 45),

                    // Password Input
                    commonInputField(
                      isDarkMod: isDarkMod,
                      controller: passwordController,
                      hintText: 'enterPassword'.tr(),
                      icon: Icons.lock,
                    ),
                    const SizedBox(height: 45),

                    // Login Button

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: makeLogin, // call the login function
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: isLoading
                            ? const SpinKitWave(color: Colors.white, size: 20.0)
                            : Text(
                                'login'.tr(),
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'dontHaveAccount'.tr(),
                          style: GoogleFonts.inter(
                              color:
                                  Theme.of(context).scaffoldBackgroundColor ==
                                          Colors.black
                                      ? Colors.white
                                      : Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          child: Text(
                            'signUp'.tr(),
                            style: GoogleFonts.inter(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
