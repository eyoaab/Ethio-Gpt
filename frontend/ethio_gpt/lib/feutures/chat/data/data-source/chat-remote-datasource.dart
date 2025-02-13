import 'dart:convert';

import 'package:ethio_gpt/cors/error/exception.dart';
import 'package:ethio_gpt/cors/network/network_info.dart';
import 'package:ethio_gpt/cors/urls/urls.dart';
import 'package:ethio_gpt/feutures/chat/data/model/chat-response-model.dart';
import 'package:http/http.dart' as http;

abstract class ChatResponseRemoteDataSource {
  Future<ChatResponseModel> getChatResponse(
      String prompt, String roomId, String token, bool isAmharic);
}

class ChatResponseRemoteDataSourceImpl implements ChatResponseRemoteDataSource {
  final http.Client client;
  final NetworkInfo networkInfo;

  ChatResponseRemoteDataSourceImpl(this.client, this.networkInfo);
  @override
  Future<ChatResponseModel> getChatResponse(
      String prompt, String roomId, String token, bool isAmharic) async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        throw NetworkException('No Internet Connection');
      }
      final response = await client.post(
        //
        !isAmharic
            ? Uri.parse('${Url().baseUrl()}chat/english')
            : Uri.parse('${Url().baseUrl()}chat/amharic'),

        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'prompt': prompt,
          'roomId': roomId,
        }),
      );
      if (response.statusCode == 200) {
        return ChatResponseModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 500 ||
          response.statusCode == 401 ||
          response.statusCode == 403 ||
          response.statusCode == 400) {
        String errorMessage = jsonDecode(response.body)['message'];
        throw ServerException(errorMessage);
      } else {
        throw ServerException('Unknown Error Occured Please Try Again');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
