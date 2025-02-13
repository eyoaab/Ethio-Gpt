import 'dart:convert';
import 'package:ethio_gpt/cors/error/exception.dart';
import 'package:ethio_gpt/cors/network/network_info.dart';
import 'package:ethio_gpt/cors/urls/urls.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/data/model/faq-model.dart';
import 'package:http/http.dart' as http;

abstract class FaqRemoteDataSource {
  Future<List<FaqModel>> getAllFaqs();
}

class FaqRemoteDataSourceImpl implements FaqRemoteDataSource {
  final http.Client client;
  final NetworkInfo networkInfo;

  FaqRemoteDataSourceImpl(this.client, this.networkInfo);

  // get all faqs
  @override
  Future<List<FaqModel>> getAllFaqs() async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        throw NetworkException('No Internet Connection');
      }
      final response = await client.get(
        Uri.parse('${Url().baseUrl()}faq'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<FaqModel> faqs = [];
        final List<dynamic> faqList = jsonDecode(response.body)['faqs'];
        for (var element in faqList) {
          faqs.add(FaqModel.fromJson(element));
        }
        return faqs;
      } else {
        String errorMessage = jsonDecode(response.body)['message'];
        throw ServerException(errorMessage);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
