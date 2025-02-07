import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/chat/data/model/chat-response-model.dart';
import 'package:ethio_gpt/feutures/chat/domain/entity/history-entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, ChatResponseModel>> getChatResponse(
      String prompt, String roomId);
  Future<Either<Failure, ChatHistoryEntity>> getChatHistory();
  Future<Either<Failure, bool>> deleteChatHistory(String roomId);
}
