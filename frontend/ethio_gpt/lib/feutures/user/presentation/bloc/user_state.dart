import 'package:ethio_gpt/feutures/user/domain/entity/user-entity.dart';

abstract class UserState {}

final class UserInitial extends UserState {}

// for log in
final class UserLoginLoadingState extends UserState {}

final class UserLoginSuccessState extends UserState {
  final UserEntity user;
  UserLoginSuccessState(this.user);
}

final class UserLoginErrorState extends UserState {
  final String message;
  UserLoginErrorState(this.message);
}

// for Signup
final class UserSignUpLoadingState extends UserState {}

final class UserSignUpSuccessState extends UserState {
  final UserEntity user;
  UserSignUpSuccessState(this.user);
}

final class UserSignUpErrorState extends UserState {
  final String message;
  UserSignUpErrorState(this.message);
}

// for update user
final class UserUpdateLoadingState extends UserState {}

final class UserUpdateSuccessState extends UserState {}

final class UserUpdateErrorState extends UserState {
  final String message;
  UserUpdateErrorState(this.message);
}

// for user Delete State
final class UserDeleteLoadingState extends UserState {}

final class UserDeleteSuccessState extends UserState {}

final class UserDeleteErrorState extends UserState {
  final String message;
  UserDeleteErrorState(this.message);
}

// for logout user
final class UserLogoutLoadingState extends UserState {}

final class UserLogoutSuccessState extends UserState {}

final class UserLogoutErrorState extends UserState {
  final String message;
  UserLogoutErrorState(this.message);
}
