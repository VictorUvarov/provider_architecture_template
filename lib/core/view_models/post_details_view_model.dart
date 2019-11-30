import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/exceptions/repository_exception.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/models/user/user.dart';
import 'package:provider_start/core/repositories/users_repository/users_repository.dart';
import 'package:provider_start/core/view_models/base_view_model.dart';
import 'package:provider_start/locator.dart';

class PostDetailsViewModel extends BaseViewModel {
  final _usersRepository = locator<UsersRepository>();

  User _user;
  User get user => _user;

  Future<void> init(Post post) async {
    setState(ViewState.Busy);
    try {
      _user = await _usersRepository.fetchUser(post.userId);
      setState(ViewState.DataFetched);
    } on RepositoryException {
      setState(ViewState.Error);
    }
  }
}
