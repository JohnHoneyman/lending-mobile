// ignore_for_file: public_member_api_docs, sort_constructors_first
class JsonSchema {
  final String type;
  final String? title;
  final Map<String, JsonSchema>? properties;
  final JsonSchema? items;
  final List<String>? required;
  final List<String>? enumerated;

  JsonSchema({
    required this.type,
    this.title,
    this.properties,
    this.items,
    this.required,
    this.enumerated,
  });

  factory JsonSchema.fromJson(Map<String, dynamic> json) {
    return JsonSchema(
      type: json['type'] as String,
      title: json['title'] as String?,
      properties: (json['properties'] as Map<String, dynamic>?)?.map(
        (key, value) =>
            MapEntry(key, JsonSchema.fromJson(value as Map<String, dynamic>)),
      ),
      items: json['items'] != null
          ? JsonSchema.fromJson(json['items'] as Map<String, dynamic>)
          : null, // Parse `items` as a single JsonSchema,
      required: json['required'] as List<String>?,
      enumerated: json['enum'] as List<String>?,
    );
  }

  Map<String, dynamic> toJson() {
    final json = {
      'type': type,
      if (title != null) 'title': title,
      if (properties != null)
        'properties':
            properties!.map((key, value) => MapEntry(key, value.toJson())),
      if (items != null) 'items': items!.toJson(), // Serialize `items`
      if (required != null) 'required': required,
      if (enumerated != null) 'enum': enumerated,
    };
    return json;
  }

  @override
  String toString() {
    return 'JsonSchema(type: $type, ${title != null ? 'title: $title, ' : ''}${properties != null ? 'properties: {$properties}, ' : ''}${items != null ? '{items: $items}, ' : ''}${required != null ? 'required: $required' : ''}${enumerated != null ? 'enum: $enumerated' : ''})';
  }
}
