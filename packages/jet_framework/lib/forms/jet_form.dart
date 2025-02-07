import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jet_framework/helpers/jet_logger.dart';
import 'package:jet_framework/resources/widgets/jet_button.dart';

import 'jet_form_controller.dart';

class JetForm<T> extends StatelessWidget {
  const JetForm({
    super.key,
    this.header,
    this.dismissKeyboard = true,
    this.footer,
    required this.formController,
  });

  final JetFormController formController;

  /// Optional widget to display above the form fields.
  final Widget? header;

  /// Automatically hides the keyboard on submit.
  final bool dismissKeyboard;

  /// Optional footer widget builder.
  final Widget Function(BuildContext context)? footer;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
        key: formController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (header != null) header!,
            const SizedBox(height: 10),
            ...formController.fields.map((field) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: field,
              );
            }),
            const SizedBox(height: 10),
            footer != null
                ? footer!(context)
                : JetButton.elevated(
                    expanded: true,
                    label: 'Submit'.tr,
                    onPressed: () async {
                      await formController.submit();
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
