import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_start/core/data_sources/users/users_local_data_source.dart';
import 'package:provider_start/core/data_sources/users/users_remote_data_source.dart';
import 'package:provider_start/core/exceptions/cache_exception.dart';
import 'package:provider_start/core/exceptions/network_exception.dart';
import 'package:provider_start/core/exceptions/repository_exception.dart';
import 'package:provider_start/core/repositories/users_repository/users_repository.dart';
import 'package:provider_start/core/services/connectivity/connectivity_service.dart';
import 'package:provider_start/core/utils/logger.dart';
import 'package:provider_start/locator.dart';

import '../../data/mocks.dart';

class MockUsersLocalDataSource extends Mock implements UsersLocalDataSource {}

class MockUsersRemoteDataSource extends Mock implements UsersRemoteDataSource {}

class MockConnectivityService extends Mock implements ConnectivityService {}

void main() {
  UsersRepository repository;
  UsersRemoteDataSource usersRemoteDataSource;
  UsersLocalDataSource usersLocalDataSource;
  ConnectivityService connectivityService;

  setUp(() async {
    setupLogger(test: true);

    await setupLocator(test: true);
    locator.allowReassignment = true;

    usersRemoteDataSource = MockUsersRemoteDataSource();
    usersLocalDataSource = MockUsersLocalDataSource();
    connectivityService = MockConnectivityService();

    locator.registerSingleton<UsersRemoteDataSource>(usersRemoteDataSource);
    locator.registerSingleton<UsersLocalDataSource>(usersLocalDataSource);
    locator.registerSingleton<ConnectivityService>(connectivityService);

    repository = locator<UsersRepository>();
  });

  test('users repository is a UsersRepository type', () {
    expect(repository, isA<UsersRepository>());
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
        final uid = 1;
        when(connectivityService.isConnected).thenAnswer((_) async => true);
        // act
        await repository.fetchUser(uid);
        // assert
        verify(connectivityService.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(usersRemoteDataSource.fetchUser(any))
              .thenAnswer((_) async => mockUser);
          // act
          final result = await repository.fetchUser(mockUID);
          // assert
          verify(usersRemoteDataSource.fetchUser(mockUID));
          expect(result, equals(mockUser));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(usersRemoteDataSource.fetchUser(mockUID))
              .thenAnswer((_) async => mockUser);
          // act
          await repository.fetchUser(mockUID);
          // assert
          verify(usersRemoteDataSource.fetchUser(mockUID));
          verify(usersLocalDataSource.cacheUser(mockUser));
        },
      );

      test(
        'should throw repository exception when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(usersRemoteDataSource.fetchUser(mockUID))
              .thenThrow(NetworkException(''));
          try {
            // act
            await repository.fetchUser(mockUID);
          } catch (e) {
            // assert
            verify(usersRemoteDataSource.fetchUser(mockUID));
            verifyZeroInteractions(usersLocalDataSource);
            expect(e, equals(isA<RepositoryException>()));
          }
        },
      );

      test('should throw repository exception when the null id is passed in',
          () async {
        // arrange
        when(usersRemoteDataSource.fetchUser(null))
            .thenThrow(NetworkException(''));

        try {
          // act
          await repository.fetchUser(null);
        } catch (e) {
          // assert
          verifyNever(usersRemoteDataSource.fetchUser(null));
          verifyZeroInteractions(usersLocalDataSource);
          expect(e, equals(isA<RepositoryException>()));
        }
      });
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(usersLocalDataSource.fetchUser(mockUID))
              .thenAnswer((_) async => mockUser);
          // act
          final result = await repository.fetchUser(mockUID);
          // assert
          verifyZeroInteractions(usersRemoteDataSource);
          verify(usersLocalDataSource.fetchUser(mockUID));
          expect(result, equals(mockUser));
        },
      );

      test(
        'should throw repository exception when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(usersLocalDataSource.fetchUser(mockUID))
              .thenThrow(CacheException(''));
          try {
            // act
            await repository.fetchUser(mockUID);
          } catch (e) {
            // assert
            verify(usersLocalDataSource.fetchUser(mockUID));
            verifyZeroInteractions(usersRemoteDataSource);
            expect(e, equals(isA<RepositoryException>()));
          }
        },
      );

      test(
        'should throw repository exception when null id is passed in',
        () async {
          // arrange
          when(usersLocalDataSource.fetchUser(null))
              .thenThrow(CacheException(''));
          try {
            // act
            await repository.fetchUser(null);
          } catch (e) {
            // assert
            verifyNever(usersLocalDataSource.fetchUser(null));
            verifyZeroInteractions(usersRemoteDataSource);
            expect(e, equals(isA<RepositoryException>()));
          }
        },
      );
    });
  });
}
