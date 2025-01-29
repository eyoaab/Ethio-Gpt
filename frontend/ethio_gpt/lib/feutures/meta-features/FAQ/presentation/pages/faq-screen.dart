import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:ethio_gpt/cors/widgets/common-app-bar.dart';
import 'package:ethio_gpt/cors/widgets/common-drawer.dart';
import 'package:ethio_gpt/dummy-data.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/domain/entiry/faq-entity.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/presentation/pages/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  void showSide() {
    _scaffoldKey.currentState?.openDrawer();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: const CommonDrawer(),
        appBar: commonAppBar(action: showSide),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/backgroun.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                // Search Field
                TextField(
                  style: GoogleFonts.inter(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search FAQs',
                    hintStyle: GoogleFonts.inter(color: Colors.grey),
                    suffixIcon: Icon(Icons.search, color: primaryColor),
                    fillColor: lightGray,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.trim().toLowerCase();
                    });
                  },
                ),
                const SizedBox(height: 16),

                // FAQ List
                Expanded(
                  child: Builder(
                    builder: (context) {
                      List<FaqEntity> filteredFaqs = dummyFaq
                          .where((faq) =>
                              faq.question.toLowerCase().contains(searchQuery))
                          .toList();

                      if (filteredFaqs.isEmpty) {
                        return const Center(
                          child: Text(
                            'No FAQs found!',
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: filteredFaqs.length,
                        itemBuilder: (context, index) {
                          return FaqCard(faq: filteredFaqs[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
