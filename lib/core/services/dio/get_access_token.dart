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
    return 'eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICIzSUJMQ1p1R0VaRjRBajB0MElZNUhzWlNnc0d0YVVxZUd2Yy1ncjBzaElvIn0.eyJleHAiOjE3MzMxNDE4MDksImlhdCI6MTczMzEwNTgwOSwianRpIjoiZTgxYTQwYTEtNDBkMy00MzRjLWIyNjYtZTBjYzgxNTcyZGM0IiwiaXNzIjoiaHR0cHM6Ly9rZXljbG9hay53aXRoOThsYWJzLmNvbS9yZWFsbXMvZm9ybXMtZW5naW5lIiwiYXVkIjoiZm9ybS1hZG1pbi1zZXJ2aWNlIiwic3ViIjoiNTFjMTQyNjQtZWMxMi00NDRiLWJlOWYtNGY4ODgxYjgyNzllIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoibGVuZGluZy1hcHAtc2VydmljZSIsImFjciI6IjEiLCJhbGxvd2VkLW9yaWdpbnMiOlsiLyoiXSwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbImZvcm1fYWRtaW4iXX0sInJlc291cmNlX2FjY2VzcyI6eyJmb3JtLWFkbWluLXNlcnZpY2UiOnsicm9sZXMiOlsiZm9ybV9hZG1pbiJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSIsInRlbmFudF9pZCI6ImQ3MDBkYmUyLWJjY2ItNDI4Ni05YjJlLTIzNTY5ZDA1YmUzZiIsImNsaWVudEhvc3QiOiIxMzYuMTU4LjMxLjUwIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJzZXJ2aWNlLWFjY291bnQtbGVuZGluZy1hcHAtc2VydmljZSIsImNsaWVudEFkZHJlc3MiOiIxMzYuMTU4LjMxLjUwIiwiY2xpZW50X2lkIjoibGVuZGluZy1hcHAtc2VydmljZSJ9.ZuHYrlPl7jOHevVeWVe0g41Y9mbj2pzxboxpK_1qk0_jqT-8YWtM82rvRFqQSZBjly1zgbb2XvzTyNdP36ey3YPsp6fayUvOHdNl4khQdjVxOiIeVFfQ0PO46oMBgbm7l-wOKNRkUJnlJeFQZqDgnMHJ_UPmZml-lGbexFZ_MuNyaI2YanLxzzg-c3tVYsUnn-zIAvTavMGR8lno6P1Qva7doAsenFmbC7ERVt_CWsix7w20axfRrv9fJ2QhCXZVyqSHtwQ-sPZb6TjjtnmqPHqnVWaEV2GNQ8JWcjyoCkKJ-Ge6rGIl4sfkq4iMsZL0T-fZPj-Nb5U-A9RbFfnTdA';
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
