import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:utueji/src/core/api/dio_client.dart';
import 'package:utueji/src/core/network/i_network_info.dart';
import 'package:utueji/src/core/network/network_info.dart';
import 'package:utueji/src/features/categories/data/datasources/category_remote_datasource.dart';
import 'package:utueji/src/features/categories/data/repositories/category_repository.dart';
import 'package:utueji/src/features/categories/domain/repositories/i_category_repository.dart';
import 'package:utueji/src/features/categories/domain/usecases/create_category_usecase.dart';
import 'package:utueji/src/features/categories/domain/usecases/delete_category_usecase.dart';
import 'package:utueji/src/features/categories/domain/usecases/get_all_categories_usecase.dart';
import 'package:utueji/src/features/categories/domain/usecases/get_category_by_id_usecase.dart';
import 'package:utueji/src/features/categories/domain/usecases/update_category_usecase.dart';
import 'package:utueji/src/features/categories/presentation/cubit/categories/categories_cubit.dart';
import 'package:utueji/src/features/categories/presentation/cubit/categories_data/categories_data_cubit.dart';
import 'package:utueji/src/features/posts/data/datasources/post_api_service.dart';
import 'package:utueji/src/features/posts/data/repositories/post_repository_impl.dart';
import 'package:utueji/src/features/posts/domain/repositories/post_repository.dart';
import 'package:utueji/src/features/posts/domain/usecases/get_posts_usecase.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Core
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());
  sl.registerLazySingleton<INetWorkInfo>(() => NetWorkInfo(netWorkInfo: sl()));
  sl.registerSingleton<Dio>(createDio());

  // Features - Categories
  // Data Source
  sl.registerLazySingleton<ICategoryRemoteDataSource>(() => ICategoryRemoteDataSource(sl()));

  // Repository
  sl.registerLazySingleton<ICategoryRepository>(() => CategoryRepository(remoteDataSource: sl(), networkInfo: sl()));

  // Use Cases
  sl.registerLazySingleton<CreateCategoryUseCase>(() => CreateCategoryUseCase(sl()));
  sl.registerLazySingleton<GetAllCategoriesUseCase>(() => GetAllCategoriesUseCase(sl()));
  sl.registerLazySingleton<GetCategoryByIdUseCase>(() => GetCategoryByIdUseCase(sl()));
  sl.registerLazySingleton<UpdateCategoryUseCase>(() => UpdateCategoryUseCase(sl()));
  sl.registerLazySingleton<DeleteCategoryUseCase>(() => DeleteCategoryUseCase(sl()));

  // Cubits
  sl.registerFactory(() => CategoriesCubit(
        createCategoryUseCase: sl(),
        getAllCategoriesUseCase: sl(),
        getCategoryByIdUseCase: sl(),
        updateCategoryUseCase: sl(),
        deleteCategoryUseCase: sl(),
      ));
  sl.registerFactory(() => CategoriesDataCubit(getCategoryByIdUseCase: sl()));

  // Features - Posts (existing)
  // API Service
  sl.registerSingleton<PostApiService>(PostApiService(sl()));

  // Repository
  sl.registerSingleton<PostRepository>(PostRepositoryImpl(sl()));

  // UseCase
  sl.registerSingleton<GetPostsUseCase>(GetPostsUseCase(sl()));
}
