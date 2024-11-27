import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/widgets/json_schema_form/json_schema_form.dart';
import 'package:lendingmobile/core/json_schema_data/json_schema_data.dart';
import 'package:lendingmobile/core/model/json_schema.dart';

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
    final schema = JsonSchema.fromJson(JsonSchemaData.personalInformation);
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
