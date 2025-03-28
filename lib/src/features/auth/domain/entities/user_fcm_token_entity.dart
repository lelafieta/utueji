class UserFcmTokenEntity {
  final String id;
  final String userId;
  final String fcmToken;
  final DateTime createdAt;

  UserFcmTokenEntity({
    required this.id,
    required this.userId,
    required this.fcmToken,
    required this.createdAt,
  });
}
