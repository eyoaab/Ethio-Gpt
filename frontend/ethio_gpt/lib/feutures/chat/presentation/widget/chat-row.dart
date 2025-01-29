import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:ethio_gpt/feutures/chat/domain/entity/chat-room-entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Container chatHistoryRow(
        {required ChatRoomEntity chatRoomEntity,
        required BuildContext context}) =>
    Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: darkGray, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.message, color: Color(0xffC7C7C7)),
                const SizedBox(width: 5),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      chatRoomEntity
                          .messages[chatRoomEntity.messages.length - 1].content,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                      ),
                      softWrap: false,
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ));
