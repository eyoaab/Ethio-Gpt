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

// for update password
final class UserPasswordUpdateLoadingState extends UserState {}

final class UserPasswordUpdateSuccessState extends UserState {}

final class UserPasswordUpdateErrorState extends UserState {
  final String message;
  UserPasswordUpdateErrorState(this.message);
}

//  google user login state
final class GoogleUserLoginLoadingState extends UserState {}

final class GoogleUserLoginSuccessState extends UserState {
  final UserEntity user;
  GoogleUserLoginSuccessState(this.user);
}

final class GoogleUserLoginErrorState extends UserState {
  final String message;
  GoogleUserLoginErrorState(this.message);
}

// google user sign up state
final class GoogleUserSignUpLoadingState extends UserState {}

final class GoogleUserSignUpSuccessState extends UserState {
  final UserEntity user;
  GoogleUserSignUpSuccessState(this.user);
}

final class GoogleUserSignUpErrorState extends UserState {
  final String message;
  GoogleUserSignUpErrorState(this.message);
}
