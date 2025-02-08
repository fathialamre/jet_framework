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
      if (error.response?.statusCode == 422) {
        return validationMessages(error, showToast: showToast);
      } else {
        if (showToast) {
          showError(dioError(error));
        }
      }
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
        final response = error.response;
        switch (error.response?.statusCode) {
          case 401:
            return response?.data['message'] ?? 'Unauthorized'.tr;
          case 422:
            return 'Some fields are invalid'.tr;
          default:
            return 'Bad response error'.tr;
        }

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

  Map<String, String>? validationMessages(
    DioException error, {
    bool showToast = false,
  }) {
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
