import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/user/domain/repository/user-repository.dart';

class LogoutUsecase {
  final UserRepository userRepository;

  LogoutUsecase(this.userRepository);

  Future<Either<Failure, bool>> excute() async {
    return userRepository.logOut();
  }
}
