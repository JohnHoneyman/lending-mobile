import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lendingmobile/core/common/widgets/button.dart';
import 'package:lendingmobile/core/common/widgets/gap.dart';
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
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {};

  final TextEditingController _dateController = TextEditingController();

  Widget buildField(JsonSchema schema, String? keyName) {
    Widget field;

    final List<String> requiredFields = [
      ...?widget.jsonSchema.requiredFields,
      ...widget.jsonSchema.properties!.values
          .expand((value) => (value.requiredFields ?? []) as Iterable<String>)
    ].toList();

    switch (schema.type) {
      case 'object':
        field = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(schema.title ?? ''),
            ...(schema.properties?.entries ?? []).map((entry) {
              return buildField(
                entry.value,
                entry.key,
              );
            })
          ],
        );
      case 'string':
        if (schema.enumerated != null) {
          field = DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: schema.title ?? keyName),
            items: schema.enumerated?.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                formData[keyName ?? ''] = value;
              });
            },
            validator: (value) {
              if (requiredFields.contains(keyName) &&
                  (value == null || value.isEmpty)) {
                return 'Please enter your ${schema.title ?? keyName}.';
              }

              return null;
            },
          );
        } else if (schema.format != null && schema.format == 'date') {
          field = TextFormField(
            controller: _dateController,
            decoration: InputDecoration(
              labelText: schema.title ?? keyName,
            ),
            readOnly: true,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            validator: (value) {
              if (requiredFields.contains(keyName) &&
                  (value == null || value.isEmpty)) {
                return 'Please enter your ${schema.title ?? keyName}.';
              }
              return null;
            },
            onTap: () {
              _selectDate();
              setState(() {
                formData[keyName ?? ''] = _dateController.text;
              });
            },
          );
        } else {
          field = TextFormField(
            decoration: InputDecoration(
              labelText: schema.title ?? keyName,
            ),
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            onChanged: (value) {
              setState(() {
                formData[keyName ?? ''] = value;
              });
            },
            validator: (value) {
              if (requiredFields.contains(keyName) &&
                  (value == null || value.isEmpty)) {
                return 'Please enter your ${schema.title ?? keyName}.';
              }
              if (schema.minLength != null &&
                  value!.length < schema.minLength!) {
                return 'Name must be at least ${schema.minLength} characters long.';
              }
              if (schema.maxLength != null &&
                  value!.length > schema.maxLength!) {
                return 'Name must not be more than ${schema.maxLength} characters long.';
              }
              return null;
            },
          );
        }
      case 'integer':
      case 'number':
        field = TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: schema.title ?? keyName,
          ),
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          onChanged: (value) {
            setState(() {
              formData[keyName ?? ''] = int.tryParse(value);
            });
          },
          validator: (value) {
            if (requiredFields.contains(keyName) &&
                (value == null || value.isEmpty)) {
              return 'Please enter your ${schema.title ?? keyName}.';
            }
            if (schema.minimum != null && int.parse(value!) < schema.minimum!) {
              return '${schema.title ?? keyName} must be at least ${schema.minimum}.';
            }
            return null;
          },
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
                    formData[keyName ?? ''] = value ?? false;
                  });
                }),
          ],
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
                  );
                },
              ),
              const Gap(),
              Button(
                buttonName: 'Save changes',
                onPress: () {
                  print('Form Data: $formData');
                  if (_formKey.currentState!.validate()) {
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
