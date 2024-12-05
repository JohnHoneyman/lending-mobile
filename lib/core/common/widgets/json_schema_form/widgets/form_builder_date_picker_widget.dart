import 'package:flutter/material.dart';
import 'package:lendingmobile/core/model/json_schema.dart';

class FormBuilderDatePickerWidget extends StatefulWidget {
  final JsonSchema jsonSchema;
  final String? keyName;
  final Function(String value) onChanged;
  final List<String> requiredFields;
  final String? Function(String? value)? validator; // Custom validator function
  final InputDecoration? inputDecoration;

  const FormBuilderDatePickerWidget({
    super.key,
    required this.jsonSchema,
    this.keyName,
    required this.onChanged,
    required this.requiredFields,
    this.validator,
    this.inputDecoration,
  });

  @override
  State<FormBuilderDatePickerWidget> createState() =>
      _FormBuilderDatePickerWidgetState();
}

class _FormBuilderDatePickerWidgetState
    extends State<FormBuilderDatePickerWidget> {
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _dateController.text = selectedDate.toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      decoration: InputDecoration(
        labelText: widget.jsonSchema.title ?? widget.keyName ?? '',
      ),
      readOnly: true,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        }

        if (widget.requiredFields.contains(widget.keyName) &&
            (value == null || value.isEmpty)) {
          return 'Please enter your ${widget.jsonSchema.title ?? widget.keyName ?? ''}.';
        }

        return null;
      },
      onTap: () {
        _selectDate();
        widget.onChanged(_dateController.text);
      },
    );
  }
}
