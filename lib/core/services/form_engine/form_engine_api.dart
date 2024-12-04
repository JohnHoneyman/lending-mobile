import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FormEngineApi {
  final Dio dio;

  FormEngineApi(this.dio);

  static String? baseUrl = dotenv.env['BASE_URL'];

  Future<Response?> fetchFormList(String accessToken) async {
    final String url = '$baseUrl/form';

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

  Future<Response?> submitDataToForm(
    String accessToken,
    Map<String, dynamic> data,
  ) async {
    final String url = '$baseUrl/formdata';

    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await dio.post(
        url,
        data: jsonEncode(data),
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print('Sucess! Response: $response');
        return response;
      } else {
        print('Error response: ${response.statusCode}, ${response.data}');
        return null;
      }
    } catch (e) {
      print('Error submitting form: $e');
      return null;
    }
  }

  Future<Response?> fetchFormDataFromUserId(
      String accessToken, String userId) async {
    final url = '$baseUrl/formdata/user/$userId';

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
        print('Error response: ${response.data}');
      }

      return response;
    } catch (e) {
      print('Error submitting form: $e');
      return null;
    }
  }
}
