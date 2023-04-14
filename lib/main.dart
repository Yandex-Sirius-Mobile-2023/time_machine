import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/core/utils/logging.dart.dart';

import 'app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initLogger();
  
  runApp(const App());
}

