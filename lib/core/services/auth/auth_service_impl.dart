import 'package:provider_start/core/constant/auth_exception_messages.dart';
import 'package:provider_start/core/exceptions/auth_exception.dart';
import 'package:provider_start/core/services/auth/auth_service.dart';
import 'package:provider_start/core/services/key_storage/key_storage_service.dart';
import 'package:provider_start/core/utils/logger.dart';
import 'package:provider_start/locator.dart';

class AuthServiceImpl implements AuthService {
  final _keyStorageService = locator<KeyStorageService>();

  @override
  Future<void> signUpWithEmailPassword(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      await Future.delayed(Duration(milliseconds: 250));
      _keyStorageService.hasLoggedIn = true;
    } on Exception catch (_) {
      Logger.e('AuthService: Error signing up', s: StackTrace.current);
      throw AuthException(AuthExceptionMessages.general);
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await Future.delayed(Duration(milliseconds: 250));
      _keyStorageService.hasLoggedIn = true;
    } on Exception catch (_) {
      Logger.e('AuthService: Error signing in', s: StackTrace.current);
      throw AuthException(AuthExceptionMessages.general);
    }
  }
}
