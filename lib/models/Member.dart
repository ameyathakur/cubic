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


/** This is an auto generated class representing the Member type in your schema. */
@immutable
class Member extends Model {
  static const classType = const _MemberModelType();
  final String id;
  final String? _name;
  final String? _gender;
  final String? _dob;
  final String? _adhar_no;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _userMembersId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get name {
    return _name;
  }
  
  String? get gender {
    return _gender;
  }
  
  String? get dob {
    return _dob;
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
  
  String? get userMembersId {
    return _userMembersId;
  }
  
  const Member._internal({required this.id, name, gender, dob, adhar_no, createdAt, updatedAt, userMembersId}): _name = name, _gender = gender, _dob = dob, _adhar_no = adhar_no, _createdAt = createdAt, _updatedAt = updatedAt, _userMembersId = userMembersId;
  
  factory Member({String? id, String? name, String? gender, String? dob, String? adhar_no, String? userMembersId}) {
    return Member._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      gender: gender,
      dob: dob,
      adhar_no: adhar_no,
      userMembersId: userMembersId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Member &&
      id == other.id &&
      _name == other._name &&
      _gender == other._gender &&
      _dob == other._dob &&
      _adhar_no == other._adhar_no &&
      _userMembersId == other._userMembersId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Member {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("gender=" + "$_gender" + ", ");
    buffer.write("dob=" + "$_dob" + ", ");
    buffer.write("adhar_no=" + "$_adhar_no" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("userMembersId=" + "$_userMembersId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Member copyWith({String? id, String? name, String? gender, String? dob, String? adhar_no, String? userMembersId}) {
    return Member._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      adhar_no: adhar_no ?? this.adhar_no,
      userMembersId: userMembersId ?? this.userMembersId);
  }
  
  Member.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _gender = json['gender'],
      _dob = json['dob'],
      _adhar_no = json['adhar_no'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _userMembersId = json['userMembersId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'gender': _gender, 'dob': _dob, 'adhar_no': _adhar_no, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'userMembersId': _userMembersId
  };

  static final QueryField ID = QueryField(fieldName: "member.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField GENDER = QueryField(fieldName: "gender");
  static final QueryField DOB = QueryField(fieldName: "dob");
  static final QueryField ADHAR_NO = QueryField(fieldName: "adhar_no");
  static final QueryField USERMEMBERSID = QueryField(fieldName: "userMembersId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Member";
    modelSchemaDefinition.pluralName = "Members";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Member.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Member.GENDER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Member.DOB,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Member.ADHAR_NO,
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Member.USERMEMBERSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _MemberModelType extends ModelType<Member> {
  const _MemberModelType();
  
  @override
  Member fromJson(Map<String, dynamic> jsonData) {
    return Member.fromJson(jsonData);
  }
}