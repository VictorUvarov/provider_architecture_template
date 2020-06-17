import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_start/core/constant/api_routes.dart';
import 'package:provider_start/core/data_sources/posts/posts_remote_data_source.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/services/http/http_service.dart';
import 'package:provider_start/locator.dart';

import '../../../data/mocks.dart';

class MockHttpService extends Mock implements HttpService {}

void main() {
  PostsRemoteDataSource postsRemoteDataSource;
  HttpService httpService;

  setUp(() async {
    await setupLocator(test: true);
    locator.allowReassignment = true;

    locator.registerSingleton<HttpService>(MockHttpService());
    httpService = locator<HttpService>();

    postsRemoteDataSource = locator<PostsRemoteDataSource>();
  });

  test('should call httpService.getHttp when we fetch posts', () async {
    // arrange
    when(httpService.getHttp(ApiRoutes.posts))
        .thenAnswer((_) => Future.value(mockPostsJson));

    // act
    await postsRemoteDataSource.fetchPosts();

    // assert
    verify(httpService.getHttp(ApiRoutes.posts));
  });

  test('should convert json data to posts when we fetch posts', () async {
    // arrange
    when(httpService.getHttp(ApiRoutes.posts))
        .thenAnswer((_) => Future.value(mockPostsJson));
    final mockPosts =
        mockPostsJson.map<Post>((postMap) => Post.fromMap(postMap)).toList();

    // act
    final posts = await postsRemoteDataSource.fetchPosts();

    // assert
    expect(posts, equals(mockPosts));
  });
}
