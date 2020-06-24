import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_start/core/services/auth/auth_service.dart';
import 'package:provider_start/core/services/auth/auth_service_impl.dart';
import 'package:provider_start/locator.dart';

import '../../data/mocks.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  AuthService authService;

  setUp(() {
    locator.allowReassignment = true;

    locator.registerSingleton<AuthService>(AuthServiceImpl());
    authService = locator<AuthService>();
  });

  group('signUpWithEmailPassword', () {
    test('current user is not null when signed up', () async {
      // arrange

      // act
      await authService.signUpWithEmailPassword(
        mockUser.email,
        mockPassword,
        mockUser.username,
      );

      // assert
      expect(authService.currentUser.id, equals(mockUser.id));
    });
  });

  group('signUpWithEmailPassword', () {
    test('current user is not null when signed in', () async {
      // arrange

      // act
      await authService.signInWithEmailAndPassword(
        mockUser.email,
        mockPassword,
      );

      // assert
      expect(authService.currentUser.id, equals(mockUser.id));
    });
  });

  group('signOut', () {
    test('current user is null when signed out', () async {
      // arrange

      // act
      await authService.signOut();

      // assert
      expect(authService.currentUser, isNull);
    });
  });
}
