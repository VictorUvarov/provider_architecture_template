import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/exceptions/repository_exception.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/repositories/posts_repository/posts_repository.dart';
import 'package:provider_start/core/view_models/base_view_model.dart';
import 'package:provider_start/locator.dart';

class HomeViewModel extends BaseViewModel {
  final _postsRepository = locator<PostsRepository>();

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  Future<void> init() async {
    setState(ViewState.Busy);
    try {
      final fetchedPosts = await _postsRepository.fetchPosts();
      _posts = fetchedPosts.take(20).toList();
    } on RepositoryException {
      setState(ViewState.Error);
    }
    setState(ViewState.Idle);
  }
}
