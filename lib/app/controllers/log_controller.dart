import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class LogController {
  static final _instance = Logger();

  LogController._();
  static void logWarning(String message) => _instance.w(
      "${DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())}: $message",
      message.toUpperCase());
  static void logInfo(String message) => _instance.i(
      "${DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())}: $message",
      message.toUpperCase());
  static void logError(String message) => _instance.e(
      "${DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())}: $message",
      message.toUpperCase());
}
