import 'package:dartz/dartz.dart';
import 'package:ethio_gpt/cors/error/faliure.dart';
import 'package:ethio_gpt/feutures/chat/domain/repository/chat-repository.dart';

class DeleteChatUsecase {
  final ChatRepository chatRepository;
  DeleteChatUsecase({required this.chatRepository});

  Future<Either<Failure, bool>> excute(String roomId) async {
    return await chatRepository.deleteChatHistory(roomId);
  }
}
