import 'package:logging/logging.dart';
import "dart:developer";

Logger logger = Logger("dsffdsfsd");

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
    log('[${record.level}],[${record.loggerName}]: ${record.message}\n\t${stackTrace != null ? "Stack trace: $stackTrace" : ""}');
  });
}
