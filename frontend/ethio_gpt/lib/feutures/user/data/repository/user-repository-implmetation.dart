import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/exception.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/user/data/data-source/remote-data-source.dart';
import 'package:ethio_gpt/feutures/user/data/model/user-model.dart';
import 'package:ethio_gpt/feutures/user/domain/repository/user-repository.dart';
import 'package:ethio_gpt/cors/utility-functions/token-validation.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSourceImpl remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});
  final TokenValidation tokenValidation = TokenValidation();

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
      final response = await remoteDataSource.updateUser(
        email,
        password,
      );
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
      final response = await remoteDataSource.deleteUser();
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
}
