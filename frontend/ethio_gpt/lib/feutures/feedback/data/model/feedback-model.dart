import 'package:ethio_gpt/feutures/feedback/domain/entity/feedback-entity.dart';

class FeedbackModel extends FeedbackEntity {
  String content;
  String? email;
  String userId;

  FeedbackModel({
    required this.content,
    this.email,
    required this.userId,
  }) : super(content: content, email: email, userId: userId);

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'email': email,
      'userId': userId,
    };
  }

  FeedbackEntity toEntity() {
    return FeedbackEntity(
      content: content,
      email: email,
      userId: userId,
    );
  }
}
