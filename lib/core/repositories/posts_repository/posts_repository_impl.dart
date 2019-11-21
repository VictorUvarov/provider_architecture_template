import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider_start/core/constant/api_routes.dart';
import 'package:provider_start/core/constant/repository_exception_messages.dart';
import 'package:provider_start/core/exceptions/network_exception.dart';
import 'package:provider_start/core/exceptions/repository_exception.dart';
import 'package:provider_start/core/hive_models/post_h.dart';
import 'package:provider_start/core/repositories/posts_repository/posts_repository.dart';
import 'package:provider_start/core/serializers/post.dart';
import 'package:provider_start/core/services/connectivity/connectivity_service.dart';
import 'package:provider_start/core/services/http/http_service_impl.dart';
import 'package:provider_start/core/services/local_storage/local_storage_service.dart';
import 'package:provider_start/locator.dart';

class PostsRepositoryImpl implements PostsRepository {
  final _localStorageService = locator<LocalStorageService>();
  final _connectionService = locator<ConnectivityService>();

  @override
  Future<List<Post>> fetchPosts() async {
    try {
      if (await _connectionService.isConnected()) {
        final posts = await compute(_fetchPostsRemotely, null);
        unawaited(_storePostsLocally(posts));
        return posts;
      } else {
        final posts = _fetchPostsLocally();
        return posts;
      }
    } on NetworkException {
      throw RepositoryException(RepositoryExceptionMessages.general_posts);
    }
  }

  static Future<List<Post>> _fetchPostsRemotely(_) async {
    final HttpServiceImpl httpService = HttpServiceImpl();

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
