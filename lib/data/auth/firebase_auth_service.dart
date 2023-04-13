import 'package:time_machine/data/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_machine/data/auth/status/auth_create_exception.dart';
import 'package:time_machine/data/auth/status/email_sign_exception.dart';

import 'my_user.dart';

/// Firebase authentication.
class FirebaseAuthService implements AuthService {
  final FirebaseAuth _auth;

  FirebaseAuthService(this._auth);

  /// User in current log session.
  @override
  MyUser? get user =>
      _auth.currentUser != null ? _myUserFromFirebase(_auth.currentUser!) : null;

  /// Attempts to create  user via email and password.
  /// Throws [AuthCreateException] on sign failures.
  @override
  Future<MyUser> createWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      // Sign user
      var credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return _myUserFromFirebase(credentials.user!);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use:":
          throw const AuthCreateException.emailAlreadyUsed();
        case "weak-password":
          throw const AuthCreateException.weakPassword();
        case "invalid-email":
        default:
          throw const AuthCreateException.invalidEmail();
      }
    }
  }

  /// Attempts to sign in user via email and password.
  /// Throws [EmailSignException] on sign failures.
  @override
  Future<MyUser> signInEmailAndPassword(
      {required String email, required String password}) async {
    try {
      // Sign user
      var credentials =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _myUserFromFirebase(credentials.user!);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          throw const EmailSignException.userNotFound();
        case "wrong-password":
        case "invalid-email":
        default:
          throw const EmailSignException.wrondCredentials();
      }
    }
  }

  @override
  Future<MyUser> signInWithApple() async {
    throw UnimplementedError();
  }

  @override
  Future<MyUser> signInWithGoogle() async {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async => await _auth.signOut();

  MyUser _myUserFromFirebase(User user) =>
      MyUser(name: user.displayName ?? "Not defined", uid: user.uid);
}
