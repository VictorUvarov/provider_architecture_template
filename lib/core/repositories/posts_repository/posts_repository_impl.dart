import 'package:flutter/foundation.dart';
import 'package:provider_start/core/constant/api_routes.dart';
import 'package:provider_start/core/repositories/posts_repository/posts_repository.dart';
import 'package:provider_start/core/serializers/post.dart';
import 'package:provider_start/core/services/http/http_service.dart';
import 'package:provider_start/locator.dart';

class PostsRepositoryImpl implements PostsRepository {
  final _httpService = locator<HttpService>();

  @override
  Future<List<Post>> fetchPosts() {
    return compute(_fetchPosts, _httpService);
  }

  static Future<List<Post>> _fetchPosts(HttpService httpService) async {
    final postsJsonData =
        await httpService.getHttp(ApiRoutes.posts) as List<dynamic>;

    final posts = postsJsonData
        .map((data) => data as Map<String, dynamic>)
        .map(Post.fromMap)
        .toList();

    return posts;
  }
}
