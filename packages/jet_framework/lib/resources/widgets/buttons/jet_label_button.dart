import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jet_framework/bindings/jet_injector.dart';
import 'package:jet_framework/resources/widgets/jet_button.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JetTextButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AsyncCallback? onAsyncPressed;
  final bool autoHideKeyboard;
  final bool isFuture;
  final RxBool _isLoading = false.obs;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;

  JetTextButton({
    super.key,
    required this.label,
    this.onPressed,
    this.onAsyncPressed,
    this.autoHideKeyboard = true,
    this.isFuture = false,
    this.textStyle,
    this.buttonStyle,
  });

  factory JetTextButton.future({
    required String label,
    required AsyncCallback onPressed,
    bool autoHideKeyboard = true,
    ButtonStyle? buttonStyle,
    TextStyle? textStyle,
  }) =>
      JetTextButton(
        label: label,
        onAsyncPressed: onPressed,
        isFuture: true,
        autoHideKeyboard: autoHideKeyboard,
        buttonStyle: buttonStyle,
      );

  @override
  Widget build(BuildContext context) {
    final child = Text(label, style: textStyle);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Obx(
        () => _isLoading.value
            ? JetApp.style.buttonLoader(context)
            : TextButton(
                onPressed: () async {
                  if (isFuture) {
                    _isLoading.value = true;
                    if (autoHideKeyboard) FocusScope.of(context).unfocus();
                    try {
                      await onAsyncPressed!();
                    } finally {
                      if (context.mounted) _isLoading.value = false;
                    }
                  } else {
                    onPressed?.call();
                  }
                },
                style: buttonStyle, // Apply the optional style here
                child: child,
              ),
      ),
    );
  }
}
