import '../models/blog_model.dart';

abstract class IBlogDataSource {
  Stream<List<BlogModel>> fetchBlogs();
  Stream<List<BlogModel>> fetchLatestBlogs();
}
