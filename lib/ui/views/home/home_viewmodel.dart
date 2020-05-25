import '../../../core/enums/view_state.dart';
import '../../../core/exceptions/repository_exception.dart';
import '../../../core/models/post/post.dart';
import '../../../core/repositories/posts_repository/posts_repository.dart';
import '../../../locator.dart';
import '../../shared/base_viewmodel_extension.dart';

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
