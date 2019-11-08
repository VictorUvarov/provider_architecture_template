import 'package:provider_start/core/serializers/user.dart';

abstract class UsersRepository {
  /// - throws `RepositoryException` if fetch fails
  Future<User> fetchUser(int userId);
}
