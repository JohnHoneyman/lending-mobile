import 'package:dio/dio.dart';

class FormEngineApi {
  final Dio dio;

  FormEngineApi(this.dio);

  static const String baseUrl = 'https://forms-engine-an7kk7zfja-as.a.run.app';

  Future<Response?> fetchFormList(String accessToken) async {
    const url = '$baseUrl/form';

    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode != 200) {
        print('Error resposne: ${response.data}');
      }

      return response;
    } catch (e) {
      print('Error submitting form: $e');
      return null;
    }
  }

  Future<Response?> fetchFormFromId(String accessToken, String id) async {
    final url = '$baseUrl/form/$id';

    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode != 200) {
        print('Error resposne: ${response.data}');
      }

      return response;
    } catch (e) {
      print('Error submitting form: $e');
      return null;
    }
  }
}
