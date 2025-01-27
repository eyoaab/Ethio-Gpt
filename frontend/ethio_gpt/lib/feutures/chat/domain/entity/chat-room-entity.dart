import 'package:ethio_gpt/feutures/chat/domain/entity/message-entiry.dart';

class ChatRoomEntity {
  String id;
  List<MessageEntity> messages;
  ChatRoomEntity({required this.id, required this.messages});
}
