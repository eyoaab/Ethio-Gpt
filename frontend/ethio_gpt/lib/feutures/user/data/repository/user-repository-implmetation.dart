import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/exception.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/user/data/data-source/remote-data-source.dart';
import 'package:ethio_gpt/feutures/user/data/model/user-model.dart';
import 'package:ethio_gpt/feutures/user/domain/entity/user-entity.dart';
import 'package:ethio_gpt/feutures/user/domain/repository/user-repository.dart';
import 'package:ethio_gpt/cors/utility-functions/token-validation.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSourceImpl remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});
  final TokenValidation tokenValidation = TokenValidation();

  // google user login
  @override
  Future<Either<Failure, UserEntity>> googleLogIn(String email) async {
    try {
      final token = await remoteDataSource.gooleSignInUser(email);
      await tokenValidation.saveToken(token.token);
      return Right(token);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(e.errorMessage));
      } else if (e is NetworkException) {
        return const Left(NetworkFailure('No internet connection'));
      } else {
        return const Left(ServerFailure('Unexpected error occurred'));
      }
    }
  }

  // for google sign up
  @override
  Future<Either<Failure, UserEntity>> googleSignUp(String email) async {
    try {
      final token = await remoteDataSource.googleSignUpUser(
        email,
      );
      await tokenValidation.saveToken(token.token);

      return Right(token);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(e.errorMessage));
      } else if (e is NetworkException) {
        return const Left(NetworkFailure('No internet connection'));
      } else {
        return const Left(ServerFailure('Unexpected error occurred'));
      }
    }
  }

  // login a user
  @override
  Future<Either<Failure, UserModel>> logIn(
      String email, String password) async {
    try {
      final token = await remoteDataSource.signInUser(email, password);
      await tokenValidation.saveToken(token.token);
      return Right(token);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(e.errorMessage));
      } else if (e is NetworkException) {
        return const Left(NetworkFailure('No internet connection'));
      } else {
        return const Left(ServerFailure('Unexpected error occurred'));
      }
    }
  }

  // sign up a user
  @override
  Future<Either<Failure, UserModel>> signUp(
      String email, String password) async {
    try {
      final token = await remoteDataSource.signUpUser(
        email,
        password,
      );
      await tokenValidation.saveToken(token.token);

      return Right(token);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(e.errorMessage));
      } else if (e is NetworkException) {
        return const Left(NetworkFailure('No internet connection'));
      } else {
        return const Left(ServerFailure('Unexpected error occurred'));
      }
    }
  }

  // update a user
  @override
  Future<Either<Failure, bool>> updateUser(
      String email, String password) async {
    try {
      String? token = await tokenValidation.getToken();
      final response =
          await remoteDataSource.updateUser(email, password, token!);
      return Right(response);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(e.errorMessage));
      } else if (e is NetworkException) {
        return const Left(NetworkFailure('No internet connection'));
      } else {
        return const Left(ServerFailure('Unexpected error occurred'));
      }
    }
  }

  // delete a suer
  @override
  // write a delete user function
  Future<Either<Failure, bool>> deleteUser() async {
    try {
      String? token = await tokenValidation.getToken();
      if (token == null) {
        return const Left(CacheFailure('token is empty'));
      }
      final response = await remoteDataSource.deleteUser(token);
      return Right(response);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(e.errorMessage));
      } else if (e is NetworkException) {
        return const Left(NetworkFailure('No internet connection'));
      } else {
        return const Left(ServerFailure('Unexpected error occurred'));
      }
    }
  }

  // log outa user
  @override
  // write a fucntion to log out a user
  Future<Either<Failure, bool>> logOut() async {
    try {
      final response = await remoteDataSource.logOut();
      await tokenValidation.removeToken();

      return Right(response);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(e.errorMessage));
      } else if (e is NetworkException) {
        return const Left(NetworkFailure('No internet connection'));
      } else {
        return const Left(ServerFailure('Unexpected error occurred'));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> updatePassword(
      String oldPassword, String newPassword) async {
    try {
      String? token = await tokenValidation.getToken();

      final response = await remoteDataSource.updatePassword(
          oldPassword, newPassword, token!);
      return Right(response);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(e.errorMessage));
      } else if (e is NetworkException) {
        return const Left(NetworkFailure('No internet connection'));
      } else {
        return const Left(ServerFailure('Unexpected error occurred'));
      }
    }
  }
}
