import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/user/domain/entity/user-entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> logIn(String email, String password);
  Future<Either<Failure, UserEntity>> signUp(String email, String password);
  Future<Either<Failure, bool>> updateUser(String email, String password);
  Future<Either<Failure, bool>> logOut();
  Future<Either<Failure, bool>> deleteUser();
}
