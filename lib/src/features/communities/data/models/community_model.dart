import '../../domain/entities/community_entity.dart';

class CommunityModel extends CommunityEntity {
  CommunityModel({
    super.userId,
    super.name,
    super.description,
    super.id,
    super.createdAt,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      userId: json['user_id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'user_id': userId,
      'name': name,
      'description': description,
    };
  }
}
