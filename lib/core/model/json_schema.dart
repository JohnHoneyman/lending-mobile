// ignore_for_file: public_member_api_docs, sort_constructors_first
class JsonSchema {
  final String type;
  final String? title;
  final Map<String, JsonSchema>? properties;
  final JsonSchema? items;
  final List<String>? required;
  final List<String>? enumerated;
  final int? minimum;
  final int? maximum;
  final bool? additionalProperties;
  final int? minLength;
  final int? maxLength;

  JsonSchema({
    required this.type,
    this.title,
    this.properties,
    this.items,
    this.required,
    this.enumerated,
    this.minimum,
    this.maximum,
    this.additionalProperties,
    this.minLength,
    this.maxLength,
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
      minimum: json['minimum'] as int?,
      maximum: json['maximum'] as int?,
      minLength: json['minLength'] as int?,
      maxLength: json['minLength'] as int?,
      additionalProperties: json['additionalProperties'] as bool?,
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
      if (minimum != null) 'minimum': minimum,
      if (maximum != null) 'maximum': maximum,
      if (additionalProperties != null)
        'additionalProperties': additionalProperties,
    };
    return json;
  }

  // @override
  // String toString() {
  //   return 'JsonSchema(type: $type, ${title != null ? 'title: $title, ' : ''}${properties != null ? 'properties: {$properties}, ' : ''}${items != null ? '{items: $items}, ' : ''}${required != null ? 'required: $required, ' : ''}${enumerated != null ? 'enum: $enumerated, ' : ''}${minimum != null ? 'minimum: $minimum, ' : ''}${maximum != null ? 'maximum: $maximum, ' : ''}${additionalProperties != null ? 'additionalProperties: $additionalProperties, ' : ''})';
  // }

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.writeln('JsonSchema(');
    buffer.writeln('  type: $type,');
    if (title != null) buffer.writeln('  title: $title,');
    if (required != null) buffer.writeln('  required: $required,');
    if (properties != null) {
      buffer.writeln('  properties: {');
      properties!.forEach((key, value) {
        buffer.writeln('    $key: $value,');
      });
      buffer.writeln('  },');
    }
    if (items != null) buffer.writeln('  items: $items,');
    if (enumerated != null) buffer.writeln('  enum: $enumerated,');
    if (minimum != null) buffer.writeln('  minimum: $minimum,');
    if (maximum != null) buffer.writeln('  maximum: $maximum,');
    if (additionalProperties != null) {
      buffer.writeln('  additionalProperties: {');
      buffer.writeln('    $additionalProperties');
      buffer.writeln('  },');
    }
    buffer.write(')');

    return buffer.toString();
  }
}
