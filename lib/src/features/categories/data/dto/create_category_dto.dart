import 'package:json_annotation/json_annotation.dart';

part 'create_category_dto.g.dart';

@JsonSerializable()
class CreateCategoryDto {
  final String name;

  const CreateCategoryDto({
    required this.name,
  });

  factory CreateCategoryDto.fromJson(Map<String, dynamic> json) => _$CreateCategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCategoryDtoToJson(this);
}
