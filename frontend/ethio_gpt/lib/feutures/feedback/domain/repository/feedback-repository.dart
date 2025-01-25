import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/feedback/domain/entity/feedback-entity.dart';

abstract class FeedbackRepository {
  Future<Either<Failure, bool>> addFeedback(FeedbackEntity feedback);
}
