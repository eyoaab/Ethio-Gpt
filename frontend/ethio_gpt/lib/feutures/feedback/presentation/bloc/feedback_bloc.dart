import 'package:bloc/bloc.dart';
import 'package:ethio_gpt/feutures/feedback/domain/usecase/feedback-repository.dart';
import 'package:ethio_gpt/feutures/feedback/presentation/bloc/feedback_event.dart';
import 'package:ethio_gpt/feutures/feedback/presentation/bloc/feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final FeedBackUseCase feedBackUseCase;
  FeedbackBloc({required this.feedBackUseCase}) : super(FeedbackInitial()) {
    on<AddFeedbackEvent>((event, emit) async {
      emit(FeedbackLoadingState());
      final result = await feedBackUseCase.excute(event.feedbackEntity);
      result.fold(
        (failure) => emit(FeedbackErrorState(errorMessage: failure.message)),
        (isAdded) => emit(FeedbackAddedState()),
      );
    });
  }
}
