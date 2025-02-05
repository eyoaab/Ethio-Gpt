import 'package:ethio_gpt/cors/widgets/common-app-bar.dart';
import 'package:ethio_gpt/cors/widgets/common-drawer.dart';
import 'package:ethio_gpt/cors/widgets/common-submit-button.dart';
import 'package:ethio_gpt/feutures/user/presentation/widget/common-widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateUserNameScreen extends StatefulWidget {
  const UpdateUserNameScreen({super.key});

  @override
  _UpdateUserNameScreenState createState() => _UpdateUserNameScreenState();
}

class _UpdateUserNameScreenState extends State<UpdateUserNameScreen> {
  void showSide() {
    _scaffoldKey.currentState?.openDrawer();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController newUserNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

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
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Update UserName',
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
                controller: newUserNameController,
                hintText: 'Enter Your New Email',
                icon: Icons.person,
              ),
              const SizedBox(height: 45),

              // New Password Input
              commonInputField(
                isDarkMod: isDarkMod,
                controller: passwordController,
                hintText: 'Enter Your Password',
                icon: Icons.lock,
              ),
              const SizedBox(height: 45),
              // Confirm Password Input

              // Login Button

              const SizedBox(height: 40),

              submitButton(
                  onPressed: () {}, label: 'Update', isLoading: isLoading),
            ],
          ),
        ),
      ),
    );
  }
}
