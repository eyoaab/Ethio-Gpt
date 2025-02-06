import 'package:ethio_gpt/feutures/chat/data/model/message-model.dart';
import 'package:ethio_gpt/feutures/chat/domain/entity/chat-room-entity.dart';

class ChatRoomModel extends ChatRoomEntity {
  ChatRoomModel({required super.id, required super.messages});

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
        id: json['roomId'],
        messages: (json['messages'] as List)
            .map((message) =>
                MessageModel.fromJson(message as Map<String, dynamic>)
                    .toEntity())
            .toList());
  }

  ChatRoomEntity toEntity() {
    return ChatRoomEntity(id: id, messages: messages);
  }
}
