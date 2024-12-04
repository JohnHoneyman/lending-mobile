// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FormStruct {
  final String id;
  final String? code;
  final String name;
  final String? createdAt;
  final String? description;
  final String? updatedAt;
  final bool? isVerified;

  FormStruct({
    required this.id,
    this.code,
    required this.name,
    this.createdAt,
    this.description,
    this.updatedAt,
    this.isVerified,
  });

  FormStruct copyWith({
    String? id,
    String? code,
    String? name,
    String? createdAt,
    String? description,
    String? updatedAt,
    bool? isVerified,
  }) {
    return FormStruct(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      updatedAt: updatedAt ?? this.updatedAt,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'name': name,
      'createdAt': createdAt,
      'description': description,
      'updatedAt': updatedAt,
      'isVerified': isVerified,
    };
  }

  factory FormStruct.fromMap(Map<String, dynamic> map) {
    return FormStruct(
      id: map['id'] as String,
      code: map['code'] != null ? map['code'] as String : null,
      name: map['name'] as String,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      isVerified: map['isVerified'] != null ? map['isVerified'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormStruct.fromJson(String source) =>
      FormStruct.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FormStruct(id: $id, code: $code, name: $name, createdAt: $createdAt, description: $description, updatedAt: $updatedAt, isVerified: $isVerified)';
  }

  @override
  bool operator ==(covariant FormStruct other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.code == code &&
        other.name == name &&
        other.createdAt == createdAt &&
        other.description == description &&
        other.updatedAt == updatedAt &&
        other.isVerified == isVerified;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        code.hashCode ^
        name.hashCode ^
        createdAt.hashCode ^
        description.hashCode ^
        updatedAt.hashCode ^
        isVerified.hashCode;
  }
}
