import 'package:flutter/foundation.dart';

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

  JsonSchema copyWith({
    String? type,
    String? title,
    String? description,
    Map<String, JsonSchema>? properties,
    JsonSchema? items,
    List<String>? requiredFields,
    List<String>? enumerated,
    String? format,
    String? pattern,
    int? minimum,
    int? maximum,
    bool? additionalProperties,
    int? minLength,
    int? maxLength,
  }) {
    return JsonSchema(
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      properties: properties ?? this.properties,
      items: items ?? this.items,
      requiredFields: requiredFields ?? this.requiredFields,
      enumerated: enumerated ?? this.enumerated,
      format: format ?? this.format,
      pattern: pattern ?? this.pattern,
      minimum: minimum ?? this.minimum,
      maximum: maximum ?? this.maximum,
      additionalProperties: additionalProperties ?? this.additionalProperties,
      minLength: minLength ?? this.minLength,
      maxLength: maxLength ?? this.maxLength,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'title': title,
      'description': description,
      'properties': properties,
      'items': items?.toMap(),
      'required': requiredFields,
      'enum': enumerated,
      'format': format,
      'pattern': pattern,
      'minimum': minimum,
      'maximum': maximum,
      'additionalProperties': additionalProperties,
      'minLength': minLength,
      'maxLength': maxLength,
    };
  }

  factory JsonSchema.fromMap(Map<String, dynamic> map) {
    return JsonSchema(
      type: map['type'] as String,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      properties: map['properties'] != null
          ? (map['properties'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(
                  key, JsonSchema.fromMap(value as Map<String, dynamic>)),
            )
          : null,
      items: map['items'] != null
          ? JsonSchema.fromMap(map['items'] as Map<String, dynamic>)
          : null,
      requiredFields: map['required'] != null
          ? List<String>.from(map['required'] as List)
          : null,
      enumerated:
          map['enum'] != null ? List<String>.from(map['enum'] as List) : null,
      format: map['format'] != null ? map['format'] as String : null,
      pattern: map['pattern'] != null ? map['pattern'] as String : null,
      minimum: map['minimum'] != null ? map['minimum'] as int : null,
      maximum: map['maximum'] != null ? map['maximum'] as int : null,
      additionalProperties: map['additionalProperties'] != null
          ? map['additionalProperties'] as bool
          : null,
      minLength: map['minLength'] != null ? map['minLength'] as int : null,
      maxLength: map['maxLength'] != null ? map['maxLength'] as int : null,
    );
  }

  @override
  bool operator ==(covariant JsonSchema other) {
    if (identical(this, other)) return true;

    return other.type == type &&
        other.title == title &&
        other.description == description &&
        mapEquals(other.properties, properties) &&
        other.items == items &&
        listEquals(other.requiredFields, requiredFields) &&
        listEquals(other.enumerated, enumerated) &&
        other.format == format &&
        other.pattern == pattern &&
        other.minimum == minimum &&
        other.maximum == maximum &&
        other.additionalProperties == additionalProperties &&
        other.minLength == minLength &&
        other.maxLength == maxLength;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        title.hashCode ^
        description.hashCode ^
        properties.hashCode ^
        items.hashCode ^
        requiredFields.hashCode ^
        enumerated.hashCode ^
        format.hashCode ^
        pattern.hashCode ^
        minimum.hashCode ^
        maximum.hashCode ^
        additionalProperties.hashCode ^
        minLength.hashCode ^
        maxLength.hashCode;
  }
}
