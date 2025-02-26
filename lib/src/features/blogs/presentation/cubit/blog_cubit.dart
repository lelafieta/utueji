import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utueji/src/features/blogs/presentation/cubit/blog_state.dart';

import '../../../../core/entities/no_params.dart';
import '../../domain/entities/blog_entity.dart';
import '../../domain/usecases/fetch_blogs_usecase.dart';
import '../../domain/usecases/fetch_latest_blogs_usecase.dart';

class BlogCubit extends Cubit<BlogState> {
  final FetchBlogUseCase fetchBlogUseCase;
  final FetchLatestBlogUseCase fetchLatestBlogUseCase;

  BlogCubit(
      {required this.fetchBlogUseCase, required this.fetchLatestBlogUseCase})
      : super(BlogLoading());

  Future<void> getBlogs() async {
    final response = fetchLatestBlogUseCase.call(const NoParams());

    response.listen((event) {
      emit(BlogLoaded(blogs: event));
    });
  }

  Stream<List<BlogEntity>> getLatestBlogs() {
    final streamController = StreamController<List<BlogEntity>>();
    emit(BlogLoading());
    fetchLatestBlogUseCase.call(const NoParams()).listen((data) {
      streamController.add(data);
    }, onError: (error) {
      emit(BlogFailure(failure: error.toString()));
      streamController.addError(error);
    }, onDone: () => streamController.close());
    return streamController.stream;
  }
}
