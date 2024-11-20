import 'package:flutter/material.dart';

class ResidentialAddressPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ResidentialAddressPage(),
      );
  const ResidentialAddressPage({super.key});

  @override
  State<ResidentialAddressPage> createState() => _ResidentialAddressPageState();
}

class _ResidentialAddressPageState extends State<ResidentialAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
