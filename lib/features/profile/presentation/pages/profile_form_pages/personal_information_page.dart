import 'package:flutter/material.dart';

class PersonalInformationPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const PersonalInformationPage(),
      );
  const PersonalInformationPage({super.key});

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Container(
          child: Text(index.toString()),
        );
      }),
    );
  }
}
