import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:ethio_gpt/cors/widgets/common-snackbar.dart';
import 'package:ethio_gpt/feutures/chat/domain/entity/chat-room-entity.dart';
import 'package:ethio_gpt/feutures/chat/presentation/bloc/chat_bloc.dart';
import 'package:ethio_gpt/feutures/chat/presentation/bloc/chat_event.dart';
import 'package:ethio_gpt/feutures/chat/presentation/screens/make-caht-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

GestureDetector chatHistoryRow(
        {required ChatRoomEntity chatRoomEntity,
        required BuildContext context}) =>
    GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      roomId: chatRoomEntity.id,
                      previousMessages: chatRoomEntity.messages,
                    )));
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor == Colors.black
                  ? darkGray
                  : Colors.grey,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.message,
                    color: primaryColor,
                    size: 25,
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        maxLines: 1,
                        chatRoomEntity.messages.isEmpty
                            ? ''
                            : chatRoomEntity.messages[0].content,
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
                onPressed: () {
                  showQuestionDialog(
                      context, 'Are you Sure To Delete The Chat History?', () {
                    context
                        .read<ChatBloc>()
                        .add(DeleteChatHistoryEvent(roomId: chatRoomEntity.id));
                  });
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          )),
    );
