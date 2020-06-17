import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_start/core/exceptions/repository_exception.dart';
import 'package:provider_start/core/repositories/posts_repository/posts_repository.dart';
import 'package:provider_start/core/utils/logger.dart';
import 'package:provider_start/locator.dart';
import 'package:provider_start/ui/views/home/home_view_model.dart';

import '../../../data/mocks.dart';

class MockPostsRepository extends Mock implements PostsRepository {}

void main() {
  PostsRepository postsRepository;
  HomeViewModel homeViewModel;

  setUp(() {
    setupLogger();
    setupLocator(test: true);
    locator.allowReassignment = true;
    postsRepository = MockPostsRepository();
    locator.registerSingleton(postsRepository);

    homeViewModel = HomeViewModel();
  });

  void mockFetchPostsSuccess() {
    when(postsRepository.fetchPosts())
        .thenAnswer((realInvocation) async => mockPosts);
  }

  void mockFetchPostsFailure() {
    when(postsRepository.fetchPosts()).thenThrow(RepositoryException(''));
  }

  group('init()', () {
    test('UI set to busy when init is called', () async {
      // arrange
      var called = false;
      homeViewModel.addListener(() {
        if (homeViewModel.isBusy) {
          called = true;
        }
      });

      // act
      await homeViewModel.init();

      // assert
      expect(called, true);
    });

    test('Posts start as an empty list', () async {
      // arrange

      // act

      // assert
      expect(homeViewModel.posts.isEmpty, true);
    });

    test('When posts are successfully fetched the posts are not empty',
        () async {
      // arrange
      mockFetchPostsSuccess();

      // act
      expect(homeViewModel.posts.isEmpty, true);
      await homeViewModel.init();

      // assert
      expect(homeViewModel.posts.isEmpty, false);
    });

    test('When posts are unsuccessfully fetched the posts are empty', () async {
      // arrange
      mockFetchPostsFailure();

      // act
      expect(homeViewModel.posts.isEmpty, true);
      await homeViewModel.init();

      // assert
      expect(homeViewModel.posts.isEmpty, true);
    });
  });
}
