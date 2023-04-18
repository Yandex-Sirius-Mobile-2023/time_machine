import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:time_machine/data/auth/firebase_auth_service.dart';

import '../../data/auth/auth_service.dart';

final firebaseAuthProvider = Provider<FirebaseAuthService>(
  (ref) => FirebaseAuthService(
    firebaseAuth: FirebaseAuth.instance,
    googleAuth: GoogleSignIn(),
  ),
);

final emailSignProvider =
    Provider<EmailAuthService>((ref) => ref.watch(firebaseAuthProvider));

final googleSignProvider =
    Provider<GoogleAuthService>((ref) => ref.watch(firebaseAuthProvider));
