import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/config/keycloak_config.dart';
import 'package:lendingmobile/core/common/index.dart';

class PersonalInfoPage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const PersonalInfoPage(),
      );
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Information'),
      ),
      body: FutureBuilder(
        future: keycloakWrapper.getUserInfo(),
        builder: (context, snapshot) {
          print(snapshot.data);
          final name = snapshot.data?['name'] ?? '';
          final givenName = snapshot.data?['given_name'] ?? '';
          final familyName = snapshot.data?['family_name'] ?? '';
          final username = snapshot.data?['preferred_username'] ?? '';
          final email = snapshot.data?['email'] ?? '';
          final accessToken = keycloakWrapper.accessToken ?? '';
          final refreshToken = keycloakWrapper.refreshToken ?? '';
          final idToken = keycloakWrapper.idToken ?? '';
          // final authenticationStream =
          //     keycloakWrapper.authenticationStream;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xff65558F),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    const Gap(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [const Text('Name'), Text(name)],
                    ),
                    const Gap(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [const Text('Username'), Text(username)],
                    ),
                    const Gap(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [const Text('Email'), Text(email)],
                    ),
                    const Gap(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'accessToken',
                        ),
                        Text(
                            '${accessToken.substring(0, 15)}}.....${accessToken.substring(accessToken.length - 10, accessToken.length)}')
                      ],
                    ),
                    const Gap(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('refreshToken'),
                        Text(
                          '${refreshToken.substring(0, 15)}.....${refreshToken.substring(refreshToken.length - 10, refreshToken.length)}',
                        ),
                      ],
                    ),
                    const Gap(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('idToken'),
                        Text(
                          '${idToken.substring(0, 15)}.....${idToken.substring(idToken.length - 10, idToken.length)} ',
                        ),
                      ],
                    ),
                    const Gap(),
                  ]),
            ),
          );
        },
      ),
    );
  }
}
