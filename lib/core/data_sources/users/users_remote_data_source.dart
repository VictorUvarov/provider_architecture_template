import '../../../locator.dart';
import '../../constant/api_routes.dart';
import '../../models/user/user.dart';
import '../../services/http/http_service.dart';

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
