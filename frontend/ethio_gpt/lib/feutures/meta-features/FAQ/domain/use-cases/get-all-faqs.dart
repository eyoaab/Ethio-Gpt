import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/domain/entiry/faq-entity.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/domain/repository/faq-repository.dart';

class FaqUsecases {
  final FaqRepository repository;

  FaqUsecases(this.repository);

  Future<Either<Failure, List<FaqEntity>>> excute() async {
    return repository.getFaqs();
  }
}
