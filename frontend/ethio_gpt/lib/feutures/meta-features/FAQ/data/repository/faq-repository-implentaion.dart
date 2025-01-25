import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/exception.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/data/model/faq-model.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/domain/repository/faq-repository.dart';

class FaqRepositoryImpl implements FaqRepository {
  final FaqRepository remoteDataSource;

  FaqRepositoryImpl({required this.remoteDataSource});

  // get faq pages
  @override
  Future<Either<Failure, List<FaqModel>>> getFaqs() async {
    try {
      final faqMOdels = await remoteDataSource.getFaqs();
      return faqMOdels;
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
