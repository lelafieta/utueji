
import 'package:flutter/material.dart';
import 'package:utueji/src/core/either.dart';
import 'package:utueji/src/features/posts/domain/entities/post_entity.dart';
import 'package:utueji/src/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:utueji/src/service_locator.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late final GetPostsUseCase _getPostsUseCase;
  Future<Either<dynamic, List<PostEntity>>>? _postsFuture;

  @override
  void initState() {
    super.initState();
    _getPostsUseCase = sl<GetPostsUseCase>();
    _postsFuture = _getPostsUseCase.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: FutureBuilder(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No data'));
          }

          final either = snapshot.data!;

          return either.fold(
            (failure) => Center(child: Text('Error: ${failure.message}')),
            (posts) => ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
