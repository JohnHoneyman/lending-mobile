import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lendingmobile/core/common/index.dart';
import 'package:lendingmobile/core/constants/constants.dart';
import 'package:lendingmobile/features/auth/index.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  keycloakWrapper.initialize();
  runApp(const LendingApp());
}

class LendingApp extends StatelessWidget {
  static MaterialPageRoute route({bool isFromCalcPage = false}) =>
      MaterialPageRoute(
        builder: (context) => LendingApp(
          isFromCalcPage: isFromCalcPage,
        ),
      );

  final bool isFromCalcPage;
  const LendingApp({
    super.key,
    this.isFromCalcPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder<bool>(
        stream: keycloakWrapper.authenticationStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.data!) {
            return const HomeScreen();
          } else {
            return LoginScreen(
              isFromCalcPage: isFromCalcPage,
            );
          }
        },
      ),
    );
  }
}
