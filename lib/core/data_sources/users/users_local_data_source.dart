import 'package:provider_start/core/exceptions/cache_exception.dart';
import 'package:provider_start/core/models/user/user.dart';
import 'package:provider_start/core/models/user/user_h.dart';
import 'package:provider_start/core/services/local_storage/local_storage_service.dart';
import 'package:provider_start/locator.dart';

abstract class UsersLocalDataSource {
  User fetchUser(int uid);

  Future<void> cacheUser(User user);
}

class UsersLocalDataSourceImpl implements UsersLocalDataSource {
  final localStorageService = locator<LocalStorageService>();

  @override
  Future<void> cacheUser(User user) {
    return localStorageService.usersBox.put(user.id, UserH.fromUser(user));
  }

  @override
  User fetchUser(int uid) {
    final userH = localStorageService.usersBox.get(uid);

    if (userH == null) {
      throw CacheException('No user with $uid found in cache');
    }

    return User.fromMap(userH.toMap());
  }
}
