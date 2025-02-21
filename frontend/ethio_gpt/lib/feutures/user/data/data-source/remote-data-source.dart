import 'dart:convert';
import 'package:ethio_gpt/cors/error/exception.dart';
import 'package:ethio_gpt/cors/network/network_info.dart';
import 'package:ethio_gpt/cors/urls/urls.dart';
import 'package:ethio_gpt/cors/utility-functions/token-validation.dart';
import 'package:ethio_gpt/feutures/user/data/model/user-model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDatasource {
  Future<UserModel> signUpUser(String email, String password);
  Future<UserModel> signInUser(String email, String password);
  Future<UserModel> googleSignUpUser(String email);
  Future<UserModel> gooleSignInUser(String email);
  Future<bool> updateUser(String email, String password, String token);
  Future<bool> updatePassword(
      String oldPassword, String newPassword, String token);
  Future<bool> deleteUser(String token);
  Future<bool> logOut();
}

class UserRemoteDataSourceImpl implements UserRemoteDatasource {
  final http.Client client;
  final NetworkInfo networkInfo;

  UserRemoteDataSourceImpl({required this.client, required this.networkInfo});
  TokenValidation tokenValidation = TokenValidation();

  // google sign up user with email and password
  @override
  Future<UserModel> googleSignUpUser(String email) async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        throw NetworkException('No Internet Connection');
      }
      final response = await client.post(
        Uri.parse('${Url().baseUrl()}user/registerGoogle'),
        body: jsonEncode({'email': email}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        String errorMessage = jsonDecode(response.body)['message'];

        throw ServerException(errorMessage);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // login google user with email and password
  @override
  Future<UserModel> gooleSignInUser(
    String email,
  ) async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        throw NetworkException('No Internet Connection');
      }
      final response = await client.post(
        Uri.parse('${Url().baseUrl()}user/loginGoogle'),
        body: jsonEncode({'email': email}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        String token = jsonDecode(response.body)['token'];
        return UserModel(token: token);
      } else {
        String errorMessage = jsonDecode(response.body)['message'];

        throw ServerException(errorMessage.toString());
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // login user with email and password
  @override
  Future<UserModel> signInUser(String email, String password) async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        throw NetworkException('No Internet Connection');
      }
      final response = await client.post(
        Uri.parse('${Url().baseUrl()}user/login'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        String token = jsonDecode(response.body)['token'];
        return UserModel(token: token);
      } else {
        String errorMessage = jsonDecode(response.body)['message'];

        throw ServerException(errorMessage.toString());
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // sign up user with email and password
  @override
  Future<UserModel> signUpUser(String email, String password) async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        throw NetworkException('No Internet Connection');
      }
      final response = await client.post(
        Uri.parse('${Url().baseUrl()}user/register'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        String errorMessage = jsonDecode(response.body)['message'];

        throw ServerException(errorMessage);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // update user with email and password
  @override
  Future<bool> updateUser(String email, String password, String token) async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        throw NetworkException('No Internet Connection');
      }
      final response = await client.put(
        Uri.parse('${Url().baseUrl()}user/updateEmail'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        String token = jsonDecode(response.body)["token"];
        await tokenValidation.saveToken(token);
        return true;
      } else {
        String errorMessage = jsonDecode(response.body)['message'];
        throw ServerException(errorMessage);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> updatePassword(
      String oldPassword, String newPassword, String token) async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        throw NetworkException('No Internet Connection');
      }
      final response = await client.put(
        Uri.parse('${Url().baseUrl()}user/updatePassword'),
        body: jsonEncode(
            {'oldPassword': oldPassword, 'newPassword': newPassword}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        String token = jsonDecode(response.body)["token"];
        await tokenValidation.saveToken(token);
        return true;
      } else {
        String errorMessage = jsonDecode(response.body)['message'];
        throw ServerException(errorMessage);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // delete user
  @override
  Future<bool> deleteUser(String token) async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        throw NetworkException('No Internet Connection');
      }
      final response = await client.delete(
        Uri.parse('${Url().baseUrl()}user/delete'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        String errorMessage = jsonDecode(response.body)['message'];
        throw ServerException(errorMessage);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // logout user
  @override
  Future<bool> logOut() async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        throw NetworkException('No Internet Connection');
      }
      String response = ''; // You should retrieve this from session management

      if (response.isEmpty) {
        return true;
      } else {
        throw ServerException('Please try again.');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
