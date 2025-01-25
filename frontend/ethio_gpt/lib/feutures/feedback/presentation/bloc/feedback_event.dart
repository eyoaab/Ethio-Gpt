import 'package:ethio_gpt/feutures/feedback/domain/entity/feedback-entity.dart';

class FeedbackEvent {}

class AddFeedbackEvent extends FeedbackEvent {
  final FeedbackEntity feedbackEntity;

  AddFeedbackEvent({required this.feedbackEntity});
}
