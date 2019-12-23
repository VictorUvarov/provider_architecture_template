import 'package:provider_start/core/exceptions/auth_exception.dart';
import 'package:provider_start/core/services/auth/auth_service.dart';
import 'package:provider_start/core/services/key_storage/key_storage_service.dart';
import 'package:provider_start/core/utils/logger.dart';
import 'package:provider_start/locator.dart';

class AuthServiceImpl implements AuthService {
  final keyStorageService = locator<KeyStorageService>();

  @override
  Future<void> signUpWithEmailPassword(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      await Future.delayed(Duration(milliseconds: 250));
      keyStorageService.hasLoggedIn = true;
    } on Exception {
      Logger.e('AuthService: Error signing up');
      throw AuthException('Error signing up');
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await Future.delayed(Duration(milliseconds: 250));
      keyStorageService.hasLoggedIn = true;
    } on Exception {
      Logger.e('AuthService: Error signing in');
      throw AuthException('Error signing in');
    }
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(Duration(milliseconds: 250));
    keyStorageService.hasLoggedIn = false;
  }
}
