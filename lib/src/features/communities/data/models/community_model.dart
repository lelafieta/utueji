import '../../domain/entities/community_entity.dart';

class CommunityModel extends CommunityEntity {
  CommunityModel({
    super.userId,
    super.name,
    super.description,
    super.id,
    super.banner,
    super.image,
    super.createdAt,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      userId: json['user_id'],
      name: json['name'],
      image: json['image'],
      banner: json['banner'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'user_id': userId,
      'name': name,
      'image': image,
      'banner': banner,
      'description': description,
    };
  }
}
