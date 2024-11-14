import 'package:lendingmobile/core/services/index.dart';

final keycloakConfig = KeycloakConfig(
  // bundleIdentifier: 'com.example.lendingmobile',
  // clientId: 'keycloak-mobile',
  // frontendUrl: 'http://10.0.2.2:8080',
  // realm: 'Keycloak-POC',
  realm: 'lending-app',
  clientId: 'lending-app-mobile',
  bundleIdentifier: 'com.example.lendingmobile',
  frontendUrl: 'https://keycloak.with98labs.com',
  clientSecret: 'ouu75E4sVybaYSYoO7nUCCiLwrbrdtQM',
);

final keycloakWrapper = KeycloakWrapper(config: keycloakConfig);
