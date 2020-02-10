import 'package:provider_start/core/constant/api_routes.dart';
import 'package:provider_start/core/models/user/user.dart';
import 'package:provider_start/core/services/http/http_service.dart';
import 'package:provider_start/locator.dart';

abstract class UsersRemoteDataSource {
  Future<User> fetchUser(int uid);
}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  final httpService = locator<HttpService>();

  @override
  Future<User> fetchUser(int uid) async {
    final postsMap = await httpService.getHttp('${ApiRoutes.users}/$uid')
        as Map<String, dynamic>;

    return User.fromMap(postsMap);
  }
}
