import 'package:flutter/material.dart';
import 'package:lendingmobile/core/services/keycloak/keycloak_wrapper.dart';

class LoginPage extends StatefulWidget {
  KeycloakWrapper keycloakWrapper;

  LoginPage({super.key, required this.keycloakWrapper});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Center(
        child: Placeholder(),
      ),
    );
  }
}
