import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/widgets/json_schema_form/json_schema_form.dart';
import 'package:lendingmobile/core/json_schema_data/json_schema_data.dart';
import 'package:lendingmobile/core/model/json_schema.dart';

class ActiveCreditCardFormPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ActiveCreditCardFormPage(),
      );

  const ActiveCreditCardFormPage({super.key});

  @override
  State<ActiveCreditCardFormPage> createState() =>
      _ActiveCreditCardFormPageState();
}

class _ActiveCreditCardFormPageState extends State<ActiveCreditCardFormPage> {
  @override
  Widget build(BuildContext context) {
    final schema = JsonSchema.fromJson(JsonSchemaData.activeCreditCard);
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
