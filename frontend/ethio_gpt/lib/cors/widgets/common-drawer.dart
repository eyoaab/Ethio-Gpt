import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:ethio_gpt/cors/widgets/drawer-row.dart';
import 'package:ethio_gpt/feutures/user/presentation/widget/common-widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key});

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
            color: darkGray,
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
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(color: Colors.white30, thickness: 0.5),

              // Drawer Items
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    commonListTile(
                        title: 'Home',
                        icon: Icons.home,
                        onTap: () {},
                        isSelected: true),
                    commonListTile(
                        title: 'Feedback',
                        icon: Icons.feedback_outlined,
                        onTap: () {},
                        isSelected: false),
                    commonListTile(
                        title: 'Chat History',
                        icon: Icons.chat_outlined,
                        onTap: () {},
                        isSelected: false),
                    commonListTile(
                        title: 'Rate Our App',
                        icon: Icons.rate_review_outlined,
                        onTap: () {},
                        isSelected: false),
                    commonListTile(
                        title: 'About Developer',
                        icon: Icons.code,
                        onTap: () {},
                        isSelected: false),
                    commonListTile(
                        title: 'FAQ Page',
                        icon: Icons.question_answer_outlined,
                        onTap: () {},
                        isSelected: false),
                    commonListTile(
                        title: 'Settings',
                        icon: Icons.settings,
                        onTap: () {},
                        isSelected: false),
                  ],
                ),
              ),

              const Divider(color: Colors.white30, thickness: 0.5),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: changeLanduadge(
                      onPressed: () {}, label: 'Change Language'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
