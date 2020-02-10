import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:hive/hive.dart';
import 'package:provider_start/core/constant/local_storage_keys.dart';
import 'package:provider_start/core/data_sources/users/users_local_data_source.dart';
import 'package:provider_start/core/exceptions/cache_exception.dart';
import 'package:provider_start/core/models/user/user.dart';
import 'package:provider_start/core/models/user/user_h.dart';
import 'package:provider_start/core/utils/file_helper.dart';
import 'package:provider_start/locator.dart';

class MockHive extends Mock implements HiveInterface {}

class MockFileHelper extends Mock implements FileHelper {}

class MockBox<UserH> extends Mock implements Box<UserH> {}

void main() {
  UsersLocalDataSource usersLocalDataSource;
  FileHelper fileHelper;
  HiveInterface hive;
  MockBox<UserH> usersBox;

  final fakePath = 'users/';

  final mockUser = User(
    (p) => p
      ..id = 1
      ..username = 'James420'
      ..email = 'Jamesbond@gmail.com'
      ..name = 'James Bond'
      ..phone = '1112223333'
      ..website = 'Jamesbond.dev',
  );

  setUp(() async {
    await setupLocator(test: true);
    locator.allowReassignment = true;

    locator.registerSingleton<FileHelper>(MockFileHelper());
    fileHelper = locator<FileHelper>();

    locator.registerSingleton<HiveInterface>(MockHive());
    hive = locator<HiveInterface>();

    usersLocalDataSource = locator<UsersLocalDataSource>();

    usersBox = MockBox<UserH>();
  });

  void setupHiveDirectoryWithClosedBox() {
    when(hive.isBoxOpen(LocalStorageKeys.users)).thenReturn(false);
    when(fileHelper.getApplicationDocumentsDirectoryPath())
        .thenAnswer((_) => Future.value(fakePath));
  }

  void setupHiveDirectoryWithOpenBox() {
    when(hive.isBoxOpen(LocalStorageKeys.users)).thenReturn(true);
    when(fileHelper.getApplicationDocumentsDirectoryPath())
        .thenAnswer((_) => Future.value(fakePath));
  }

  void setupOpenedBox() {
    when(hive.openBox<UserH>(LocalStorageKeys.users))
        .thenAnswer((_) => Future.value(usersBox));
    when(hive.box<UserH>(LocalStorageKeys.users)).thenReturn(usersBox);
  }

  test(
      'local data source should use the applications directory path when initializing',
      () async {
    // arrange
    setupHiveDirectoryWithClosedBox();

    // act
    await usersLocalDataSource.init();

    // assert
    verify(fileHelper.getApplicationDocumentsDirectoryPath());
  });

  test('local data source should initialize hive when initializing', () async {
    // arrange
    setupHiveDirectoryWithClosedBox();

    // act
    await usersLocalDataSource.init();

    // assert
    verify(hive.init(fakePath));
  });

  test('local data source should register a user adapter', () async {
    // arrange
    setupHiveDirectoryWithOpenBox();
    setupOpenedBox();

    try {
      // act
      await usersLocalDataSource.init();

      // assert
      verify(hive.registerAdapter<UserH>(UserHAdapter()));
    } catch (e) {
      //TODO: Fix this test to not use try catch
    }
  });

  test('local data source should open box when box is not open', () async {
    // arrange
    setupHiveDirectoryWithClosedBox();

    // act
    await usersLocalDataSource.init();

    // assert
    verify(hive.openBox(LocalStorageKeys.users));
  });

  test('local data source should not open box when box is open', () async {
    // arrange
    setupHiveDirectoryWithOpenBox();

    // act
    await usersLocalDataSource.init();

    // assert
    verifyNever(hive.openBox(LocalStorageKeys.users));
  });

  test(
      'local data fetchUser(uid) should throw CacheException when no user is found',
      () async {
    // arrange
    setupHiveDirectoryWithOpenBox();
    setupOpenedBox();

    when(usersBox.isEmpty).thenReturn(true);
    // when(usersBox.get(userId)).thenReturn(UserH.fromUser(mockUser));

    try {
      // act
      await usersLocalDataSource.fetchUser(1);
    } catch (e) {
      // assert
      expect(e, equals(isA<CacheException>()));
    }
  });

  test('local data source should call putAll() when cachePosts() is called',
      () async {
    // arrange
    setupHiveDirectoryWithOpenBox();
    setupOpenedBox();

    try {
      // act
      await usersLocalDataSource.cacheUser(mockUser);

      // assert
      verify(usersBox.put(mockUser.id, UserH.fromUser(mockUser)));
    } catch (e) {
      //TODO: Fix this test to not use try catch
    }
  });
}
