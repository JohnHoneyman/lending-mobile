import 'package:dio/dio.dart';

class FormEngineApi {
  final Dio dio;

  FormEngineApi(this.dio);

  Future<Response?> submitForm(
      String accessToken, Map<String, dynamic> formData) async {
    const url = 'https://forms-engine-an7kk7zfja-as.a.run.app/form';

    final headers = {
      'Authorization':
          'Bearer $accessToken', // Pass the token in the Authorization header
      'Content-Type': 'application/json', // Content type for JSON payload
    };

    try {
      final response = await dio.post(
        url,
        data: formData, // Pass the form data as the request body
        options: Options(
          headers: headers,
        ),
      );

      return response; // Return the response from the API
    } catch (e) {
      print('Error submitting form: $e');
      return null;
    }
  }
}
