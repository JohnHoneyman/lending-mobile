import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lendingmobile/core/common/widgets/button.dart';
import 'package:lendingmobile/core/common/widgets/gap.dart';
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
          .expand((value) => (value.requiredFields ?? []) as Iterable<String>)
    ].toList();

    void updateFormData(FormValue value) {
      Object? parsedValue = value is StringValue
          ? int.tryParse(value.value) ?? value.value
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

    switch (schema.type) {
      case 'object':
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
      case 'string':
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
      case 'integer':
      case 'number':
        field = FormBuilderNumberFieldWidget(
          jsonSchema: schema,
          keyName: keyName,
          onChanged: (value) {
            updateFormData(StringValue(value));
          },
          requiredFields: requiredFields,
        );
      case 'boolean':
        final bool currentValue = formData[keyName ?? ''] ?? false;
        field = Row(
          children: [
            Text(schema.title ?? keyName!),
            Checkbox(
                value: currentValue,
                activeColor: Colors.deepPurple,
                onChanged: (bool? value) {
                  setState(() {
                    if (rootProperty != null) {
                      formData[rootProperty] ??= {};
                      formData[rootProperty]?[keyName ?? ''] = value ?? false;
                    } else {
                      formData[keyName ?? ''] = value ?? false;
                    }
                  });
                }),
          ],
        );
        field = FormBuilderCheckboxWidget(
          jsonSchema: schema,
          onChanged: (value) {
            updateFormData(BoolValue(value));
          },
          requiredFields: requiredFields,
        );
      // TODO: FIX ARRAY DATA SUBMISSION AND VALIDATION
      case 'array':
        field = ArrayField(
          schema: schema,
          keyName: keyName,
          onChanged: (values) {
            setState(() {
              formData[keyName ?? ''] = values;
            });
          },
        );
      default:
        field = Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Missing widget for: ${schema.type}',
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
                  print(jsonEncode(formData));
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

class ArrayField extends StatefulWidget {
  final JsonSchema schema;
  final String? keyName;
  final ValueChanged<List<dynamic>>? onChanged;

  const ArrayField({
    super.key,
    required this.schema,
    this.keyName,
    this.onChanged,
  });

  @override
  _ArrayFieldState createState() => _ArrayFieldState();
}

class _ArrayFieldState extends State<ArrayField> {
  final List<dynamic> items = [];

  @override
  Widget build(BuildContext context) {
    final itemSchema = widget.schema.items;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.schema.title != null) Text(widget.schema.title!),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildItemField(itemSchema!, index),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () {
                    setState(() {
                      items.removeAt(index);
                      widget.onChanged?.call(items);
                    });
                  },
                ),
              ],
            );
          },
        ),
        TextButton.icon(
          onPressed: () {
            setState(() {
              items.add(
                  {}); // Add a new empty object for 'object' type or null for primitives
              widget.onChanged?.call(items);
            });
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Item'),
        ),
      ],
    );
  }

  Widget buildItemField(JsonSchema schema, int index) {
    if (schema.type == 'object') {
      final objectSchema = schema.properties ?? {};
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: objectSchema.entries.map((entry) {
          final fieldKey = entry.key;
          final fieldSchema = entry.value;

          return buildField(fieldSchema, fieldKey, index);
        }).toList(),
      );
    } else {
      // Handle primitive types like string/number directly
      return buildField(schema, "Item $index", index);
    }
  }

  Widget buildField(JsonSchema schema, String keyName, int index) {
    switch (schema.type) {
      case 'string':
        if (schema.enumerated != null) {
          return DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: keyName),
            items: schema.enumerated!.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                items[index][keyName] = value;
                widget.onChanged?.call(items);
              });
            },
          );
        }
        return TextFormField(
          decoration: InputDecoration(labelText: keyName),
          onChanged: (value) {
            setState(() {
              items[index][keyName] = value;
              widget.onChanged?.call(items);
            });
          },
        );
      case 'number':
        return TextFormField(
          decoration: InputDecoration(labelText: keyName),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              items[index][keyName] = double.tryParse(value);
              widget.onChanged?.call(items);
            });
          },
        );
      case 'integer':
        return TextFormField(
          decoration: InputDecoration(labelText: keyName),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              items[index][keyName] = int.tryParse(value);
              widget.onChanged?.call(items);
            });
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
