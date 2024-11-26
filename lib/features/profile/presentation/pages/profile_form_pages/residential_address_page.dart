import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/widgets/json_schema_form.dart';
import 'package:lendingmobile/core/json_schema_data/json_schema_data.dart';

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
    final schema = jsonSchema[1]; // TODO: API CALL
    return Scaffold(
      appBar: AppBar(),
      body: JsonSchemaForm(
        jsonSchema: schema,
      ),
    );
  }
}
