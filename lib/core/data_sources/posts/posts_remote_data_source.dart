import 'package:flutter/foundation.dart';
import 'package:provider_start/core/constant/api_routes.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/services/http/http_service.dart';
import 'package:provider_start/core/utils/logger.dart';

abstract class PostsRemoteDataSource {
  Future<List<Post>> fetchPosts();
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final HttpService httpService;

  PostsRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<List<Post>> fetchPosts() async {
    final posts = await compute(_fetchPosts, httpService);
    return posts;
  }

  static Future<List<Post>> _fetchPosts(HttpService httpService) async {
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
}
