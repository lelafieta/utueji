import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:utueji/src/features/auth/data/datasources/auth_datasource.dart';
import 'package:utueji/src/features/auth/data/datasources/i_auth_datasource.dart';

import '../features/auth/data/repositories/auth_repository.dart';
import '../features/auth/domain/repositories/i_auth_repository.dart';
import '../features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import '../features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import '../features/auth/domain/usecases/sign_in_with_phone_usecase.dart';
import '../features/auth/domain/usecases/sign_out_usecase.dart';
import '../features/auth/domain/usecases/sign_up_with_email_usecase.dart';
import '../features/auth/domain/usecases/verify_phone_usecase.dart';
import '../features/auth/presentation/cubit/auth_cubit.dart';

GetIt instance = GetIt.instance;

Future init() async {
  _setUpExternal();
  _setUpCubits();
  _setUpUsecases();
  _setUpRepositories();
  _setUpDatasources();

  // Repositories
}

void _setUpDatasources() {
  instance.registerLazySingleton<IAuthDataSource>(
      () => AuthDataSource(auth: instance(), googleSignIn: instance()));
}

void _setUpRepositories() {
  instance.registerLazySingleton<IAuthRepository>(
      () => AuthRespository(authDataSource: instance()));
}

void _setUpUsecases() {
  instance.registerLazySingleton<SignInWithEmailUseCase>(
      () => SignInWithEmailUseCase(repository: instance()));
  instance.registerLazySingleton<SignUpWithEmailUseCase>(
      () => SignUpWithEmailUseCase(repository: instance()));
  instance.registerLazySingleton<SignInWithGoogleUseCase>(
      () => SignInWithGoogleUseCase(repository: instance()));
  instance.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: instance()));
  instance.registerLazySingleton<VerifyPhoneUseCase>(
      () => VerifyPhoneUseCase(repository: instance()));
  instance.registerLazySingleton<SignInWithPhoneUseCase>(
      () => SignInWithPhoneUseCase(repository: instance()));
}

void _setUpCubits() {
  instance.registerFactory(() => AuthCubit(
      signInWithEmailUseCase: instance(),
      signUpWithEmailUseCase: instance(),
      signInWithGoogleUseCase: instance(),
      signOutUseCase: instance(),
      verifyPhoneUseCase: instance(),
      signInWithPhoneUseCase: instance()));
}

void _setUpExternal() {
  instance.registerFactory(() => FirebaseFirestore.instance);
  instance.registerFactory(() => GoogleSignIn());
  instance.registerFactory(() => FirebaseAuth.instance);
  instance.registerFactory(() => FirebaseStorage.instance);
}
