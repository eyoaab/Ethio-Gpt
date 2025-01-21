import 'package:ethio_gpt/feutures/chat/domain/entity/chat-entity.dart';

class ChatModel extends ChatEntity {
  String prompt;

  ChatModel({
    required this.prompt,
  }) : super(prompt: prompt);

  Map<String, dynamic> toJson() {
    return {
      'prompt': prompt,
    };
  }

  ChatEntity toEntity() {
    return ChatEntity(
      prompt: prompt,
    );
  }
}
