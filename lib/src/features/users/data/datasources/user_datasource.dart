import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../auth/data/models/user_model.dart';
import 'i_user_datasource.dart';

class UserDatasource extends IUserDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  UserDatasource({
    required this.firestore,
    required this.auth,
    required this.storage,
  });
  @override
  Stream<UserModel> getUserById(String id) {
    return firestore
        .collection('users')
        .doc(id)
        .snapshots()
        .map((event) => UserModel.fromJson(event as Map<String, dynamic>));
  }
}
