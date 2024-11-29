import 'package:flutter/material.dart';
import 'package:lendingmobile/core/model/json_schema.dart';

class FormBuilderDropdownFormFieldWidget extends StatefulWidget {
  final JsonSchema jsonSchema;
  final String? keyName;
  final Function(String value) onChanged;
  final List<String> requiredFields;
  final String? Function(String? value)? validator; // Custom validator function
  final InputDecoration? inputDecoration;

  const FormBuilderDropdownFormFieldWidget({
    super.key,
    required this.jsonSchema,
    this.keyName,
    required this.onChanged,
    required this.requiredFields,
    this.validator,
    this.inputDecoration,
  });

  @override
  State<FormBuilderDropdownFormFieldWidget> createState() =>
      _FormBuilderDropdownFormFieldWidgetState();
}

class _FormBuilderDropdownFormFieldWidgetState
    extends State<FormBuilderDropdownFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String?>(
      decoration: widget.inputDecoration ??
          InputDecoration(
            labelText: widget.jsonSchema.title ?? widget.keyName ?? '',
          ),
      items: widget.jsonSchema.enumerated?.map((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        widget.onChanged(value!);
      },
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        }

        if (widget.requiredFields.contains(widget.keyName) &&
            (value == null || value.isEmpty)) {
          return 'Please enter your ${widget.jsonSchema.title ?? widget.keyName}.';
        }

        return null;
      },
    );
  }
}
