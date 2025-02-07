import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:jet_framework/helpers/helper.dart';

class JetErrorHandler {
  String handle(Object error, [StackTrace? stackTrace]) {
    if (error is DioException) {
      return dioError(error);
    }
    return error.toString();
  }

  Map<String, String>? formErrors(Object error, {bool showToast = false}) {
    if (error is DioException) {
      return extractValidationMessages(error, showToast: showToast);
    }
    return null;
  }

  String dioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout'.tr;
      case DioExceptionType.sendTimeout:
        return 'Send timeout'.tr;
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout'.tr;
      case DioExceptionType.badResponse:
        return error.response?.statusCode == 422
            ? 'Some fields are invalid'.tr
            : 'Bad response error'.tr;
      case DioExceptionType.cancel:
        return 'Request cancelled'.tr;
      case DioExceptionType.unknown:
        return 'Unknown error'.tr;
      case DioExceptionType.badCertificate:
        return 'Bad certificate'.tr;
      case DioExceptionType.connectionError:
        return 'Connection error'.tr;
    }
  }

  Map<String, String>? extractValidationMessages(
    DioException error, {
    bool showToast = false,
  }) {
    if (error.response?.statusCode != 422) return null;

    final responseData = error.response?.data;
    if (responseData is! Map<String, dynamic>) return null;

    final validationErrors = responseData['errors'];
    if (validationErrors is! Map<String, dynamic>) return null;

    if (showToast && validationErrors.isNotEmpty) {
      showError(dioError(error));
    }

    return validationErrors.map(
      (key, value) => MapEntry(
        key,
        value is List ? value.first : value.toString(),
      ),
    );
  }
}
