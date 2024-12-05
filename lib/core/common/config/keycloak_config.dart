import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lendingmobile/core/services/index.dart';

final keycloakConfig = KeycloakConfig(
  // bundleIdentifier: 'com.example.lendingmobile',
  // clientId: 'keycloak-mobile',
  // frontendUrl: 'http://10.0.2.2:8080',
  // realm: 'Keycloak-POC',
  // realm: 'lending-app',
  // clientId: 'lending-app-mobile',
  // bundleIdentifier: 'com.example.lendingmobile',
  // frontendUrl: 'https://keycloak.with98labs.com',
  // clientSecret: 'ouu75E4sVybaYSYoO7nUCCiLwrbrdtQM',
  realm: dotenv.env['KEYCLOAK_REALM']!,
  clientId: dotenv.env['KEYCLOAK_CLIENT_ID']!,
  bundleIdentifier: dotenv.env['KEYCLOAK_BUNDLE_IDENTIFIER']!,
  frontendUrl: dotenv.env['KEYCLOAK_FRONTEND_URL']!,
  clientSecret: dotenv.env['KEYCLOAK_CLIENT_SECRET']!,
);

final keycloakWrapper = KeycloakWrapper(config: keycloakConfig);
