import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:time_machine/core/utils/logging.dart.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'app.dart';
import 'data/settings/settings_repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initLogger();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  await Hive.initFlutter();
  await Hive.openBox(SettingsRepository.boxPath);

  runApp(const ProviderScope(child: App()));
}
