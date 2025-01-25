import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/feedback/domain/entity/feedback-entity.dart';
import 'package:ethio_gpt/feutures/feedback/domain/repository/feedback-repository.dart';

class FeedBackUseCase {
  final FeedbackRepository feedBackRepository;

  FeedBackUseCase({required this.feedBackRepository});

  Future<Either<Failure, bool>> excute(FeedbackEntity feedback) async {
    return await feedBackRepository.addFeedback(feedback);
  }
}
