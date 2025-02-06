import 'package:ethio_gpt/cors/widgets/bg-box-decoration.dart';
import 'package:ethio_gpt/cors/widgets/common-app-bar.dart';
import 'package:ethio_gpt/cors/widgets/common-drawer.dart';
import 'package:ethio_gpt/cors/widgets/common-snackbar.dart';
import 'package:ethio_gpt/cors/widgets/common-submit-button.dart';
import 'package:ethio_gpt/feutures/user/presentation/widget/common-widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  void showSide() {
    _scaffoldKey.currentState?.openDrawer();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController oldnewPasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool isLoading = false;

  void makeUpdate() {
    if (newpasswordController.text != confirmpasswordController.text) {
      showCustomSnackBar(context, 'Please much the Passwords', false);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMod =
        Theme.of(context).scaffoldBackgroundColor == Colors.black;
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CommonDrawer(),
      appBar: commonAppBar(action: showSide, context: context),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: bgBoxDecoration(isDarkMod),
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
                  color:
                      Theme.of(context).scaffoldBackgroundColor == Colors.black
                          ? Colors.white
                          : Colors.black,
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
                isDarkMod: isDarkMod,
                controller: oldnewPasswordController,
                hintText: 'Enter Your Email',
                icon: Icons.person,
              ),
              const SizedBox(height: 45),

              // New Password Input
              commonInputField(
                isDarkMod: isDarkMod,
                controller: newpasswordController,
                hintText: 'Enter Your Password',
                icon: Icons.lock,
              ),
              const SizedBox(height: 45),
              // Confirm Password Input

              commonInputField(
                isDarkMod: isDarkMod,
                controller: confirmpasswordController,
                hintText: 'Confirm Your Password',
                icon: Icons.lock,
              ),
              // Login Button

              const SizedBox(height: 40),

              submitButton(
                  onPressed: makeUpdate, label: 'Update', isLoading: isLoading),
            ],
          ),
        ),
      ),
    );
  }
}
