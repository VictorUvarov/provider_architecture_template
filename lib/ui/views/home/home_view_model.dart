import 'package:provider_start/core/exceptions/repository_exception.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/repositories/posts_repository/posts_repository.dart';
import 'package:provider_start/locator.dart';
import 'package:provider_start/state/base_view_model.dart';
import 'package:provider_start/ui/views/home/home_view_state.dart';

class HomeViewModel extends BaseViewModel<HomeViewState> {
  final _postsRepository = locator<PostsRepository>();

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  Future<void> init() async {
    await _attemptFetchPosts();
  }

  Future<void> _attemptFetchPosts() async {
    setState(HomeViewState.loading());
    try {
      final fetchedPosts = await _postsRepository.fetchPosts();
      _posts = fetchedPosts.take(20).toList();
      _checkIfAvailableData();
    } on RepositoryException catch (e) {
      setState(HomeViewState.error(e.message));
    }
  }

  void _checkIfAvailableData() {
    (_posts.isEmpty)
        ? setState(HomeViewState.noPosts())
        : setState(HomeViewState.loaded(_posts));
  }
}
