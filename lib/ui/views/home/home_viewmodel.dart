import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/exceptions/repository_exception.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/repositories/posts_repository/posts_repository.dart';
import 'package:provider_start/locator.dart';
import 'package:provider_start/ui/shared/base_viewmodel_extension.dart';

class HomeViewModel extends BaseViewModelExt {
  final _postsRepository = locator<PostsRepository>();

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  Future<void> init() async {
    await _attemptFetchPosts();
  }

  Future<void> _attemptFetchPosts() async {
    setState(ViewState.Busy);
    try {
      final fetchedPosts = await _postsRepository.fetchPosts();
      _posts = fetchedPosts.take(20).toList();
      _checkIfAvailableData();
    } on RepositoryException {
      setState(ViewState.Error);
    }
  }

  void _checkIfAvailableData() {
    (_posts.isEmpty)
        ? setState(ViewState.NoDataAvailable)
        : setState(ViewState.Idle);
  }
}
