import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_start/core/services/navigation/navigation_service.dart';
import 'package:provider_start/locator.dart';
import 'package:provider_start/ui/router.gr.dart';
import 'package:provider_start/ui/widgets/stateful/post_tile/post_tile_view_model.dart';

import '../../../data/mocks.dart';

class MockNavigationService extends Mock implements NavigationService {}

void main() {
  NavigationService mockNavigationService;
  PostTileViewModel postTileViewModel;

  setUp(() {
    locator.allowReassignment = true;

    mockNavigationService = MockNavigationService();
    locator.registerSingleton(mockNavigationService);

    postTileViewModel = PostTileViewModel();
  });

  group('init', () {
    test(
      'when init() is called post is assigned to the view models post',
      () {
        // arrange

        // act
        postTileViewModel.init(mockPost1);

        // assert
        expect(postTileViewModel.post, mockPost1);
      },
    );
  });

  group('showPostDetails()', () {
    test(
      'when called post is passed to post details view',
      () {
        // arrange
        postTileViewModel.init(mockPost1);
        when(mockNavigationService.pushNamed(
          Routes.postDetailsView,
          arguments: PostDetailsViewArguments(post: mockPost1),
        )).thenAnswer((realInvocation) async => Null);

        // act
        postTileViewModel.showPostDetails();

        // assert
        verify(mockNavigationService.pushNamed(
          Routes.postDetailsView,
          arguments: isA<PostDetailsViewArguments>(),
        )).called(1);
      },
    );
  });
}
