import 'package:flutter/foundation.dart' show debugPrint;
import 'package:provider_start/core/constant/local_storage_keys.dart';
import 'package:provider_start/core/hive_models/post_h.dart';
import 'package:provider_start/core/hive_models/user_h.dart';
import 'package:hive/hive.dart';
import 'package:provider_start/core/services/local_storage/local_storage_service.dart';
import 'package:provider_start/core/utils/file_utils.dart' as fileUtils;

class LocalStorageServiceImpl implements LocalStorageService {
  Box<PostH> _postsBox;
  Box<PostH> get postsBox => _postsBox;

  Box<UserH> _usersBox;
  Box<UserH> get usersBox => _usersBox;

  Future<void> init() async {
    try {
      final path = await fileUtils.getApplicationDocumentsDirectoryPath();
      Hive.init(path);

      Hive.registerAdapter(UserHAdapter(), 0);
      Hive.registerAdapter(PostHAdapter(), 1);
    } on HiveError catch (e) {
      debugPrint('(WARNING) ${e.message}');
    }

    _postsBox = await Hive.openBox<PostH>(LocalStorageKeys.posts);
    _usersBox = await Hive.openBox<UserH>(LocalStorageKeys.users);
  }
}
