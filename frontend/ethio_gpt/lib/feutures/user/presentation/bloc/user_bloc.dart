import 'package:bloc/bloc.dart';
import 'package:ethio_gpt/feutures/user/domain/usecase/delete-usecase.dart';
import 'package:ethio_gpt/feutures/user/domain/usecase/login-usecase.dart';
import 'package:ethio_gpt/feutures/user/domain/usecase/logout-usecase.dart';
import 'package:ethio_gpt/feutures/user/domain/usecase/signup-usecase.dart';
import 'package:ethio_gpt/feutures/user/domain/usecase/update-usecase.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_event.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UpdateUsecase updateUsecase;
  final DeleteUsecase deleteUsecase;
  final LogoutUsecase logoutUsecase;
  final SigninUsecase signinUsecase;
  final LoginUsecase loginUsecase;
  UserBloc({
    required this.updateUsecase,
    required this.deleteUsecase,
    required this.logoutUsecase,
    required this.signinUsecase,
    required this.loginUsecase,
  }) : super(UserInitial()) {
    // login event
    on<UserLoginEvent>((event, emit) async {
      emit(UserLoginLoadingState());
      final result = await loginUsecase.excute(event.email, event.password);
      result.fold(
        (left) => emit(UserLoginErrorState(left.message.toString())),
        (right) => emit(UserLoginSuccessState(right)),
      );
    });
    on<EmitUserLoginState>((event, emit) async {
      emit(UserLoginSuccessState(event.userEntity));
    });

    // signup event
    on<UserSignUpEvent>((event, emit) async {
      emit(UserSignUpLoadingState());
      final result = await signinUsecase.excute(event.email, event.password);
      result.fold(
        (left) => emit(UserSignUpErrorState(left.message)),
        (right) => emit(UserSignUpSuccessState(right)),
      );
    });

    // update event
    on<UserUpdateEvent>((event, emit) async {
      emit(UserUpdateLoadingState());
      final result = await updateUsecase.excute(event.email, event.password);
      result.fold(
        (left) => emit(UserUpdateErrorState(left.message)),
        (right) => emit(UserUpdateSuccessState()),
      );
    });

    // logout event
    on<UserLogoutEvent>((event, emit) async {
      emit(UserLogoutLoadingState());
      final result = await logoutUsecase.excute();
      result.fold(
        (left) => emit(UserLogoutErrorState(left.message)),
        (right) => emit(UserLogoutSuccessState()),
      );
    });

    // delete event
    on<UserDeleteEvent>((event, emit) async {
      emit(UserDeleteLoadingState());
      final result = await deleteUsecase.excute();
      result.fold(
        (left) => emit(UserDeleteErrorState(left.message)),
        (right) => emit(UserDeleteSuccessState()),
      );
    });
  }
}
