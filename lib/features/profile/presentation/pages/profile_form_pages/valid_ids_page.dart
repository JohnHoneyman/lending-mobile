import 'package:flutter/material.dart';

class ValidIdsPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ValidIdsPage(),
      );
  const ValidIdsPage({super.key});

  @override
  State<ValidIdsPage> createState() => _ValidIdsPageState();
}

class _ValidIdsPageState extends State<ValidIdsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
