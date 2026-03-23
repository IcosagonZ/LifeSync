import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/colors_overview_buttons.dart';

/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade the package to version 8.4.0.
///
/// Use it in a [MaterialApp] like this:
///
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
/// );
abstract final class ThemeRed {
  // The FlexColorScheme defined light mode ThemeData.
  static ThemeData light = FlexThemeData.light(
    // Set font family
    textTheme: GoogleFonts.latoTextTheme(),
    // Set additional colors
    extensions: [
      const ColorsOverviewButtons(
        time: Color(0xFF607D8B),
        sleep: Color(0xFF3F51B5),
        academics: Color(0xFF2196F3),
        workout: Color(0xFFFF9800),
        activity: Color(0xFF00BCD4),
        nutrition: Color(0xFF4CAF50),
        mind: Color(0xFF9C27B0),
        symptoms: Color(0xFFFFC107),
        vitals: Color(0xFFF44336),
        body: Color(0xFFFF5252),
      ),
    ],
    // Using FlexColorScheme built-in FlexScheme enum based colors
    //scheme: FlexScheme.shadRose,
    colors: const FlexSchemeColor(
      primary: Color(0xFF8E57E2),
      primaryContainer: Color(0xFF7C3AED),
      secondary: Color(0xFFF3F4F6),
      secondaryContainer: Color(0xFFF3F4F6),
      tertiary: Color(0xFFF3F4F6),
      tertiaryContainer: Color(0xFFF3F4F6),
      appBarColor: Color(0xFFF3F4F6),
      error: Color(0xFFEF4444),
      errorContainer: Color(0xFFFFDAD6),
    ),
    // Convenience direct styling properties.
    tooltipsMatchBackground: true,
    // Component theme configurations for light mode.
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useMaterial3Typography: true,
      useM2StyleDividerInM3: true,
      adaptiveAppBarScrollUnderOff: FlexAdaptive.all(),
      defaultRadius: 20.0,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        alignedDropdown: true,
        snackBarBackgroundSchemeColor: SchemeColor.secondary,
        snackBarActionSchemeColor: SchemeColor.onSecondary,
        navigationRailUseIndicator: true,
    ),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    //cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );

  // The FlexColorScheme defined dark mode ThemeData.
  static ThemeData dark = FlexThemeData.dark(
    // Set font family
    textTheme: GoogleFonts.latoTextTheme(),
    // Set additional colors
    extensions: [
      const ColorsOverviewButtons(
        time: Color(0xFF607D8B),
        sleep: Color(0xFF3F51B5),
        academics: Color(0xFF2196F3),
        workout: Color(0xff495057),
        activity: Color(0xFF00BCD4),
        nutrition: Color(0xFF4CAF50),
        mind: Color(0xFF9C27B0),
        symptoms: Color(0xffa61e4d),
        vitals: Color(0xFFF44336),
        body: Color(0xFFFF5252),
      ),
    ],
    colors: const FlexSchemeColor(
      primary: Color(0xFF8E57E2),
      primaryContainer: Color(0xFF6D28D9),
      primaryLightRef: Color(0xFF7C3AED), // The color of light mode primary
      secondary: Color(0xFF1F2937),
      secondaryContainer: Color(0xFF1F2937),
      secondaryLightRef: Color(0xFFF3F4F6), // The color of light mode secondary
      tertiary: Color(0xFF1F2937),
      tertiaryContainer: Color(0xFF1F2937),
      tertiaryLightRef: Color(0xFFF3F4F6), // The color of light mode tertiary
      appBarColor: Color(0xFFF3F4F6),
      error: Color(0xFF7F1D1D),
      errorContainer: Color(0xFF93000A),
    ),
    // Using FlexColorScheme built-in FlexScheme enum based colors.
    //scheme: FlexScheme.shadRose,
    // Convenience direct styling properties.
    tooltipsMatchBackground: true,
    // Component theme configurations for dark mode.
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      scaffoldBackgroundSchemeColor: SchemeColor.black,
      useMaterial3Typography: true,
      useM2StyleDividerInM3: true,
      adaptiveAppBarScrollUnderOff: FlexAdaptive.all(),
      defaultRadius: 20.0,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        alignedDropdown: true,
        snackBarBackgroundSchemeColor: SchemeColor.secondary,
        snackBarActionSchemeColor: SchemeColor.onSecondary,
        navigationRailUseIndicator: true,
    ),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    //cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}
