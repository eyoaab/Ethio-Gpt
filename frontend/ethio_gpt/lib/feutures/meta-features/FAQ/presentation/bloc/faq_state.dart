import 'package:ethio_gpt/feutures/meta-features/FAQ/domain/entiry/faq-entity.dart';

abstract class FaqState {}

final class FaqInitial extends FaqState {}

final class FaqLoadingState extends FaqState {}

final class FaqErrorState extends FaqState {
  final String errorMessage;

  FaqErrorState({required this.errorMessage});
}

final class FaqLoadedState extends FaqState {
  List<FaqEntity> faqs = [];
  FaqLoadedState({required this.faqs});
}
