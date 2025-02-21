import 'package:easy_localization/easy_localization.dart';
import 'package:ethio_gpt/cors/widgets/bg-box-decoration.dart';
import 'package:ethio_gpt/cors/widgets/common-app-bar.dart';
import 'package:ethio_gpt/cors/widgets/common-drawer.dart';
import 'package:ethio_gpt/cors/widgets/common-snackbar.dart';
import 'package:ethio_gpt/cors/widgets/common-submit-button.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_bloc.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_event.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_state.dart';
import 'package:ethio_gpt/feutures/user/presentation/widget/common-widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  void changePassword() {
    if (isLoading) {
      return;
    }
    if (oldnewPasswordController.text.isEmpty ||
        newpasswordController.text.isEmpty ||
        confirmpasswordController.text.isEmpty) {
      showCustomSnackBar(context, 'fillAllFields'.tr(), false);
      return;
    } else if (newpasswordController.text != confirmpasswordController.text) {
      showCustomSnackBar(context, 'passwordNotMatch'.tr(), false);
      return;
    }

    // emit the state to the bloc
    context.read<UserBloc>().add(UsesrPasswordUpdateEvent(
          oldPassword: oldnewPasswordController.text,
          newPassword: newpasswordController.text,
        ));
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
          child: BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserPasswordUpdateLoadingState) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is UserPasswordUpdateSuccessState) {
                setState(() {
                  isLoading = false;
                  oldnewPasswordController.clear();
                  newpasswordController.clear();
                  confirmpasswordController.clear();
                });
                showCustomSnackBar(context, 'successOfUpdatePassword'.tr(),
                    true); //translate this one
              } else if (state is UserPasswordUpdateErrorState) {
                setState(() {
                  isLoading = false;
                });
                showCustomSnackBar(context, state.message, false);
              }
            },
            // Content
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'changePassword'.tr(),
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      color: Theme.of(context).scaffoldBackgroundColor ==
                              Colors.black
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
                    hintText: 'eneterOldPassword'.tr(),
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 45),

                  // New Password Input
                  commonInputField(
                    isDarkMod: isDarkMod,
                    controller: newpasswordController,
                    hintText: 'enterNewPassword'.tr(),
                    icon: Icons.lock,
                  ),
                  const SizedBox(height: 45),
                  // Confirm Password Input

                  commonInputField(
                    isDarkMod: isDarkMod,
                    controller: confirmpasswordController,
                    hintText: 'confirmPassword'.tr(),
                    icon: Icons.lock,
                  ),
                  // Login Button

                  const SizedBox(height: 40),

                  submitButton(
                      onPressed: changePassword,
                      label: 'submit'.tr(),
                      isLoading: isLoading),
                ],
              ),
            ),
          )),
    );
  }
}
