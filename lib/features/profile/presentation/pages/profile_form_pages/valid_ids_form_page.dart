import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/widgets/json_schema_form/json_schema_form.dart';
import 'package:lendingmobile/core/json_schema_data/json_schema_data.dart';
import 'package:lendingmobile/core/model/json_schema.dart';

class ValidIdsFormPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ValidIdsFormPage(),
      );
  const ValidIdsFormPage({super.key});

  @override
  State<ValidIdsFormPage> createState() => _ValidIdsFormPageState();
}

class _ValidIdsFormPageState extends State<ValidIdsFormPage> {
  @override
  Widget build(BuildContext context) {
    final schema = JsonSchema.fromJson(JsonSchemaData.validIds);
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
