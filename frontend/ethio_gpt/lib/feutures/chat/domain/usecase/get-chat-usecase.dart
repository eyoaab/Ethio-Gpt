import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/chat/data/model/chat-response-model.dart';
import 'package:ethio_gpt/feutures/chat/domain/repository/chat-repository.dart';

class ChatResponceUseCase {
  final ChatRepository chatRepository;
  ChatResponceUseCase({required this.chatRepository});

  Future<Either<Failure, ChatResponseModel>> excute(
      String prompt, String roomId) async {
    return await chatRepository.getChatResponse(prompt, roomId);
  }
}
