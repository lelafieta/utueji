import '../entities/blog_entity.dart';

abstract class IBlogRepository {
  Stream<List<BlogEntity>> fetchBlogs();
  Stream<List<BlogEntity>> fetchLatestBlogs();
}
