import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart' as debug_logger;
import 'package:provider_start/core/utils/simple_log_printer.dart'
    as debug_logger_util;
import 'package:mockito/mockito.dart';

/// Run this before starting app
void setupLogger({bool test = false}) {
  if (test) {
    Logger.useClient(_MockClient());
  } else if (!kReleaseMode) {
    // Add standard log output only on debug builds
    debug_logger.Logger.level = debug_logger.Level.verbose;
    Logger.useClient(_DebugLoggerClient());
  } else {
    // Pass all uncaught errors from the framework to something like Crashlytics.
  }
}

class _MockClient extends Mock implements _LoggerClient {
  @override
  void log({LogLevel level, String message, e, StackTrace s}) {}
}

class Logger {
  static _LoggerClient _client;

  /// Debug level logs
  static void d(
    String message, {
    dynamic e,
    StackTrace s,
  }) {
    _client.log(
      level: LogLevel.debug,
      message: message,
      e: e,
      s: s,
    );
  }

  // Warning level logs
  static void w(
    String message, {
    dynamic e,
    StackTrace s,
  }) {
    _client.log(
      level: LogLevel.warning,
      message: message,
      e: e,
      s: s,
    );
  }

  /// Error level logs
  /// Requires a current StackTrace to report correctly on Crashlytics
  /// Always reports as non-fatal to Crashlytics
  static void e(
    String message, {
    dynamic e,
    StackTrace s,
  }) {
    _client.log(
      level: LogLevel.error,
      message: message,
      e: e,
      s: s,
    );
  }

  static void useClient(_LoggerClient client) {
    _client = client;
  }
}

enum LogLevel { debug, warning, error }

abstract class _LoggerClient {
  void log({
    LogLevel level,
    String message,
    dynamic e,
    StackTrace s,
  });
}

/// Debug logger that just prints to console
class _DebugLoggerClient implements _LoggerClient {
  final debug_logger.Logger _logger = debug_logger_util.getLogger();

  @override
  void log({
    LogLevel level,
    String message,
    dynamic e,
    StackTrace s,
  }) {
    switch (level) {
      case LogLevel.debug:
        if (e != null) {
          _logger.d(message, e.toString(), s ?? StackTrace.current);
        } else {
          _logger.d(message);
        }
        break;
      case LogLevel.warning:
        if (e != null) {
          _logger.w(message, e.toString(), s ?? StackTrace.current);
        } else {
          _logger.w(message);
        }
        break;
      case LogLevel.error:
        if (e != null) {
          _logger.e(message, e.toString(), s ?? StackTrace.current);
        } else {
          _logger.e(message, null, s ?? StackTrace.current);
        }
        break;
    }
  }
}
