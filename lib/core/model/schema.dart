import 'properties.dart';

class Schema {
  final String title;
  final String type;
  final String? description;
  final List<String> required;
  final List<Properties> properties;

  Schema({
    required this.title,
    required this.type,
    this.description,
    required this.required,
    required this.properties,
  });

  factory Schema.fromJson(Map<String, dynamic> json) {
    // Parse the properties and required list
    final requiredList =
        (json['required'] as List<dynamic>?)?.cast<String>() ?? [];
    final propertiesMap = (json['properties'] as Map<String, dynamic>?);
    final properties = _parseProperties(propertiesMap, requiredList);

    return Schema(
      title: json['title'] ?? '',
      type: json['type'] ?? '',
      description: json['description'],
      required: requiredList,
      properties: properties,
    );
  }

  static List<Properties> _parseProperties(
      Map<String, dynamic>? json, List<String> requiredList) {
    if (json == null) return [];

    return json.entries.map((entry) {
      final key = entry.key;
      final data = entry.value as Map<String, dynamic>;
      final isRequired = requiredList.contains(key);

      return Properties(
        id: key,
        type: data['type'] ?? '',
        title: data['title'] ?? '',
        defaultValue: data['default'],
        required: isRequired,
      );
    }).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type,
      'description': description,
      'required': required,
      'properties': {
        for (var prop in properties) prop.id: prop.toJson(),
      },
    };
  }
}
