import 'package:bloc/bloc.dart';
import 'package:ethio_gpt/feutures/meta-features/setting/bloc/setting_event.dart';
import 'package:ethio_gpt/feutures/meta-features/setting/bloc/setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(CurrentindexState(0)) {
    on<CangeSetingEvent>((event, emit) {
      emit(CurrentindexState(event.index));
    });
  }
}
