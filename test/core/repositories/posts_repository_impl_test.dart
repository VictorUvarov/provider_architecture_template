import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_start/core/data_sources/posts/posts_local_data_source.dart';
import 'package:provider_start/core/data_sources/posts/posts_remote_data_source.dart';
import 'package:provider_start/core/exceptions/cache_exception.dart';
import 'package:provider_start/core/exceptions/network_exception.dart';
import 'package:provider_start/core/exceptions/repository_exception.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/models/user/user.dart';
import 'package:provider_start/core/repositories/posts_repository/posts_repository.dart';
import 'package:provider_start/core/repositories/posts_repository/posts_repository_impl.dart';
import 'package:provider_start/core/services/connectivity/connectivity_service.dart';
import 'package:provider_start/core/utils/logger.dart';

class MockPostsLocalDataSource extends Mock implements PostsLocalDataSource {}

class MockPostsRemoteDataSource extends Mock implements PostsRemoteDataSource {}

class MockConnectivityService extends Mock implements ConnectivityService {}

void main() {
  PostsRepositoryImpl repository;
  MockPostsRemoteDataSource mockPostsRemoteDataSource;
  MockPostsLocalDataSource mockPostsLocalDataSource;
  MockConnectivityService mockConnectivityService;

  final mockPost = Post(
    (p) => p
      ..id = 1
      ..title = 'title'
      ..description = 'desc'
      ..userId = 1,
  );
  final mockPosts = [mockPost, mockPost];

  setUp(() {
    mockPostsRemoteDataSource = MockPostsRemoteDataSource();
    mockPostsLocalDataSource = MockPostsLocalDataSource();
    mockConnectivityService = MockConnectivityService();
    repository = PostsRepositoryImpl(
      remoteDataSource: mockPostsRemoteDataSource,
      localDataSource: mockPostsLocalDataSource,
      connectivityService: mockConnectivityService,
    );
    setupLogger(test: true);
  });

  test('posts repository is a PostsRepository type', () {
    expect(repository, isA<PostsRepository>());
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockConnectivityService.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockConnectivityService.isConnected)
            .thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('fetchUser', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockConnectivityService.isConnected).thenAnswer((_) async => true);
        // act
        await repository.fetchPosts();
        // assert
        verify(mockConnectivityService.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockPostsRemoteDataSource.fetchPosts())
              .thenAnswer((_) async => mockPosts);
          // act
          final result = await repository.fetchPosts();
          // assert
          verify(mockPostsRemoteDataSource.fetchPosts());
          expect(result, equals(mockPosts));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockPostsRemoteDataSource.fetchPosts())
              .thenAnswer((_) async => mockPosts);
          // act
          await repository.fetchPosts();
          // assert
          verify(mockPostsRemoteDataSource.fetchPosts());
          verify(mockPostsLocalDataSource.cachePosts(mockPosts));
        },
      );

      test(
        'should throw repository exception when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockPostsRemoteDataSource.fetchPosts())
              .thenThrow(NetworkException(''));
          try {
            // act
            await repository.fetchPosts();
          } catch (e) {
            // assert
            verify(mockPostsRemoteDataSource.fetchPosts());
            verifyZeroInteractions(mockPostsLocalDataSource);
            expect(e.runtimeType, equals(RepositoryException('').runtimeType));
          }
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockPostsLocalDataSource.fetchPosts())
              .thenAnswer((_) => mockPosts);
          // act
          final result = await repository.fetchPosts();
          // assert
          verifyZeroInteractions(mockPostsRemoteDataSource);
          verify(mockPostsLocalDataSource.fetchPosts());
          expect(result, equals(mockPosts));
        },
      );

      test(
        'should throw repository exception when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockPostsLocalDataSource.fetchPosts())
              .thenThrow(CacheException(''));
          try {
            // act
            await repository.fetchPosts();
          } catch (e) {
            // assert
            verify(mockPostsLocalDataSource.fetchPosts());
            verifyZeroInteractions(mockPostsRemoteDataSource);
            expect(e.runtimeType, equals(RepositoryException('').runtimeType));
          }
        },
      );
    });
  });
}
