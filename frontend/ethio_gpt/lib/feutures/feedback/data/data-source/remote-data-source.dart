import 'dart:convert';

import 'package:ethio_gpt/cors/error/exception.dart';
import 'package:ethio_gpt/cors/urls/urls.dart';
import 'package:ethio_gpt/feutures/feedback/domain/entity/feedback-entity.dart';
import 'package:http/http.dart' as http;

abstract class FeedbackRemoteDataSource {
  Future<bool> addFeedback(FeedbackEntity feedback);
}

class FeedbackRemoteDataSourceImpl implements FeedbackRemoteDataSource {
  final http.Client client;

  FeedbackRemoteDataSourceImpl(this.client);
  @override
  Future<bool> addFeedback(FeedbackEntity feedback) async {
    try {
      const String token = '';
      final response = await client.post(
        Uri.parse('${Url().baseUrl()}/feedbacks'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'content': feedback.content,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 404) {
        final String errorMessage = jsonDecode(response.body)['message'];

        throw ServerException(errorMessage);
      } else {
        throw ServerException('Failed to add feedback');
      }
    } catch (e) {
      throw ServerException('Failed to add feedback ${e.toString()}');
    }
  }
}
