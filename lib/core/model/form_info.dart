import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:lendingmobile/core/model/json_schema.dart';

class FormInfoStruct {
  final String createdAt;
  final String description;
  final String id;
  final String name;
  final String updatedAt;
  final String version;
  final String versionID;
  final JsonSchema fields;
  final Map<String, dynamic> uiSchema;
  final Map<String, dynamic> permissionSchema;

  FormInfoStruct({
    required this.createdAt,
    required this.description,
    required this.id,
    required this.name,
    required this.updatedAt,
    required this.version,
    required this.versionID,
    required this.fields,
    required this.uiSchema,
    required this.permissionSchema,
  });

  FormInfoStruct copyWith({
    String? createdAt,
    String? description,
    String? id,
    String? name,
    String? updatedAt,
    String? version,
    String? versionID,
    JsonSchema? fields,
    Map<String, dynamic>? uiSchema,
    Map<String, dynamic>? permissionSchema,
  }) {
    return FormInfoStruct(
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      id: id ?? this.id,
      name: name ?? this.name,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
      versionID: versionID ?? this.versionID,
      fields: fields ?? this.fields,
      uiSchema: uiSchema ?? this.uiSchema,
      permissionSchema: permissionSchema ?? this.permissionSchema,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt,
      'description': description,
      'id': id,
      'name': name,
      'updatedAt': updatedAt,
      'version': version,
      'versionID': versionID,
      'fields': fields.toMap(),
      'uiSchema': uiSchema,
      'permissionSchema': permissionSchema,
    };
  }

  factory FormInfoStruct.fromMap(Map<String, dynamic> map) {
    try {
      final Map<String, dynamic> data = map['data'] ?? map;
      return FormInfoStruct(
        createdAt: data['createdAt'] as String,
        description: data['description'] as String,
        id: data['id'] as String,
        name: data['name'] as String,
        updatedAt: data['updatedAt'] as String,
        version: data['version'] as String,
        versionID: data['versionID'] as String,
        fields: JsonSchema.fromMap(data['fields'] as Map<String, dynamic>),
        uiSchema: Map<String, dynamic>.from(
            (data['uiSchema'] as Map<String, dynamic>)),
        permissionSchema: Map<String, dynamic>.from(
          (data['permissionSchema'] as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      throw 'Error mapping: $e';
    }
  }

  String toJson() => json.encode(toMap());

  factory FormInfoStruct.fromJson(String source) =>
      FormInfoStruct.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FormInfoStruct(createdAt: $createdAt, description: $description, id: $id, name: $name, updatedAt: $updatedAt, version: $version, versionID: $versionID, fields: $fields, uiSchema: $uiSchema, permissionSchema: $permissionSchema)';
  }

  @override
  bool operator ==(covariant FormInfoStruct other) {
    if (identical(this, other)) return true;

    return other.createdAt == createdAt &&
        other.description == description &&
        other.id == id &&
        other.name == name &&
        other.updatedAt == updatedAt &&
        other.version == version &&
        other.versionID == versionID &&
        other.fields == fields &&
        mapEquals(other.uiSchema, uiSchema) &&
        mapEquals(other.permissionSchema, permissionSchema);
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
        description.hashCode ^
        id.hashCode ^
        name.hashCode ^
        updatedAt.hashCode ^
        version.hashCode ^
        versionID.hashCode ^
        fields.hashCode ^
        uiSchema.hashCode ^
        permissionSchema.hashCode;
  }
}
