class ChatEvent {}

// event to send a request
class ChatRequestEvent extends ChatEvent {
  final String prompt;
  final String roomId;

  ChatRequestEvent({required this.prompt, required this.roomId});
}

// event to get the chat history
class ChatHistoryEvent extends ChatEvent {}

// event to delte a chat history

class DeleteChatHistoryEvent extends ChatEvent {
  final String roomId;

  DeleteChatHistoryEvent({required this.roomId});
}
