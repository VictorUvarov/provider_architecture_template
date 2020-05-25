import '../../models/user/user.dart';

abstract class AuthService {
  User get currentUser;

  Future<void> signUpWithEmailPassword(
    String email,
    String password,
    String displayName,
  );

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  );

  Future<void> signOut();

  Future<bool> isUserLoggedIn();
}
