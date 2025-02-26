import '../../../auth/data/models/user_model.dart';
import '../../../ongs/data/models/ong_model.dart';
import '../../domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  EventModel(
      {super.id,
      super.createdAt,
      super.updatedAt,
      super.ongId,
      super.userId,
      super.title,
      super.location,
      super.description,
      super.backgroundImageUrl,
      super.startDate,
      super.endDate,
      super.ong,
      super.user});

  // Factory para criar uma instância de EventModel a partir de um Map
  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      ongId: map['ong_id'],
      userId: map['user_id'],
      title: map['title'],
      location: map['location'],
      description: map['description'],
      backgroundImageUrl: map['background_image_url'],
      startDate: DateTime.parse(map['start_date']),
      endDate: DateTime.parse(map['end_date']),
      ong: (map['ong'] != null) ? OngModel.fromMap(map['ong']) : null,
      user: (map['user'] != null) ? UserModel.fromJson(map['user']) : null,
    );
  }

  // Método para converter o objeto EventModel para um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ong_id': ongId,
      'user_id': userId,
      'title': title,
      'location': location,
      'description': description,
      'background_image_url': backgroundImageUrl,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
