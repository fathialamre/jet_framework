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
    this.submitLabel,
    required this.controller,
  });

  final JetFormController controller;

  /// Optional widget to display above the form fields.
  final Widget? header;

  /// Automatically hides the keyboard on submit.
  final bool dismissKeyboard;
  final String? submitLabel;

  /// Optional footer widget builder.
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: FormBuilder(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (header != null) header!,
              const SizedBox(height: 10),
              ...controller.fields.map((field) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: field,
                );
              }),
              const SizedBox(height: 10),
              footer != null
                  ? footer!
                  : JetButton.elevated(
                      expanded: true,
                      label: submitLabel ?? 'Submit'.tr,
                      onPressed: () async {
                        await controller.submit();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
