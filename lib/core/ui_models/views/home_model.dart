import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/serializers/post.dart';
import 'package:provider_start/core/services/api/api_service.dart';
import 'package:provider_start/core/ui_models/base_model.dart';
import 'package:provider_start/locator.dart';

class HomeModel extends BaseModel {
  final _apiService = locator<ApiService>();

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  Future<void> init() async {
    setState(ViewState.Busy);
    final fetchedPosts = await _apiService.fetchPosts();
    _posts = fetchedPosts.take(20).toList();
    setState(ViewState.Idle);
  }
}
