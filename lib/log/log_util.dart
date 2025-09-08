import 'dart:core';
import 'dart:io';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class CustomOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    event.lines.forEach(debugPrint);
  }
}

var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: !Platform.isIOS,
    printEmojis: true,
  ),
  output: CustomOutput(),
);

/// Logging config
void printLog([dynamic rawData, Level? level]) {
  /// 如果不想打log
  // if (false) {
  //   return;
  // }
  if (foundation.kDebugMode) {
    try {
      final data = '$rawData';
      final log = '${DateFormat.Hms().format(DateTime.now())} ${data.toString()}';
      debugPrint(log);
      return;
    } catch (err, trace) {
      printError(err, trace);
    }
  }
}

void printError(dynamic err, [dynamic trace, dynamic message]) {
  if (!foundation.kDebugMode) {
    return;
  }

  final shouldHide = trace == null ||
      '$trace'.isEmpty ||
      '$trace'.contains('package:inspireui');
  if (shouldHide) {
    logger.d(err, error: message, stackTrace: StackTrace.empty);
    return;
  }

  logger.e(err, error: message ?? 'Stack trace:', stackTrace: trace);
}
