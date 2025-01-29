import 'package:ethio_gpt/feutures/chat/domain/entity/chat-room-entity.dart';
import 'package:ethio_gpt/feutures/chat/domain/entity/history-entity.dart';
import 'package:ethio_gpt/feutures/chat/domain/entity/message-entiry.dart';

List<MessageEntity> dummyMessage = [
  MessageEntity(
      content:
          "Here’s an improved version of your chatHistoryRow function with the following enhancements:Fixed Message Index Issue: chatRoomEntity.messages[-1] is incorrect; use chatRoomEntity.messages.last instead.Spacing and Alignment: Added mainAxisAlignment for better spacing between elements",
      isBot: true),
  MessageEntity(content: "I need help with my order.", isBot: false),
];

List<ChatRoomEntity> dummylistChatRoom = [
  ChatRoomEntity(id: "chat_001", messages: dummyMessage),
  ChatRoomEntity(
    id: "chat_002",
    messages: dummyMessage,
  ),
  ChatRoomEntity(id: "chat_003", messages: dummyMessage),
];

ChatHistoryEntity dummyChathistory = ChatHistoryEntity(
    old: dummylistChatRoom,
    today: dummylistChatRoom,
    yestarday: dummylistChatRoom);

ChatRoomEntity dummySingleRoom =
    ChatRoomEntity(id: "chat_001", messages: dummyMessage);
