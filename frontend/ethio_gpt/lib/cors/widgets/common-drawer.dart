import 'package:easy_localization/easy_localization.dart';
import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:ethio_gpt/cors/utility-functions/token-validation.dart';
import 'package:ethio_gpt/cors/widgets/common-snackbar.dart';
import 'package:ethio_gpt/cors/widgets/common-submit-button.dart';
import 'package:ethio_gpt/cors/widgets/drawer-row.dart';
import 'package:ethio_gpt/feutures/chat/presentation/screens/chat-history-page.dart';
import 'package:ethio_gpt/feutures/chat/presentation/screens/make-caht-page.dart';
import 'package:ethio_gpt/feutures/feedback/presentation/screens/feedback-screen.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/presentation/pages/faq-screen.dart';
import 'package:ethio_gpt/feutures/meta-features/about-developers/about-developers-page.dart';
import 'package:ethio_gpt/feutures/meta-features/setting/bloc/setting_bloc.dart';
import 'package:ethio_gpt/feutures/meta-features/setting/bloc/setting_event.dart';
import 'package:ethio_gpt/feutures/meta-features/setting/bloc/setting_state.dart';
import 'package:ethio_gpt/feutures/meta-features/setting/setting-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key});

  void _onTapItem(BuildContext context, int index, Widget page) {
    context.read<SettingBloc>().add(CangeSetingEvent(index));
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor == Colors.black
                ? darkGray
                : lightGray,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drawer Header
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01),
                child: Row(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('/images/small.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      'Ethio-Gpt',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        color: Theme.of(context).scaffoldBackgroundColor ==
                                Colors.black
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Divider(
                  color:
                      Theme.of(context).scaffoldBackgroundColor == Colors.black
                          ? Colors.white30
                          : Colors.black38,
                  thickness: 0.5),

              BlocBuilder<SettingBloc, SettingState>(
                builder: (context, state) {
                  if (state is CurrentindexState) {
                    // Drawer Items
                    return Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          commonListTile(
                            context: context,
                            title: 'home'.tr(),
                            icon: Icons.home,
                            onTap: () => _onTapItem(context, 0, ChatScreen()),
                            isSelected: state.index == 0,
                          ),
                          commonListTile(
                            context: context,
                            title: 'feedback'.tr(),
                            icon: Icons.feedback_outlined,
                            onTap: () =>
                                _onTapItem(context, 1, const FeedbackScreen()),
                            isSelected: state.index == 1,
                          ),
                          commonListTile(
                            context: context,
                            title: 'chatHistory'.tr(),
                            icon: Icons.chat_outlined,
                            onTap: () => _onTapItem(
                                context, 2, const ChatHistoryScreen()),
                            isSelected: state.index == 2,
                          ),
                          commonListTile(
                            context: context,
                            title: 'rateApp'.tr(),
                            icon: Icons.rate_review_outlined,
                            onTap: () => _onTapItem(context, 3,
                                ChatScreen()), // should be fixed later
                            isSelected: state.index == 3,
                          ),
                          commonListTile(
                            context: context,
                            title: 'aboutDeveloper'.tr(),
                            icon: Icons.code,
                            onTap: () => _onTapItem(
                                context, 4, const AboutDevelopersScreen()),
                            isSelected: state.index == 4,
                          ),
                          commonListTile(
                            context: context,
                            title: 'faqPge'.tr(),
                            icon: Icons.question_answer_outlined,
                            onTap: () =>
                                _onTapItem(context, 5, const FaqScreen()),
                            isSelected: state.index == 5,
                          ),
                          commonListTile(
                            context: context,
                            title: 'settings'.tr(),
                            icon: Icons.settings,
                            onTap: () =>
                                _onTapItem(context, 6, const SettingScreen()),
                            isSelected: state.index == 6,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),

              Divider(
                  color:
                      Theme.of(context).scaffoldBackgroundColor == Colors.black
                          ? Colors.white30
                          : Colors.black38,
                  thickness: 0.5),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: changeLanduadge(
                    onPressed: () {
                      TokenValidation tokenValidation = TokenValidation();
                      showQuestionDialog(context, "sureToChangeLanguage".tr(),
                          () async {
                        Locale currentLocale = context.locale;
                        if (currentLocale.languageCode == 'en') {
                          context.setLocale(const Locale('am', 'ET'));
                          Navigator.pop(context);
                          await tokenValidation.saveLanguage('am');
                        } else {
                          context.setLocale(const Locale('en', 'US'));
                          Navigator.pop(context);

                          await tokenValidation.saveLanguage('en');
                        }
                      });
                    },
                    label: 'chageLanguadge'.tr(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
