import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/user/domain/entity/user-entity.dart';
import 'package:ethio_gpt/feutures/user/domain/repository/user-repository.dart';

class SigninUsecase {
  final UserRepository userRepository;

  SigninUsecase({required this.userRepository});

  Future<Either<Failure, UserEntity>> excute(
      String email, String password) async {
    return userRepository.signUp(email, password);
  }
}
