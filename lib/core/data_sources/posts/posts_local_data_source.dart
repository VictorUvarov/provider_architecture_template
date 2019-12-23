import 'package:provider_start/core/exceptions/cache_exception.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/models/post/post_h.dart';
import 'package:provider_start/core/services/local_storage/local_storage_service.dart';
import 'package:provider_start/locator.dart';

abstract class PostsLocalDataSource {
  List<Post> fetchPosts();

  Future<void> cachePosts(List<Post> posts);
}

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  final localStorageService = locator<LocalStorageService>();

  @override
  List<Post> fetchPosts() {
    if (localStorageService.postsBox.isEmpty) {
      throw CacheException('No posts found in cache');
    }

    return localStorageService.postsBox.values
        .cast<PostH>()
        .map((postH) => Post.fromMap(postH.toMap()))
        .toList();
  }

  @override
  Future<void> cachePosts(List<Post> posts) async {
    final postsMap = <int, PostH>{};
    posts.forEach((post) => postsMap.addAll({post.id: PostH.fromPost(post)}));

    await localStorageService.postsBox.putAll(postsMap);
  }
}
