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
