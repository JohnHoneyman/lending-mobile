import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/widgets/json_schema_form/json_schema_form.dart';
import 'package:lendingmobile/core/json_schema_data/json_schema_data.dart';
import 'package:lendingmobile/core/model/json_schema.dart';

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
    final schema = JsonSchema.fromJson(JsonSchemaData.residentialAddress);
    return Scaffold(
      appBar: AppBar(
        title: Text(schema.title ?? ''),
      ),
      body: JsonSchemaForm(
        jsonSchema: schema,
      ),
    );
  }
}
