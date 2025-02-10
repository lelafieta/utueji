import '../../domain/entities/need_entity.dart';

abstract class INeedRemoteDataSource {
  Stream<List<NeedEntity>> fetchNeeds();
  Stream<NeedEntity> fetchNeedById(String id);
  Future<void> addNeed(NeedEntity need);
  Future<void> editNeed(NeedEntity need);
  Future<void> removeNeed(String id);
}
