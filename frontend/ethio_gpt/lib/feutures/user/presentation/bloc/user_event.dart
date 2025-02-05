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

// for delete user
class UserDeleteEvent extends UserEvent {}

// event to emit user login state
class EmitUserLoginState extends UserEvent {
  final UserEntity userEntity;

  EmitUserLoginState({required this.userEntity});
}
