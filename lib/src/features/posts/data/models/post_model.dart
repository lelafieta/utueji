
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/post_entity.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends PostEntity {
  const PostModel({
    required int id,
    required int userId,
    required String title,
    required String body,
  }) : super(id: id, userId: userId, title: title, body: body);

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
