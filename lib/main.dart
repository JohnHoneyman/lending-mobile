import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lendingmobile/core/services/keycloak/keycloak_wrapper.dart';

final keycloakConfig = KeycloakConfig(
  bundleIdentifier: 'com.example.lendingmobile',
  clientId: 'keycloak-mobile',
  frontendUrl: 'http://10.0.2.2:8080',
  realm: 'Keycloak-POC',
);

final keycloakWrapper = KeycloakWrapper(config: keycloakConfig);

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  keycloakWrapper.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const LoginPage(),
      home: StreamBuilder<bool>(
          stream: keycloakWrapper.authenticationStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            } else if (snapshot.data!) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          }),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Login using the given configuration.
  Future<bool> login() async {
    // Check if user has successfully logged in.
    final isLoggedIn = await keycloakWrapper.login();

    final user = await keycloakWrapper.getUserInfo();

    final name = user?['name'];
    final email = user?['email'];

    return isLoggedIn;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: TextButton(onPressed: login, child: const Text('Login')),
        ),
      );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Logout from the current realm.
  Future<bool> logout() async {
    // Check if user has successfully logged out.
    final isLoggedOut = await keycloakWrapper.logout();

    return isLoggedOut;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder(
                // Retrieve the user information.
                future: keycloakWrapper.getUserInfo(),
                builder: (context, snapshot) {
                  final name = snapshot.data?['name'];

                  return Text('$name ${snapshot.data}');
                },
              ),
              TextButton(onPressed: logout, child: const Text('Logout')),
            ],
          ),
        ),
      );
}
