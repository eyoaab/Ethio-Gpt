import 'package:ethio_gpt/feutures/feedback/domain/entity/feedback-entity.dart';

class FeedbackModel extends FeedbackEntity {
  String content;

  FeedbackModel({
    required this.content,
  }) : super(
          content: content,
        );

  FeedbackEntity toEntity() {
    return FeedbackEntity(
      content: content,
    );
  }
}
