import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/widgets/button.dart';
import 'package:lendingmobile/core/common/widgets/gap.dart';
import 'package:lendingmobile/core/common/widgets/json_schema_form/utils/parse_json_schema_type.dart';
import 'package:lendingmobile/core/common/widgets/json_schema_form/widgets/form_builder_array_field_widget.dart';
import 'package:lendingmobile/core/common/widgets/json_schema_form/widgets/form_builder_checkbox_widget.dart';
import 'package:lendingmobile/core/common/widgets/json_schema_form/widgets/form_builder_date_picker_widget.dart';
import 'package:lendingmobile/core/common/widgets/json_schema_form/widgets/form_builder_dropdown_form_field_widget.dart';
import 'package:lendingmobile/core/common/widgets/json_schema_form/widgets/form_builder_number_field_widget.dart';
import 'package:lendingmobile/core/common/widgets/json_schema_form/widgets/form_builder_text_form_field_widget.dart';
import 'package:lendingmobile/core/model/json_schema.dart';

sealed class FormValue {
  const FormValue();
}

class StringValue extends FormValue {
  final String value;
  const StringValue(this.value);
}

class NumberValue extends FormValue {
  final String value;
  const NumberValue(this.value);
}

class BoolValue extends FormValue {
  final bool value;
  const BoolValue(this.value);
}

class JsonSchemaForm extends StatefulWidget {
  final JsonSchema jsonSchema;
  final Function(Map<String, dynamic>) onSubmit;

  const JsonSchemaForm({
    super.key,
    required this.jsonSchema,
    required this.onSubmit,
  });

  @override
  State<JsonSchemaForm> createState() => _JsonSchemaFormState();
}

class _JsonSchemaFormState extends State<JsonSchemaForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {};

  Widget buildField(JsonSchema schema, String? keyName, String? rootProperty) {
    Widget field;

    final List<String> requiredFields = [
      ...?widget.jsonSchema.requiredFields,
      ...widget.jsonSchema.properties!.values
          .expand((value) => (value.requiredFields ?? []) as Iterable<String>),
      ...widget.jsonSchema.properties!.values
          .map((value) => value.items?.requiredFields)
          .whereType<List<String>>()
          .expand((fields) => fields)
    ].toList();

    void updateFormData(FormValue value) {
      Object? parsedValue = value is StringValue
          ? value.value
          : value is NumberValue
              ? int.tryParse(value.value)
              : value is BoolValue
                  ? value.value
                  : value;

      setState(() {
        if (rootProperty != null) {
          formData[rootProperty] ??= {};
          formData[rootProperty]?[keyName ?? ''] = parsedValue;
        } else {
          formData[keyName ?? ''] = parsedValue;
        }
      });
    }

    switch (parseJsonSchemaType(schema.type)) {
      case JsonSchemaType.object:
        field = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(schema.title ?? keyName ?? ''),
            ...(schema.properties?.entries ?? []).map((entry) {
              return buildField(
                entry.value,
                entry.key,
                keyName,
              );
            })
          ],
        );
      case JsonSchemaType.string:
        if (schema.enumerated != null) {
          field = FormBuilderDropdownFormFieldWidget(
            jsonSchema: schema,
            keyName: keyName,
            onChanged: (value) {
              updateFormData(StringValue(value));
            },
            requiredFields: requiredFields,
          );
        } else if (schema.format != null && schema.format == 'date') {
          field = FormBuilderDatePickerWidget(
            jsonSchema: schema,
            keyName: keyName,
            onChanged: (value) {
              updateFormData(StringValue(value));
            },
            requiredFields: requiredFields,
          );
        } else {
          field = FormBuilderTextFormFieldWidget(
            jsonSchema: schema,
            keyName: keyName,
            onChanged: (value) {
              updateFormData(StringValue(value));
            },
            requiredFields: requiredFields,
          );
        }
      case JsonSchemaType.integer:
      case JsonSchemaType.number:
        field = FormBuilderNumberFieldWidget(
          jsonSchema: schema,
          keyName: keyName,
          onChanged: (value) {
            updateFormData(NumberValue(value));
          },
          requiredFields: requiredFields,
        );
      case JsonSchemaType.boolean:
        field = FormBuilderCheckboxWidget(
          jsonSchema: schema,
          keyName: keyName,
          onChanged: (value) {
            updateFormData(BoolValue(value));
          },
          requiredFields: requiredFields,
        );
      case JsonSchemaType.array:
        field = FormBuilderArrayFieldWidget(
          jsonSchema: schema,
          keyName: keyName,
          requiredFields: requiredFields,
          buildField: buildField,
          onChanged: (value) {
            setState(() {
              formData[keyName ?? ''] = value;
            });
          },
        );
      case JsonSchemaType.unknown:
      default:
        field = Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Missing widget for schema type: ${schema.type}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        field,
        if (schema.description != null) Text(schema.description!),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...?widget.jsonSchema.properties?.entries.map(
                (entry) {
                  return buildField(
                    entry.value,
                    entry.key,
                    null,
                  );
                },
              ),
              const Gap(),
              Button(
                buttonName: 'Save changes',
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSubmit(formData);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$formData'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Validation failed'),
                      ),
                    );
                  }
                },
              ),
              const Gap(),
            ],
          ),
        ),
      ),
    );
  }
}
