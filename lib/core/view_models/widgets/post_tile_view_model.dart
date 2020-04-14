import 'package:get/get.dart';
import 'package:provider_start/core/constant/view_routes.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/view_models/base_view_model.dart';

class PostTileViewModel extends BaseViewModel {
  Post _post;
  Post get post => _post;

  void init(Post post) {
    _post = post;
  }

  Future<void> showPostDetails() async {
    await Get.toNamed(ViewRoutes.post_details, arguments: _post);
  }
}
