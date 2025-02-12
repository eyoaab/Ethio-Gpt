import 'package:easy_localization/easy_localization.dart';
import 'package:ethio_gpt/cors/widgets/bg-box-decoration.dart';
import 'package:ethio_gpt/cors/widgets/common-app-bar.dart';
import 'package:ethio_gpt/cors/widgets/common-drawer.dart';
import 'package:ethio_gpt/cors/widgets/common-snackbar.dart';
import 'package:ethio_gpt/cors/widgets/common-submit-button.dart';
import 'package:ethio_gpt/feutures/feedback/domain/entity/feedback-entity.dart';
import 'package:ethio_gpt/feutures/feedback/presentation/bloc/feedback_bloc.dart';
import 'package:ethio_gpt/feutures/feedback/presentation/bloc/feedback_event.dart';
import 'package:ethio_gpt/feutures/feedback/presentation/bloc/feedback_state.dart';
import 'package:ethio_gpt/feutures/feedback/presentation/widget/feedback-form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController feedbackController = TextEditingController();
  void showSide() {
    _scaffoldKey.currentState?.openDrawer();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  void addFeedback() {
    setState(() {
      if (isLoading) {
        return;
      }
      if (feedbackController.text.isEmpty) {
        return;
      }

      isLoading = true;
    });
    FeedbackEntity feedback = FeedbackEntity(content: feedbackController.text);
    context
        .read<FeedbackBloc>()
        .add(AddFeedbackEvent(feedbackEntity: feedback));
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).scaffoldBackgroundColor == Colors.black;
    return BlocListener<FeedbackBloc, FeedbackState>(
        listener: (context, state) {
          if (state is FeedbackErrorState) {
            setState(() {
              isLoading = false;
            });
            showCustomSnackBar(context, state.errorMessage, false);
          } else if (state is FeedbackAddedState) {
            setState(() {
              isLoading = false;
            });
            showCustomSnackBar(context, 'feedbackSuccess'.tr(), true);
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: commonAppBar(action: showSide, context: context),
          drawer: const CommonDrawer(),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: bgBoxDecoration(isDarkMode),
            child:
                // Content
                Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 20,
                // top: MediaQuery.of(context).size.height * 0.05
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        textAlign: TextAlign.left,
                        'howTheAppWas'.tr(),
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
                    ),
                    const SizedBox(height: 20),
                    Text('detailFeedback'.tr(),
                        textAlign: TextAlign.left,
                        style: GoogleFonts.inter(
                          fontSize: 16,
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
                        )),
                    const SizedBox(height: 20),
                    feedbackForm(
                        controller: feedbackController, context: context),
                    // submit Button
                    const SizedBox(height: 30),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          submitButton(
                            isLoading: isLoading,
                            onPressed: addFeedback,
                            label: 'submit'.tr(),
                          ),
                        ])
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
