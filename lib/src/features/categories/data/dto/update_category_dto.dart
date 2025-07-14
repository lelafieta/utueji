import 'package:json_annotation/json_annotation.dart';

part 'update_category_dto.g.dart';

@JsonSerializable()
class UpdateCategoryDto {
  final String name;

  const UpdateCategoryDto({
    required this.name,
  });

  factory UpdateCategoryDto.fromJson(Map<String, dynamic> json) => _$UpdateCategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCategoryDtoToJson(this);
}
