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

class UpdateUserNameScreen extends StatefulWidget {
  const UpdateUserNameScreen({super.key});

  @override
  _UpdateUserNameScreenState createState() => _UpdateUserNameScreenState();
}

class _UpdateUserNameScreenState extends State<UpdateUserNameScreen> {
  void showSide() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void updateUserame() {
    if (isLoading) {
      return;
    }
    if (newUserNameController.text.isEmpty || passwordController.text.isEmpty) {
      showCustomSnackBar(context, 'fillAllFields'.tr(), false);
      return;
    }
    // emit the state to the bloc
    context.read<UserBloc>().add(UserUpdateEvent(
          email: newUserNameController.text,
          password: passwordController.text,
        ));
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
          decoration: bgBoxDecoration(isDarkMod),
          child: BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserUpdateLoadingState) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is UserUpdateSuccessState) {
                setState(() {
                  isLoading = false;
                });
                // clear all fields
                newUserNameController.clear();
                passwordController.clear();
                showCustomSnackBar(context, 'successOfUpdateUsername'.tr(),
                    true); //translate this one
              } else if (state is UserUpdateErrorState) {
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
                    'changUsername'.tr(),
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
                    controller: newUserNameController,
                    hintText: 'enterNewUsername'.tr(),
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 45),

                  // New Password Input
                  commonInputField(
                    isDarkMod: isDarkMod,
                    controller: passwordController,
                    hintText: 'enterPassword'.tr(),
                    icon: Icons.lock,
                  ),
                  const SizedBox(height: 45),
                  // Confirm Password Input

                  // Login Button

                  const SizedBox(height: 40),

                  submitButton(
                      onPressed: updateUserame,
                      label: 'submit'.tr(),
                      isLoading: isLoading),
                ],
              ),
            ),
          )),
    );
  }
}
