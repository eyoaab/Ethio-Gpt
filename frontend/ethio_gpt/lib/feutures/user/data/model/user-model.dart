import 'package:ethio_gpt/feutures/user/domain/entity/user-entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(token: json['token']);
  }

  UserEntity toEntity() {
    return UserEntity(token: token);
  }
}
