import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/user/domain/repository/user-repository.dart';

class UpdateUsecase {
  final UserRepository userRepository;

  UpdateUsecase({required this.userRepository});

  Future<Either<Failure, bool>> excute(String email, String password) async {
    return userRepository.updateUser(email, password);
  }
}
