import 'package:ethio_gpt/feutures/chat/domain/entity/message-entiry.dart';

class MessageModel extends MessageEntity {
  MessageModel({required super.content, required super.isBot});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(content: json['content'], isBot: json['isBot']);
  }

  MessageEntity toEntity() {
    return MessageEntity(content: content, isBot: isBot);
  }
}
