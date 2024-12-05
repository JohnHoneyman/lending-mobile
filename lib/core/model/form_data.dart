// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class FormDataStruct {
  final String id;
  final String createdAt;
  final String formVersionID;
  final Map<String, dynamic> submittedData;
  final String updatedAt;
  final String userID;

  FormDataStruct({
    required this.id,
    required this.createdAt,
    required this.formVersionID,
    required this.submittedData,
    required this.updatedAt,
    required this.userID,
  });

  FormDataStruct copyWith({
    String? id,
    String? createdAt,
    String? formVersionID,
    Map<String, dynamic>? submittedData,
    String? updatedAt,
    String? userID,
  }) {
    return FormDataStruct(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      formVersionID: formVersionID ?? this.formVersionID,
      submittedData: submittedData ?? this.submittedData,
      updatedAt: updatedAt ?? this.updatedAt,
      userID: userID ?? this.userID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'formVersionID': formVersionID,
      'submittedData': submittedData,
      'updatedAt': updatedAt,
      'userID': userID,
    };
  }

  factory FormDataStruct.fromMap(Map<String, dynamic> map) {
    return FormDataStruct(
      id: map['id'] as String,
      createdAt: map['createdAt'] as String,
      formVersionID: map['formVersionID'] as String,
      submittedData: Map<String, dynamic>.from(
          (map['submittedData'] as Map<String, dynamic>)),
      updatedAt: map['updatedAt'] as String,
      userID: map['userID'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormDataStruct.fromJson(String source) =>
      FormDataStruct.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FormDataStruct(id: $id, createdAt: $createdAt, formVersionID: $formVersionID, submittedData: $submittedData, updatedAt: $updatedAt, userID: $userID)';
  }

  @override
  bool operator ==(covariant FormDataStruct other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.formVersionID == formVersionID &&
        mapEquals(other.submittedData, submittedData) &&
        other.updatedAt == updatedAt &&
        other.userID == userID;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        formVersionID.hashCode ^
        submittedData.hashCode ^
        updatedAt.hashCode ^
        userID.hashCode;
  }
}
