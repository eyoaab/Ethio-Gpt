import 'dart:convert';
import 'dart:developer';

import 'package:ethio_gpt/cors/error/exception.dart';
import 'package:ethio_gpt/cors/urls/urls.dart';
import 'package:ethio_gpt/feutures/chat/data/model/history-model.dart';
import 'package:http/http.dart' as http;

abstract class ChatHistoryRemoteDataSource {
  Future<ChatHistoryModel> getChatHistory(String token);
  Future<bool> deleteChatHistory(String roomId, String token);
}

class ChatHistoryRemoteDataSourceimpl implements ChatHistoryRemoteDataSource {
  final http.Client client;

  ChatHistoryRemoteDataSourceimpl({required this.client});

  Future<ChatHistoryModel> getChatHistory(String token) async {
    try {
      final response = await client.get(
        Uri.parse('${Url().baseUrl()}history/recent'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return ChatHistoryModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 403 ||
          response.statusCode == 401 ||
          response.statusCode == 500 ||
          response.statusCode == 404) {
        final String errorMessage = jsonDecode(response.body)['message'];
        throw ServerException(errorMessage);
      } else {
        throw ServerException(response.body);
      }
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<bool> deleteChatHistory(String roomId, String token) async {
    try {
      final response = await client.delete(
        Uri.parse('${Url().baseUrl()}chat'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'roomId': roomId,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 403 ||
          response.statusCode == 401 ||
          response.statusCode == 500 ||
          response.statusCode == 404 ||
          response.statusCode == 400) {
        final String errorMessage = jsonDecode(response.body)['message'];
        throw ServerException(errorMessage);
      } else {
        throw ServerException(response.body.toString());
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
