class OngDocumentEntity {
  final String? id;
  final String? userId;
  final String? ongId;
  final String? statutesConstitutiveAct;
  final String? declarationGoodStanding;
  final String? minutesConstitutiveAssembly;
  final String? publicDeed;
  final String? registrationCertificate;
  final String? nif;
  final String? biRepresentative;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const OngDocumentEntity({
    this.id,
    this.userId,
    this.ongId,
    this.statutesConstitutiveAct,
    this.declarationGoodStanding,
    this.minutesConstitutiveAssembly,
    this.publicDeed,
    this.registrationCertificate,
    this.nif,
    this.biRepresentative,
    this.status,
    this.createdAt,
    this.updatedAt,
  });
}
