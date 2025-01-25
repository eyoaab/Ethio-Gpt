import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/data/model/faq-model.dart';

abstract class FaqRepository {
  Future<Either<Failure, List<FaqModel>>> getFaqs();
}
