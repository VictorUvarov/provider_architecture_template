import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_start/core/data_sources/posts/posts_local_data_source.dart';
import 'package:provider_start/core/data_sources/posts/posts_remote_data_source.dart';
import 'package:provider_start/core/exceptions/cache_exception.dart';
import 'package:provider_start/core/exceptions/network_exception.dart';
import 'package:provider_start/core/exceptions/repository_exception.dart';
import 'package:provider_start/core/repositories/posts_repository/posts_repository.dart';
import 'package:provider_start/core/repositories/posts_repository/posts_repository_impl.dart';
import 'package:provider_start/core/services/connectivity/connectivity_service.dart';
import 'package:provider_start/locator.dart';
import 'package:provider_start/logger.dart';

import '../../data/mocks.dart';

class MockPostsLocalDataSource extends Mock implements PostsLocalDataSource {}

class MockPostsRemoteDataSource extends Mock implements PostsRemoteDataSource {}

class MockConnectivityService extends Mock implements ConnectivityService {}

void main() {
  PostsRepository repository;
  PostsRemoteDataSource postsRemoteDataSource;
  PostsLocalDataSource postsLocalDataSource;
  ConnectivityService connectivityService;

  setUp(() {
    locator.allowReassignment = true;

    postsRemoteDataSource = MockPostsRemoteDataSource();
    postsLocalDataSource = MockPostsLocalDataSource();
    connectivityService = MockConnectivityService();

    locator.registerSingleton<PostsRemoteDataSource>(postsRemoteDataSource);
    locator.registerSingleton<PostsLocalDataSource>(postsLocalDataSource);
    locator.registerSingleton<ConnectivityService>(connectivityService);

    locator.registerSingleton<PostsRepository>(PostsRepositoryImpl());
    repository = locator<PostsRepository>();
  });

  test('posts repository is a PostsRepository type', () {
    expect(repository, isA<PostsRepository>());
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(connectivityService.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(connectivityService.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('fetchUser', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(connectivityService.isConnected).thenAnswer((_) async => true);
        // act
        await repository.fetchPosts();
        // assert
        verify(connectivityService.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(postsRemoteDataSource.fetchPosts())
              .thenAnswer((_) async => mockPosts);
          // act
          final result = await repository.fetchPosts();
          // assert
          verify(postsRemoteDataSource.fetchPosts());
          expect(result, equals(mockPosts));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(postsRemoteDataSource.fetchPosts())
              .thenAnswer((_) async => mockPosts);
          // act
          await repository.fetchPosts();
          // assert
          verify(postsRemoteDataSource.fetchPosts());
          verify(postsLocalDataSource.cachePosts(mockPosts));
        },
      );

      test(
        'should throw repository exception when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(postsRemoteDataSource.fetchPosts())
              .thenThrow(NetworkException(''));
          try {
            // act
            await repository.fetchPosts();
          } catch (e) {
            // assert
            verify(postsRemoteDataSource.fetchPosts());
            verifyZeroInteractions(postsLocalDataSource);
            expect(e, equals(isA<RepositoryException>()));
          }
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(postsLocalDataSource.fetchPosts())
              .thenAnswer((_) async => mockPosts);
          // act
          final result = await repository.fetchPosts();
          // assert
          verifyZeroInteractions(postsRemoteDataSource);
          verify(postsLocalDataSource.fetchPosts());
          expect(result, equals(mockPosts));
        },
      );

      test(
        'should throw repository exception when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(postsLocalDataSource.fetchPosts()).thenThrow(CacheException(''));

          try {
            // act
            await repository.fetchPosts();
          } catch (e) {
            // assert
            verify(postsLocalDataSource.fetchPosts());
            verifyZeroInteractions(postsRemoteDataSource);
            expect(e, equals(isA<RepositoryException>()));
          }
        },
      );
    });
  });
}
