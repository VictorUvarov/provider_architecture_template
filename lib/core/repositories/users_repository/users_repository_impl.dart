import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider_start/core/constant/api_routes.dart';
import 'package:provider_start/core/constant/repository_exception_messages.dart';
import 'package:provider_start/core/exceptions/network_exception.dart';
import 'package:provider_start/core/exceptions/repository_exception.dart';
import 'package:provider_start/core/models/user/user.dart';
import 'package:provider_start/core/models/user/user_h.dart';
import 'package:provider_start/core/repositories/users_repository/users_repository.dart';
import 'package:provider_start/core/services/connectivity/connectivity_service.dart';
import 'package:provider_start/core/services/http/http_service_impl.dart';
import 'package:provider_start/core/services/local_storage/local_storage_service.dart';
import 'package:provider_start/core/utils/logger.dart';
import 'package:provider_start/locator.dart';

class UsersRepositoryImpl implements UsersRepository {
  final _localStorageService = locator<LocalStorageService>();
  final _connectionService = locator<ConnectivityService>();

  @override
  Future<User> fetchUser(int userId) async {
    try {
      if (await _connectionService.isConnected()) {
        final user = await compute(_fetchUserRemotely, userId);
        unawaited(_storeUserLocally(user));
        return user;
      } else {
        return _fetchUserLocally(userId);
      }
    } on NetworkException catch (e) {
      Logger.e(e.message, e: e, s: e.stackTrace);
      throw RepositoryException(RepositoryExceptionMessages.general_user);
    } on RepositoryException catch (e) {
      Logger.w(e.message);
      throw RepositoryException(e.message);
    }
  }

  static Future<User> _fetchUserRemotely(int userId) async {
    final httpService = HttpServiceImpl();
    setupLogger();

    try {
      final postsMap = await httpService.getHttp('${ApiRoutes.users}/$userId')
          as Map<String, dynamic>;

      final user = User.fromMap(postsMap);
      return user;
    } finally {
      httpService.dispose();
    }
  }

  Future<void> _storeUserLocally(User user) async {
    await _localStorageService.usersBox.put(user.id, UserH.fromUser(user));
  }

  User _fetchUserLocally(int userId) {
    final userH = _localStorageService.usersBox.get(userId);
    if (userH == null) {
      throw RepositoryException(RepositoryExceptionMessages.user_local);
    }

    return User.fromMap(userH.toMap());
  }
}
