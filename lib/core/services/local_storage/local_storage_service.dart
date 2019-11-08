import 'package:hive/hive.dart';
import 'package:provider_start/core/hive_models/post_h.dart';
import 'package:provider_start/core/hive_models/user_h.dart';

abstract class LocalStorageService {
  Future<void> init();

  Box<PostH> get postsBox;

  Box<UserH> get usersBox;
}
