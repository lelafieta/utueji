import '../../../auth/data/models/user_model.dart';
import '../../../ongs/data/models/ong_model.dart';
import '../../domain/entities/blog_entity.dart';

class BlogModel extends BlogEntity {
  BlogModel(
      {required super.id,
      required super.createdAt,
      super.updatedAt,
      required super.title,
      required super.description,
      required super.userId,
      required super.ondId,
      super.image,
      super.user,
      super.ong});

  // Serializa para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'title': title,
      'description': description,
      'user_id': userId,
      'ond_id': ondId,
      'image': image,
    };
  }

  // Desserializa de JSON
  factory BlogModel.fromMap(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      title: json['title'],
      description: json['description'],
      userId: json['user_id'],
      ondId: json['ond_id'],
      image: json['image'],
      user: (json['user'] == null)
          ? null
          : UserModel.fromJson(
              json['user'],
            ),
      ong: (json['ong'] == null)
          ? null
          : OngModel.fromMap(
              json['ong'],
            ),
    );
  }
}
