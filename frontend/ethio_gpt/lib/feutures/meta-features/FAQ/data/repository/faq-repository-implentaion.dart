import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/exception.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/data/data-source/faq-remote-datasource.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/domain/entiry/faq-entity.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/domain/repository/faq-repository.dart';

class FaqRepositoryImpl implements FaqRepository {
  final FaqRemoteDataSource remoteDataSource;

  FaqRepositoryImpl({required this.remoteDataSource});

  // get faq pages
  @override
  Future<Either<Failure, List<FaqEntity>>> getFaqs() async {
    try {
      final faqModels = await remoteDataSource.getAllFaqs();
      List<FaqEntity> faqs = [];
      for (var faq in faqModels) {
        faqs.add(FaqEntity(
          question: faq.question,
          answer: faq.answer,
        ));
      }
      return Right(faqs);
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
