import 'package:flutter/material.dart';

class PersonalInformationFormPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const PersonalInformationFormPage(),
      );
  const PersonalInformationFormPage({super.key});

  @override
  State<PersonalInformationFormPage> createState() =>
      _PersonalInformationFormPageState();
}

class _PersonalInformationFormPageState
    extends State<PersonalInformationFormPage> {
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
