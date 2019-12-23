import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_start/core/services/auth/auth_service.dart';
import 'package:provider_start/core/services/auth/auth_service_impl.dart';
import 'package:provider_start/core/services/key_storage/key_storage_service.dart';
import 'package:provider_start/locator.dart';

class MockKeyStorageService extends Mock implements KeyStorageService {
  bool hasLoggedIn;
}

void main() {
  MockKeyStorageService mockKeyStorageService;
  AuthServiceImpl authService;

  final mockEmail = 'email@gmail.com';
  final mockPassword = 'password';
  final mockDisplayName = 'Barrack Obama';

  setUp(() async {
    await setupLocator(test: true);
    locator.allowReassignment = true;
    locator.registerSingleton<KeyStorageService>(MockKeyStorageService());
    mockKeyStorageService = locator<KeyStorageService>();
    locator.registerSingleton<AuthService>(AuthServiceImpl());
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
      expect(mockKeyStorageService.hasLoggedIn, equals(true));
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
      expect(mockKeyStorageService.hasLoggedIn, equals(true));
    });
  });

  group('signOut', () {
    test('key storage isLoggedIn becomes false when signed out', () async {
      // arrange

      // act
      await authService.signOut();

      // assert
      expect(mockKeyStorageService.hasLoggedIn, equals(false));
    });
  });
}
