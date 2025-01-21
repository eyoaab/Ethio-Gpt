import 'package:ethio_gpt/feutures/user/domain/entity/user-entity.dart';

class UserModel extends UserEntity {
  String email;
  String password;

  UserModel({
    required this.email,
    required this.password,
  }) : super(email: email, password: password);

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      email: email,
      password: password,
    );
  }
}
