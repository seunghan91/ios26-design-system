import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ios26_colors.dart';
import 'ios26_typography.dart';

/// iOS 26 Design System - Complete Theme
///
/// Provides ready-to-use [ThemeData] and [CupertinoThemeData] configured
/// with iOS 26 color tokens, typography, and component styles.
///
/// Usage with MaterialApp:
///   MaterialApp(
///     theme: IOS26Theme.light(),
///     darkTheme: IOS26Theme.dark(),
///   )
///
/// Usage with CupertinoApp:
///   CupertinoApp(
///     theme: IOS26Theme.cupertinoLight(),
///   )
class IOS26Theme {
  IOS26Theme._();

  // ---------------------------------------------------------------------------
  // Material ThemeData
  // ---------------------------------------------------------------------------

  /// Light mode [ThemeData] with iOS 26 design tokens.
  static ThemeData light() {
    final colorScheme = ColorScheme.light(
      primary: IOS26Colors.blue,
      onPrimary: Colors.white,
      primaryContainer: IOS26Colors.blue.withValues(alpha: 0.12),
      onPrimaryContainer: IOS26Colors.blue,
      secondary: IOS26Colors.gray,
      onSecondary: Colors.white,
      secondaryContainer: IOS26Colors.gray6,
      onSecondaryContainer: IOS26Colors.labelPrimary,
      tertiary: IOS26Colors.teal,
      onTertiary: Colors.white,
      error: IOS26Colors.red,
      onError: Colors.white,
      errorContainer: IOS26Colors.red.withValues(alpha: 0.12),
      onErrorContainer: IOS26Colors.red,
      surface: IOS26Colors.backgroundPrimary,
      onSurface: IOS26Colors.labelPrimary,
      onSurfaceVariant: IOS26Colors.labelSecondary,
      outline: IOS26Colors.separatorOpaque,
      outlineVariant: IOS26Colors.separatorNonOpaque,
      surfaceContainerHighest: IOS26Colors.backgroundSecondary,
      surfaceContainerHigh: IOS26Colors.gray6,
      surfaceContainer: IOS26Colors.gray5,
      surfaceContainerLow: IOS26Colors.backgroundPrimary,
      surfaceContainerLowest: IOS26Colors.grayWhite,
    );

    final textTheme = IOS26Typography.textTheme(
      color: IOS26Colors.labelPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: IOS26Colors.backgroundGroupedPrimary,
      canvasColor: IOS26Colors.backgroundPrimary,
      cardColor: IOS26Colors.backgroundGroupedSecondary,
      dividerColor: IOS26Colors.separatorOpaque,
      splashFactory: NoSplash.splashFactory,
      highlightColor: IOS26Colors.fillPrimary,

      // AppBar
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: IOS26Colors.backgroundPrimary,
        foregroundColor: IOS26Colors.labelPrimary,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: IOS26Typography.headline.copyWith(
          color: IOS26Colors.labelPrimary,
        ),
        centerTitle: true,
      ),

      // TabBar
      tabBarTheme: TabBarTheme(
        labelColor: IOS26Colors.blue,
        unselectedLabelColor: IOS26Colors.gray,
        labelStyle: IOS26Typography.caption2Emphasized,
        unselectedLabelStyle: IOS26Typography.caption2,
        indicatorColor: IOS26Colors.blue,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
      ),

      // BottomNavigationBar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: IOS26Colors.backgroundPrimary,
        selectedItemColor: IOS26Colors.blue,
        unselectedItemColor: IOS26Colors.gray,
        selectedLabelStyle: IOS26Typography.caption2,
        unselectedLabelStyle: IOS26Typography.caption2,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // Card
      cardTheme: CardTheme(
        elevation: 0,
        color: IOS26Colors.backgroundGroupedSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16),
      ),

