import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/widgets/json_schema_form.dart';
import 'package:lendingmobile/core/json_schema_data/json_schema_data.dart';
import 'package:lendingmobile/core/model/json_schema.dart';

class ProofOfIncomeFormsPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ProofOfIncomeFormsPage(),
      );
  const ProofOfIncomeFormsPage({super.key});

  @override
  State<ProofOfIncomeFormsPage> createState() => _ProofOfIncomeFormsPageState();
}

class _ProofOfIncomeFormsPageState extends State<ProofOfIncomeFormsPage> {
  @override
  Widget build(BuildContext context) {
    final schema = JsonSchema.fromJson(JsonSchemaData.proofOfIncome);
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
