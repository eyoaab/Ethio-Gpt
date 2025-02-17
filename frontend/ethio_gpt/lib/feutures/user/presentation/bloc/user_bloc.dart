import 'package:bloc/bloc.dart';
import 'package:ethio_gpt/feutures/user/domain/usecase/delete-usecase.dart';
import 'package:ethio_gpt/feutures/user/domain/usecase/google-login-usecase.dart';
import 'package:ethio_gpt/feutures/user/domain/usecase/google-signup.dart';
import 'package:ethio_gpt/feutures/user/domain/usecase/login-usecase.dart';
import 'package:ethio_gpt/feutures/user/domain/usecase/logout-usecase.dart';
import 'package:ethio_gpt/feutures/user/domain/usecase/signup-usecase.dart';
import 'package:ethio_gpt/feutures/user/domain/usecase/update-password.dart';
import 'package:ethio_gpt/feutures/user/domain/usecase/update-usecase.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_event.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UpdateUsecase updateUsecase;
  final UpdatePasswordUseCase updatePasswordUseCase;
  final DeleteUsecase deleteUsecase;
  final LogoutUsecase logoutUsecase;
  final SigninUsecase signinUsecase;
  final LoginUsecase loginUsecase;
  final GoogleLoginUsecase googleLoginUsecase;
  final GoogleSigninUsecase googleSigninUsecase;

  UserBloc(
      {required this.updateUsecase,
      required this.deleteUsecase,
      required this.logoutUsecase,
      required this.signinUsecase,
      required this.loginUsecase,
      required this.googleLoginUsecase,
      required this.googleSigninUsecase,
      required this.updatePasswordUseCase})
      : super(UserInitial()) {
    // google user login event
    on<GoogleUserLogInEvent>((event, emit) async {
      emit(GoogleUserLoginLoadingState());
      final result = await googleLoginUsecase.excute(event.email);
      result.fold(
        (left) => emit(GoogleUserLoginErrorState(left.message.toString())),
        (right) => emit(GoogleUserLoginSuccessState(right)),
      );
    });
    // google user signup event
    on<GoogleUserSignUpEvent>((event, emit) async {
      emit(GoogleUserSignUpLoadingState());
      final result = await googleSigninUsecase.excute(event.email);
      result.fold(
        (left) => emit(GoogleUserSignUpErrorState(left.message)),
        (right) => emit(GoogleUserSignUpSuccessState(right)),
      );
    });

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

    //  update password
    on<UsesrPasswordUpdateEvent>((event, emit) async {
      emit(UserPasswordUpdateLoadingState());
      final result = await updatePasswordUseCase.excute(
          event.oldPassword, event.newPassword);
      result.fold(
        (left) => emit(UserPasswordUpdateErrorState(left.message)),
        (right) => emit(UserPasswordUpdateSuccessState()),
      );
    });
  }
}
