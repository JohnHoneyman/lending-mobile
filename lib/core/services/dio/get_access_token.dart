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
    return 'eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICIzSUJMQ1p1R0VaRjRBajB0MElZNUhzWlNnc0d0YVVxZUd2Yy1ncjBzaElvIn0.eyJleHAiOjE3NjQ4MTE4NzYsImlhdCI6MTczMzI3NTg3NiwianRpIjoiZmZmYTI1YzMtYjI5NS00Y2E2LWE1ZjgtNGVhMTI5NTAyOTU2IiwiaXNzIjoiaHR0cHM6Ly9rZXljbG9hay53aXRoOThsYWJzLmNvbS9yZWFsbXMvZm9ybXMtZW5naW5lIiwiYXVkIjoiZm9ybS1hZG1pbi1zZXJ2aWNlIiwic3ViIjoiNTFjMTQyNjQtZWMxMi00NDRiLWJlOWYtNGY4ODgxYjgyNzllIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoibGVuZGluZy1hcHAtc2VydmljZSIsImFjciI6IjEiLCJhbGxvd2VkLW9yaWdpbnMiOlsiLyoiXSwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbImZvcm1fYWRtaW4iXX0sInJlc291cmNlX2FjY2VzcyI6eyJmb3JtLWFkbWluLXNlcnZpY2UiOnsicm9sZXMiOlsiZm9ybV9hZG1pbiJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSIsInRlbmFudF9pZCI6ImQ3MDBkYmUyLWJjY2ItNDI4Ni05YjJlLTIzNTY5ZDA1YmUzZiIsImNsaWVudEhvc3QiOiIxMzYuMTU4Ljc5LjAiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInByZWZlcnJlZF91c2VybmFtZSI6InNlcnZpY2UtYWNjb3VudC1sZW5kaW5nLWFwcC1zZXJ2aWNlIiwiY2xpZW50QWRkcmVzcyI6IjEzNi4xNTguNzkuMCIsImNsaWVudF9pZCI6ImxlbmRpbmctYXBwLXNlcnZpY2UifQ.bWbsU5WUdT8hjbvFv3a9LwADrFkLTQq2HkeShI9r5Vk5SBPfF6zNBVlNQVV1_yMWCuHykrloBTkV6-JqVmVEWlv8m54UmDCV26Qva1RDW3tXVKXXDYXnmaTHP7GB_XB7s1m6SO19DlEPzzX022NLpR5E3CDBz1lGU8WpSGTkC7vfQlqMg0QygZdHyFFAFmW99FbAwv0_qgrwOIq1e8WYumzW8CxUCPNjPVGlIoJjqolRDynF1vtEyF3WRKneYp0WSNn6m7Rl02269lwkAyGphk4vtEo6gQDu0lMYIZPR7x0_PkV54UlUHC-zxBFt6xyMBiGDnmZBrGYsFXWifAOMVQ';
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
