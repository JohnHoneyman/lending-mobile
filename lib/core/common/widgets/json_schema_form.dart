import 'package:flutter/material.dart';
import 'package:lendingmobile/core/model/json_schema.dart';

class JsonSchemaForm extends StatefulWidget {
  final JsonSchema jsonSchema;
  final VoidCallback? onSubmit;
  const JsonSchemaForm({
    super.key,
    required this.jsonSchema,
    this.onSubmit,
  });

  @override
  State<JsonSchemaForm> createState() => _JsonSchemaFormState();
}

class _JsonSchemaFormState extends State<JsonSchemaForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {};

  Widget buildField(JsonSchema schema, String? keyName) {
    switch (schema.type) {
      case 'object':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(schema.title ?? ''),
            ...(schema.properties?.entries ?? []).map((entry) {
              return buildField(entry.value, entry.key);
            })
          ],
        );
      case 'string':
        if (schema.enumerated != null) {
          return DropdownButtonFormField<String>(
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
          );
        }
        return TextFormField(
          decoration: InputDecoration(
            labelText: schema.title ?? keyName,
          ),
          onChanged: (value) {
            setState(() {
              formData[keyName ?? ''] = value;
            });
          },
        );
      case 'integer':
        return TextFormField(
          decoration: InputDecoration(
            labelText: schema.title ?? keyName,
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              formData[keyName ?? ''] = int.tryParse(value);
            });
          },
        );
      case 'array':
        return ArrayField(
          schema: schema,
          keyName: keyName,
          onChanged: (values) {
            setState(() {
              formData[keyName ?? ''] = values;
            });
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.jsonSchema.title != null)
                Text(
                  widget.jsonSchema.title!,
                ),
              ...?widget.jsonSchema.properties?.entries.map(
                (entry) {
                  return buildField(entry.value, entry.key);
                },
              ),
              ElevatedButton(
                onPressed: () {
                  print('Form Data: $formData');
                  if (_formKey.currentState?.validate() ?? false) {
                    if (widget.onSubmit != null) {
                      widget.onSubmit!();
                    }
                  } else {
                    print('Validation failed');
                  }
                },
                child: const Text('Submit'),
              ),
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
    Key? key,
    required this.schema,
    this.keyName,
    this.onChanged,
  }) : super(key: key);

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
