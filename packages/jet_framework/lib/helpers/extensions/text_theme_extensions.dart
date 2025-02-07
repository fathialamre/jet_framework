import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension TextThemeExtensions on TextTheme {
  static TextTheme applyScaling(TextTheme base) {
    return base.copyWith(
      titleSmall: base.titleMedium?.copyWith(fontSize: 14.sp) ??
          TextStyle(fontSize: 14.sp),
      titleMedium: base.titleMedium?.copyWith(fontSize: 16.sp) ??
          TextStyle(fontSize: 16.sp),
      titleLarge: base.titleLarge?.copyWith(fontSize: 18.sp) ??
          TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      bodySmall: base.bodyMedium?.copyWith(fontSize: 12.sp) ??
          TextStyle(fontSize: 12.sp),
      bodyMedium: base.bodyMedium?.copyWith(fontSize: 14.sp) ??
          TextStyle(fontSize: 14.sp),
      bodyLarge: base.bodyLarge?.copyWith(fontSize: 16.sp) ??
          TextStyle(fontSize: 16.sp),
      labelSmall: base.labelMedium?.copyWith(fontSize: 10.sp) ??
          TextStyle(fontSize: 10.sp),
      labelMedium: base.labelMedium?.copyWith(fontSize: 12.sp) ??
          TextStyle(fontSize: 12.sp),
      labelLarge: base.labelLarge?.copyWith(fontSize: 14.sp) ??
          TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
      headlineSmall: base.headlineSmall?.copyWith(fontSize: 20.sp) ??
          TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
      headlineMedium: base.headlineMedium?.copyWith(fontSize: 24.sp) ??
          TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
      headlineLarge: base.headlineLarge?.copyWith(fontSize: 28.sp) ??
          TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
      displaySmall: base.displaySmall?.copyWith(fontSize: 30.sp) ??
          TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
      displayMedium: base.displayMedium?.copyWith(fontSize: 36.sp) ??
          TextStyle(fontSize: 36.sp, fontWeight: FontWeight.bold),
      displayLarge: base.displayLarge?.copyWith(fontSize: 44.sp) ??
          TextStyle(fontSize: 44.sp, fontWeight: FontWeight.bold),
    );
  }
}
