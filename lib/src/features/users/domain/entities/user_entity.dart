class UserEntity {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? email;
  final String? avatarUrl;
  final String? bio;
  final String? location;
  final bool? isVerified;
  final String? role;
  final int? donationQtd;
  final int? campaignQtd;
  final String? phoneNumber;

  UserEntity({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.avatarUrl,
    this.bio,
    this.location,
    this.isVerified,
    this.role,
    this.donationQtd,
    this.campaignQtd,
    this.phoneNumber,
  });
}
