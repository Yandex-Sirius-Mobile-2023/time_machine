import 'package:time_machine/data/auth/user.dart';

/// Service to provide sign in, create and store user.
abstract class AuthService {
  /// Current signed user.
  /// [Null] if user not signed in.
  User? get user;

  /// Attempts to sign in a user with the given email address and password.
  Future<User> signInEmailAndPassword(
      {required String email, required String password});

  /// Attempts to create in a user with the given email address and password.
  Future<User> createWithEmailAndPassword(
      {required String email, required String password});

  /// Sign out current user.
  Future<void> signOut();
}
