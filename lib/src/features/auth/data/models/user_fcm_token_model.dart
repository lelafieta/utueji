import '../../domain/entities/user_fcm_token_entity.dart';

class UserFcmTokenModel extends UserFcmTokenEntity {
  UserFcmTokenModel({
    required String id,
    required String userId,
    required String fcmToken,
    required DateTime createdAt,
  }) : super(id: id, userId: userId, fcmToken: fcmToken, createdAt: createdAt);

  /// Converte JSON para um objeto `UserFcmTokenModel`
  factory UserFcmTokenModel.fromJson(Map<String, dynamic> json) {
    return UserFcmTokenModel(
      id: json['id'],
      userId: json['user_id'],
      fcmToken: json['fcm_token'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  /// Converte `UserFcmTokenModel` para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'fcm_token': fcmToken,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Converte `UserFcmTokenModel` para uma entidade `UserFcmTokenEntity`
  UserFcmTokenEntity toEntity() {
    return UserFcmTokenEntity(
      id: id,
      userId: userId,
      fcmToken: fcmToken,
      createdAt: createdAt,
    );
  }
}
