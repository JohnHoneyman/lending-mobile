import 'package:lendingmobile/core/services/index.dart';

final keycloakConfig = KeycloakConfig(
  bundleIdentifier: 'com.example.lendingmobile',
  clientId: 'keycloak-mobile',
  frontendUrl: 'http://10.0.2.2:8080',
  realm: 'Keycloak-POC',
  // bundleIdentifier: 'com.example.lendingmobile',
  // clientId: 'lending-mobile',
  // frontendUrl: 'https://keycloak.with98labs.com',
  // realm: 'lending-app',
);

final keycloakWrapper = KeycloakWrapper(config: keycloakConfig);
