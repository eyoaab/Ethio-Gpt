import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:ethio_gpt/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:ethio_gpt/feutures/chat/domain/entity/chat-room-entity.dart';
import 'package:ethio_gpt/feutures/chat/presentation/widget/chat-row.dart';

class ShowDailyContainer extends StatefulWidget {
  final String title;
  final List<ChatRoomEntity> listChatRoomEntity;
  final bool isDarkMod;

  const ShowDailyContainer(
      {super.key,
      required this.title,
      required this.listChatRoomEntity,
      required this.isDarkMod});

  @override
  _ShowDailyContainerState createState() => _ShowDailyContainerState();
}

class _ShowDailyContainerState extends State<ShowDailyContainer> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    final int itemCount = showAll
        ? widget.listChatRoomEntity.length
        : min(5, widget.listChatRoomEntity.length);

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      color: widget.isDarkMod ? Colors.white : Colors.black),
                ),
                if (widget.listChatRoomEntity.length > 5)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showAll = !showAll;
                      });
                    },
                    child: Text(
                      showAll ? 'seeLess'.tr() : 'seeMore'.tr(),
                      style: GoogleFonts.inter(color: primaryColor),
                    ),
                  ),
              ],
            ),
          ),
          Column(
            children: List.generate(itemCount, (index) {
              return widget.listChatRoomEntity[index].messages.isEmpty
                  ? const SizedBox.shrink()
                  : chatHistoryRow(
                      chatRoomEntity: widget.listChatRoomEntity[index],
                      context: context);
            }),
          )
        ],
      ),
    );
  }
}
