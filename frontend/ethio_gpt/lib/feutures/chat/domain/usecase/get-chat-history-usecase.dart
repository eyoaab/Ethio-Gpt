import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/chat/domain/entity/history-entity.dart';
import 'package:ethio_gpt/feutures/chat/domain/repository/chat-repository.dart';

class GetChatHistoryUsecase {
  final ChatRepository chatRepository;

  GetChatHistoryUsecase({required this.chatRepository});

  Future<Either<Failure, ChatHistoryEntity>> excute() async {
    return await chatRepository.getChatHistory();
  }
}
