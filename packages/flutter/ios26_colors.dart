import 'package:flutter/material.dart';

/// iOS 26 Design System - Color Tokens
///
/// Complete color palette extracted from the iOS & iPadOS 26 Figma Community Kit.
/// Includes system colors, semantic colors, materials, and dark mode variants.
///
/// Usage:
///   Container(color: IOS26Colors.blue)
///   Text('Hello', style: TextStyle(color: IOS26Colors.labelPrimary))
class IOS26Colors {
  IOS26Colors._();

  // ---------------------------------------------------------------------------
  // System Colors (12)
  // ---------------------------------------------------------------------------

  static const Color red = Color(0xFFFF383C);
  static const Color orange = Color(0xFFFF8D28);
  static const Color yellow = Color(0xFFFFCC00);
  static const Color green = Color(0xFF34C759);
  static const Color mint = Color(0xFF00C8B3);
  static const Color teal = Color(0xFF00C3D0);
  static const Color cyan = Color(0xFF00C0E8);
  static const Color blue = Color(0xFF0088FF);
  static const Color indigo = Color(0xFF6155F5);
  static const Color purple = Color(0xFFCB30E0);
  static const Color pink = Color(0xFFFF2D55);
  static const Color brown = Color(0xFFAC7F5E);

  // ---------------------------------------------------------------------------
  // Labels - Light Mode (4 levels)
  // ---------------------------------------------------------------------------

  /// Primary label: body text, titles. 100% opacity black.
  static const Color labelPrimary = Color(0xFF000000);

  /// Secondary label: subtitles, descriptions. #3C3C43 at 60%.
  static const Color labelSecondary = Color(0x993C3C43);

  /// Tertiary label: placeholders, disabled text. #3C3C43 at 30%.
  static const Color labelTertiary = Color(0x4D3C3C43);

  /// Quaternary label: watermarks, faint text. #3C3C43 at 18%.
  static const Color labelQuaternary = Color(0x2E3C3C43);

  // ---------------------------------------------------------------------------
  // Labels - Dark Mode (4 levels)
  // ---------------------------------------------------------------------------

  static const Color darkLabelPrimary = Color(0xFFFFFFFF);
  static const Color darkLabelSecondary = Color(0x99EBEBF5);
  static const Color darkLabelTertiary = Color(0x4DEBEBF5);
  static const Color darkLabelQuaternary = Color(0x2EEBEBF5);

  // ---------------------------------------------------------------------------
  // Backgrounds - Light Mode (6)
  // ---------------------------------------------------------------------------

  /// Default screen background.
  static const Color backgroundPrimary = Color(0xFFFFFFFF);

  /// Secondary grouped content background.
  static const Color backgroundSecondary = Color(0xFFF2F2F7);

  /// Tertiary content background.
  static const Color backgroundTertiary = Color(0xFFFFFFFF);

  /// Grouped list outer background.
  static const Color backgroundGroupedPrimary = Color(0xFFF2F2F7);

  /// Card surface inside grouped list.
  static const Color backgroundGroupedSecondary = Color(0xFFFFFFFF);

  /// Third-level grouped background.
  static const Color backgroundGroupedTertiary = Color(0xFFF2F2F7);

  // ---------------------------------------------------------------------------
  // Backgrounds - Dark Mode (6)
  // ---------------------------------------------------------------------------

  static const Color darkBackgroundPrimary = Color(0xFF000000);
  static const Color darkBackgroundSecondary = Color(0xFF1C1C1E);
  static const Color darkBackgroundTertiary = Color(0xFF2C2C2E);
  static const Color darkBackgroundGroupedPrimary = Color(0xFF000000);
  static const Color darkBackgroundGroupedSecondary = Color(0xFF1C1C1E);
  static const Color darkBackgroundGroupedTertiary = Color(0xFF2C2C2E);

  // ---------------------------------------------------------------------------
  // Fills - Light Mode (4 levels with opacity)
  // ---------------------------------------------------------------------------

