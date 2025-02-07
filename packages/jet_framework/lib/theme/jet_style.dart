import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jet_framework/helpers/jet_storage.dart';
import 'package:jet_framework/resources/widgets/jet_loader.dart';
import 'package:jet_framework/theme/jet_theme.dart';
import 'package:jet_framework/theme/theme_switcher.dart';

typedef JetScheme = FlexScheme;
typedef JetGoogleFonts = GoogleFonts;

enum JetThemeMode { dark, light, system }

abstract class JetBaseStyle {
  /// Returns a custom app loader widget.
  Widget get appLoader => JetLoader();

  Widget get buttonLoader => CircularProgressIndicator();

  /// Returns the current theme based on the selected scheme.
  JetTheme get theme => JetTheme(scheme: scheme, fontFamily: fontFamily);

  /// Returns the current color scheme.
  JetScheme get scheme => JetScheme.redWine;

  /// Returns the current theme mode (dark/light/system).
  ThemeMode? get themeMode => null;

  String? get fontFamily => JetGoogleFonts.notoKufiArabic().fontFamily;
}

class JetStyle extends JetBaseStyle {
  /// Sets the app theme mode and saves it to storage.
  static Future<void> setThemeMode(ThemeMode mode) async {
    await JetStorage.write(key: 'APP_THEME', value: mode.name);
    Get.changeThemeMode(mode);
  }

  /// Sets the app theme to dark mode.
  static void themeToDark() => setThemeMode(ThemeMode.dark);

  /// Sets the app theme to light mode.
  static void themeToLight() => setThemeMode(ThemeMode.light);

  /// Checks if the app is in dark mode.
  static bool isDark() => JetStorage.read(key: 'APP_THEME') == 'dark';

  /// Checks if the app is in light mode.
  static bool isLight() => JetStorage.read(key: 'APP_THEME') == 'light';

  /// Returns the current theme mode based on storage or defaults to light mode.
  ThemeMode get getThemeMode {
    if (themeMode != null) return themeMode!;
    return _getThemeModeFromStorage();
  }

  /// Helper method to get the theme mode from storage.
  static ThemeMode _getThemeModeFromStorage() {
    final String theme = JetStorage.read(key: 'APP_THEME') ?? 'light';
    return theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }
}

showThemeSwitcher({required BuildContext context}) {
  return ThemeSwitcher.showSwitcher(context);
}
