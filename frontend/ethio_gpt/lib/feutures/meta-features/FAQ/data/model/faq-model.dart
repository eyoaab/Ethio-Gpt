import 'package:ethio_gpt/feutures/meta-features/FAQ/domain/entiry/faq-entity.dart';

class FaqModel extends FaqEntity {
  FaqModel({required super.question, required super.answer});

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      question: json['question'],
      answer: json['answer'],
    );
  }

  FaqEntity toEntity() {
    return FaqEntity(question: question, answer: answer);
  }
}
