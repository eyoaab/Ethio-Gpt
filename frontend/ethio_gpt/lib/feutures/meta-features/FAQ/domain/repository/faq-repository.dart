import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/domain/entiry/faq-entity.dart';

abstract class FaqRepository {
  Future<Either<Failure, List<FaqEntity>>> getFaqs();
}
