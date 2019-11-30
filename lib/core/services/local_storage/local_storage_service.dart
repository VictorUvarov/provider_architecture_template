import 'package:hive/hive.dart';
import 'package:provider_start/core/models/post/post_h.dart';
import 'package:provider_start/core/models/user/user_h.dart';

abstract class LocalStorageService {
  Future<void> init();

  Box<PostH> get postsBox;

  Box<UserH> get usersBox;
}
