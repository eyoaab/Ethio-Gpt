import 'package:ethio_gpt/feutures/chat/data/model/chat-room-model.dart';
import 'package:ethio_gpt/feutures/chat/domain/entity/history-entity.dart';

class ChatHistoryModel extends ChatHistoryEntity {
  ChatHistoryModel(
      {required super.old, required super.today, required super.yestarday});

  factory ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    return ChatHistoryModel(
        old: (json['old'] as List)
            .map((chatRoomModel) =>
                ChatRoomModel.fromJson(chatRoomModel as Map<String, dynamic>)
                    .toEntity())
            .toList(),
        today: (json['today'] as List)
            .map((chatRoomModel) =>
                ChatRoomModel.fromJson(chatRoomModel as Map<String, dynamic>)
                    .toEntity())
            .toList(),
        yestarday: (json['yesterday'] as List)
            .map((chatRoomModel) =>
                ChatRoomModel.fromJson(chatRoomModel as Map<String, dynamic>)
                    .toEntity())
            .toList());
  }
}
