import 'package:ethio_gpt/feutures/chat/data/model/chat-response-model.dart';
import 'package:ethio_gpt/feutures/chat/domain/entity/history-entity.dart';

class ChatState {}

final class ChatInitial extends ChatState {}

// to  the conversation part
class ChatResponseLoadingState extends ChatState {}

class ChatResponseLoadedState extends ChatState {
  ChatResponseModel chatResponseModel;
  ChatResponseLoadedState({required this.chatResponseModel});
}

class ChatResponseErrorState extends ChatState {
  String errorMessage;
  ChatResponseErrorState({required this.errorMessage});
}

//  to the chat history part
class ChatHistoryLoadingState extends ChatState {}

class ChatHistoryLoadedState extends ChatState {
  ChatHistoryEntity chatHistory;
  ChatHistoryLoadedState({required this.chatHistory});
}

class ChatHistoryErrorState extends ChatState {
  String errorMessage;
  ChatHistoryErrorState({required this.errorMessage});
}

//  to the delete chat history part
class DeleteChatHistoryLoadingState extends ChatState {}

class DeleteChatHistoryLoadedState extends ChatState {}

class DeleteChatHistoryErrorState extends ChatState {
  String errorMessage;
  DeleteChatHistoryErrorState({required this.errorMessage});
}
