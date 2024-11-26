import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/widgets/json_schema_form.dart';
import 'package:lendingmobile/core/json_schema_data/json_schema_data.dart';
import 'package:lendingmobile/core/model/json_schema.dart';

class FinancialObligationsFormPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const FinancialObligationsFormPage(),
      );
  const FinancialObligationsFormPage({super.key});

  @override
  State<FinancialObligationsFormPage> createState() =>
      _FinancialObligationsFormPageState();
}

class _FinancialObligationsFormPageState
    extends State<FinancialObligationsFormPage> {
  @override
  Widget build(BuildContext context) {
    final schema =
        JsonSchema.fromJson(JsonSchemaData.existingLoansFinancialObligations);
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
