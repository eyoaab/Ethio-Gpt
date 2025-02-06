import 'package:ethio_gpt/feutures/chat/data/model/chat-room-model.dart';
import 'package:ethio_gpt/feutures/chat/domain/entity/history-entity.dart';

class ChatHistoryModel extends ChatHistoryEntity {
  ChatHistoryModel(
      {required super.old, required super.today, required super.yestarday});

  factory ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    return ChatHistoryModel(
        old: (json['roomsOld'] as List)
            .map((chatRoomModel) =>
                ChatRoomModel.fromJson(chatRoomModel as Map<String, dynamic>)
                    .toEntity())
            .toList(),
        today: (json['roomsToday'] as List)
            .map((chatRoomModel) =>
                ChatRoomModel.fromJson(chatRoomModel as Map<String, dynamic>)
                    .toEntity())
            .toList(),
        yestarday: (json['roomsYesterday'] as List)
            .map((chatRoomModel) =>
                ChatRoomModel.fromJson(chatRoomModel as Map<String, dynamic>)
                    .toEntity())
            .toList());
  }

  // function to convert the model to entity
  ChatHistoryEntity toEntity() {
    return ChatHistoryEntity(old: old, today: today, yestarday: yestarday);
  }
}
