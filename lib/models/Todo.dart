/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, file_names, unnecessary_new, prefer_if_null_operators, prefer_const_constructors, slash_for_doc_comments, annotate_overrides, non_constant_identifier_names, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, unnecessary_const, dead_code

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Todo type in your schema. */
@immutable
class Todo extends Model {
  static const classType = const _TodoModelType();
  final String id;
  final String? _name;
  final String? _emaild_id;
  final String? _contact_no;
  final String? _dob;
  final String? _gender;
  final String? _adhar_no;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get emaild_id {
    return _emaild_id;
  }
  
  String? get contact_no {
    return _contact_no;
  }
  
  String? get dob {
    return _dob;
  }
  
  String? get gender {
    return _gender;
  }
  
  String? get adhar_no {
    return _adhar_no;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Todo._internal({required this.id, required name, emaild_id, contact_no, dob, gender, adhar_no, createdAt, updatedAt}): _name = name, _emaild_id = emaild_id, _contact_no = contact_no, _dob = dob, _gender = gender, _adhar_no = adhar_no, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Todo({String? id, required String name, String? emaild_id, String? contact_no, String? dob, String? gender, String? adhar_no}) {
    return Todo._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      emaild_id: emaild_id,
      contact_no: contact_no,
      dob: dob,
      gender: gender,
      adhar_no: adhar_no);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Todo &&
      id == other.id &&
      _name == other._name &&
      _emaild_id == other._emaild_id &&
      _contact_no == other._contact_no &&
      _dob == other._dob &&
      _gender == other._gender &&
      _adhar_no == other._adhar_no;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Todo {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("emaild_id=" + "$_emaild_id" + ", ");
    buffer.write("contact_no=" + "$_contact_no" + ", ");
    buffer.write("dob=" + "$_dob" + ", ");
    buffer.write("gender=" + "$_gender" + ", ");
    buffer.write("adhar_no=" + "$_adhar_no" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Todo copyWith({String? id, String? name, String? emaild_id, String? contact_no, String? dob, String? gender, String? adhar_no}) {
    return Todo._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      emaild_id: emaild_id ?? this.emaild_id,
      contact_no: contact_no ?? this.contact_no,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      adhar_no: adhar_no ?? this.adhar_no);
  }
  
  Todo.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _emaild_id = json['emaild_id'],
      _contact_no = json['contact_no'],
      _dob = json['dob'],
      _gender = json['gender'],
      _adhar_no = json['adhar_no'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'emaild_id': _emaild_id, 'contact_no': _contact_no, 'dob': _dob, 'gender': _gender, 'adhar_no': _adhar_no, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "todo.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField EMAILD_ID = QueryField(fieldName: "emaild_id");
  static final QueryField CONTACT_NO = QueryField(fieldName: "contact_no");
  static final QueryField DOB = QueryField(fieldName: "dob");
  static final QueryField GENDER = QueryField(fieldName: "gender");
  static final QueryField ADHAR_NO = QueryField(fieldName: "adhar_no");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Todo";
    modelSchemaDefinition.pluralName = "Todos";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.EMAILD_ID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.CONTACT_NO,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.DOB,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.GENDER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.ADHAR_NO,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _TodoModelType extends ModelType<Todo> {
  const _TodoModelType();
  
  @override
  Todo fromJson(Map<String, dynamic> jsonData) {
    return Todo.fromJson(jsonData);
  }
}