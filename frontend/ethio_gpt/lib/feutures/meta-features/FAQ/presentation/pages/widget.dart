import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/domain/entiry/faq-entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqCard extends StatefulWidget {
  final FaqEntity faq;
  final bool isDarkMode;

  const FaqCard({super.key, required this.faq, required this.isDarkMode});

  @override
  _FaqCardState createState() => _FaqCardState();
}

class _FaqCardState extends State<FaqCard> with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
      isExpanded ? _controller.forward() : _controller.reverse();
    });
  }

  Widget headerWidget() {
    return Text(
      widget.faq.question,
      textAlign: TextAlign.center,
      style: GoogleFonts.inter(
          fontSize: 14, color: widget.isDarkMode ? Colors.white : Colors.black),
    );
  }

  Widget answerWidget() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: isExpanded ? _controller.value * 300 : 0,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: isExpanded
                ? Text(
                    widget.faq.answer,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        color: widget.isDarkMode ? Colors.white : Colors.black),
                    maxLines: isExpanded ? null : 0,
                    overflow: TextOverflow.fade,
                  )
                : const Text(''),
          ),
        );
      },
    );
  }

  Widget buttonWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: _toggleExpansion,
          child: Icon(
            isExpanded ? Icons.expand_less : Icons.expand_more,
            color: primaryColor,
            size: 30,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Theme.of(context).scaffoldBackgroundColor == Colors.black
            ? darkGray
            : lightGray,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerWidget(),
              const SizedBox(height: 5),
              Divider(thickness: 1.5, color: primaryColor),
              answerWidget(),
              buttonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
