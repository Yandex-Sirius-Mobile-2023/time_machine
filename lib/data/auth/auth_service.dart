import 'package:time_machine/data/auth/my_user.dart';

/// Service to provide sign in, create and store user.
abstract class AuthService {
  /// Current signed user.
  /// [Null] if user not signed in.
  MyUser? get user;

  /// Attempts to sign in a user with the given email address and password.
  Future<MyUser> signInEmailAndPassword(
      {required String email, required String password});

  /// Attempts to create in a user with the given email address and password.
  Future<MyUser> createWithEmailAndPassword(
      {required String email, required String password});

  /// Attempts to sign in a user with the Google provider.
  Future<MyUser> signInWithGoogle();

  /// Attempts to sign in a user with the Apple provider.
  Future<MyUser> signInWithApple();

  /// Sign out current user.
  Future<void> signOut();
}
