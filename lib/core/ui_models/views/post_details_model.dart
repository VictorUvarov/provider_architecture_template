import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/exceptions/repository_exception.dart';
import 'package:provider_start/core/repositories/users_repository/users_repository.dart';
import 'package:provider_start/core/serializers/post.dart';
import 'package:provider_start/core/serializers/user.dart';
import 'package:provider_start/core/ui_models/base_model.dart';
import 'package:provider_start/locator.dart';

class PostDetailsModel extends BaseModel {
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
