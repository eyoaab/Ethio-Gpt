import 'package:ethio_gpt/feutures/user/domain/entity/user-entity.dart';

class UserEvent {}

// for login
class UserLoginEvent extends UserEvent {
  final String email;
  final String password;

  UserLoginEvent({required this.email, required this.password});
}

// for signup
class UserSignUpEvent extends UserEvent {
  final String email;
  final String password;

  UserSignUpEvent({
    required this.email,
    required this.password,
  });
}

// for logout
class UserLogoutEvent extends UserEvent {}

// for update user
class UserUpdateEvent extends UserEvent {
  final String email;
  final String password;

  UserUpdateEvent({
    required this.email,
    required this.password,
  });
}

// for user password update
class UsesrPasswordUpdateEvent extends UserEvent {
  String oldPassword;
  String newPassword;

  UsesrPasswordUpdateEvent(
      {required this.newPassword, required this.oldPassword});
}

// for delete user
class UserDeleteEvent extends UserEvent {}

// event to emit user login state
class EmitUserLoginState extends UserEvent {
  final UserEntity userEntity;

  EmitUserLoginState({required this.userEntity});
}

// to sign in with google

class GoogleUserSignUpEvent extends UserEvent {
  String email;
  GoogleUserSignUpEvent({required this.email});
}

class GoogleUserLogInEvent extends UserEvent {
  String email;
  GoogleUserLogInEvent({required this.email});
}
