import 'package:hive/hive.dart';

import 'package:provider_start/locator.dart';
import 'package:provider_start/core/constant/local_storage_keys.dart';
import 'package:provider_start/core/exceptions/cache_exception.dart';
import 'package:provider_start/core/models/user/user.dart';
import 'package:provider_start/core/models/user/user_h.dart';
import 'package:provider_start/core/utils/file_helper.dart';

abstract class UsersLocalDataSource {
  Future<void> init();

  Future<User> fetchUser(int uid);

  Future<void> cacheUser(User user);
}

class UsersLocalDataSourceImpl implements UsersLocalDataSource {
  final _fileHelper = locator<FileHelper>();
  final _hiveService = locator<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(LocalStorageKeys.users);
  Box<UserH> get _usersBox => _hiveService.box<UserH>(LocalStorageKeys.users);

  @override
  Future<void> init() async {
    final path = await _fileHelper.getApplicationDocumentsDirectoryPath();
    _hiveService.init(path);
    _hiveService.registerAdapter<UserH>(UserHAdapter());

    if (!_isBoxOpen) {
      await _hiveService.openBox<UserH>(LocalStorageKeys.users);
    }
  }

  @override
  Future<void> cacheUser(User user) async {
    return _usersBox.put(user.id, UserH.fromUser(user));
  }

  @override
  Future<User> fetchUser(int uid) async {
    final userH = _usersBox.get(uid);

    if (userH == null) {
      throw CacheException('No user with $uid found in cache');
    }

    return User.fromMap(userH.toMap());
  }
}
