import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jet_framework/bindings/jet_injector.dart';

enum ButtonAlignment {
  left,
  center,
  right,
}

typedef ModelDecoder<T> = T Function(Map<String, dynamic>);
typedef AsyncCallback = Future<void> Function();

class JetButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final bool isOutline;
  final bool isText;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final bool expanded;
  final ButtonAlignment buttonAlignment;
  final RxBool _isLoading = false.obs;

  JetButton._({
    super.key,
    this.label,
    this.icon,
    this.isOutline = false,
    this.isText = false,
    this.onPressed,
    this.style,
    this.expanded = false,
    this.buttonAlignment = ButtonAlignment.center,
  });

  factory JetButton.icon({
    Key? key,
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    bool autoHideKeyboard = true,
    ButtonStyle? style,
    bool expanded = false,
    ButtonAlignment alignment = ButtonAlignment.center,
  }) =>
      JetButton._(
        key: key,
        label: label,
        icon: icon,
        onPressed: onPressed,
        style: style,
        expanded: expanded,
        buttonAlignment: alignment,
      );

  factory JetButton.outline({
    Key? key,
    required String label,
    required VoidCallback onPressed,
    bool autoHideKeyboard = true,
    ButtonStyle? style,
    bool expanded = false,
    ButtonAlignment alignment = ButtonAlignment.center,
  }) =>
      JetButton._(
        key: key,
        label: label,
        isOutline: true,
        onPressed: onPressed,
        style: style,
        expanded: expanded,
        buttonAlignment: alignment,
      );

  factory JetButton.text({
    Key? key,
    required String label,
    required VoidCallback? onPressed,
    ButtonStyle? style,
  }) =>
      JetButton._(
        key: key,
        label: label,
        isText: true,
        onPressed: onPressed,
        style: style,
      );

  factory JetButton.elevated({
    Key? key,
    required String label,
    required VoidCallback onPressed,
    ButtonStyle? style,
    bool expanded = false,
    ButtonAlignment alignment = ButtonAlignment.center,
  }) =>
      JetButton._(
        key: key,
        label: label,
        onPressed: onPressed,
        style: style,
        expanded: expanded,
        buttonAlignment: alignment,
      );

  Future<void> _handlePress(BuildContext context) async {
    if (onPressed is Future Function()) {
      _isLoading.value = true;
      try {
        await (onPressed as Future Function())();
      } finally {
        if (context.mounted) _isLoading.value = false;
      }
    } else {
      onPressed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final child = _isLoading.value
          ? SizedBox(
              height: 24,
              width: 24,
              child: JetApp.style.buttonLoader(context),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) Icon(icon, size: 18),
                if (icon != null && label != null) const SizedBox(width: 8),
                if (label != null) Text(label!),
              ],
            );

      if (isText) {
        return TextButton(
          onPressed: _isLoading.value ? null : () => _handlePress(context),
          style: style,
          child: child,
        );
      }

      final button = isOutline
          ? OutlinedButton(
              onPressed: _isLoading.value ? null : () => _handlePress(context),
              style: style,
              child: child,
            )
          : expanded
              ? ElevatedButton(
                  onPressed:
                      _isLoading.value ? null : () => _handlePress(context),
                  style: style,
                  child: child,
                )
              : Row(
                  mainAxisAlignment: _getMainAxisAlignment(buttonAlignment),
                  children: [
                    ElevatedButton(
                      onPressed:
                          _isLoading.value ? null : () => _handlePress(context),
                      style: style,
                      child: child,
                    ),
                  ],
                );

      return button;
    });
  }

  MainAxisAlignment _getMainAxisAlignment(ButtonAlignment alignment) {
    switch (alignment) {
      case ButtonAlignment.left:
        return MainAxisAlignment.start;
      case ButtonAlignment.center:
        return MainAxisAlignment.center;
      case ButtonAlignment.right:
        return MainAxisAlignment.end;
    }
  }
}
