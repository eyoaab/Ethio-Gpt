import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:ethio_gpt/feutures/user/presentation/screens/signup-page.dart';
import 'package:ethio_gpt/feutures/user/presentation/widget/common-widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  TextEditingController oldnewPasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // Content
            Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Update Password',
                style: GoogleFonts.inter(
                  fontSize: 24,
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
              const SizedBox(height: 40),

              // Old Password Input
              commonInputField(
                controller: oldnewPasswordController,
                hintText: 'Enter Your Email',
                icon: Icons.person,
              ),
              const SizedBox(height: 45),

              // New Password Input
              commonInputField(
                controller: newpasswordController,
                hintText: 'Enter Your Password',
                icon: Icons.lock,
              ),
              const SizedBox(height: 45),
              // Confirm Password Input

              commonInputField(
                controller: confirmpasswordController,
                hintText: 'Confirm Your Password',
                icon: Icons.lock,
              ),
              // Login Button

              const SizedBox(height: 40),

              submitButton(
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
