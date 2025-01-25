import 'dart:convert';
import 'package:ethio_gpt/cors/error/exception.dart';
import 'package:ethio_gpt/cors/urls/urls.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/data/model/faq-model.dart';
import 'package:http/http.dart' as http;

abstract class FaqRemoteDataSource {
  Future<List<FaqModel>> getAllFaqs();
}

class FaqRemoteDataSourceImpl implements FaqRemoteDataSource {
  final http.Client client;

  FaqRemoteDataSourceImpl(this.client);

  // get all faqs
  @override
  Future<List<FaqModel>> getAllFaqs() async {
    try {
      final response = await client.get(
        Uri.parse('${Url().baseUrl()}/faqs'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<FaqModel> faqs = [];
        final List<dynamic> faqList = jsonDecode(response.body);
        for (var element in faqList) {
          faqs.add(FaqModel.fromJson(element));
        }
        return faqs;
      } else {
        String errorMessage = jsonDecode(response.body)['message'];
        throw ServerException(errorMessage);
      }
    } catch (e) {
      throw ServerException('Failed to load  faqs.${e.toString()}');
    }
  }
}
