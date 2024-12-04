import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lendingmobile/core/common/config/keycloak_config.dart';

Future<String?> getAccessToken() async {
  final dio = Dio();
  final url =
      '${dotenv.env['BASE_URL']!}//realms/lending-app/protocol/openid-connect/token';

  final data = {
    'grant_type': 'password',
    'client_id': 'lending-app-formengine',
    'username': 'lendingformadmin',
    'password': 'password',
  };

  try {
    return keycloakWrapper.accessToken;

    /** Call access token api */
    // final Response<dynamic> response = await dio.post(
    //   url,
    //   data: data,
    //   options: Options(
    //     headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    //   ),
    // );

    // if (response.statusCode == 200) {
    //   final accessToken = response.data['access_token'];
    //   return accessToken;
    // } else {
    //   print(
    //       'Failed to retrieve access token. Status code: ${response.statusCode}');
    //   return null;
    // }
  } catch (e) {
    print('Error getting access token: $e');
    return null;
  }
}
