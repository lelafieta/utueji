// Repository Interface
import '../entities/need_entity.dart';

abstract class INeedRepository {
  Stream<List<NeedEntity>> getNeeds();
  Stream<NeedEntity> getNeedById(String id);
  Future<void> createNeed(NeedEntity need);
  Future<void> updateNeed(NeedEntity need);
  Future<void> deleteNeed(String id);
}
