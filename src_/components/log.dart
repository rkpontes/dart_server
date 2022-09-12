import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printTime: true, // Should each log print contain a timestamp
    ),
  );

  static void debug(dynamic message) {
    _logger.d(message);
  }

  static void verbose(dynamic message) {
    _logger.v(message);
  }

  static void info(dynamic message) {
    _logger.i(message);
  }

  static void warning(dynamic message) {
    _logger.w(message);
  }

  static void error(dynamic message) {
    _logger.e(message);
  }

  static void wtf(dynamic message) {
    _logger.wtf(message);
  }
}
