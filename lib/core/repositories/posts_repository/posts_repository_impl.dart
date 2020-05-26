import 'dart:async';

import 'package:provider_start/locator.dart';
import 'package:provider_start/core/data_sources/posts/posts_local_data_source.dart';
import 'package:provider_start/core/data_sources/posts/posts_remote_data_source.dart';
import 'package:provider_start/core/exceptions/cache_exception.dart';
import 'package:provider_start/core/exceptions/network_exception.dart';
import 'package:provider_start/core/exceptions/repository_exception.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/services/connectivity/connectivity_service.dart';
import 'package:provider_start/core/utils/logger.dart';
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
