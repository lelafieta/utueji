import '../entities/blog_entity.dart';
import '../repositories/i_blog_repository.dart';

class FetchBlogUseCase {
  final IBlogRepository repository;

  FetchBlogUseCase({required this.repository});

  Stream<List<BlogEntity>> call() {
    return repository.fetchBlogs();
  }
}
