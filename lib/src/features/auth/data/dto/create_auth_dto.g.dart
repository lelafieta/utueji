// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_auth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAuthDto _$CreateAuthDtoFromJson(Map<String, dynamic> json) =>
    CreateAuthDto(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$CreateAuthDtoToJson(CreateAuthDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'phone': instance.phone,
    };
