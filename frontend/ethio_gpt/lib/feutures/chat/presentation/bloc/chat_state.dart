import 'package:ethio_gpt/feutures/chat/data/model/chat-response-model.dart';

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
