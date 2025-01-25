class FeedbackState {}

final class FeedbackInitial extends FeedbackState {}

final class FeedbackLoadingState extends FeedbackState {}

final class FeedbackAddedState extends FeedbackState {}

final class FeedbackErrorState extends FeedbackState {
  final String errorMessage;

  FeedbackErrorState({required this.errorMessage});
}
