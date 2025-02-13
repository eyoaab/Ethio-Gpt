import 'dart:convert';
import 'dart:developer';

import 'package:ethio_gpt/cors/error/exception.dart';
import 'package:ethio_gpt/cors/network/network_info.dart';
import 'package:ethio_gpt/cors/urls/urls.dart';
import 'package:ethio_gpt/cors/utility-functions/token-validation.dart';
import 'package:ethio_gpt/feutures/feedback/domain/entity/feedback-entity.dart';
import 'package:http/http.dart' as http;

abstract class FeedbackRemoteDataSource {
  Future<bool> addFeedback(FeedbackEntity feedback);
}

TokenValidation tokenValidation = TokenValidation();

class FeedbackRemoteDataSourceImpl implements FeedbackRemoteDataSource {
  final http.Client client;
  final NetworkInfo networkInfo;

  FeedbackRemoteDataSourceImpl(this.client, this.networkInfo);
  @override
  Future<bool> addFeedback(FeedbackEntity feedback) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      throw NetworkException('No Internet Connection');
    }
    try {
      String token = '';
      token = (await tokenValidation.getToken())!;
      if (token == '') {
        throw ServerException('Token is empty');
      }
      final response = await client.post(
        Uri.parse('${Url().baseUrl()}feedback'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'content': feedback.content.toString()}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 400 ||
          response.statusCode == 500 ||
          response.statusCode == 401 ||
          response.statusCode == 403) {
        final String errorMessage = jsonDecode(response.body)['message'];

        throw ServerException(errorMessage);
      } else {
        throw ServerException('Failed to add feedback please try again');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
