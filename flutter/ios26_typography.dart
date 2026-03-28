import 'package:flutter/material.dart';

/// iOS 26 Design System - Typography Tokens
///
/// Complete type scale matching iOS 26 Human Interface Guidelines.
/// Font: SF Pro (system font on iOS), falls back to system default on Android.
///
/// Each style has up to 4 variants:
///   - Regular (default weight)
///   - Emphasized (bold/semibold)
///   - Italic
///   - Emphasized Italic
///
/// Plus "Loose Leading" variants for multiline contexts (+2pt line height).
///
/// Usage:
///   Text('Title', style: IOS26Typography.largeTitle)
///   Text('Bold', style: IOS26Typography.largeTitleEmphasized)
///   Text('Multi', style: IOS26Typography.bodyLoose)
class IOS26Typography {
  IOS26Typography._();

  // ---------------------------------------------------------------------------
  // Font Family
  // ---------------------------------------------------------------------------

  /// Primary font family. Uses SF Pro on iOS, system default elsewhere.
  /// Set to null to use Flutter's default platform font resolution,
  /// which picks SF Pro on iOS/macOS automatically.
  static const String? fontFamily = null;

  // ---------------------------------------------------------------------------
  // Large Title - 34pt
  // ---------------------------------------------------------------------------

  static const TextStyle largeTitle = TextStyle(
    fontSize: 34,
    height: 41 / 34,
    letterSpacing: 0.40,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle largeTitleEmphasized = TextStyle(
    fontSize: 34,
    height: 41 / 34,
    letterSpacing: 0.40,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle largeTitleItalic = TextStyle(
    fontSize: 34,
    height: 41 / 34,
    letterSpacing: 0.40,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle largeTitleEmphasizedItalic = TextStyle(
    fontSize: 34,
    height: 41 / 34,
    letterSpacing: 0.40,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
  );

  // ---------------------------------------------------------------------------
  // Title 1 - 28pt
  // ---------------------------------------------------------------------------

  static const TextStyle title1 = TextStyle(
    fontSize: 28,
    height: 34 / 28,
    letterSpacing: 0.38,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle title1Emphasized = TextStyle(
    fontSize: 28,
    height: 34 / 28,
    letterSpacing: 0.38,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle title1Italic = TextStyle(
    fontSize: 28,
    height: 34 / 28,
    letterSpacing: 0.38,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle title1EmphasizedItalic = TextStyle(
    fontSize: 28,
    height: 34 / 28,
    letterSpacing: 0.38,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
  );

  // ---------------------------------------------------------------------------
  // Title 2 - 22pt
  // ---------------------------------------------------------------------------

  static const TextStyle title2 = TextStyle(
    fontSize: 22,
    height: 28 / 22,
    letterSpacing: -0.26,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle title2Emphasized = TextStyle(
    fontSize: 22,
    height: 28 / 22,
    letterSpacing: -0.26,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle title2Italic = TextStyle(
    fontSize: 22,
    height: 28 / 22,
    letterSpacing: -0.26,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle title2EmphasizedItalic = TextStyle(
    fontSize: 22,
    height: 28 / 22,
    letterSpacing: -0.26,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
  );

  // ---------------------------------------------------------------------------
  // Title 3 - 20pt
  // ---------------------------------------------------------------------------

  static const TextStyle title3 = TextStyle(
    fontSize: 20,
    height: 25 / 20,
    letterSpacing: -0.45,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle title3Emphasized = TextStyle(
    fontSize: 20,
    height: 25 / 20,
    letterSpacing: -0.45,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle title3Italic = TextStyle(
    fontSize: 20,
    height: 25 / 20,
    letterSpacing: -0.45,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle title3EmphasizedItalic = TextStyle(
    fontSize: 20,
    height: 25 / 20,
    letterSpacing: -0.45,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
  );

  // ---------------------------------------------------------------------------
  // Headline - 17pt (Semibold default)
  // ---------------------------------------------------------------------------

  static const TextStyle headline = TextStyle(
    fontSize: 17,
    height: 22 / 17,
    letterSpacing: -0.43,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headlineItalic = TextStyle(
    fontSize: 17,
    height: 22 / 17,
    letterSpacing: -0.43,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
  );

  // ---------------------------------------------------------------------------
  // Body - 17pt
  // ---------------------------------------------------------------------------

  static const TextStyle body = TextStyle(
    fontSize: 17,
    height: 22 / 17,
    letterSpacing: -0.43,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodyEmphasized = TextStyle(
    fontSize: 17,
    height: 22 / 17,
    letterSpacing: -0.43,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyItalic = TextStyle(
    fontSize: 17,
    height: 22 / 17,
    letterSpacing: -0.43,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle bodyEmphasizedItalic = TextStyle(
    fontSize: 17,
    height: 22 / 17,
    letterSpacing: -0.43,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
  );

  // ---------------------------------------------------------------------------
  // Callout - 16pt
  // ---------------------------------------------------------------------------

  static const TextStyle callout = TextStyle(
    fontSize: 16,
    height: 21 / 16,
    letterSpacing: -0.31,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle calloutEmphasized = TextStyle(
    fontSize: 16,
    height: 21 / 16,
    letterSpacing: -0.31,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle calloutItalic = TextStyle(
    fontSize: 16,
    height: 21 / 16,
    letterSpacing: -0.31,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle calloutEmphasizedItalic = TextStyle(
    fontSize: 16,
    height: 21 / 16,
    letterSpacing: -0.31,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
  );

  // ---------------------------------------------------------------------------
  // Subheadline - 15pt
  // ---------------------------------------------------------------------------

  static const TextStyle subheadline = TextStyle(
    fontSize: 15,
    height: 20 / 15,
    letterSpacing: -0.23,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle subheadlineEmphasized = TextStyle(
    fontSize: 15,
    height: 20 / 15,
    letterSpacing: -0.23,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle subheadlineItalic = TextStyle(
    fontSize: 15,
    height: 20 / 15,
    letterSpacing: -0.23,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle subheadlineEmphasizedItalic = TextStyle(
    fontSize: 15,
    height: 20 / 15,
    letterSpacing: -0.23,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
  );

  // ---------------------------------------------------------------------------
  // Footnote - 13pt
  // ---------------------------------------------------------------------------

  static const TextStyle footnote = TextStyle(
    fontSize: 13,
    height: 18 / 13,
    letterSpacing: -0.08,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle footnoteEmphasized = TextStyle(
    fontSize: 13,
    height: 18 / 13,
    letterSpacing: -0.08,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle footnoteItalic = TextStyle(
    fontSize: 13,
    height: 18 / 13,
    letterSpacing: -0.08,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle footnoteEmphasizedItalic = TextStyle(
    fontSize: 13,
    height: 18 / 13,
    letterSpacing: -0.08,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
  );

  // ---------------------------------------------------------------------------
  // Caption 1 - 12pt
  // ---------------------------------------------------------------------------

  static const TextStyle caption1 = TextStyle(
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle caption1Emphasized = TextStyle(
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle caption1Italic = TextStyle(
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle caption1EmphasizedItalic = TextStyle(
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
  );

  // ---------------------------------------------------------------------------
  // Caption 2 - 11pt
  // ---------------------------------------------------------------------------

  static const TextStyle caption2 = TextStyle(
    fontSize: 11,
    height: 13 / 11,
    letterSpacing: 0.06,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle caption2Emphasized = TextStyle(
    fontSize: 11,
    height: 13 / 11,
    letterSpacing: 0.06,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle caption2Italic = TextStyle(
    fontSize: 11,
    height: 13 / 11,
    letterSpacing: 0.06,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle caption2EmphasizedItalic = TextStyle(
    fontSize: 11,
    height: 13 / 11,
    letterSpacing: 0.06,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
  );

  // ---------------------------------------------------------------------------
  // Loose Leading Variants (+2pt line height for multiline text)
  // ---------------------------------------------------------------------------

  static const TextStyle largeTitleLoose = TextStyle(
    fontSize: 34,
    height: 43 / 34,
    letterSpacing: 0.40,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle largeTitleLooseEmphasized = TextStyle(
    fontSize: 34,
    height: 43 / 34,
    letterSpacing: 0.40,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle title1Loose = TextStyle(
    fontSize: 28,
    height: 36 / 28,
    letterSpacing: 0.38,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle title1LooseEmphasized = TextStyle(
    fontSize: 28,
    height: 36 / 28,
    letterSpacing: 0.38,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle title2Loose = TextStyle(
    fontSize: 22,
    height: 30 / 22,
    letterSpacing: -0.26,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle title2LooseEmphasized = TextStyle(
    fontSize: 22,
    height: 30 / 22,
    letterSpacing: -0.26,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle title3Loose = TextStyle(
    fontSize: 20,
    height: 27 / 20,
    letterSpacing: -0.45,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle title3LooseEmphasized = TextStyle(
    fontSize: 20,
    height: 27 / 20,
    letterSpacing: -0.45,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headlineLoose = TextStyle(
    fontSize: 17,
    height: 24 / 17,
    letterSpacing: -0.43,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyLoose = TextStyle(
    fontSize: 17,
    height: 24 / 17,
    letterSpacing: -0.43,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodyLooseEmphasized = TextStyle(
    fontSize: 17,
    height: 24 / 17,
    letterSpacing: -0.43,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle calloutLoose = TextStyle(
    fontSize: 16,
    height: 23 / 16,
    letterSpacing: -0.31,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle calloutLooseEmphasized = TextStyle(
    fontSize: 16,
    height: 23 / 16,
    letterSpacing: -0.31,
    fontWeight: FontWeight.w600,
  );

  // ---------------------------------------------------------------------------
  // TextTheme factory (for ThemeData integration)
  // ---------------------------------------------------------------------------

  /// Creates a Flutter [TextTheme] mapped to iOS 26 type scale.
  ///
  /// Mapping:
  ///   displayLarge  -> Large Title
  ///   displayMedium -> Title 1
  ///   displaySmall  -> Title 2
  ///   headlineLarge -> Title 3
  ///   headlineMedium -> Headline
  ///   headlineSmall -> Body Emphasized
  ///   titleLarge    -> Body
  ///   titleMedium   -> Callout
  ///   titleSmall    -> Subheadline
  ///   bodyLarge     -> Body
  ///   bodyMedium    -> Callout
  ///   bodySmall     -> Footnote
  ///   labelLarge    -> Subheadline Emphasized
  ///   labelMedium   -> Caption 1
  ///   labelSmall    -> Caption 2
  static TextTheme textTheme({Color? color}) {
    return TextTheme(
      displayLarge: largeTitle.copyWith(color: color),
      displayMedium: title1.copyWith(color: color),
      displaySmall: title2.copyWith(color: color),
      headlineLarge: title3.copyWith(color: color),
      headlineMedium: headline.copyWith(color: color),
      headlineSmall: bodyEmphasized.copyWith(color: color),
      titleLarge: body.copyWith(color: color),
      titleMedium: callout.copyWith(color: color),
      titleSmall: subheadline.copyWith(color: color),
      bodyLarge: body.copyWith(color: color),
      bodyMedium: callout.copyWith(color: color),
      bodySmall: footnote.copyWith(color: color),
      labelLarge: subheadlineEmphasized.copyWith(color: color),
      labelMedium: caption1.copyWith(color: color),
      labelSmall: caption2.copyWith(color: color),
    );
  }
}
