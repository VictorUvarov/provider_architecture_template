import 'dart:async';

import '../../../locator.dart';
import '../../data_sources/posts/posts_local_data_source.dart';
import '../../data_sources/posts/posts_remote_data_source.dart';
import '../../exceptions/cache_exception.dart';
import '../../exceptions/network_exception.dart';
import '../../exceptions/repository_exception.dart';
import '../../models/post/post.dart';
import '../../services/connectivity/connectivity_service.dart';
import '../../utils/logger.dart';
import 'posts_repository.dart';

class PostsRepositoryImpl implements PostsRepository {
  final remoteDataSource = locator<PostsRemoteDataSource>();
  final localDataSource = locator<PostsLocalDataSource>();
  final connectivityService = locator<ConnectivityService>();

  @override
  Future<List<Post>> fetchPosts() async {
    try {
      if (await connectivityService.isConnected) {
        final posts = await remoteDataSource.fetchPosts();
        await localDataSource.cachePosts(posts);
        return posts;
      } else {
        final posts = await localDataSource.fetchPosts();
        return posts;
      }
    } on NetworkException catch (e) {
      Logger.e('Failed to fetch posts remotely');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      Logger.e('Failed to fetch posts locally');
      throw RepositoryException(e.message);
    }
  }
}
