import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:ethio_gpt/feutures/chat/domain/entity/message-entiry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Expanded listMessagesWidget({
  required List<MessageEntity> messagesList,
  required bool isLoading,
  required String? errorMessage,
  required bool isDarkMode,
  required ScrollController scrollController,
}) =>
    Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemCount: messagesList.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (isLoading && index == messagesList.length) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SpinKitWave(color: primaryColor, size: 20.0),
                  const SizedBox(width: 10),
                  const Text("ረዳትዎ  እየጻፈ ነው....",
                      style: TextStyle(fontSize: 16)),
                  if (errorMessage != null) ...[
                    const SizedBox(width: 10),
                    const Icon(Icons.error, color: Colors.red),
                    const SizedBox(width: 5),
                    Text(errorMessage,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 16)),
                  ],
                ],
              ),
            );
          }

          final message = messagesList[index];
          final isUserMessage = !message.isBot;

          return Align(
            alignment:
                isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: isUserMessage
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isUserMessage) ...[
                  CircleAvatar(
                    backgroundColor: primaryColor,
                    child: Container(
                        margin: const EdgeInsets.only(left: 2),
                        child: const Icon(Icons.android, color: Colors.white)),
                  ),
                ],
                Flexible(
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                    decoration: BoxDecoration(
                      color: isUserMessage
                          ? isDarkMode
                              ? darkGray
                              : lightGray.withOpacity(0.5)
                          : primaryColor.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        bottomLeft: isUserMessage
                            ? const Radius.circular(20)
                            : const Radius.circular(5),
                        bottomRight: isUserMessage
                            ? const Radius.circular(5)
                            : const Radius.circular(20),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      message.content,
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                if (isUserMessage) ...[
                  CircleAvatar(
                    backgroundColor: darkGray,
                    child: Container(
                      margin: const EdgeInsets.only(right: 2.0),
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
