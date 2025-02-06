import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/chat/data/model/chat-response-model.dart';

abstract class ChatRepository {
  Future<Either<Failure, ChatResponseModel>> getChatResponse(
      String prompt, String roomId);
}
