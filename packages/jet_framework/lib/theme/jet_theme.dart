import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'jet_style.dart';

abstract class JetBaseTheme {
  ThemeData get light;

  ThemeData get dark;
}

class JetTheme implements JetBaseTheme {
  final JetScheme scheme;
  final String? fontFamily;

  JetTheme({required this.scheme, this.fontFamily});

  @override
  ThemeData get light => FlexThemeData.light(
        fontFamily: fontFamily,
        scheme: FlexScheme.blue,
        surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
        blendLevel: 2,
        subThemesData: const FlexSubThemesData(
          inputDecoratorIsDense: true,
          interactionEffects: true,
          tintedDisabledControls: true,
          blendOnLevel: 10,
          useM2StyleDividerInM3: true,
          elevatedButtonSchemeColor: SchemeColor.surface,
          elevatedButtonSecondarySchemeColor: SchemeColor.primary,
          elevatedButtonRadius: 8.0,
          filledButtonRadius: 8.0,
          outlinedButtonOutlineSchemeColor: SchemeColor.primary,
          outlinedButtonPressedBorderWidth: 2.0,
          toggleButtonsBorderSchemeColor: SchemeColor.primary,
          segmentedButtonSchemeColor: SchemeColor.primary,
          segmentedButtonBorderSchemeColor: SchemeColor.primary,
          unselectedToggleIsColored: true,
          sliderValueTinted: true,
          inputDecoratorSchemeColor: SchemeColor.primary,
          inputDecoratorIsFilled: true,
          inputDecoratorBackgroundAlpha: 21,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          inputDecoratorRadius: 12.0,
          inputDecoratorUnfocusedHasBorder: false,
          inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
          popupMenuRadius: 6.0,
          popupMenuElevation: 8.0,
          alignedDropdown: true,
          drawerIndicatorSchemeColor: SchemeColor.primary,
          bottomNavigationBarMutedUnselectedLabel: false,
          bottomNavigationBarMutedUnselectedIcon: false,
          menuRadius: 6.0,
          menuElevation: 8.0,
          menuBarRadius: 0.0,
          menuBarElevation: 1.0,
          navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
          navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationBarIndicatorSchemeColor: SchemeColor.primary,
          navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
          navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationRailUseIndicator: true,
          navigationRailIndicatorSchemeColor: SchemeColor.primary,
          navigationRailIndicatorOpacity: 1.00,
          navigationRailLabelType: NavigationRailLabelType.all,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
      );

  @override
  ThemeData get dark => FlexThemeData.dark(
        fontFamily: fontFamily,
        scheme: FlexScheme.blue,
        surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
        blendLevel: 8,
        subThemesData: const FlexSubThemesData(
          inputDecoratorIsDense: true,
          interactionEffects: true,
          tintedDisabledControls: true,
          blendOnLevel: 8,
          blendOnColors: true,
          useM2StyleDividerInM3: true,
          outlinedButtonOutlineSchemeColor: SchemeColor.primary,
          outlinedButtonPressedBorderWidth: 2.0,
          elevatedButtonSchemeColor: SchemeColor.surface,
          elevatedButtonSecondarySchemeColor: SchemeColor.primary,
          elevatedButtonRadius: 8.0,
          filledButtonRadius: 8.0,
          toggleButtonsBorderSchemeColor: SchemeColor.primary,
          segmentedButtonSchemeColor: SchemeColor.primary,
          segmentedButtonBorderSchemeColor: SchemeColor.primary,
          unselectedToggleIsColored: true,
          sliderValueTinted: true,
          inputDecoratorSchemeColor: SchemeColor.primary,
          inputDecoratorIsFilled: true,
          inputDecoratorBackgroundAlpha: 43,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          inputDecoratorRadius: 12.0,
          inputDecoratorUnfocusedHasBorder: false,
          popupMenuRadius: 6.0,
          popupMenuElevation: 8.0,
          alignedDropdown: true,
          drawerIndicatorSchemeColor: SchemeColor.primary,
          bottomNavigationBarMutedUnselectedLabel: false,
          bottomNavigationBarMutedUnselectedIcon: false,
          menuRadius: 6.0,
          menuElevation: 8.0,
          menuBarRadius: 0.0,
          menuBarElevation: 1.0,
          navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
          navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationBarIndicatorSchemeColor: SchemeColor.primary,
          navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
          navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationRailUseIndicator: true,
          navigationRailIndicatorSchemeColor: SchemeColor.primary,
          navigationRailIndicatorOpacity: 1.00,
          navigationRailLabelType: NavigationRailLabelType.all,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
      );
}
