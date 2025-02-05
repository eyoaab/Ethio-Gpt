import 'package:ethio_gpt/cors/widgets/common-app-bar.dart';
import 'package:ethio_gpt/cors/widgets/common-drawer.dart';
import 'package:ethio_gpt/cors/widgets/common-submit-button.dart';
import 'package:ethio_gpt/feutures/feedback/presentation/widget/feedback-form.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
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
                    'How was your experience',
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
                Text('This will help us please try to be more descriptive ',
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
                feedbackForm(controller: feedbackController, context: context),
                // submit Button
                const SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      submitButton(
                        onPressed: () {},
                        label: 'Submit',
                      ),
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
