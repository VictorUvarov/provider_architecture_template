import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/serializers/post.dart';
import 'package:provider_start/core/serializers/user.dart';
import 'package:provider_start/core/services/api/api_service.dart';
import 'package:provider_start/core/ui_models/base_model.dart';
import 'package:provider_start/locator.dart';

class PostDetailsModel extends BaseModel {
  final _apiService = locator<ApiService>();

  User _user;
  User get user => _user;

  Future<void> init(Post post) async {
    setState(ViewState.Busy);
    _user = await _apiService.fetchUser(post.userId);
    setState(ViewState.DataFetched);
  }
}
