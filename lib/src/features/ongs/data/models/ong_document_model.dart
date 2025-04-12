import '../../domain/entities/ong_document_entity.dart';

class OngDocumentModel extends OngDocumentEntity {
  const OngDocumentModel({
    super.id,
    super.userId,
    super.ongId,
    super.statutesConstitutiveAct,
    super.declarationGoodStanding,
    super.minutesConstitutiveAssembly,
    super.publicDeed,
    super.registrationCertificate,
    super.nif,
    super.biRepresentative,
    super.status,
    super.createdAt,
    super.updatedAt,
  });

  factory OngDocumentModel.fromMap(Map<String, dynamic> map) {
    return OngDocumentModel(
      id: map['id'],
      userId: map['user_id'],
      ongId: map['ong_id'],
      statutesConstitutiveAct: map['statutes_constitutive_act'],
      declarationGoodStanding: map['declaration_good_standing'],
      minutesConstitutiveAssembly: map['minutes_constitutive_assembly'],
      publicDeed: map['public_deed'],
      registrationCertificate: map['registration_certificate'],
      nif: map['nif'],
      biRepresentative: map['bi_representative'],
      status: map['status'] ?? 'pending',
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'ong_id': ongId,
      'statutes_constitutive_act': statutesConstitutiveAct,
      'declaration_good_standing': declarationGoodStanding,
      'minutes_constitutive_assembly': minutesConstitutiveAssembly,
      'public_deed': publicDeed,
      'registration_certificate': registrationCertificate,
      'tin': nif,
      'bi_representative': biRepresentative,
      'status': status,
      'created_at': createdAt!.toIso8601String(),
      'updated_at': updatedAt!.toIso8601String(),
    };
  }
}
