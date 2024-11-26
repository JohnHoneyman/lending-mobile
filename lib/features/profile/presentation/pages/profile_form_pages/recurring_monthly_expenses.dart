import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/widgets/json_schema_form.dart';
import 'package:lendingmobile/core/json_schema_data/json_schema_data.dart';
import 'package:lendingmobile/core/model/json_schema.dart';

class RecurringMonthlyExpenses extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const RecurringMonthlyExpenses(),
      );
  const RecurringMonthlyExpenses({super.key});

  @override
  State<RecurringMonthlyExpenses> createState() =>
      _RecurringMonthlyExpensesState();
}

class _RecurringMonthlyExpensesState extends State<RecurringMonthlyExpenses> {
  @override
  Widget build(BuildContext context) {
    final schema = JsonSchema.fromJson(JsonSchemaData.recurringMonthlyExpenses);
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
