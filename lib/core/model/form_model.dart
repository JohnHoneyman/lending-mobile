import 'dart:convert';

class FormStruct {
  final String id;
  final String code;
  final String name;
  final String createdAt;
  final String description;
  final String updatedAt;

  FormStruct({
    required this.id,
    required this.code,
    required this.name,
    required this.createdAt,
    required this.description,
    required this.updatedAt,
  });

  FormStruct copyWith({
    String? id,
    String? code,
    String? name,
    String? createdAt,
    String? description,
    String? updatedAt,
  }) {
    return FormStruct(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'Code': code,
      'name': name,
      'createdAt': createdAt,
      'description': description,
      'updatedAt': updatedAt,
    };
  }

  factory FormStruct.fromMap(Map<String, dynamic> map) {
    return FormStruct(
      id: map['id'] as String,
      code: map['Code'] as String,
      name: map['name'] as String,
      createdAt: map['createdAt'] as String,
      description: map['description'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormStruct.fromJson(String source) =>
      FormStruct.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Form(id: $id, Code: $code, name: $name, createdAt: $createdAt, description: $description, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant FormStruct other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.code == code &&
        other.name == name &&
        other.createdAt == createdAt &&
        other.description == description &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        code.hashCode ^
        name.hashCode ^
        createdAt.hashCode ^
        description.hashCode ^
        updatedAt.hashCode;
  }
}
