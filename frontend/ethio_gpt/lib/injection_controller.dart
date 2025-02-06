import 'package:ethio_gpt/cors/network/network_info.dart';
import 'package:ethio_gpt/feutures/chat/data/data-source/chat-remote-datasource.dart';
import 'package:ethio_gpt/feutures/chat/data/data-source/history-remote-data-source.dart';
import 'package:ethio_gpt/feutures/chat/data/repository/chat-repository-implmentation.dart';
import 'package:ethio_gpt/feutures/chat/domain/repository/chat-repository.dart';
import 'package:ethio_gpt/feutures/chat/domain/usecase/get-chat-history-usecase.dart';
import 'package:ethio_gpt/feutures/chat/domain/usecase/get-chat-usecase.dart';
import 'package:ethio_gpt/feutures/chat/presentation/bloc/chat_bloc.dart';
import 'package:ethio_gpt/feutures/feedback/data/repository/feedback-repository-impl.dart';
import 'package:ethio_gpt/feutures/feedback/domain/usecase/feedback-repository.dart';
import 'package:ethio_gpt/feutures/feedback/presentation/bloc/feedback_bloc.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/data/repository/faq-repository-implentaion.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/domain/use-cases/get-faqs-usecase.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/presentation/bloc/faq_bloc.dart';
import 'package:ethio_gpt/feutures/user/data/repository/user-repository-implmetation.dart';
import 'package:ethio_gpt/feutures/user/domain/usecase/delete-usecase.dart';
import 'package:ethio_gpt/feutures/user/domain/usecase/login-usecase.dart';
import 'package:ethio_gpt/feutures/user/domain/usecase/logout-usecase.dart';
import 'package:ethio_gpt/feutures/user/domain/usecase/signup-usecase.dart';
import 'package:ethio_gpt/feutures/user/domain/usecase/update-usecase.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ethio_gpt/feutures/feedback/data/data-source/remote-data-source.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/data/data-source/faq-remote-datasource.dart';
import 'package:ethio_gpt/feutures/user/data/data-source/remote-data-source.dart';
import 'package:ethio_gpt/feutures/feedback/domain/repository/feedback-repository.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/domain/repository/faq-repository.dart';
import 'package:ethio_gpt/feutures/user/domain/repository/user-repository.dart';

final locator = GetIt.instance;

Future<void> setUp() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(prefs);
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: locator()),
  );

  /*******/
  locator.registerLazySingleton(() => http.Client());
  // locator.registerLazySingleton(() => InternetConnectionChecker());

  //! Data Sources
  locator.registerLazySingleton<UserRemoteDataSourceImpl>(
      () => UserRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<FaqRemoteDataSource>(
      () => FaqRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<FeedbackRemoteDataSource>(
      () => FeedbackRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<ChatResponseRemoteDataSource>(
      () => ChatResponseRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<ChatHistoryRemoteDataSource>(
      () => ChatHistoryRemoteDataSourceimpl(client: locator()));

  //! Repositories

  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<FeedbackRepository>(
      () => FeedbackRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<FaqRepository>(
      () => FaqRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<ChatRepository>(() =>
      ChatResponseRepositoryImpl(
          chatResponseRemoteDataSource: locator(),
          chatHistoryRemoteDataSource: locator()));

  //! Use Cases
  locator.registerLazySingleton(() => LoginUsecase(userRepository: locator()));
  locator.registerLazySingleton(() => DeleteUsecase(locator()));
  locator.registerLazySingleton(() => LogoutUsecase(locator()));
  locator.registerLazySingleton(() => SigninUsecase(userRepository: locator()));
  locator.registerLazySingleton(() => UpdateUsecase(userRepository: locator()));
  locator.registerLazySingleton(
      () => FeedBackUseCase(feedBackRepository: locator()));
  locator.registerLazySingleton(() => FaqUsecases(locator()));
  locator.registerLazySingleton(
      () => ChatResponceUseCase(chatRepository: locator()));
  locator.registerLazySingleton(
      () => GetChatHistoryUsecase(chatRepository: locator()));

  //! BLoC

  locator.registerFactory(() => UserBloc(
      updateUsecase: locator(),
      deleteUsecase: locator(),
      logoutUsecase: locator(),
      signinUsecase: locator(),
      loginUsecase: locator()));

  locator.registerFactory(() => FaqBloc(loadFaqsUseCase: locator()));
  locator.registerFactory(() => FeedbackBloc(feedBackUseCase: locator()));

  locator.registerFactory(() => ChatBloc(
      chatResponceUseCase: locator(), getChatHistoryUsecase: locator()));
}
