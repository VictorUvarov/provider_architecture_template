import 'package:provider_start/core/serializers/user.dart';

abstract class UsersRepository {
  Future<User> fetchUser(int userId);
}
