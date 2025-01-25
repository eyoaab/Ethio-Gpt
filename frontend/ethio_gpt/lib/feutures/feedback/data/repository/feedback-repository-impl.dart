import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/exception.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/feedback/data/data-source/remote-data-source.dart';
import 'package:ethio_gpt/feutures/feedback/domain/entity/feedback-entity.dart';
import 'package:ethio_gpt/feutures/feedback/domain/repository/feedback-repository.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  final FeedbackRemoteDataSource remoteDataSource;

  FeedbackRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, bool>> addFeedback(FeedbackEntity feedback) async {
    try {
      final isAdded = await remoteDataSource.addFeedback(feedback);
      return Right(isAdded);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(e.errorMessage));
      } else if (e is NetworkException) {
        return const Left(NetworkFailure('No internet connection'));
      } else {
        return const Left(ServerFailure('Unexpected error occurred'));
      }
    }
  }
}
