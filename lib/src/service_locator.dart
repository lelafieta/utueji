import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:utueji/src/core/api/dio_client.dart';
import 'package:utueji/src/features/posts/data/datasources/post_api_service.dart';
import 'package:utueji/src/features/posts/data/repositories/post_repository_impl.dart';
import 'package:utueji/src/features/posts/domain/repositories/post_repository.dart';
import 'package:utueji/src/features/posts/domain/usecases/get_posts_usecase.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Dio
  sl.registerSingleton<Dio>(createDio());

  // API Service
  sl.registerSingleton<PostApiService>(PostApiService(sl()));

  // Repository
  sl.registerSingleton<PostRepository>(PostRepositoryImpl(sl()));

  // UseCase
  sl.registerSingleton<GetPostsUseCase>(GetPostsUseCase(sl()));
}
