import 'dart:async';

import 'package:flutter/foundation.dart' show compute;
import 'package:provider_start/core/constant/api_routes.dart';
import 'package:provider_start/core/serializers/post.dart';
import 'package:provider_start/core/serializers/user.dart';
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
    // TODO: Replace compute with work service
    return compute(_fetchPosts, _httpService);
  }

  @override
  Future<User> fetchUser(int userId) async {
    final postsJsonData = await _httpService
        .getHttp('${ApiRoutes.users}/$userId') as Map<String, dynamic>;

    return User.fromMap(postsJsonData);
  }

  @override
  Future<void> samplePost() async {
    final body = {
      'udid': _hardwareService.udid,
    };

    await _httpService.postHttp(ApiRoutes.photos, body);
  }

  static Future<List<Post>> _fetchPosts(HttpService httpService) async {
    final postsJsonData =
        await httpService.getHttp(ApiRoutes.posts) as List<dynamic>;

    final posts = postsJsonData
        .map((data) => data as Map<String, dynamic>)
        .map(Post.fromMap)
        .toList();

    return posts;
  }
}
