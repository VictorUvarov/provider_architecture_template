import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider_start/core/constant/api_routes.dart';
import 'package:provider_start/core/constant/repository_exception_messages.dart';
import 'package:provider_start/core/exceptions/network_exception.dart';
import 'package:provider_start/core/exceptions/repository_exception.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/models/post/post_h.dart';
import 'package:provider_start/core/repositories/posts_repository/posts_repository.dart';
import 'package:provider_start/core/services/connectivity/connectivity_service.dart';
import 'package:provider_start/core/services/http/http_service_impl.dart';
import 'package:provider_start/core/services/local_storage/local_storage_service.dart';
import 'package:provider_start/core/utils/logger.dart';
import 'package:provider_start/locator.dart';

class PostsRepositoryImpl implements PostsRepository {
  final _localStorageService = locator<LocalStorageService>();
  final _connectionService = locator<ConnectivityService>();

  @override
  Future<List<Post>> fetchPosts() async {
    try {
      if (await _connectionService.isConnected()) {
        Logger.d('PostsRepository: Fetching posts Remotely');
        final posts = await compute(_fetchPostsRemotely, null);
        unawaited(_storePostsLocally(posts));
        return posts;
      } else {
        Logger.d('PostsRepository: Fetching posts locally');
        final posts = _fetchPostsLocally();
        return posts;
      }
    } on NetworkException catch (e) {
      Logger.e('PostsRepository: ${e.message}', e: e, s: e.stackTrace);
      throw RepositoryException(
        RepositoryExceptionMessages.general_posts,
        stackTrace: e.stackTrace,
      );
    }
  }

  static Future<List<Post>> _fetchPostsRemotely(_) async {
    final HttpServiceImpl httpService = HttpServiceImpl();
    setupLogger();

    try {
      final postsJsonData =
          await httpService.getHttp(ApiRoutes.posts) as List<dynamic>;

      final posts = postsJsonData
          .map((data) => data as Map<String, dynamic>)
          .map(Post.fromMap)
          .toList();

      return posts;
    } finally {
      httpService.dispose();
    }
  }

  List<Post> _fetchPostsLocally() {
    if (_localStorageService.postsBox.isEmpty) {
      throw RepositoryException(RepositoryExceptionMessages.posts_local);
    }

    return _localStorageService.postsBox.values
        .cast<PostH>()
        .map((postH) => Post.fromMap(postH.toMap()))
        .toList();
  }

  Future<void> _storePostsLocally(List<Post> posts) async {
    final postsMap = <int, PostH>{};
    posts.forEach((post) => postsMap.addAll({post.id: PostH.fromPost(post)}));

    await _localStorageService.postsBox.putAll(postsMap);
  }
}
