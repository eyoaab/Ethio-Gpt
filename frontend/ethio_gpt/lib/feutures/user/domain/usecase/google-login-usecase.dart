import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/user/domain/entity/user-entity.dart';
import 'package:ethio_gpt/feutures/user/domain/repository/user-repository.dart';

class GoogleLoginUsecase {
  final UserRepository userRepository;

  GoogleLoginUsecase({required this.userRepository});

  Future<Either<Failure, UserEntity>> excute(String email) async {
    return userRepository.googleLogIn(
      email,
    );
  }
}
