abstract class AuthService {
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
}
