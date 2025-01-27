import 'package:ethio_gpt/feutures/chat/domain/entity/chat-room-entity.dart';

class ChatHistoryEntity {
  List<ChatRoomEntity> today;
  List<ChatRoomEntity> yestarday;
  List<ChatRoomEntity> old;

  ChatHistoryEntity(
      {required this.old, required this.today, required this.yestarday});
}
