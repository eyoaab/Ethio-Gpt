import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:ethio_gpt/cors/widgets/bg-box-decoration.dart';
import 'package:ethio_gpt/cors/widgets/common-app-bar.dart';
import 'package:ethio_gpt/cors/widgets/common-drawer.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/domain/entiry/faq-entity.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/presentation/bloc/faq_bloc.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/presentation/bloc/faq_event.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/presentation/bloc/faq_state.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/presentation/pages/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<FaqBloc>().add(LoadFaqsEvent());
  }

  void showSide() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Theme.of(context).scaffoldBackgroundColor == Colors.black;
    final Color searchFieldColor = isDarkMode ? darkGray : lightGray;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const CommonDrawer(),
      appBar: commonAppBar(action: showSide, context: context),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: bgBoxDecoration(isDarkMode),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, bottom: 8.0, top: 2),
          child: Column(
            children: [
              // Search Field
              TextField(
                style: GoogleFonts.inter(color: textColor),
                decoration: InputDecoration(
                  hintText: 'Search FAQs',
                  hintStyle: GoogleFonts.inter(color: Colors.grey),
                  suffixIcon: Icon(Icons.search, color: primaryColor),
                  fillColor: searchFieldColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onChanged: (value) =>
                    setState(() => searchQuery = value.trim().toLowerCase()),
              ),
              const SizedBox(height: 8),

              // FAQ List using BlocBuilder
              Expanded(
                child: BlocBuilder<FaqBloc, FaqState>(
                  builder: (context, state) {
                    if (state is FaqLoadingState) {
                      return Center(
                          child:
                              CircularProgressIndicator(color: primaryColor));
                    }
                    if (state is FaqErrorState) {
                      return Center(
                        child: Text(state.errorMessage,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 16)),
                      );
                    }

                    List<FaqEntity> faqs =
                        state is FaqLoadedState ? state.faqs : [];
                    List<FaqEntity> filteredFaqs = faqs
                        .where((faq) =>
                            faq.question.toLowerCase().contains(searchQuery))
                        .toList();

                    return filteredFaqs.isEmpty
                        ? const Center(
                            child: Text('No FAQs found!',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 18)),
                          )
                        : ListView.builder(
                            itemCount: filteredFaqs.length,
                            itemBuilder: (context, index) {
                              return FaqCard(
                                  faq: filteredFaqs[index],
                                  isDarkMode: isDarkMode);
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
