import 'package:provider_start/core/serializers/post.dart';

abstract class PostsRepository {
  Future<List<Post>> fetchPosts();
}
