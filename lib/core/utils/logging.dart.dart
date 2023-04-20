import 'package:logging/logging.dart';
import "dart:developer";
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// Config logger prefernces.
///
/// Example of logging info.
/// ```
/// Logger logger = new Logger("This class");
///
/// void someWork(){
///   // or call logger.info(...)
///   logger.log(Level.INFO, "Some text");
/// }
/// ```
/// Example of logging errors.
/// ```
/// Logger logger = new Logger("This buggy class");
///
/// ...
///
/// void logException(Exception e, StackTrace stackTrace){
///   logger.severe("Some comments", e, stackTrace);
/// }
/// ```
void initLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    var stackTrace = record.stackTrace;
    var error = record.error;
    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: 'a non-fatal error',
    );

    String errorMessage =
        stackTrace != null ? "\n\tError:$error\nStack trace: $stackTrace" : "";
    log('[${record.level}],[${record.loggerName}]: ${record.message}$errorMessage');
  });
}
