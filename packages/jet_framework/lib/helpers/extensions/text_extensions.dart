import 'package:flutter/material.dart';

extension TextThemeExtensions on Text {
  // Title variants
  Text titleSmall(BuildContext context, {Key? key}) =>
      _styledText(context, Theme.of(context).textTheme.titleSmall, key);

  Text titleMedium(BuildContext context, {Key? key}) =>
      _styledText(context, Theme.of(context).textTheme.titleMedium, key);

  Text titleLarge(BuildContext context, {Key? key}) =>
      _styledText(context, Theme.of(context).textTheme.titleLarge, key);

  // Body variants
  Text bodySmall(BuildContext context, {Key? key}) =>
      _styledText(context, Theme.of(context).textTheme.bodySmall, key);

  Text bodyMedium(BuildContext context, {Key? key}) =>
      _styledText(context, Theme.of(context).textTheme.bodyMedium, key);

  Text bodyLarge(BuildContext context, {Key? key}) =>
      _styledText(context, Theme.of(context).textTheme.bodyLarge, key);

  // Label variants
  Text labelSmall(BuildContext context, {Key? key}) =>
      _styledText(context, Theme.of(context).textTheme.labelSmall, key);

  Text labelMedium(BuildContext context, {Key? key}) =>
      _styledText(context, Theme.of(context).textTheme.labelMedium, key);

  Text labelLarge(BuildContext context, {Key? key}) =>
      _styledText(context, Theme.of(context).textTheme.labelLarge, key);

  // Headline variants
  Text headlineSmall(BuildContext context, {Key? key}) =>
      _styledText(context, Theme.of(context).textTheme.headlineSmall, key);

  Text headlineMedium(BuildContext context, {Key? key}) =>
      _styledText(context, Theme.of(context).textTheme.headlineMedium, key);

  Text headlineLarge(BuildContext context, {Key? key}) =>
      _styledText(context, Theme.of(context).textTheme.headlineLarge, key);

  // Display variants
  Text displaySmall(BuildContext context, {Key? key}) =>
      _styledText(context, Theme.of(context).textTheme.displaySmall, key);

  Text displayMedium(BuildContext context, {Key? key}) =>
      _styledText(context, Theme.of(context).textTheme.displayMedium, key);

  Text displayLarge(BuildContext context, {Key? key}) =>
      _styledText(context, Theme.of(context).textTheme.displayLarge, key);

  // ✅ Added styling extensions
  Text bold() => _applyStyle(const TextStyle(fontWeight: FontWeight.bold));

  Text underline() =>
      _applyStyle(const TextStyle(decoration: TextDecoration.underline));

  Text color(Color color) => _applyStyle(TextStyle(color: color));

  Text fontSize(double size) => _applyStyle(TextStyle(fontSize: size));

  /// Helper to merge styles dynamically
  Text _applyStyle(TextStyle style) {
    return Text(
      data ?? '',
      key: key,
      style: (this.style ?? const TextStyle()).merge(style),
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }

  Text _styledText(BuildContext context, TextStyle? style, Key? key) {
    return Text(
      data ?? '',
      key: key ?? this.key,
      style: (style ?? const TextStyle()).merge(this.style),
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }

  // ✅ Improved copyWith extension for more flexibility
  Text copyWith({
    String? data,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
    Key? key,
  }) {
    return Text(
      data ?? this.data ?? '',
      key: key ?? this.key,
      style: style ?? this.style,
      strutStyle: strutStyle ?? this.strutStyle,
      textAlign: textAlign ?? this.textAlign,
      textDirection: textDirection ?? this.textDirection,
      locale: locale ?? this.locale,
      softWrap: softWrap ?? this.softWrap,
      overflow: overflow ?? this.overflow,
      textScaler: textScaler ?? this.textScaler,
      maxLines: maxLines ?? this.maxLines,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      textWidthBasis: textWidthBasis ?? this.textWidthBasis,
      textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
      selectionColor: selectionColor ?? this.selectionColor,
    );
  }
}
