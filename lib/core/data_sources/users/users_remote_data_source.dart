import 'package:flutter/foundation.dart';
import 'package:provider_start/core/constant/api_routes.dart';
import 'package:provider_start/core/models/user/user.dart';
import 'package:provider_start/core/services/http/http_service.dart';
import 'package:provider_start/core/services/http/http_service_impl.dart';
import 'package:provider_start/core/utils/logger.dart';

abstract class UsersRemoteDataSource {
  Future<User> fetchUser(int uid);
}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  final HttpService httpService;

  UsersRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<User> fetchUser(int uid) async {
    final user = await compute(_fetchUserRemotely, uid);
    return user;
  }

  static Future<User> _fetchUserRemotely(int userId) async {
    setupLogger();

    final httpService = HttpServiceImpl();

    try {
      final postsMap = await httpService.getHttp('${ApiRoutes.users}/$userId')
          as Map<String, dynamic>;

      final user = User.fromMap(postsMap);
      return user;
    } finally {
      httpService.dispose();
    }
  }
}
