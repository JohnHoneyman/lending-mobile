import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lendingmobile/core/model/json_schema.dart';

class FormBuilderNumberFieldWidget extends StatefulWidget {
  final JsonSchema jsonSchema;
  final String? keyName;
  final Function(String value) onChanged;
  final List<String> requiredFields;
  final String? Function(String? value)? validator; // Custom validator function
  final InputDecoration? inputDecoration;

  const FormBuilderNumberFieldWidget({
    super.key,
    required this.jsonSchema,
    this.keyName,
    required this.onChanged,
    required this.requiredFields,
    this.validator,
    this.inputDecoration,
  });

  @override
  State<FormBuilderNumberFieldWidget> createState() =>
      _FormBuilderNumberFieldWidgetState();
}

class _FormBuilderNumberFieldWidgetState
    extends State<FormBuilderNumberFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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

        if (widget.jsonSchema.minimum != null &&
            int.parse(value!) < widget.jsonSchema.minimum!) {
          return '${widget.jsonSchema.title ?? widget.keyName} must be at least ${widget.jsonSchema.minimum}.';
        }

        if (widget.jsonSchema.maximum != null &&
            int.parse(value!) > widget.jsonSchema.maxLength!) {
          return '${widget.jsonSchema.title ?? widget.keyName} must be less than ${widget.jsonSchema.maximum}.';
        }
        return null;
      },
    );
  }
}
