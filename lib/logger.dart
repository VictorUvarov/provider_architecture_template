import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:logger/logger.dart' as fancy;

void setupLogger() {
  Logger.root.level = kReleaseMode ? Level.OFF : Level.ALL;
  Logger.root.onRecord.listen((record) {
    var m =
        '${record.loggerName} ${record.level.name}: ${record.time}: ${record.message}';
    var log = _getLogger();

    // ignore: case_expression_type_implements_equals
    switch (record.level) {
      case Level.SEVERE:
        log.wtf(m);
        break;
      case Level.SHOUT:
        log.e(m);
        break;
      case Level.WARNING:
        log.w(m);
        break;
      case Level.INFO:
        log.i(m);
        break;
      case Level.CONFIG:
      case Level.FINE:
        log.d(m);
        break;
      case Level.FINER:
      case Level.FINEST:
      default:
        log.v(m);
    }
  });
}

fancy.Logger _getLogger() {
  return fancy.Logger(printer: _SimpleLogPrinter());
}

class _SimpleLogPrinter extends fancy.LogPrinter {
  @override
  List<String> log(fancy.LogEvent event) {
    var color = fancy.PrettyPrinter.levelColors[event.level];
    var emoji = fancy.PrettyPrinter.levelEmojis[event.level];
    return [color('$emoji: ${event.message}')];
  }
}
