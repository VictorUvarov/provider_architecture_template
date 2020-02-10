import 'package:hive/hive.dart';
import 'package:provider_start/core/constant/local_storage_keys.dart';
import 'package:provider_start/core/exceptions/cache_exception.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/models/post/post_h.dart';
import 'package:provider_start/core/utils/file_helper.dart';
import 'package:provider_start/locator.dart';

abstract class PostsLocalDataSource {
  Future<void> init();

  Future<List<Post>> fetchPosts();

  Future<void> cachePosts(List<Post> posts);
}

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  final _fileHelper = locator<FileHelper>();
  final _hiveService = locator<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(LocalStorageKeys.posts);
  Box<PostH> get _postsBox => _hiveService.box<PostH>(LocalStorageKeys.posts);

  @override
  Future<void> init() async {
    final path = await _fileHelper.getApplicationDocumentsDirectoryPath();
    _hiveService.init(path);
    _hiveService.registerAdapter<PostH>(PostHAdapter());

    if (!_isBoxOpen) {
      await _hiveService.openBox<PostH>(LocalStorageKeys.posts);
    }
  }

  @override
  Future<List<Post>> fetchPosts() async {
    if (_postsBox.isEmpty) {
      throw CacheException('No posts found in cache');
    }

    return _postsBox.values
        .map<Post>((postH) => Post.fromMap(postH.toMap()))
        .toList();
  }

  @override
  Future<void> cachePosts(List<Post> posts) async {
    final postsMap = <int, PostH>{};
    posts.forEach((post) => postsMap.addAll({post.id: PostH.fromPost(post)}));

    await _postsBox.putAll(postsMap);
  }
}
