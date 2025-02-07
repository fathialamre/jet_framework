import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jet_framework/resources/widgets/jet_button.dart';
import 'package:jet_framework/router/jet_router.dart';

class JetDialog {
  /// Shows a customizable confirmation dialog.
  static void showConfirmationDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    required BuildContext context,
    VoidCallback? onCancel,
    String? confirmText,
    String? cancelText,
    Color? confirmTextColor,
    Color? cancelTextColor,
    Color? buttonColor,
    double radius = 10.0,
    EdgeInsets contentPadding = const EdgeInsets.all(20),
    TextStyle? titleStyle,
    TextStyle? middleTextStyle,
    bool barrierDismissible = false,
  }) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      textConfirm: confirmText ?? 'Yes'.tr,
      textCancel: cancelText ?? 'No'.tr,
      confirmTextColor: confirmTextColor,
      cancelTextColor: cancelTextColor ?? context.theme.colorScheme.onSurface,
      buttonColor: buttonColor ?? context.theme.primaryColor,
      onConfirm: () {
        routeBack();
        onConfirm();
      },
      onCancel: onCancel ?? () => routeBack(),
      radius: radius,
      contentPadding: contentPadding,
      titleStyle: titleStyle ??
          context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
      middleTextStyle: middleTextStyle ?? context.textTheme.bodySmall,
      barrierDismissible: barrierDismissible,
    );
  }

  static void showConfirmationBottomSheet({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String? confirmText,
    String? cancelText,
    Color? confirmTextColor,
    Color? cancelTextColor,
    Color? buttonColor,
    double radius = 20.0,
    EdgeInsets contentPadding = const EdgeInsets.all(24),
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    bool barrierDismissible = true,
    Color? backgroundColor,
    double elevation = 4.0,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    AnimationController? transitionAnimationController,
    Duration? enterBottomSheetDuration,
    Duration? exitBottomSheetDuration,
    bool enableDrag = true,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool ignoreSafeArea = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Get.bottomSheet(
      Container(
        padding: contentPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: titleStyle ??
                  theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: messageStyle ??
                  theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                JetButton.outline(
                  onPressed: () {
                    Get.back();
                    onCancel?.call();
                  },
                  label: cancelText ?? 'No'.tr,
                ),
                const SizedBox(width: 8),
                JetButton.outline(
                  onPressed: () {
                    Get.back();
                    onConfirm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor ?? colorScheme.primary,
                    foregroundColor: confirmTextColor ?? colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(radius),
                    ),
                  ),
                  label: confirmText ?? 'Yes'.tr,
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      elevation: elevation,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
            ),
          ),
      clipBehavior: clipBehavior ?? Clip.hardEdge,
      enterBottomSheetDuration:
          enterBottomSheetDuration ?? const Duration(milliseconds: 250),
      exitBottomSheetDuration:
          exitBottomSheetDuration ?? const Duration(milliseconds: 200),
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      settings: RouteSettings(name: 'ConfirmationBottomSheet'),
      ignoreSafeArea: ignoreSafeArea,
    );
  }
}
