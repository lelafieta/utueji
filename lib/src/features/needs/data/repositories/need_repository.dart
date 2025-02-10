import '../../domain/entities/need_entity.dart';
import '../../domain/repositories/i_need_repository.dart';
import '../datasources/i_need_datasource.dart';

class NeedRepository implements INeedRepository {
  final INeedRemoteDataSource needDataSource;

  NeedRepository({required this.needDataSource});

  @override
  Stream<List<NeedEntity>> getNeeds() {
    return needDataSource.fetchNeeds();
  }

  @override
  Stream<NeedEntity> getNeedById(String id) {
    return needDataSource.fetchNeedById(id);
  }

  @override
  Future<void> createNeed(NeedEntity need) async {
    await needDataSource.addNeed(need);
  }

  @override
  Future<void> updateNeed(NeedEntity need) async {
    await needDataSource.editNeed(need);
  }

  @override
  Future<void> deleteNeed(String id) async {
    await needDataSource.removeNeed(id);
  }
}
