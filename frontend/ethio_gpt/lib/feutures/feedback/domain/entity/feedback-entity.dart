class FeedbackEntity {
  final String content;
  final String? email;
  final String userId;

  FeedbackEntity({
    required this.content,
    this.email,
    required this.userId,
  });
}
