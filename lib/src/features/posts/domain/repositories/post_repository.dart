
import 'package:utueji/src/core/either.dart';
import 'package:utueji/src/core/error/failure.dart';
import '../entities/post_entity.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostEntity>>> getPosts();
}
