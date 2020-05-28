import 'package:provider_start/core/exceptions/repository_exception.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/repositories/users_repository/users_repository.dart';
import 'package:provider_start/locator.dart';
import 'package:provider_start/state/base_view_model.dart';
import 'package:provider_start/ui/views/post_details/post_details_view_state.dart';

class PostDetailsViewModel extends BaseViewModel<PostDetailsViewState> {
  final _usersRepository = locator<UsersRepository>();

  Future<void> init(Post post) async {
    setState(PostDetailsViewState.loading());
    try {
      var user = await _usersRepository.fetchUser(post.userId);
      setState(PostDetailsViewState.loaded(user));
    } on RepositoryException catch (e) {
      setState(PostDetailsViewState.error(e.message));
    }
  }
}
