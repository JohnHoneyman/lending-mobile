// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:lendingmobile/core/model/json_schema.dart';

class FormBuilderTextFormFieldWidget extends StatefulWidget {
  final JsonSchema jsonSchema;
  final String? keyName;
  final Function(String value) onChanged;
  final List<String> requiredFields;
  final String? Function(String? value)? validator; // Custom validator function
  final InputDecoration? inputDecoration;

  const FormBuilderTextFormFieldWidget({
    super.key,
    required this.jsonSchema,
    this.keyName,
    required this.onChanged,
    required this.requiredFields,
    this.validator,
    this.inputDecoration,
  });

  @override
  State<FormBuilderTextFormFieldWidget> createState() =>
      _FormBuilderTextFormFieldWidgetState();
}

class _FormBuilderTextFormFieldWidgetState
    extends State<FormBuilderTextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: widget.inputDecoration ??
          InputDecoration(
            labelText: widget.jsonSchema.title ?? widget.keyName ?? '',
          ),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      onChanged: (value) {
        widget.onChanged(value);
      },
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        }

        if (widget.requiredFields.contains(widget.keyName) &&
            (value == null || value.isEmpty)) {
          return 'Please enter your ${widget.jsonSchema.title ?? widget.keyName}.';
        }

        if (widget.jsonSchema.minLength != null &&
            value!.length < widget.jsonSchema.minLength!) {
          return 'Name must be at least ${widget.jsonSchema.minLength} characters long.';
        }
        if (widget.jsonSchema.maxLength != null &&
            value!.length > widget.jsonSchema.maxLength!) {
          return 'Name must not be more than ${widget.jsonSchema.maxLength} characters long.';
        }
        if (value!.isNotEmpty &&
            widget.jsonSchema.pattern != null &&
            !RegExp(widget.jsonSchema.pattern!).hasMatch(value)) {
          return 'Please enter a valid ${widget.jsonSchema.title ?? widget.keyName ?? ''}.';
        }

        return null;
      },
    );
  }
}
