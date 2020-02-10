import 'package:hive/hive.dart';
import 'package:provider_start/core/constant/local_storage_keys.dart';
import 'package:provider_start/core/exceptions/cache_exception.dart';
import 'package:provider_start/core/models/user/user.dart';
import 'package:provider_start/core/models/user/user_h.dart';
import 'package:provider_start/core/utils/file_helper.dart';
import 'package:provider_start/locator.dart';

abstract class UsersLocalDataSource {
  Future<void> init();

  Future<User> fetchUser(int uid);

  Future<void> cacheUser(User user);
}

class UsersLocalDataSourceImpl implements UsersLocalDataSource {
  final FileHelper _fileHelper = locator<FileHelper>();

  Box<UserH> usersBox;

  @override
  Future<void> init() async {
    final path = await _fileHelper.getApplicationDocumentsDirectoryPath();
    Hive.init(path);
    Hive.registerAdapter(UserHAdapter());

    if (!Hive.isBoxOpen(LocalStorageKeys.users)) {
      usersBox = await Hive.openBox<UserH>(LocalStorageKeys.users);
    }
  }

  @override
  Future<void> cacheUser(User user) async {
    return usersBox.put(user.id, UserH.fromUser(user));
  }

  @override
  Future<User> fetchUser(int uid) async {
    final userH = usersBox.get(uid);

    if (userH == null) {
      throw CacheException('No user with $uid found in cache');
    }

    return User.fromMap(userH.toMap());
  }
}
