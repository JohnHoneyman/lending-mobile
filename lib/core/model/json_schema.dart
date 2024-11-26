class JsonSchema {
  final String type;
  final String? title;
  final String? description;
  final Map<String, JsonSchema>? properties;
  final JsonSchema? items;
  final List<String>? requiredFields;
  final List<String>? enumerated;
  final String? format;
  final String? pattern;
  final int? minimum;
  final int? maximum;
  final bool? additionalProperties;
  final int? minLength;
  final int? maxLength;

  JsonSchema({
    required this.type,
    this.title,
    this.description,
    this.properties,
    this.items,
    this.requiredFields,
    this.enumerated,
    this.format,
    this.pattern,
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
      description: json['description'] as String?,
      properties: (json['properties'] as Map<String, dynamic>?)?.map(
        (key, value) =>
            MapEntry(key, JsonSchema.fromJson(value as Map<String, dynamic>)),
      ),
      items: json['items'] != null
          ? JsonSchema.fromJson(json['items'] as Map<String, dynamic>)
          : null, // Parse `items` as a single JsonSchema,
      requiredFields: json['required'] as List<String>?,
      enumerated: json['enum'] as List<String>?,
      format: json['format'] as String?,
      pattern: json['pattern'] as String?,
      minimum: json['minimum'] as int?,
      maximum: json['maximum'] as int?,
      minLength: json['minLength'] as int?,
      maxLength: json['maxLength'] as int?,
      additionalProperties: json['additionalProperties'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    final json = {
      'type': type,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (properties != null)
        'properties':
            properties!.map((key, value) => MapEntry(key, value.toJson())),
      if (items != null) 'items': items!.toJson(), // Serialize `items`
      if (requiredFields != null) 'required': requiredFields,
      if (enumerated != null) 'enum': enumerated,
      if (format != null) 'format': format,
      if (pattern != null) 'pattern': pattern,
      if (minimum != null) 'minimum': minimum,
      if (maximum != null) 'maximum': maximum,
      if (minLength != null) 'minLength': minLength,
      if (maxLength != null) 'maxLength': maxLength,
      if (additionalProperties != null)
        'additionalProperties': additionalProperties,
    };
    return json;
  }

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.writeln('JsonSchema(');
    buffer.writeln('  type: $type,');
    if (title != null) buffer.writeln('  title: $title,');
    if (description != null) buffer.writeln('  required: $description,');
    if (requiredFields != null) buffer.writeln('  required: $requiredFields,');
    if (properties != null) {
      buffer.writeln('  properties: {');
      properties!.forEach((key, value) {
        buffer.writeln('    $key: $value,');
      });
      buffer.writeln('  },');
    }
    if (items != null) buffer.writeln('  items: $items,');
    if (enumerated != null) buffer.writeln('  enum: $enumerated,');
    if (format != null) buffer.writeln('  format: $format,');
    if (pattern != null) buffer.writeln('  pattern: $pattern,');
    if (minimum != null) buffer.writeln('  minimum: $minimum,');
    if (maximum != null) buffer.writeln('  maximum: $maximum,');
    if (minLength != null) buffer.writeln('  minLength: $minLength,');
    if (maxLength != null) buffer.writeln('  maxLength: $maxLength,');
    if (additionalProperties != null) {
      buffer.writeln('  additionalProperties: {');
      buffer.writeln('    $additionalProperties');
      buffer.writeln('  },');
    }
    buffer.write(')');

    return buffer.toString();
  }
}
