import 'package:utueji/src/features/blogs/domain/entities/blog_entity.dart';

import '../../domain/repositories/i_blog_repository.dart';
import '../datasources/i_blog_datasource.dart';

class BlogRepository extends IBlogRepository {
  final IBlogDataSource datasource;

  BlogRepository({required this.datasource});

  @override
  Stream<List<BlogEntity>> fetchBlogs() {
    return datasource.fetchBlogs();
  }

  @override
  Stream<List<BlogEntity>> fetchLatestBlogs() {
    return datasource.fetchLatestBlogs();
  }
}
