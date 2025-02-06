class ChatResponseModel {
  String response;
  String roomId;
  ChatResponseModel({required this.response, required this.roomId});

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatResponseModel(
        response: json['response'], roomId: json['roomId']);
  }
}
