import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/user/domain/repository/user-repository.dart';

class UpdatePasswordUseCase {
  final UserRepository _userRepository;

  UpdatePasswordUseCase(this._userRepository);

  Future<Either<Failure, bool>> excute(
      String oldPassword, String newPassword) async {
    return await _userRepository.updatePassword(oldPassword, newPassword);
  }
}
