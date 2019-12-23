import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_start/core/services/auth/auth_service.dart';
import 'package:provider_start/core/services/key_storage/key_storage_service.dart';
import 'package:provider_start/locator.dart';

class MockKeyStorageService extends Mock implements KeyStorageService {
  bool hasLoggedIn;
}

void main() {
  KeyStorageService keyStorageService;
  AuthService authService;

  final mockEmail = 'email@gmail.com';
  final mockPassword = 'password';
  final mockDisplayName = 'Barrack Obama';

  setUp(() async {
    await setupLocator(test: true);
    locator.allowReassignment = true;

    keyStorageService = MockKeyStorageService();
    locator.registerSingleton<KeyStorageService>(keyStorageService);

    authService = locator<AuthService>();
  });

  group('signUpWithEmailPassword', () {
    test('key storage isLoggedIn becomes true when signed up', () async {
      // arrange

      // act
      await authService.signUpWithEmailPassword(
        mockEmail,
        mockPassword,
        mockDisplayName,
      );

      // assert
      expect(keyStorageService.hasLoggedIn, equals(true));
    });
  });

  group('signUpWithEmailPassword', () {
    test('key storage isLoggedIn becomes true when signed in', () async {
      // arrange

      // act
      await authService.signInWithEmailAndPassword(
        mockEmail,
        mockPassword,
      );

      // assert
      expect(keyStorageService.hasLoggedIn, equals(true));
    });
  });

  group('signOut', () {
    test('key storage isLoggedIn becomes false when signed out', () async {
      // arrange

      // act
      await authService.signOut();

      // assert
      expect(keyStorageService.hasLoggedIn, equals(false));
    });
  });
}
