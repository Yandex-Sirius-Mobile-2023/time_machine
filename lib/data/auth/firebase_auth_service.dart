import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:time_machine/data/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:time_machine/data/auth/status/auth_create_exception.dart';
import 'package:time_machine/data/auth/status/credential_sign_exception.dart';
import 'package:time_machine/data/auth/status/email_sign_exception.dart';

import 'user.dart';

/// Firebase authentication.
class FirebaseAuthService implements AuthService {
  static const String notDefinedName = "Not defined";
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleAuth;

  FirebaseAuthService({
    required firebase_auth.FirebaseAuth firebaseAuth,
    required GoogleSignIn googleAuth,
  })  : _firebaseAuth = firebaseAuth,
        _googleAuth = googleAuth;

  /// User in current logging session.
  @override
  User? get user => _firebaseAuth.currentUser != null
      ? _myUserFromFirebase(_firebaseAuth.currentUser!)
      : null;

  /// Attempts to create user via email and password.
  ///
  /// Throws [AuthCreateException] on sign failures.
  @override
  Future<User> createWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Sign user
      var credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _myUserFromFirebase(credentials.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      switch (e.code) {
        case FirebaseErrorCode.usedEmail:
          throw const AuthCreateException.emailAlreadyUsed();
        case FirebaseErrorCode.weakPassword:
          throw const AuthCreateException.weakPassword();
        case FirebaseErrorCode.invalidEmail:
        default:
          throw const AuthCreateException.invalidEmail();
      }
    }
  }

  /// Attempts to sign in user via email and password.
  ///
  /// Throws [EmailSignException] on sign failures.
  @override
  Future<User> signInEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Sign user.
      var credentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _myUserFromFirebase(credentials.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      switch (e.code) {
        case FirebaseErrorCode.userNotFound:
          throw const EmailSignException.userNotFound();
        case FirebaseErrorCode.wrongPassword:
        case FirebaseErrorCode.invalidEmail:
        default:
          throw const EmailSignException.wrondCredentials();
      }
    }
  }

  /// Sign in with Google account.
  ///
  /// Throws [CredentialSignException] on sign failures.
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleAuth.signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential.
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    try {
      var firebaseCredential = await _firebaseAuth.signInWithCredential(credential);
      return _myUserFromFirebase(firebaseCredential.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      switch (e.code) {
        case FirebaseErrorCode.exsistWithAnotherCredential:
          throw const CredentialSignException.exsistAnother();
        case FirebaseErrorCode.invalidCredential:
          throw const CredentialSignException.invalidCredential();
        case FirebaseErrorCode.userNotFound:
        default:
          throw const CredentialSignException.userNotFound();
      }
    }
  }

  @override
  Future<void> signOut() async => await _firebaseAuth.signOut();

  User _myUserFromFirebase(firebase_auth.User user) =>
      User(name: user.displayName ?? notDefinedName, uid: user.uid);

  /// Listen updates of user login status.
  StreamSubscription listenUpdates(Function callback) =>
      _firebaseAuth.authStateChanges().asBroadcastStream().listen((_) => callback());
}

/// Error codes of Firebase Auth package.
abstract class FirebaseErrorCode {
  static const String usedEmail = "email-already-in-use";
  static const String weakPassword = "weak-password";
  static const String invalidEmail = "invalid-email";
  static const String userNotFound = "user-not-found";
  static const String wrongPassword = "wrong-password";
  static const String invalidCredential = "email-already-in-use";
  static const String exsistWithAnotherCredential =
      "account-exists-with-different-credential";
}
