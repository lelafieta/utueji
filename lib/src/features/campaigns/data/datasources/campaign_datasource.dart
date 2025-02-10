import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/firebase/firebase_consts.dart';
import '../../../users/data/models/user_profile_model.dart';
import '../../domain/entities/campaign_entity.dart';
import '../models/campaign_model.dart';
import 'i_campaign_datasource.dart';

class CampaignRemoteDataSource extends ICampaignRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  CampaignRemoteDataSource({
    required this.firestore,
    required this.auth,
    required this.storage,
  });

  @override
  Future<void> addCampaign(CampaignEntity campaign) {
    // TODO: implement addCampaign
    throw UnimplementedError();
  }

  @override
  Future<void> editCampaign(CampaignEntity need) {
    // TODO: implement editNeed
    throw UnimplementedError();
  }

  @override
  Stream<CampaignEntity> fetchCampaignById(String id) {
    // TODO: implement fetchNeedById
    throw UnimplementedError();
  }

  @override
  Stream<List<CampaignEntity>> fetchCampaigns() {
    return firestore
        .collection(FirebaseConsts.campaignsCollection)
        .snapshots()
        .asyncMap((snapshot) async {
      List<CampaignEntity> needs = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic>? needData = doc.data() as Map<String, dynamic>?;
        CampaignModel need = CampaignModel.fromJson(needData!);
        DocumentSnapshot userDoc = await firestore
            .collection(FirebaseConsts.profilesCollection)
            .doc(need.userId)
            .get();
        Map<String, dynamic>? userMap = userDoc.data() as Map<String, dynamic>?;
        need = need.copyWith(user: UserProfileModel.fromJson(userMap!));
        needs.add(need);
      }

      return needs;
    });
  }

  @override
  Future<void> removeCampaign(String id) {
    throw UnimplementedError();
  }

  @override
  Stream<List<CampaignEntity>> fetchLatestCampaigns() {
    return firestore
        .collection(FirebaseConsts.campaignsCollection)
        .snapshots()
        .asyncMap((snapshot) async {
      List<CampaignEntity> needs = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic>? needData = doc.data() as Map<String, dynamic>?;
        CampaignModel need = CampaignModel.fromJson(needData!);
        DocumentSnapshot userDoc = await firestore
            .collection(FirebaseConsts.profilesCollection)
            .doc(need.userId)
            .get();
        Map<String, dynamic>? userMap = userDoc.data() as Map<String, dynamic>?;

        need = need.copyWith(user: UserProfileModel.fromJson(userMap!));
        needs.add(need);
      }

      return needs;
    });
  }
}
