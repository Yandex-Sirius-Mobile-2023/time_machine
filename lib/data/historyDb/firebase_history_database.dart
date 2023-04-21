import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:logging/logging.dart';
import 'package:time_machine/data/auth/firebase_auth_service.dart';

import 'history_database.dart';

Logger logger = Logger("FirebaseHistoryDatabase");

class FirebaseHistoryDatabase implements HistoryDatabase {
  final FirebaseAuthService auth;
  final DatabaseReference ref;

  FirebaseHistoryDatabase({required this.auth, required this.ref});

  @override
  Future<void> addHistoryJson(Map<String, dynamic> json) {
    var uid = auth.user?.uid;
    if (uid == null) {
      logger.warning("Cant update collections. User is null");
      return Future.sync(() {});
    }
    return ref.child(uid).push().set(json);
  }

  @override
  Future<List<Map<String, Object?>>> getHistoryJson() async {
    var uid = auth.user?.uid;
    if (uid == null) {
      logger.warning("Cant get collections. User is null");
      return List.empty();
    }
    final res = await ref.child(uid).get();
    return res.children
        .map(
          (e) => Map<String, Object?>.from(e.value as Map<Object?, Object?>),
        )
        .toList();
  }
}
