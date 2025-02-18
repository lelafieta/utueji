import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:utueji/src/features/events/domain/usecases/fetch_latest_events_usecase.dart';
import '../features/auth/data/datasources/auth_datasource.dart';
import '../features/auth/data/datasources/i_auth_datasource.dart';
import '../features/auth/data/repositories/auth_repository.dart';
import '../features/auth/domain/repositories/i_auth_repository.dart';
import '../features/auth/domain/usecases/is_sign_in_usecase.dart';
import '../features/auth/domain/usecases/sign_in_usecase.dart';
import '../features/auth/domain/usecases/sign_out_usecase.dart';
import '../features/auth/domain/usecases/sign_up_usecase.dart';
import '../features/auth/presentation/cubit/auth_cubit.dart';
import '../features/auth/presentation/cubit/initial_cubit/initial_cubit.dart';
import '../features/campaigns/data/datasources/i_campaign_datasource.dart';
import '../features/campaigns/data/datasources/campaign_datasource.dart';
import '../features/campaigns/data/repositories/campaign_repository.dart';
import '../features/campaigns/domain/repositories/i_campaign_repository.dart';
import '../features/campaigns/domain/usecases/get_campaigns_usecases.dart';
import '../features/campaigns/domain/usecases/get_latest_campaigns_usecases.dart';
import '../features/campaigns/presentation/cubit/campaign_cubit.dart';
import '../features/events/data/datasources/event_datasource.dart';
import '../features/events/data/datasources/i_event_datasource.dart';
import '../features/events/data/repositories/event_repository.dart';
import '../features/events/domain/repositories/i_event_repository.dart';
import '../features/events/presentation/cubit/event_cubit.dart';

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
      () => AuthDataSource(supabase: instance()));
  instance.registerLazySingleton<ICampaignRemoteDataSource>(
      () => CampaignRemoteDataSource(supabase: instance()));
  instance.registerLazySingleton<IEventDataSource>(
      () => EventDataSource(supabase: instance()));
}

void _setUpRepositories() {
  instance.registerLazySingleton<IAuthRepository>(
      () => AuthRespository(authDataSource: instance()));
  instance.registerLazySingleton<ICampaignRepository>(
      () => CampaignRepository(repository: instance()));
  instance.registerLazySingleton<IEventRepository>(
      () => EventRepository(repository: instance()));
}

void _setUpUsecases() {
  instance.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: instance()));
  instance.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: instance()));
  instance.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: instance()));
  instance.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: instance()));
  instance.registerLazySingleton<GetCampaignsUseCase>(
      () => GetCampaignsUseCase(repository: instance()));
  instance.registerLazySingleton<GetLatestCampaignsUseCase>(
      () => GetLatestCampaignsUseCase(repository: instance()));
  instance.registerLazySingleton<FetchLatestEventsUsecase>(
      () => FetchLatestEventsUsecase(repository: instance()));
}

void _setUpCubits() {
  instance.registerFactory(() => AuthCubit(
        signInUseCase: instance(),
        signUpUseCase: instance(),
        signOutUseCase: instance(),
      ));
  instance.registerFactory(() => InitialCubit(isSignInUseCase: instance()));
  instance.registerFactory(() => CampaignCubit(
      getCampaignsUseCase: instance(), getLatestCampaignsUseCase: instance()));
  instance
      .registerFactory(() => EventCubit(fetchLatestEventsUsecase: instance()));
}

void _setUpExternal() {
  instance.registerFactory(() => Supabase.instance.client);
  instance.registerFactory(() => FirebaseFirestore.instance);
  instance.registerFactory(() => GoogleSignIn());
  instance.registerFactory(() => FirebaseAuth.instance);
  instance.registerFactory(() => FirebaseStorage.instance);
}
