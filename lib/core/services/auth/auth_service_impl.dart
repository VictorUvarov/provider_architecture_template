import 'package:provider_start/core/exceptions/auth_exception.dart';
import 'package:provider_start/core/models/user/user.dart';
import 'package:provider_start/core/services/auth/auth_service.dart';
import 'package:provider_start/core/utils/logger.dart';

class AuthServiceImpl implements AuthService {
  User _currentUser;
  @override
  User get currentUser => _currentUser;

  @override
  Future<void> signUpWithEmailPassword(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      // authenticate with server
      await Future.delayed(Duration(milliseconds: 250));

      // fetch current user from server
      _currentUser = User(
        (u) => u
          ..id = 1
          ..email = email
          ..username = displayName,
      );
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
      // authenticate with server
      await Future.delayed(Duration(milliseconds: 250));

      // fetch current user from server
      _currentUser = User(
        (u) => u
          ..id = 1
          ..email = email
          ..username = 'Barrack Obama',
      );
    } on Exception {
      Logger.e('AuthService: Error signing in');
      throw AuthException('Error signing in');
    }
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(Duration(milliseconds: 250));
    _currentUser = null;
  }

  @override
  Future<bool> isUserLoggedIn() async {
    // check server for login status
    await Future.delayed(Duration(seconds: 1));

    return _currentUser != null;
  }
}
