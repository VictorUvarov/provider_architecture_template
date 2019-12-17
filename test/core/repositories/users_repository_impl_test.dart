import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_start/core/data_sources/users/users_local_data_source.dart';
import 'package:provider_start/core/data_sources/users/users_remote_data_source.dart';
import 'package:provider_start/core/exceptions/cache_exception.dart';
import 'package:provider_start/core/exceptions/network_exception.dart';
import 'package:provider_start/core/exceptions/repository_exception.dart';
import 'package:provider_start/core/models/user/user.dart';
import 'package:provider_start/core/repositories/users_repository/users_repository.dart';
import 'package:provider_start/core/repositories/users_repository/users_repository_impl.dart';
import 'package:provider_start/core/services/connectivity/connectivity_service.dart';
import 'package:provider_start/core/utils/logger.dart';

class MockUsersLocalDataSource extends Mock implements UsersLocalDataSource {}

class MockUsersRemoteDataSource extends Mock implements UsersRemoteDataSource {}

class MockConnectivityService extends Mock implements ConnectivityService {}

void main() {
  UsersRepositoryImpl repository;
  MockUsersRemoteDataSource mockUsersRemoteDataSource;
  MockUsersLocalDataSource mockUsersLocalDataSource;
  MockConnectivityService mockConnectivityService;

  final mockUID = 1;
  final mockUser = User(
    (u) => u
      ..id = 1
      ..name = 'Barrack Obama'
      ..username = 'Barrack'
      ..phone = '1112223333'
      ..email = 'barrackobama@gmail.com'
      ..website = 'barrackobama.com',
  );

  setUp(() {
    mockUsersRemoteDataSource = MockUsersRemoteDataSource();
    mockUsersLocalDataSource = MockUsersLocalDataSource();
    mockConnectivityService = MockConnectivityService();
    repository = UsersRepositoryImpl(
      remoteDataSource: mockUsersRemoteDataSource,
      localDataSource: mockUsersLocalDataSource,
      connectivityService: mockConnectivityService,
    );
    setupLogger(test: true);
  });

  test('users repository is a UsersRepository type', () {
    expect(repository, isA<UsersRepository>());
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
        final uid = 1;
        when(mockConnectivityService.isConnected).thenAnswer((_) async => true);
        // act
        await repository.fetchUser(uid);
        // assert
        verify(mockConnectivityService.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockUsersRemoteDataSource.fetchUser(any))
              .thenAnswer((_) async => mockUser);
          // act
          final result = await repository.fetchUser(mockUID);
          // assert
          verify(mockUsersRemoteDataSource.fetchUser(mockUID));
          expect(result, equals(mockUser));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockUsersRemoteDataSource.fetchUser(mockUID))
              .thenAnswer((_) async => mockUser);
          // act
          await repository.fetchUser(mockUID);
          // assert
          verify(mockUsersRemoteDataSource.fetchUser(mockUID));
          verify(mockUsersLocalDataSource.cacheUser(mockUser));
        },
      );

      test(
        'should throw repository exception when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockUsersRemoteDataSource.fetchUser(mockUID))
              .thenThrow(NetworkException(''));
          try {
            // act
            await repository.fetchUser(mockUID);
          } catch (e) {
            // assert
            verify(mockUsersRemoteDataSource.fetchUser(mockUID));
            verifyZeroInteractions(mockUsersLocalDataSource);
            expect(e.runtimeType, equals(RepositoryException('').runtimeType));
          }
        },
      );

      test('should throw repository exception when the null id is passed in',
          () async {
        // arrange
        when(mockUsersRemoteDataSource.fetchUser(null))
            .thenThrow(NetworkException(''));

        try {
          // act
          await repository.fetchUser(null);
        } catch (e) {
          // assert
          verifyNever(mockUsersRemoteDataSource.fetchUser(null));
          verifyZeroInteractions(mockUsersLocalDataSource);
          expect(e.runtimeType, equals(RepositoryException('').runtimeType));
        }
      });
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockUsersLocalDataSource.fetchUser(mockUID))
              .thenAnswer((_) => mockUser);
          // act
          final result = await repository.fetchUser(mockUID);
          // assert
          verifyZeroInteractions(mockUsersRemoteDataSource);
          verify(mockUsersLocalDataSource.fetchUser(mockUID));
          expect(result, equals(mockUser));
        },
      );

      test(
        'should throw repository exception when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockUsersLocalDataSource.fetchUser(mockUID))
              .thenThrow(CacheException(''));
          try {
            // act
            await repository.fetchUser(mockUID);
          } catch (e) {
            // assert
            verify(mockUsersLocalDataSource.fetchUser(mockUID));
            verifyZeroInteractions(mockUsersRemoteDataSource);
            expect(e.runtimeType, equals(RepositoryException('').runtimeType));
          }
        },
      );

      test(
        'should throw repository exception when null id is passed in',
        () async {
          // arrange
          when(mockUsersLocalDataSource.fetchUser(null))
              .thenThrow(CacheException(''));
          try {
            // act
            await repository.fetchUser(null);
          } catch (e) {
            // assert
            verifyNever(mockUsersLocalDataSource.fetchUser(null));
            verifyZeroInteractions(mockUsersRemoteDataSource);
            expect(e.runtimeType, equals(RepositoryException('').runtimeType));
          }
        },
      );
    });
  });
}
