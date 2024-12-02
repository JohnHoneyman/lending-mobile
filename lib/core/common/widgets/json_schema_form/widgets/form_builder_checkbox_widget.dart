import 'package:flutter/material.dart';
import 'package:lendingmobile/core/model/json_schema.dart';

class FormBuilderCheckboxWidget extends StatefulWidget {
  final JsonSchema jsonSchema;
  final String? keyName;
  final Function(bool value) onChanged;
  final List<String> requiredFields;
  final String? Function(String? value)? validator; // Custom validator function
  final bool currentValue;
  final InputDecoration? inputDecoration;

  const FormBuilderCheckboxWidget({
    super.key,
    required this.jsonSchema,
    this.keyName,
    required this.onChanged,
    required this.requiredFields,
    this.validator,
    this.currentValue = false,
    this.inputDecoration,
  });

  @override
  State<FormBuilderCheckboxWidget> createState() =>
      _FormBuilderCheckboxWidgetState();
}

class _FormBuilderCheckboxWidgetState extends State<FormBuilderCheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    bool formValue = widget.currentValue;

    return Row(
      children: [
        Text(widget.jsonSchema.title ?? widget.keyName ?? ''),
        Checkbox(
          value: formValue,
          activeColor: Colors.deepPurple,
          onChanged: (value) {
            widget.onChanged(value ?? false);
          },
        )
      ],
    );
  }
}