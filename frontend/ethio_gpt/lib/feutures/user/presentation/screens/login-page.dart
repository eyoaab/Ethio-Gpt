import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:ethio_gpt/feutures/user/presentation/screens/signup-page.dart';
import 'package:ethio_gpt/feutures/user/presentation/widget/common-widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    color: Colors.white,
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
                  'Please Login To Your Account',
                  style: GoogleFonts.inter(fontSize: 14, color: abAb),
                ),
                const SizedBox(height: 30),

                // Social Authentication
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    commomSocialIcon('G'), // Google Icon
                    commomSocialIcon('F'), // Facebook Icon
                    commomSocialIcon('A'), // Apple Icon
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
                  controller: emailController,
                  hintText: 'Enter Your Email',
                  icon: Icons.person,
                ),
                const SizedBox(height: 45),

                // Password Input
                commonInputField(
                  controller: passwordController,
                  hintText: 'Enter Your Password',
                  icon: Icons.lock,
                ),
                const SizedBox(height: 45),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Login',
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
                      'Don\'t have an account?',
                      style: GoogleFonts.inter(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      child: Text(
                        'Sign Up',
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
    );
  }
}
