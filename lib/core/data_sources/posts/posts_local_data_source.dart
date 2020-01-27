import 'package:hive/hive.dart';
import 'package:provider_start/core/constant/local_storage_keys.dart';
import 'package:provider_start/core/exceptions/cache_exception.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/models/post/post_h.dart';
import 'package:provider_start/core/utils/file_utils.dart';

abstract class PostsLocalDataSource {
  Future<void> init();

  Future<List<Post>> fetchPosts();

  Future<void> cachePosts(List<Post> posts);
}

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  Box<PostH> postsBox;

  @override
  Future<void> init() async {
    final path = await getApplicationDocumentsDirectoryPath();
    Hive.init(path);
    Hive.registerAdapter(PostHAdapter());

    if (!Hive.isBoxOpen(LocalStorageKeys.posts)) {
      postsBox = await Hive.openBox<PostH>(LocalStorageKeys.posts);
    }
  }

  @override
  Future<List<Post>> fetchPosts() async {
    if (postsBox.isEmpty) {
      throw CacheException('No posts found in cache');
    }

    return postsBox.values
        .cast<PostH>()
        .map<Post>((postH) => Post.fromMap(postH.toMap()))
        .toList();
  }

  @override
  Future<void> cachePosts(List<Post> posts) async {
    final postsMap = <int, PostH>{};
    posts.forEach((post) => postsMap.addAll({post.id: PostH.fromPost(post)}));

    await postsBox.putAll(postsMap);
  }
}
