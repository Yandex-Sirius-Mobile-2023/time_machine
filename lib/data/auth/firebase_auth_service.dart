import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:time_machine/data/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_machine/data/auth/status/auth_create_exception.dart';
import 'package:time_machine/data/auth/status/credential_sign_exception.dart';
import 'package:time_machine/data/auth/status/email_sign_exception.dart';

import 'my_user.dart';

/// Firebase authentication.
class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleAuth;

  FirebaseAuthService({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleAuth,
  })  : _firebaseAuth = firebaseAuth,
        _googleAuth = googleAuth;

  /// User in current log session.
  @override
  MyUser? get user => _firebaseAuth.currentUser != null
      ? _myUserFromFirebase(_firebaseAuth.currentUser!)
      : null;

  /// Attempts to create  user via email and password.
  ///
  /// Throws [AuthCreateException] on sign failures.
  @override
  Future<MyUser> createWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      // Sign user
      var credentials = await _firebaseAuth.createUserWithEmailAndPassword(
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
  ///
  /// Throws [EmailSignException] on sign failures.
  @override
  Future<MyUser> signInEmailAndPassword(
      {required String email, required String password}) async {
    try {
      // Sign user.
      var credentials = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
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

  /// Sign in with Google account.
  ///
  /// Throws [CredentialSignException] on sign failures.
  @override
  Future<MyUser> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleAuth.signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential.
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    try {
      var firebaseCredential = await _firebaseAuth.signInWithCredential(credential);
      return _myUserFromFirebase(firebaseCredential.user!);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "account-exists-with-different-credential":
          throw const CredentialSignException.exsistAnother();
        case "invalid-credential":
          throw const CredentialSignException.invalidCredential();
        case "user-not-found":
        default:
          throw const CredentialSignException.userNotFound();
      }
    }
  }

  @override
  Future<void> signOut() async => await _firebaseAuth.signOut();
  MyUser _myUserFromFirebase(User user) =>
      MyUser(name: user.displayName ?? "Not defined", uid: user.uid);

  /// Listen updates of user login status.
  StreamSubscription listenUpdates(Function callback) =>
      _firebaseAuth.authStateChanges().asBroadcastStream().listen((_) => callback());
}
