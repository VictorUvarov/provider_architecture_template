import 'package:provider_start/core/serializers/post.dart';
import 'package:provider_start/core/serializers/user.dart';

abstract class ApiService {
  Future<void> init();

  Future<List<Post>> fetchPosts();

  Future<User> fetchUser(int userId);

  Future<void> samplePost();
}
