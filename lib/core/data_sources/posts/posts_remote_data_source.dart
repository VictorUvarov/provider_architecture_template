import 'package:provider_start/locator.dart';
import 'package:provider_start/core/constant/api_routes.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/services/http/http_service.dart';

abstract class PostsRemoteDataSource {
  Future<List<Post>> fetchPosts();
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final httpService = locator<HttpService>();

  @override
  Future<List<Post>> fetchPosts() async {
    final postsJsonData =
        await httpService.getHttp(ApiRoutes.posts) as List<dynamic>;

    final List<Post> posts =
        postsJsonData.map<Post>((postMap) => Post.fromMap(postMap)).toList();

    return posts;
  }
}
