import '../../domain/entities/blog_entity.dart';

abstract class BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<BlogEntity> blogs;

  BlogLoaded({required this.blogs});
}

class BlogFailure extends BlogState {
  final String failure;

  BlogFailure({required this.failure});
}
