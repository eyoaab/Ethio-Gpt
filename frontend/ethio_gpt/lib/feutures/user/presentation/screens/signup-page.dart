import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:ethio_gpt/cors/utility-functions/email-validation.dart';
import 'package:ethio_gpt/cors/widgets/bg-box-decoration.dart';
import 'package:ethio_gpt/cors/widgets/common-snackbar.dart';
import 'package:ethio_gpt/feutures/chat/presentation/screens/make-caht-page.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_bloc.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_event.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_state.dart';
import 'package:ethio_gpt/feutures/user/presentation/screens/login-page.dart';
import 'package:ethio_gpt/feutures/user/presentation/widget/common-widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  ValidateEmail validateEmail = ValidateEmail();
  bool isLoading = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    clientId: (defaultTargetPlatform == TargetPlatform.android)
        ? "199108539875-eriel7b0ph51gl2pk79dvs6sf720dlsm.apps.googleusercontent.com"
        : "199108539875-eriel7b0ph51gl2pk79dvs6sf720dlsm.apps.googleusercontent.com",
  );

  Future<void> signUpWithGoogle() async {
    if (isLoading) {
      return;
    }
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // User canceled sign-in

      final String userEmail = googleUser.email;

      log(userEmail);
      BlocProvider.of<UserBloc>(context).add(GoogleUserSignUpEvent(
        email: userEmail,
      ));
    } catch (error) {
      log("Error signing in with Google: $error");
    }
  }

  void makeSignUp() {
    if (isLoading) return;
    if (passwordController.text.isEmpty ||
        confirmController.text.isEmpty ||
        emailController.text.isEmpty) {
      showCustomSnackBar(context, 'fillAllFields'.tr(), false);
      return;
    }

    if (passwordController.text != confirmController.text) {
      showCustomSnackBar(context, 'passwordNotMatch'.tr(), false);
      return;
    }
    if (!validateEmail.isValidEmail(emailController.text)) {
      showCustomSnackBar(context, 'enterValidEmail'.tr(), false);
      return;
    }
    BlocProvider.of<UserBloc>(context).add(UserSignUpEvent(
      email: emailController.text,
      password: passwordController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMod =
        Theme.of(context).scaffoldBackgroundColor == Colors.black;
    return BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserSignUpSuccessState ||
              state is GoogleUserSignUpSuccessState) {
            setState(() {
              isLoading = false;
            });
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => ChatScreen()));
          } else if (state is UserSignUpLoadingState ||
              state is GoogleUserSignUpLoadingState) {
            setState(() {
              isLoading = true;
            });
          } else if (state is UserSignUpErrorState) {
            setState(() {
              isLoading = false;
            });
            showCustomSnackBar(context, state.message, false);
          } else if (state is GoogleUserSignUpErrorState) {
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
                        color: Theme.of(context).scaffoldBackgroundColor ==
                                Colors.black
                            ? Colors.white
                            : Colors.black,
                        shadows: [
                          const Shadow(
                            blurRadius: 4.0,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'pleaseLogin'.tr(),
                      style: GoogleFonts.inter(fontSize: 14, color: abAb),
                    ),
                    const SizedBox(height: 20),

                    // Social Authentication
                    SizedBox(
                      child: GestureDetector(
                          onTap: signUpWithGoogle,
                          child: commomSocialIcon(
                              'Google', isDarkMod)), // Google Icon,
                    ),
                    const SizedBox(height: 10),

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
                    const SizedBox(height: 35),

                    // Password Input
                    commonInputField(
                      isDarkMod: isDarkMod,
                      controller: passwordController,
                      hintText: 'enterPassword'.tr(),
                      icon: Icons.lock,
                    ),
                    const SizedBox(height: 34),
                    // Confirm input
                    commonInputField(
                      isDarkMod: isDarkMod,
                      controller: confirmController,
                      hintText: 'confirmPassword'.tr(),
                      icon: Icons.lock,
                    ),
                    const SizedBox(height: 35),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: makeSignUp, //call the function
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: isLoading
                            ? const SpinKitWave(color: Colors.white, size: 20.0)
                            : Text(
                                'signUp'.tr(),
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
                          'haveAccount'.tr(),
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
                                    builder: (context) => const LoginScreen()));
                          },
                          child: Text(
                            'login'.tr(),
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
