import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jet_framework/bindings/jet_injector.dart';
import 'package:jet_framework/exceptions/jet_error.dart';
import 'package:jet_framework/exceptions/jet_exception_handler.dart';
import 'package:jet_framework/helpers/helper.dart';
import 'package:jet_framework/helpers/jet_logger.dart';
import 'package:jet_framework/networking/jet_service.dart';
import 'package:jet_framework/resources/widgets/jet_error_widget.dart';
import 'package:jet_framework/state/jet_state.dart';

import 'jet_filed.dart';

typedef JetDecoder<R> = R Function(Map<String, dynamic> json);

/// A controller for managing form data and submission logic.
///
/// - [T]: The type of data returned after form submission.
/// - [R]: The type of the request model (parsed form data).
abstract class JetFormController<T, R> extends GetxController {
  /// Global key for managing the form state.
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  final RxBool isLoading = false.obs;

  /// List of fields in the form.
  /// Override this getter to define the form fields.
  List<JetField> get fields;

  bool get showErrorToast => true;

  // The global service instance.
  JetService get service => JetApp.apiService;

  /// Function to parse the form data into a request object of type [R].
  /// Override this getter to provide a custom parser.
  JetDecoder<R>? get decoder => null;

  /// Returns the parsed form data or raw data if no parser is provided.
  R get formValue => _getFormValue(true);

  /// Returns the raw form data.
  dynamic get formRawValue => _getFormValue(false);

  /// Invalidates a specific field with an error message.
  void invalidField(String name, String error) {
    formKey.currentState?.fields[name]?.invalidate(error);
  }

  /// Invalidates multiple fields with error messages.
  void invalidFields(Map<String, String> errors) {
    if (errors.isNotEmpty) {
      errors.forEach(invalidField);
    }
  }

  /// Resets the form to its initial state.
  void reset() {
    formKey.currentState?.reset();
  }

  /// Submits the form and returns a [Future] with the result.
  ///
  /// Override this method to implement custom submission logic.
  Future<T?> action();

  /// Handles form submission, including success and error callbacks.
  Future<void> submit() async {
    try {
      // Validate and save the form
      if (formKey.currentState?.saveAndValidate() ?? false) {
        isLoading.value = true;
        // Call the form action and handle the response
        final response = await action();
        if (response != null) {
          onSuccess(response);
        }
      } else {
        throw Exception('Form validation failed.');
      }
    } catch (err, stackTrace) {
      onError(err, stackTrace);
    } finally {
      isLoading.value = false;
    }
  }

  /// Callback for successful form submission.
  /// Override this method to handle success cases.
  void onSuccess(T result) {
    // Default implementation does nothing.
  }

  /// Callback for form submission errors.
  void onError(Object error, StackTrace stackTrace) {
    final result = JetApp.errorHandler.formErrors(
      error,
      showToast: showErrorToast,
    );

    if (result != null) {
      invalidFields(result);
    }
  }

  /// Helper method to retrieve form data.
  dynamic _getFormValue(bool toModel) {
    final formState = formKey.currentState;
    tryWithDump(
      () {
        if (formState?.saveAndValidate() ?? false) {
          if (toModel && decoder != null) {
            return decoder!(formState!.value);
          }
          return formState!.value; // Return raw data if no parser is provided
        }
        return null;
      },
    );
    try {
      if (formState?.saveAndValidate() ?? false) {
        if (toModel && decoder != null) {
          return decoder!(formState!.value);
        }
        return formState!.value; // Return raw data if no parser is provided
      }
      return null;
    } catch (e, stackTrace) {
      dump('message', stackTrace: stackTrace);
      // stackTrace.dump();
      // throw JetError('Failed to parse form data: $e');
    }
  }
}
