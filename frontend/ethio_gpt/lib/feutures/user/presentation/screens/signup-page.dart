import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:ethio_gpt/cors/utility-functions/email-validation.dart';
import 'package:ethio_gpt/cors/widgets/common-snackbar.dart';
import 'package:ethio_gpt/feutures/chat/presentation/screens/make-caht-page.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_bloc.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_event.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_state.dart';
import 'package:ethio_gpt/feutures/user/presentation/screens/login-page.dart';
import 'package:ethio_gpt/feutures/user/presentation/widget/common-widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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

  void makeSignUp() {
    if (isLoading) return;
    if (passwordController.text != confirmController.text) {
      showCustomSnackBar(context, 'Please much the Passwords', false);
      return;
    }
    if (!validateEmail.isValidEmail(emailController.text)) {
      showCustomSnackBar(context, 'Please Enter Valid Email', false);
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
          if (state is UserSignUpSuccessState) {
            setState(() {
              isLoading = false;
            });
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => ChatScreen()));
          } else if (state is UserSignUpLoadingState) {
            setState(() {
              isLoading = true;
            });
          } else if (state is UserSignUpErrorState) {
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    Theme.of(context).scaffoldBackgroundColor == Colors.black
                        ? '/images/backgroun.png'
                        : '/images/whitebg.png'),
                fit: BoxFit.cover,
              ),
            ),
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
                      'Please Login To Your Account',
                      style: GoogleFonts.inter(fontSize: 14, color: abAb),
                    ),
                    const SizedBox(height: 30),

                    // Social Authentication
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        commomSocialIcon('G', isDarkMod), // Google Icon
                        commomSocialIcon('F', isDarkMod), // Facebook Icon
                        commomSocialIcon('A', isDarkMod), // Apple Icon
                      ],
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
                        Text('OR',
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
                      hintText: 'Enter Your Email',
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 35),

                    // Password Input
                    commonInputField(
                      isDarkMod: isDarkMod,
                      controller: passwordController,
                      hintText: 'Enter Your Password',
                      icon: Icons.lock,
                    ),
                    const SizedBox(height: 34),
                    // Confirm input
                    commonInputField(
                      isDarkMod: isDarkMod,
                      controller: confirmController,
                      hintText: 'Confirm Your Password',
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
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : Text(
                                'SignUp',
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
                          'Already Have Account?',
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
                            'Login',
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
