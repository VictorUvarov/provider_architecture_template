import '../../../core/enums/view_state.dart';
import '../../../core/exceptions/repository_exception.dart';
import '../../../core/models/post/post.dart';
import '../../../core/models/user/user.dart';
import '../../../core/repositories/users_repository/users_repository.dart';
import '../../../locator.dart';
import '../../shared/base_viewmodel_extension.dart';

class PostDetailsViewModel extends BaseViewModelExt {
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
