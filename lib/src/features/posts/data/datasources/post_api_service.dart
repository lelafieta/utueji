
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/post_model.dart';

part 'post_api_service.g.dart';

@RestApi()
abstract class PostApiService {
  factory PostApiService(Dio dio, {String baseUrl}) = _PostApiService;

  @GET('/posts')
  Future<List<PostModel>> getPosts();
}
