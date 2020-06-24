import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:hive/hive.dart';
import 'package:provider_start/core/constant/local_storage_keys.dart';
import 'package:provider_start/core/data_sources/posts/posts_local_data_source.dart';
import 'package:provider_start/core/exceptions/cache_exception.dart';
import 'package:provider_start/core/models/post/post_h.dart';
import 'package:provider_start/core/utils/file_helper.dart';
import 'package:provider_start/locator.dart';

import '../../../data/mocks.dart';

class MockHive extends Mock implements HiveInterface {}

class MockFileHelper extends Mock implements FileHelper {}

class MockBox<PostH> extends Mock implements Box<PostH> {}

void main() {
  PostsLocalDataSource postsLocalDataSource;
  FileHelper fileHelper;
  HiveInterface hive;
  MockBox<PostH> postsBox;

  final fakePath = '/foo/bars';

  setUp(() {
    locator.allowReassignment = true;

    locator.registerSingleton<FileHelper>(MockFileHelper());
    fileHelper = locator<FileHelper>();

    locator.registerSingleton<HiveInterface>(MockHive());
    hive = locator<HiveInterface>();

    locator.registerSingleton<PostsLocalDataSource>(PostsLocalDataSourceImpl());
    postsLocalDataSource = locator<PostsLocalDataSource>();

    postsBox = MockBox<PostH>();
  });

  void setupHiveDirectoryWithClosedBox() {
    when(hive.isBoxOpen(LocalStorageKeys.posts)).thenReturn(false);
    when(fileHelper.getApplicationDocumentsDirectoryPath())
        .thenAnswer((_) => Future.value(fakePath));
  }

  void setupHiveDirectoryWithOpenBox() {
    when(hive.isBoxOpen(LocalStorageKeys.posts)).thenReturn(true);
    when(fileHelper.getApplicationDocumentsDirectoryPath())
        .thenAnswer((_) => Future.value(fakePath));
  }

  void setupOpenedBox() {
    when(hive.openBox<PostH>(LocalStorageKeys.posts))
        .thenAnswer((_) => Future.value(postsBox));
    when(hive.box<PostH>(LocalStorageKeys.posts)).thenReturn(postsBox);
  }

  test(
      'local data source should use the applications directory path when initializing',
      () async {
    // arrange
    setupHiveDirectoryWithClosedBox();

    // act
    await postsLocalDataSource.init();

    // assert
    verify(fileHelper.getApplicationDocumentsDirectoryPath()).called(1);
  });

  test('local data source should initialize hive when initializing', () async {
    // arrange
    setupHiveDirectoryWithClosedBox();

    // act
    await postsLocalDataSource.init();

    // assert
    verify(hive.init(fakePath)).called(1);
  });

  test('local data source should register a post adapter', () async {
    // arrange
    setupHiveDirectoryWithOpenBox();
    setupOpenedBox();

    // act
    await postsLocalDataSource.init();

    // assert
    verify(hive.registerAdapter<PostH>(PostHAdapter())).called(1);
  });

  test('local data source should open box when box is not open', () async {
    // arrange
    setupHiveDirectoryWithClosedBox();

    // act
    await postsLocalDataSource.init();

    // assert
    verify(hive.openBox(LocalStorageKeys.posts)).called(1);
  });

  test('local data source should not open box when box is open', () async {
    // arrange
    setupHiveDirectoryWithOpenBox();

    // act
    await postsLocalDataSource.init();

    // assert
    verifyNever(hive.openBox(LocalStorageKeys.posts));
  });

  test(
      'local data fetchPosts() should throw CacheException when no posts are found',
      () async {
    // arrange
    setupHiveDirectoryWithOpenBox();
    setupOpenedBox();

    when(postsBox.isEmpty).thenReturn(true);

    try {
      // act
      await postsLocalDataSource.fetchPosts();
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

    // act
    await postsLocalDataSource.cachePosts(mockPosts);

    final postsMap = <int, PostH>{};
    for (final post in mockPosts) {
      postsMap.putIfAbsent(post.id, () => PostH.fromPost(post));
    }

    // assert
    verify(postsBox.putAll(postsMap)).called(1);
  });
}
