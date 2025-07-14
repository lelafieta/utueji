import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:utueji/src/features/categories/data/dto/create_category_dto.dart';
import 'package:utueji/src/features/categories/data/dto/update_category_dto.dart';
import 'package:utueji/src/features/categories/data/models/category_model.dart';

part 'category_remote_datasource.g.dart';

@RestApi(baseUrl: "http://your-api-url.com/categories")
abstract class CategoryRemoteDataSource {
  factory CategoryRemoteDataSource(Dio dio, {String baseUrl}) =
      _CategoryRemoteDataSource;

  @POST('/')
  Future<CategoryModel> createCategory(
    @Body() CreateCategoryDto createCategoryDto,
  );

  @GET('/')
  Future<List<CategoryModel>> getAllCategories();

  @GET('/{id}')
  Future<CategoryModel> getCategoryById(@Path('id') int id);

  @PATCH('/{id}')
  Future<CategoryModel> updateCategory(
    @Path('id') int id,
    @Body() UpdateCategoryDto updateCategoryDto,
  );

  @DELETE('/{id}')
  Future<void> deleteCategory(@Path('id') int id);
}
