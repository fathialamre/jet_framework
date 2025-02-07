import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:jet_framework/bindings/jet_injector.dart';
import 'package:jet_framework/exceptions/jet_exception_handler.dart';
import 'package:jet_framework/helpers/jet_logger.dart';

String get getBaseUrl => dotenv.get('BASE_URL', fallback: '');

getEnv(String key, {String? fallback}) => dotenv.get(
      key,
      fallback: fallback,
    );

isDebug() => getEnv('APP_DEBUG', fallback: 'false') == 'true';

getEnvLocal() {
  return Locale(
    getEnv('APP_LOCALE', fallback: 'en'),
  );
}

ifNotNull(bool condition, Function() callback) {
  if (condition) {
    callback();
  }
}

ifNull(bool condition, Function() callback) {
  if (!condition) {
    callback();
  }
}

showToast(BuildContext context, String message, {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.black87 : Colors.green,
    ),
  );
}

showError(String message) {
  Get.showSnackbar(
    GetSnackBar(
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      message: message,
      backgroundColor: Colors.black87,
      duration: const Duration(seconds: 3),
    ),
  );
}

errorHandler(Object? error, StackTrace? stackTrace) {
  final errorHandler = JetApp.errorHandler;
  return errorHandler.handle(error!, stackTrace);
}

tryWithDump(
  Function() callback, {
  String? tag,
  Function({StackTrace? stackTrace})? onCatch,
}) {
  try {
    callback();
  } catch (e, s) {
    onCatch?.call(stackTrace: s);
    dump(e, stackTrace: s, tag: tag);
  }
}
