import 'package:json_annotation/json_annotation.dart';

part 'login_auth_dto.g.dart';

@JsonSerializable()
class LoginAuthDto {
  final String email;
  final String password;

  LoginAuthDto({
    required this.email,
    required this.password,
  });

  factory LoginAuthDto.fromJson(Map<String, dynamic> json) => _$LoginAuthDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginAuthDtoToJson(this);
}
