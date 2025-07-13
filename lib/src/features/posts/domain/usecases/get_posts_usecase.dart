
import 'package:utueji/src/core/either.dart';
import 'package:utueji/src/core/error/failure.dart';
import 'package:utueji/src/core/usecase.dart';
import 'package:utueji/src/features/posts/domain/entities/post_entity.dart';
import 'package:utueji/src/features/posts/domain/repositories/post_repository.dart';

class GetPostsUseCase implements UseCase<List<PostEntity>, void> {
  final PostRepository _postRepository;

  GetPostsUseCase(this._postRepository);

  @override
  Future<Either<Failure, List<PostEntity>>> call({void params}) {
    return _postRepository.getPosts();
  }
}
