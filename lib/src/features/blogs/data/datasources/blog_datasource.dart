import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:utueji/src/features/blogs/data/models/blog_model.dart';

import 'i_blog_datasource.dart';

class BlogDataSource extends IBlogDataSource {
  final SupabaseClient supabase;

  BlogDataSource({required this.supabase});

  @override
  Stream<List<BlogModel>> fetchBlogs() {
    final blogs = supabase
        .from('blogs')
        .select("*, user:profiles(*), ong:ongs(*)")
        .order('created_at')
        .limit(10)
        .asStream()
        .map((data) {
      return data.map((blog) => BlogModel.fromMap(blog)).toList();
    });

    return blogs;
  }

  @override
  Stream<List<BlogModel>> fetchLatestBlogs() {
    final blogs = supabase
        .from('blogs')
        .select("*, user:profiles(*), ong:ongs(*)")
        .order('created_at')
        .limit(10)
        .asStream()
        .map((data) {
      return data.map((blog) => BlogModel.fromMap(blog)).toList();
    });

    return blogs;
  }
}
