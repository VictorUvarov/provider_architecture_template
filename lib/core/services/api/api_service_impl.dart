import 'package:provider_start/core/constant/api_routes.dart';
import 'package:provider_start/core/serializers/post.dart';
import 'package:provider_start/core/services/api/api_service.dart';
import 'package:provider_start/core/services/hardware/hardware_service.dart';
import 'package:provider_start/core/services/http/http_service.dart';
import 'package:provider_start/locator.dart';

/// Example HTTP api service that uses [HttpService]
class ApiServiceImpl implements ApiService {
  final _hardwareService = locator<HardwareService>();
  final _httpService = locator<HttpService>();

  @override
  Future<void> init() async {
    await _hardwareService.init();
  }

  @override
  Future<List<Post>> fetchPosts() async {
    final postsJsonData =
        await _httpService.getHttp(ApiRoutes.posts) as List<dynamic>;

    final futurePosts = postsJsonData.map((postJsonData) async {
      final userRoute = '${ApiRoutes.users}/${postJsonData['userId']}';

      final userJsonData = await _httpService.getHttp(userRoute);

      postJsonData.addAll({'user': userJsonData});

      return Post.fromMap(postJsonData);
    }).toList();

    // Fetch all posts in parrallel
    final futures = <Future<Post>>[];
    futurePosts.forEach((futurePost) => futures.add(futurePost));
    final posts = await Future.wait(futures);

    return posts;
  }

  @override
  Future<void> samplePost() async {
    final body = {
      'udid': _hardwareService.udid,
    };

    await _httpService.postHttp(ApiRoutes.photos, body);
  }
}
