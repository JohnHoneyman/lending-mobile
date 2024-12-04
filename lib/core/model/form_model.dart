// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FormStruct {
  final String? code;
  final String? description;
  final String formID;
  final String? formVersionID;
  final String name;
  final String? version;
  final bool? isVerified;

  FormStruct({
    this.code,
    this.description,
    required this.formID,
    this.formVersionID,
    required this.name,
    this.version,
    this.isVerified,
  });

  FormStruct copyWith({
    String? code,
    String? description,
    String? formID,
    String? formVersionID,
    String? name,
    String? version,
    bool? isVerified,
  }) {
    return FormStruct(
      code: code ?? this.code,
      description: description ?? this.description,
      formID: formID ?? this.formID,
      formVersionID: formVersionID ?? this.formVersionID,
      name: name ?? this.name,
      version: version ?? this.version,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'description': description,
      'formID': formID,
      'formVersionID': formVersionID,
      'name': name,
      'version': version,
      'isVerified': isVerified,
    };
  }

  factory FormStruct.fromMap(Map<String, dynamic> map) {
    return FormStruct(
      code: map['code'] != null ? map['code'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      formID: map['formID'] as String,
      formVersionID:
          map['formVersionID'] != null ? map['formVersionID'] as String : null,
      name: map['name'] as String,
      version: map['version'] != null ? map['version'] as String : null,
      isVerified: map['isVerified'] != null ? map['isVerified'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormStruct.fromJson(String source) =>
      FormStruct.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FormStruct(code: $code, description: $description, formID: $formID, formVersionID: $formVersionID, name: $name, version: $version, isVerified: $isVerified)';
  }

  @override
  bool operator ==(covariant FormStruct other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.description == description &&
        other.formID == formID &&
        other.formVersionID == formVersionID &&
        other.name == name &&
        other.version == version &&
        other.isVerified == isVerified;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        description.hashCode ^
        formID.hashCode ^
        formVersionID.hashCode ^
        name.hashCode ^
        version.hashCode ^
        isVerified.hashCode;
  }
}
