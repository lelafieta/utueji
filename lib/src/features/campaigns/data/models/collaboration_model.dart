import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../ongs/data/models/ong_model.dart';
import '../../../ongs/domain/entities/ong_entity.dart';
import '../../domain/entities/collaboration_entity.dart';

class CollaborationModel extends CollaborationEntity {
  CollaborationModel({
    String? id,
    String? campaignId,
    String? userId,
    String? ongId,
    DateTime? createdAt,
    OngModel? ongEntity,
    UserModel? userEntity,
  }) : super(
          id: id,
          campaignId: campaignId,
          userId: userId,
          ongId: ongId,
          createdAt: createdAt,
          ongEntity: ongEntity,
          userEntity: userEntity,
        );

  factory CollaborationModel.fromJson(Map<String, dynamic> json) {
    return CollaborationModel(
      id: json['id'] as String?,
      campaignId: json['campaignId'] as String?,
      userId: json['userId'] as String?,
      ongId: json['ongId'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      ongEntity: json['ongEntity'] != null
          ? OngModel.fromMap(json['ongEntity'] as Map<String, dynamic>)
          : null,
      userEntity: json['userEntity'] != null
          ? UserModel.fromJson(json['userEntity'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'campaignId': campaignId,
      'userId': userId,
      'ongId': ongId,
      'createdAt': createdAt?.toIso8601String(),
      // 'ongEntity': ongEntity?.toJson(),
      // 'userEntity': userEntity.toJson(),
    };
  }
}