  /// Primary fill. #787878 at 20%.
  static const Color fillPrimary = Color(0x33787878);

  /// Secondary fill. #787880 at 16%.
  static const Color fillSecondary = Color(0x29787880);

  /// Tertiary fill. #767680 at 12%.
  static const Color fillTertiary = Color(0x1F767680);

  /// Quaternary fill. #747480 at 8%.
  static const Color fillQuaternary = Color(0x14747480);

  // ---------------------------------------------------------------------------
  // Fills - Dark Mode (4 levels with opacity)
  // ---------------------------------------------------------------------------

  static const Color darkFillPrimary = Color(0x5C787880);
  static const Color darkFillSecondary = Color(0x52787880);
  static const Color darkFillTertiary = Color(0x3D767680);
  static const Color darkFillQuaternary = Color(0x2E747480);

  // ---------------------------------------------------------------------------
  // Grays (8)
  // ---------------------------------------------------------------------------

  static const Color grayBlack = Color(0xFF000000);
  static const Color gray = Color(0xFF8E8E93);
  static const Color gray2 = Color(0xFFAEAEB2);
  static const Color gray3 = Color(0xFFC7C7CC);
  static const Color gray4 = Color(0xFFD1D1D6);
  static const Color gray5 = Color(0xFFE5E5EA);
  static const Color gray6 = Color(0xFFF2F2F7);
  static const Color grayWhite = Color(0xFFFFFFFF);

  // ---------------------------------------------------------------------------
  // Separators - Light Mode (2)
  // ---------------------------------------------------------------------------

  /// Opaque separator line. Solid #C6C6C8.
  static const Color separatorOpaque = Color(0xFFC6C6C8);

  /// Non-opaque separator line. #000000 at 12%.
  static const Color separatorNonOpaque = Color(0x1F000000);

  // ---------------------------------------------------------------------------
  // Separators - Dark Mode (2)
  // ---------------------------------------------------------------------------

  static const Color darkSeparatorOpaque = Color(0xFF38383A);
  static const Color darkSeparatorNonOpaque = Color(0x8C545458);

  // ---------------------------------------------------------------------------
  // Vibrant Labels - Light Mode (4 levels)
  // ---------------------------------------------------------------------------

  static const Color vibrantLabelLightPrimary = Color(0xFF000000);
  static const Color vibrantLabelLightSecondary = Color(0xFF3D3D3D);
  static const Color vibrantLabelLightTertiary = Color(0x803D3D3D);
  static const Color vibrantLabelLightQuaternary = Color(0x803D3D3D);

  // ---------------------------------------------------------------------------
  // Vibrant Labels - Dark Mode (4 levels)
  // ---------------------------------------------------------------------------

  static const Color vibrantLabelDarkPrimary = Color(0xFFFFFFFF);
  static const Color vibrantLabelDarkSecondary = Color(0xFF999999);
  static const Color vibrantLabelDarkTertiary = Color(0xFF404040);
  static const Color vibrantLabelDarkQuaternary = Color(0xFF262626);

  // ---------------------------------------------------------------------------
  // Vibrant Fills - Light Mode (3)
  // ---------------------------------------------------------------------------

  static const Color vibrantFillLightPrimary = Color(0xFFCCCCCC);
  static const Color vibrantFillLightSecondary = Color(0xFFE0E0E0);
  static const Color vibrantFillLightTertiary = Color(0xFFEDEDED);

  // ---------------------------------------------------------------------------
  // Vibrant Fills - Dark Mode (3)
  // ---------------------------------------------------------------------------

  static const Color vibrantFillDarkPrimary = Color(0xFF333333);
  static const Color vibrantFillDarkSecondary = Color(0xFF1F1F1F);
  static const Color vibrantFillDarkTertiary = Color(0xFF121212);

  // ---------------------------------------------------------------------------
  // Liquid Glass Material Colors
  // ---------------------------------------------------------------------------

