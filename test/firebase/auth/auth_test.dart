import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:time_machine/data/auth/firebase_auth_service.dart';
import 'package:time_machine/data/auth/my_user.dart';
import 'package:time_machine/data/auth/status/auth_create_exception.dart';
import 'package:time_machine/data/auth/status/credential_sign_exception.dart';
import 'package:time_machine/data/auth/status/email_sign_exception.dart';

import 'auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseAuth>(),
  MockSpec<GoogleSignIn>(),
  MockSpec<UserCredential>(),
  MockSpec<User>()
])
void main() {
  group("Auth service", () {
    MockFirebaseAuth firebaseMock = MockFirebaseAuth();
    MockGoogleSignIn googleMock = MockGoogleSignIn();
    FirebaseAuthService authService =
        FirebaseAuthService(firebaseAuth: firebaseMock, googleAuth: googleMock);

    when(googleMock.signIn()).thenAnswer((_) async => null);

    test("Sign in email", () async {
      MockUserCredential mockUserCredential = MockUserCredential();
      MockUser user = MockUser();
      when(user.uid).thenReturn("asd");
      when(mockUserCredential.user).thenReturn(user);
      when(firebaseMock.signInWithEmailAndPassword(
              password: "123", email: "email@gmail.com"))
          .thenAnswer((_) async => mockUserCredential);
      await authService.signInEmailAndPassword(
          password: "123", email: "email@gmail.com");
      verify(firebaseMock.signInWithEmailAndPassword(
          email: "email@gmail.com", password: "123"));
    });

    group("Handle exceptions", () {
      test(
        "Create: invalid email",
        () async {
          when(firebaseMock.createUserWithEmailAndPassword(
                  email: "invalid", password: "123"))
              .thenAnswer((realInvocation) =>
                  throw FirebaseAuthException(code: "invalid-email"));
          expectLater(
            authService.createWithEmailAndPassword(
                password: "123", email: "invalid"),
            throwsA(isA<InvalidEmailCreateException>()),
          );
        },
      );

      test("Create: used email", () {
        when(firebaseMock.createUserWithEmailAndPassword(
                email: "used", password: "123"))
            .thenAnswer((realInvocation) =>
                throw FirebaseAuthException(code: "email-already-in-use"));
        expectLater(
          authService.createWithEmailAndPassword(password: "123", email: "used"),
          throwsA(isA<EmailAlreadyUsedCreateException>()),
        );
      });

      test("Create: weak password", () {
        when(firebaseMock.createUserWithEmailAndPassword(
                email: "weak_password", password: "123"))
            .thenAnswer((realInvocation) =>
                throw FirebaseAuthException(code: "weak-password"));
        expectLater(
          authService.createWithEmailAndPassword(
              password: "123", email: "weak_password"),
          throwsA(isA<WeakPasswordCreateException>()),
        );
      });

      test("Sign in: wrong password", () async {
        when(firebaseMock.signInWithEmailAndPassword(
                email: "some@gmail.com", password: "wrong"))
            .thenAnswer((realInvocation) =>
                throw FirebaseAuthException(code: "wrong-password"));
        expectLater(
          authService.signInEmailAndPassword(
              password: "wrong", email: "some@gmail.com"),
          throwsA(isA<EmailWrongCredentialException>()),
        );
      });

      test("Sign in: invalid email", () async {
        when(firebaseMock.signInWithEmailAndPassword(
                email: "invalid", password: "wrong"))
            .thenAnswer((realInvocation) =>
                throw FirebaseAuthException(code: "invalid-email"));
        expectLater(
          authService.signInEmailAndPassword(password: "wrong", email: "invalid"),
          throwsA(isA<EmailWrongCredentialException>()),
        );
      });

      test("Sign in: user not found", () async {
        when(firebaseMock.signInWithEmailAndPassword(
                email: "not-found-user", password: "wrong"))
            .thenAnswer((realInvocation) =>
                throw FirebaseAuthException(code: "user-not-found"));
        expectLater(
          authService.signInEmailAndPassword(
              password: "wrong", email: "not-found-user"),
          throwsA(isA<EmailUserNotFoundException>()),
        );
      });

      // add google auth exception check
    });
  });
}
