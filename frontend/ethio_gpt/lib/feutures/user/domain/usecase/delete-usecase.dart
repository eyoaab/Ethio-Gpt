import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/user/domain/repository/user-repository.dart';

class DeleteUsecase {
  UserRepository userRepository;
  DeleteUsecase(this.userRepository);

  Future<Either<Failure, bool>> excute() async {
    return userRepository.deleteUser();
  }
}
