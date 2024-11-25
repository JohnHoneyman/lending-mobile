import 'package:flutter/material.dart';
import 'package:lendingmobile/core/model/json_schema.dart';

class JsonSchemaForm extends StatefulWidget {
  final JsonSchema jsonSchema;
  const JsonSchemaForm({
    super.key,
    required this.jsonSchema,
  });

  @override
  State<JsonSchemaForm> createState() => _JsonSchemaFormState();
}

class _JsonSchemaFormState extends State<JsonSchemaForm> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
