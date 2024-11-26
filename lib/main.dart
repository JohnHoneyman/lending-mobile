import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/index.dart';
import 'package:lendingmobile/core/constants/constants.dart';
import 'package:lendingmobile/features/auth/index.dart';
import 'package:lendingmobile/features/profile/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  keycloakWrapper.initialize();
  runApp(const LendingApp());
}

class LendingApp extends StatelessWidget {
  const LendingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: StreamBuilder<bool>(
      //   stream: keycloakWrapper.authenticationStream,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const LoadingScreen();
      //     } else if (snapshot.data!) {
      //       return const HomeScreen();
      //     } else {
      //       return const LoginScreen();
      //     }
      //   },
      // ),

      home: ResidentialAddressPage(),
    );
  }
}
