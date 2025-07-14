import 'package:json_annotation/json_annotation.dart';

part 'create_auth_dto.g.dart';

@JsonSerializable()
class CreateAuthDto {
  final String name;
  final String email;
  final String password;
  final String phone;

  CreateAuthDto({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

     
  factory CreateAuthDto.fromJson(Map<String, dynamic> json) => _$CreateAuthDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAuthDtoToJson(this);
}
