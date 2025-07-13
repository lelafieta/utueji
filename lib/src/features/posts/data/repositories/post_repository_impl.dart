
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:utueji/src/core/either.dart';
import 'package:utueji/src/core/error/failure.dart';
import 'package:utueji/src/features/posts/data/datasources/post_api_service.dart';
import 'package:utueji/src/features/posts/domain/entities/post_entity.dart';
import 'package:utueji/src/features/posts/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostApiService _postApiService;

  PostRepositoryImpl(this._postApiService);

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts() async {
    try {
      final httpResponse = await _postApiService.getPosts();
      return Right(httpResponse);
    } on DioException catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Unknown error',
        statusCode: e.response?.statusCode,
      ));
    } on SocketException {
      return const Left(ConnectionFailure(message: 'Failed to connect to the network'));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
