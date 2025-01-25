import 'package:bloc/bloc.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/domain/use-cases/get-faqs-usecase.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/presentation/bloc/faq_event.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/presentation/bloc/faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  final FaqUsecases loadFaqsUseCase;

  FaqBloc({required this.loadFaqsUseCase}) : super(FaqInitial()) {
    on<LoadFaqsEvent>((event, emit) async {
      emit(FaqLoadingState());
      final result = await loadFaqsUseCase.excute();
      result.fold(
        (failure) => emit(FaqErrorState(errorMessage: failure.message)),
        (response) => emit(FaqLoadedState(faqs: response)),
      );
    });
  }
}
