import 'package:bloc/bloc.dart';
import 'package:ethio_gpt/feutures/chat/domain/usecase/get-chat-history-usecase.dart';
import 'package:ethio_gpt/feutures/chat/domain/usecase/get-chat-usecase.dart';
import 'package:ethio_gpt/feutures/chat/presentation/bloc/chat_event.dart';
import 'package:ethio_gpt/feutures/chat/presentation/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatResponceUseCase chatResponceUseCase;
  GetChatHistoryUsecase getChatHistoryUsecase;
  ChatBloc(
      {required this.chatResponceUseCase, required this.getChatHistoryUsecase})
      : super(ChatInitial()) {
    // to send a requiest to the server
    on<ChatRequestEvent>((event, emit) async {
      emit(ChatResponseLoadingState());
      final result =
          await chatResponceUseCase.excute(event.prompt, event.roomId);
      result.fold(
          (faliure) => emit(
              ChatResponseErrorState(errorMessage: faliure.message.toString())),
          (chatResponseModel) => emit(
              ChatResponseLoadedState(chatResponseModel: chatResponseModel)));
    });

    on<ChatHistoryEvent>((event, emit) async {
      emit(ChatHistoryLoadingState());
      final result = await getChatHistoryUsecase.excute();
      result.fold(
          (faliure) => emit(
              ChatHistoryErrorState(errorMessage: faliure.message.toString())),
          (chatHistory) =>
              emit(ChatHistoryLoadedState(chatHistory: chatHistory)));
    });
  }
}
