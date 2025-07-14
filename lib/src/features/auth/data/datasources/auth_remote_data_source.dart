import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:utueji/src/features/auth/data/dto/create_auth_dto.dart';
import 'package:utueji/src/features/auth/data/dto/login_auth_dto.dart';
import 'package:utueji/src/features/auth/data/models/user_model.dart';

part 'auth_remote_data_source.g.dart';

@RestApi(baseUrl: "http://your-api-url.com/auth")
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio, {String baseUrl}) = _AuthRemoteDataSource;

  @POST('/register')
  Future<UserModel> register(@Body() CreateAuthDto createAuthDto);

  @POST('/login')
  Future<UserModel> login(@Body() LoginAuthDto loginAuthDto);

  @GET('/profile')
  Future<UserModel> getProfile();
}
