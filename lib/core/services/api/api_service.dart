import 'package:provider_start/core/serializers/post.dart';

abstract class ApiService {
  Future<void> init();

  Future<List<Post>> fetchPosts();

  Future<void> samplePost();
}
