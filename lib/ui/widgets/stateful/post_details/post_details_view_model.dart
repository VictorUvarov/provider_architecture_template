import 'package:logging/logging.dart';
import 'package:provider_start/core/exceptions/repository_exception.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/models/user/user.dart';
import 'package:provider_start/core/repositories/users_repository/users_repository.dart';
import 'package:provider_start/locator.dart';
import 'package:stacked/stacked.dart';

class PostDetailsViewModel extends BaseViewModel {
  final _usersRepository = locator<UsersRepository>();
  final _log = Logger('HomeViewModel');

  User _user;
  User get user => _user;

  bool _errorFetchingUser = false;
  bool get errorFetchingUser => _errorFetchingUser;

  Future<void> init(Post post) async {
    setBusy(true);
    try {
      _user = await _usersRepository.fetchUser(post.userId);
    } on RepositoryException catch (e) {
      _log.shout(e.message);
      _errorFetchingUser = true;
    }
    setBusy(false);
  }
}
