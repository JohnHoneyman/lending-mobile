import 'package:flutter/material.dart';
import 'package:lendingmobile/core/model/json_schema.dart';

class FormBuilderArrayFieldWidget extends StatefulWidget {
  final JsonSchema jsonSchema;
  final String? keyName;
  final List<String> requiredFields;
  final String? Function(String? value)? validator; // Custom validator function
  final Function(String value) onChanged;
  final Widget Function(
      JsonSchema schema, String? keyName, String? rootProperty)? buildField;

  const FormBuilderArrayFieldWidget({
    super.key,
    required this.jsonSchema,
    this.keyName,
    required this.requiredFields,
    this.validator,
    required this.onChanged,
    this.buildField,
  });

  @override
  State<FormBuilderArrayFieldWidget> createState() =>
      _FormBuilderArrayFieldWidgetState();
}

class _FormBuilderArrayFieldWidgetState
    extends State<FormBuilderArrayFieldWidget> {
  final List<dynamic> items = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.jsonSchema.title ?? widget.keyName ?? ''),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            children: [
                              widget.buildField!(
                                widget.jsonSchema.items!,
                                '${widget.keyName ?? ''}[$index]',
                                null,
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(Icons.remove_circle),
                            onPressed: () {
                              setState(() {
                                items.removeAt(index);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        TextButton.icon(
          onPressed: () {
            setState(() {
              items.add({});
            });
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Item'),
        )
      ],
    );
  }
}
