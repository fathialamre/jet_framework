// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:jet/forms/jet_filed.dart';
//
// /// Typedef for parsing form data into a request object of type [T].
// typedef ModelParser<T> = T Function(Map<String, dynamic> json);
//
// /// Abstract class for handling form data in Flutter.
// abstract class JetFormData<T, R> {
//   /// Global key for managing the form state.
//   GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
//
//   /// List of fields in the form.
//   List<JetField> get fields;
//
//   /// Function to parse the form data into a request object of type [T].
//   /// If not provided, raw data will be returned.
//   ModelParser<T>? get modelParser => null;
//
//   /// Returns the parsed form data or raw data if no parser is provided.
//   T? get formValue => _getFormValue(true);
//
//   /// Returns the raw form data.
//   dynamic get formRawValue => _getFormValue(false);
//
//   /// Invalidates a specific field with an error message.
//   void invalidField(String name, String error) {
//     formKey.currentState?.fields[name]?.invalidate(error);
//   }
//
//   /// Invalidates multiple fields with error messages.
//   void invalidFields(Map<String, String> errors) {
//     if (errors.isNotEmpty) {
//       errors.forEach(invalidField);
//     }
//   }
//
//   /// Resets the form to its initial state.
//   void reset() {
//     formKey.currentState?.reset();
//   }
//
//   /// Helper method to retrieve form data.
//   dynamic _getFormValue(bool toModel) {
//     final formState = formKey.currentState;
//     if (formState?.saveAndValidate() ?? false) {
//       if (toModel && modelParser != null) {
//         return modelParser!(formState!.value);
//       }
//       return formState!.value; // Return raw data if no parser is provided
//     }
//     return null;
//   }
// }
