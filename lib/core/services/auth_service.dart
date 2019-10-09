import 'package:provider_start/core/constant/auth_exception_messages.dart';
import 'package:provider_start/core/exceptions/auth_exception.dart';
import 'package:provider_start/core/services/key_storage_service.dart';
import 'package:provider_start/locator.dart';

class AuthService {
  Future<void> signUpWithEmailPassword(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      await Future.delayed(Duration(milliseconds: 250));
      locator<KeyStorageService>().hasLoggedIn = true;
    } on Exception catch (_) {
      throw AuthException(AuthExceptionMessages.general);
    }
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await Future.delayed(Duration(milliseconds: 250));
      locator<KeyStorageService>().hasLoggedIn = true;
    } on Exception catch (_) {
      throw AuthException(AuthExceptionMessages.general);
    }
  }
}
