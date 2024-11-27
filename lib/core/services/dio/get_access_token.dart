import 'package:dio/dio.dart';

Future<String?> getAccessToken() async {
  final dio = Dio();
  const url =
      'https://keycloak.with98labs.com//realms/lending-app/protocol/openid-connect/token';

  final data = {
    'grant_type': 'password',
    'client_id': 'lending-app-formengine',
    'username': 'lendingformadmin',
    'password': 'password',
  };

  try {
    final Response<dynamic> response = await dio.post(
      url,
      data: data,
      options: Options(
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      ),
    );

    if (response.statusCode == 200) {
      final accessToken = response.data['access_token'];
      return accessToken;
    } else {
      print(
          'Failed to retrieve access token. Status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error getting access token: $e');
    return null;
  }
}
