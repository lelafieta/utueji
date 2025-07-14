import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:utueji/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:utueji/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:utueji/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:utueji/src/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:utueji/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:utueji/src/features/auth/domain/usecases/register_usecase.dart';
import 'package:utueji/src/features/auth/presentation/bloc/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> initAuthDependencies() async {
  // Cubit
  sl.registerFactory(() => AuthCubit(
        registerUseCase: sl(),
        loginUseCase: sl(),
        getProfileUseCase: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl()));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(sl()));

  // External
  sl.registerLazySingleton(() => Dio());
}