      // ListTile
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        minVerticalPadding: 11,
        titleTextStyle: IOS26Typography.body.copyWith(
          color: IOS26Colors.labelPrimary,
        ),
        subtitleTextStyle: IOS26Typography.subheadline.copyWith(
          color: IOS26Colors.labelSecondary,
        ),
        tileColor: IOS26Colors.backgroundGroupedSecondary,
      ),

      // Divider
      dividerTheme: DividerThemeData(
        color: IOS26Colors.separatorOpaque,
        thickness: 0.5,
        indent: 16,
        space: 0,
      ),

      // Dialog
      dialogTheme: DialogTheme(
        backgroundColor: IOS26Colors.backgroundPrimary,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        titleTextStyle: IOS26Typography.headline.copyWith(
          color: IOS26Colors.labelPrimary,
        ),
        contentTextStyle: IOS26Typography.subheadline.copyWith(
          color: IOS26Colors.labelSecondary,
        ),
      ),

      // BottomSheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: IOS26Colors.backgroundPrimary,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        dragHandleColor: IOS26Colors.gray3,
        dragHandleSize: const Size(36, 5),
        showDragHandle: true,
      ),

      // ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: IOS26Colors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
          textStyle: IOS26Typography.bodyEmphasized,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),

      // TextButton
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: IOS26Colors.blue,
          textStyle: IOS26Typography.body,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
      ),

      // OutlinedButton
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: IOS26Colors.blue,
          textStyle: IOS26Typography.body,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          side: const BorderSide(color: IOS26Colors.separatorOpaque),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),

      // InputDecoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: IOS26Colors.fillTertiary,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        hintStyle: IOS26Typography.body.copyWith(
          color: IOS26Colors.labelTertiary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: IOS26Colors.blue, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: IOS26Colors.red, width: 1),
        ),
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          return Colors.white;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IOS26Colors.green;
          }
          return IOS26Colors.fillSecondary;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: IOS26Colors.fillTertiary,
        selectedColor: IOS26Colors.blue.withValues(alpha: 0.15),
        labelStyle: IOS26Typography.subheadline,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),

      // SnackBar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: IOS26Colors.grayBlack.withValues(alpha: 0.85),
        contentTextStyle: IOS26Typography.subheadline.copyWith(
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // ProgressIndicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: IOS26Colors.blue,
        linearTrackColor: IOS26Colors.fillTertiary,
      ),

      // Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: IOS26Colors.blue,
        inactiveTrackColor: IOS26Colors.fillSecondary,
        thumbColor: Colors.white,
        overlayColor: IOS26Colors.blue.withValues(alpha: 0.12),
        trackHeight: 4,
      ),
    );
  }

  /// Dark mode [ThemeData] with iOS 26 design tokens.
  static ThemeData dark() {
    final colorScheme = ColorScheme.dark(
      primary: IOS26Colors.blue,
      onPrimary: Colors.white,
      primaryContainer: IOS26Colors.blue.withValues(alpha: 0.20),
      onPrimaryContainer: IOS26Colors.blue,
      secondary: IOS26Colors.gray,
      onSecondary: Colors.white,
      secondaryContainer: IOS26Colors.darkBackgroundSecondary,
      onSecondaryContainer: IOS26Colors.darkLabelPrimary,
      tertiary: IOS26Colors.teal,
      onTertiary: Colors.white,
      error: IOS26Colors.red,
      onError: Colors.white,
      errorContainer: IOS26Colors.red.withValues(alpha: 0.20),
      onErrorContainer: IOS26Colors.red,
      surface: IOS26Colors.darkBackgroundPrimary,
      onSurface: IOS26Colors.darkLabelPrimary,
      onSurfaceVariant: IOS26Colors.darkLabelSecondary,
      outline: IOS26Colors.darkSeparatorOpaque,
      outlineVariant: IOS26Colors.darkSeparatorNonOpaque,
      surfaceContainerHighest: IOS26Colors.darkBackgroundTertiary,
      surfaceContainerHigh: IOS26Colors.darkBackgroundSecondary,
      surfaceContainer: IOS26Colors.darkBackgroundSecondary,
      surfaceContainerLow: IOS26Colors.darkBackgroundPrimary,
      surfaceContainerLowest: IOS26Colors.grayBlack,
    );

    final textTheme = IOS26Typography.textTheme(
      color: IOS26Colors.darkLabelPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: IOS26Colors.darkBackgroundGroupedPrimary,
      canvasColor: IOS26Colors.darkBackgroundPrimary,
      cardColor: IOS26Colors.darkBackgroundGroupedSecondary,
      dividerColor: IOS26Colors.darkSeparatorOpaque,
      splashFactory: NoSplash.splashFactory,
      highlightColor: IOS26Colors.darkFillPrimary,

      // AppBar
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: IOS26Colors.darkBackgroundPrimary,
        foregroundColor: IOS26Colors.darkLabelPrimary,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: IOS26Typography.headline.copyWith(
          color: IOS26Colors.darkLabelPrimary,
        ),
        centerTitle: true,
      ),

      // TabBar
      tabBarTheme: TabBarTheme(
        labelColor: IOS26Colors.blue,
        unselectedLabelColor: IOS26Colors.gray,
        labelStyle: IOS26Typography.caption2Emphasized,
        unselectedLabelStyle: IOS26Typography.caption2,
        indicatorColor: IOS26Colors.blue,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
      ),

      // BottomNavigationBar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: IOS26Colors.darkBackgroundPrimary,
        selectedItemColor: IOS26Colors.blue,
        unselectedItemColor: IOS26Colors.gray,
        selectedLabelStyle: IOS26Typography.caption2,
        unselectedLabelStyle: IOS26Typography.caption2,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // Card
      cardTheme: CardTheme(
        elevation: 0,
        color: IOS26Colors.darkBackgroundGroupedSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16),
      ),

      // ListTile
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        minVerticalPadding: 11,
        titleTextStyle: IOS26Typography.body.copyWith(
          color: IOS26Colors.darkLabelPrimary,
        ),
        subtitleTextStyle: IOS26Typography.subheadline.copyWith(
          color: IOS26Colors.darkLabelSecondary,
        ),
        tileColor: IOS26Colors.darkBackgroundGroupedSecondary,
      ),

      // Divider
      dividerTheme: DividerThemeData(
        color: IOS26Colors.darkSeparatorOpaque,
        thickness: 0.5,
        indent: 16,
        space: 0,
      ),

      // Dialog
      dialogTheme: DialogTheme(
        backgroundColor: IOS26Colors.darkBackgroundSecondary,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        titleTextStyle: IOS26Typography.headline.copyWith(
          color: IOS26Colors.darkLabelPrimary,
        ),
        contentTextStyle: IOS26Typography.subheadline.copyWith(
          color: IOS26Colors.darkLabelSecondary,
        ),
      ),

      // BottomSheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: IOS26Colors.darkBackgroundSecondary,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        dragHandleColor: IOS26Colors.gray,
        dragHandleSize: const Size(36, 5),
        showDragHandle: true,
      ),

      // ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: IOS26Colors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
          textStyle: IOS26Typography.bodyEmphasized,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),

      // TextButton
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: IOS26Colors.blue,
          textStyle: IOS26Typography.body,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
      ),

      // OutlinedButton
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: IOS26Colors.blue,
          textStyle: IOS26Typography.body,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          side: const BorderSide(color: IOS26Colors.darkSeparatorOpaque),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),

      // InputDecoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: IOS26Colors.darkFillTertiary,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        hintStyle: IOS26Typography.body.copyWith(
          color: IOS26Colors.darkLabelTertiary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: IOS26Colors.blue, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: IOS26Colors.red, width: 1),
        ),
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          return Colors.white;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IOS26Colors.green;
          }
          return IOS26Colors.darkFillSecondary;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: IOS26Colors.darkFillTertiary,
        selectedColor: IOS26Colors.blue.withValues(alpha: 0.25),
        labelStyle: IOS26Typography.subheadline.copyWith(
          color: IOS26Colors.darkLabelPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),

      // SnackBar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: IOS26Colors.gray.withValues(alpha: 0.9),
        contentTextStyle: IOS26Typography.subheadline.copyWith(
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // ProgressIndicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: IOS26Colors.blue,
        linearTrackColor: IOS26Colors.darkFillTertiary,
      ),

      // Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: IOS26Colors.blue,
        inactiveTrackColor: IOS26Colors.darkFillSecondary,
        thumbColor: Colors.white,
        overlayColor: IOS26Colors.blue.withValues(alpha: 0.20),
        trackHeight: 4,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Cupertino ThemeData
  // ---------------------------------------------------------------------------

  /// Light mode [CupertinoThemeData] with iOS 26 design tokens.
  static CupertinoThemeData cupertinoLight() {
    return const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: IOS26Colors.blue,
      primaryContrastingColor: CupertinoColors.white,
      scaffoldBackgroundColor: IOS26Colors.backgroundGroupedPrimary,
      barBackgroundColor: IOS26Colors.backgroundPrimary,
      textTheme: CupertinoTextThemeData(
        primaryColor: IOS26Colors.blue,
        textStyle: IOS26Typography.body,
        actionTextStyle: TextStyle(
          fontSize: 17,
          height: 22 / 17,
          letterSpacing: -0.43,
          fontWeight: FontWeight.w400,
          color: IOS26Colors.blue,
        ),
        tabLabelTextStyle: IOS26Typography.caption2,
        navTitleTextStyle: IOS26Typography.headline,
        navLargeTitleTextStyle: IOS26Typography.largeTitleEmphasized,
        navActionTextStyle: TextStyle(
          fontSize: 17,
          height: 22 / 17,
          letterSpacing: -0.43,
          fontWeight: FontWeight.w400,
          color: IOS26Colors.blue,
        ),
        pickerTextStyle: TextStyle(
          fontSize: 22,
          height: 28 / 22,
          letterSpacing: -0.26,
          fontWeight: FontWeight.w400,
          color: IOS26Colors.labelPrimary,
        ),
        dateTimePickerTextStyle: TextStyle(
          fontSize: 22,
          height: 28 / 22,
          letterSpacing: -0.26,
          fontWeight: FontWeight.w400,
          color: IOS26Colors.labelPrimary,
        ),
      ),
    );
  }

  /// Dark mode [CupertinoThemeData] with iOS 26 design tokens.
  static CupertinoThemeData cupertinoDark() {
    return const CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: IOS26Colors.blue,
      primaryContrastingColor: CupertinoColors.white,
      scaffoldBackgroundColor: IOS26Colors.darkBackgroundGroupedPrimary,
      barBackgroundColor: IOS26Colors.darkBackgroundPrimary,
      textTheme: CupertinoTextThemeData(
        primaryColor: IOS26Colors.blue,
        textStyle: IOS26Typography.body,
        actionTextStyle: TextStyle(
          fontSize: 17,
          height: 22 / 17,
          letterSpacing: -0.43,
          fontWeight: FontWeight.w400,
          color: IOS26Colors.blue,
        ),
        tabLabelTextStyle: IOS26Typography.caption2,
        navTitleTextStyle: IOS26Typography.headline,
        navLargeTitleTextStyle: IOS26Typography.largeTitleEmphasized,
        navActionTextStyle: TextStyle(
          fontSize: 17,
          height: 22 / 17,
          letterSpacing: -0.43,
          fontWeight: FontWeight.w400,
          color: IOS26Colors.blue,
        ),
        pickerTextStyle: TextStyle(
          fontSize: 22,
          height: 28 / 22,
          letterSpacing: -0.26,
          fontWeight: FontWeight.w400,
          color: IOS26Colors.darkLabelPrimary,
        ),
        dateTimePickerTextStyle: TextStyle(
          fontSize: 22,
          height: 28 / 22,
          letterSpacing: -0.26,
          fontWeight: FontWeight.w400,
          color: IOS26Colors.darkLabelPrimary,
        ),
      ),
    );
  }
}
