class Properties {
  final String id;
  final String type;
  final String title;
  final dynamic defaultValue;
  final bool required;

  Properties({
    required this.id,
    required this.type,
    required this.title,
    this.defaultValue,
    this.required = false, // Defaults to false if not provided
  });

  factory Properties.fromJson(String propertyId, Map<String, dynamic> json) {
    return Properties(
      id: propertyId,
      type: json['type'] ?? '', // Provides a default value if type is null
      title: json['title'] ?? '', // Provides a default value if title is null
      defaultValue: json['default'],
      required: json['required'] ?? false, // Defaults to false if not provided
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'default': defaultValue,
      'required': required,
    };
  }
}
