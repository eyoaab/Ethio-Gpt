import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/cors/utility-functions/token-validation.dart';
import 'package:ethio_gpt/feutures/chat/data/data-source/chat-remote-datasource.dart';
import 'package:ethio_gpt/feutures/chat/data/data-source/history-remote-data-source.dart';
import 'package:ethio_gpt/feutures/chat/data/model/chat-response-model.dart';
import 'package:ethio_gpt/feutures/chat/domain/entity/history-entity.dart';
import 'package:ethio_gpt/feutures/chat/domain/repository/chat-repository.dart';

class ChatResponseRepositoryImpl implements ChatRepository {
  final ChatResponseRemoteDataSource chatResponseRemoteDataSource;
  ChatHistoryRemoteDataSource chatHistoryRemoteDataSource;
  ChatResponseRepositoryImpl(
      {required this.chatResponseRemoteDataSource,
      required this.chatHistoryRemoteDataSource});
  TokenValidation tokenValidation = TokenValidation();

  @override
  Future<Either<Failure, ChatResponseModel>> getChatResponse(
      String prompt, String roomId) async {
    try {
      final token = await tokenValidation.getToken();
      final response = await chatResponseRemoteDataSource.getChatResponse(
          prompt, roomId, token!);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChatHistoryEntity>> getChatHistory() async {
    try {
      final token = await tokenValidation.getToken();
      final response = await chatHistoryRemoteDataSource.getChatHistory(token!);
      final ChatHistoryEntity chatHistoryEntity = response.toEntity();
      return Right(chatHistoryEntity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteChatHistory(String roomId) async {
    try {
      final token = await tokenValidation.getToken();
      final response =
          await chatHistoryRemoteDataSource.deleteChatHistory(roomId, token!);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
