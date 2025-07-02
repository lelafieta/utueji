import '../../../../core/entities/no_params.dart';
import '../../../../core/usecases/stream_usecase.dart';
import '../entities/blog_entity.dart';
import '../repositories/i_blog_repository.dart';

class FetchBlogUseCase extends StreamUseCase<List<BlogEntity>, NoParams> {
  final IBlogRepository repository;

  FetchBlogUseCase({required this.repository});

  @override
  Stream<List<BlogEntity>> call(NoParams params) {
    return repository.fetchBlogs();
  }
}
