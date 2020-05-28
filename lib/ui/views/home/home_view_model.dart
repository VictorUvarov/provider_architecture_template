import 'package:provider_start/core/exceptions/repository_exception.dart';
import 'package:provider_start/core/repositories/posts_repository/posts_repository.dart';
import 'package:provider_start/locator.dart';
import 'package:provider_start/state/base_view_model.dart';
import 'package:provider_start/ui/views/home/home_view_state.dart';

class HomeViewModel extends BaseViewModel<HomeViewState> {
  final _postsRepository = locator<PostsRepository>();

  Future<void> init() async {
    await _attemptFetchPosts();
  }

  Future<void> _attemptFetchPosts() async {
    setState(HomeViewState.loading());
    try {
      final posts = await _postsRepository.fetchPosts();
      posts.isEmpty
          ? setState(HomeViewState.noPosts())
          : setState(HomeViewState.loaded(posts));
    } on RepositoryException catch (e) {
      setState(HomeViewState.error(e.message));
    }
  }
}
