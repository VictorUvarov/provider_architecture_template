import 'package:provider_start/core/constant/api_routes.dart';
import 'package:provider_start/core/repositories/users_repository/users_repository.dart';
import 'package:provider_start/core/serializers/user.dart';
import 'package:provider_start/core/services/http/http_service.dart';
import 'package:provider_start/locator.dart';

class UsersRepositoryImpl implements UsersRepository {
  final _httpService = locator<HttpService>();

  @override
  Future<User> fetchUser(int userId) async {
    final postsJsonData = await _httpService
        .getHttp('${ApiRoutes.users}/$userId') as Map<String, dynamic>;

    return User.fromMap(postsJsonData);
  }
}
