import '../entities/blog_entity.dart';
import '../repositories/i_blog_repository.dart';

class FetchLatestBlogUseCase {
  final IBlogRepository repository;

  FetchLatestBlogUseCase({required this.repository});

  Stream<List<BlogEntity>> call() {
    return repository.fetchLatestBlogs();
  }
}