  /// Liquid Glass Large - Light background at 70% opacity.
  static const Color liquidGlassLargeLightBg = Color(0xB3FAFAFA);

  /// Liquid Glass Large - Dark background at 80% opacity.
  static const Color liquidGlassLargeDarkBg = Color(0xCC000000);

  /// Liquid Glass Medium - Light background at 60% opacity.
  static const Color liquidGlassMediumLightBg = Color(0x99F5F5F5);

  /// Liquid Glass Medium - Dark background at 60% opacity.
  static const Color liquidGlassMediumDarkBg = Color(0x99000000);

  /// Liquid Glass Small - Light default background.
  static const Color liquidGlassSmallLightBg = Color(0xFFF7F7F7);

  /// Liquid Glass Small - Light default border.
  static const Color liquidGlassSmallLightBorder = Color(0xFFDDDDDD);

  /// Liquid Glass Small - Dark background at 60% opacity.
  static const Color liquidGlassSmallDarkBg = Color(0x99000000);

  /// Liquid Glass tint overlay for dark mode. White at 6%.
  static const Color liquidGlassDarkTint = Color(0x0FFFFFFF);

  /// Liquid Glass Clear - Light background. White at 7%.
  static const Color liquidGlassClearBg = Color(0x12FFFFFF);

  /// Primary accent color used in Liquid Glass Small/Primary variant.
  static const Color liquidGlassPrimaryIcon = Color(0xFF0091FF);

  // ---------------------------------------------------------------------------
  // Convenience: resolve light/dark by brightness
  // ---------------------------------------------------------------------------

  /// Returns the label color for the given [brightness].
  static Color label(Brightness brightness, {int level = 0}) {
    if (brightness == Brightness.light) {
      return const [
        labelPrimary,
        labelSecondary,
        labelTertiary,
        labelQuaternary,
      ][level.clamp(0, 3)];
    }
    return const [
      darkLabelPrimary,
      darkLabelSecondary,
      darkLabelTertiary,
      darkLabelQuaternary,
    ][level.clamp(0, 3)];
  }

  /// Returns the background color for the given [brightness].
  /// Set [grouped] to true for grouped list backgrounds.
  static Color background(
    Brightness brightness, {
    int level = 0,
    bool grouped = false,
  }) {
    if (brightness == Brightness.light) {
      if (grouped) {
        return const [
          backgroundGroupedPrimary,
          backgroundGroupedSecondary,
          backgroundGroupedTertiary,
        ][level.clamp(0, 2)];
      }
      return const [
        backgroundPrimary,
        backgroundSecondary,
        backgroundTertiary,
      ][level.clamp(0, 2)];
    }
    if (grouped) {
      return const [
        darkBackgroundGroupedPrimary,
        darkBackgroundGroupedSecondary,
        darkBackgroundGroupedTertiary,
      ][level.clamp(0, 2)];
    }
    return const [
      darkBackgroundPrimary,
      darkBackgroundSecondary,
      darkBackgroundTertiary,
    ][level.clamp(0, 2)];
  }

  /// Returns the fill color for the given [brightness].
  static Color fill(Brightness brightness, {int level = 0}) {
    if (brightness == Brightness.light) {
      return const [
        fillPrimary,
        fillSecondary,
        fillTertiary,
        fillQuaternary,
      ][level.clamp(0, 3)];
    }
    return const [
      darkFillPrimary,
      darkFillSecondary,
      darkFillTertiary,
      darkFillQuaternary,
    ][level.clamp(0, 3)];
  }

  /// Returns the separator color for the given [brightness].
  static Color separator(Brightness brightness, {bool opaque = true}) {
    if (brightness == Brightness.light) {
      return opaque ? separatorOpaque : separatorNonOpaque;
    }
    return opaque ? darkSeparatorOpaque : darkSeparatorNonOpaque;
  }
}
