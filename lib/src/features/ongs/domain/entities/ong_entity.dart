class OngEntity {
  final String? id;
  final DateTime? createdAt;
  final String? about;
  final String? bio;
  final String? coverImageUrl;
  final bool isVerified;
  final String? mission;
  final String? name;
  final String? status;
  final String? phoneNumber;
  final String? profileImageUrl;
  final int? servicesNumber;
  final double? supportsNumber;
  final String? userId;
  final String? vision;
  final DateTime? updatedAt;

  OngEntity({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.about,
    this.bio,
    this.coverImageUrl,
    this.status,
    this.isVerified = false,
    this.mission,
    this.name,
    this.phoneNumber,
    this.profileImageUrl,
    this.servicesNumber,
    this.supportsNumber,
    this.userId,
    this.vision,
  });
}
