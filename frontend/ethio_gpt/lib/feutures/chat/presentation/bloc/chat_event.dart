class ChatEvent {}

// event to send a request
class ChatRequestEvent extends ChatEvent {
  final String prompt;
  final String roomId;
  final bool isAmharic;

  ChatRequestEvent(
      {required this.prompt, required this.roomId, required this.isAmharic});
}

// event to get the chat history
class ChatHistoryEvent extends ChatEvent {}

// event to delte a chat history

class DeleteChatHistoryEvent extends ChatEvent {
  final String roomId;

  DeleteChatHistoryEvent({required this.roomId});
}
