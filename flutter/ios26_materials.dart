import 'dart:ui';

import 'package:flutter/material.dart';

import 'ios26_colors.dart';

// =============================================================================
// Liquid Glass
// =============================================================================

/// Size variants for Liquid Glass material.
enum LiquidGlassSize {
  /// Large: navigation bars, toolbars. Radius 14.
  large,

  /// Medium: floating action bars, prominent cards. Radius 12.
  medium,

  /// Small: tab bar items, icon buttons. Radius 8.
  small,
}

/// Visual mode for Liquid Glass Small variant.
enum LiquidGlassMode {
  /// Default: neutral tint background.
  regular,

  /// Primary: white background with blue accent icon.
  primary,

  /// Clear: ultra-transparent with minimal tint.
  clear,
}

/// iOS 26 Liquid Glass material effect.
///
/// A translucent glass surface with background blur, tinted overlay,
/// and soft shadow. The hallmark visual treatment of iOS 26.
///
/// Usage:
///   LiquidGlass(
///     size: LiquidGlassSize.large,
///     child: Row(children: [backButton, title, actionButton]),
///   )
class LiquidGlass extends StatelessWidget {
  const LiquidGlass({
    super.key,
    required this.child,
    this.size = LiquidGlassSize.medium,
    this.mode = LiquidGlassMode.regular,
    this.padding,
    this.borderRadius,
  });

  /// The content rendered inside the glass surface.
  final Widget child;

  /// Size variant controlling blur intensity, radius, and opacity.
  final LiquidGlassSize size;

  /// Visual mode (only affects [LiquidGlassSize.small]).
  final LiquidGlassMode mode;

  /// Custom padding. Defaults vary by [size].
  final EdgeInsetsGeometry? padding;

  /// Custom border radius. Overrides the default for [size].
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final config = _resolveConfig(brightness);

    final effectiveRadius = borderRadius ?? config.borderRadius;
    final effectivePadding = padding ?? config.padding;

    return Container(
      decoration: BoxDecoration(
        borderRadius: effectiveRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: config.shadowOpacity),
            blurRadius: 40,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: effectiveRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: config.blurSigma,
            sigmaY: config.blurSigma,
          ),
          child: Container(
            padding: effectivePadding,
            decoration: BoxDecoration(
              color: config.backgroundColor,
              borderRadius: effectiveRadius,
              border: config.borderColor != null
                  ? Border.all(
                      color: config.borderColor!,
                      width: 0.5,
                    )
                  : null,
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  _LiquidGlassConfig _resolveConfig(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    switch (size) {
      case LiquidGlassSize.large:
        return _LiquidGlassConfig(
          backgroundColor: isDark
              ? IOS26Colors.liquidGlassLargeDarkBg
              : IOS26Colors.liquidGlassLargeLightBg,
          borderRadius: BorderRadius.circular(14),
          blurSigma: 20,
          shadowOpacity: isDark ? 0.3 : 0.08,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          borderColor:
              isDark ? IOS26Colors.liquidGlassDarkTint : null,
        );

      case LiquidGlassSize.medium:
        return _LiquidGlassConfig(
          backgroundColor: isDark
              ? IOS26Colors.liquidGlassMediumDarkBg
              : IOS26Colors.liquidGlassMediumLightBg,
          borderRadius: BorderRadius.circular(12),
          blurSigma: 20,
          shadowOpacity: isDark ? 0.25 : 0.06,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          borderColor:
              isDark ? IOS26Colors.liquidGlassDarkTint : null,
        );

      case LiquidGlassSize.small:
        if (mode == LiquidGlassMode.clear) {
          return _LiquidGlassConfig(
            backgroundColor: IOS26Colors.liquidGlassClearBg,
            borderRadius: BorderRadius.circular(5),
            blurSigma: 20,
            shadowOpacity: isDark ? 0.2 : 0.04,
            padding: const EdgeInsets.all(8),
            borderColor: null,
          );
        }
        if (mode == LiquidGlassMode.primary) {
          return _LiquidGlassConfig(
            backgroundColor: Colors.white,
            borderRadius: BorderRadius.circular(8),
            blurSigma: 20,
            shadowOpacity: isDark ? 0.3 : 0.08,
            padding: const EdgeInsets.all(8),
            borderColor: null,
          );
        }
        return _LiquidGlassConfig(
          backgroundColor: isDark
              ? IOS26Colors.liquidGlassSmallDarkBg
              : IOS26Colors.liquidGlassSmallLightBg,
          borderRadius: BorderRadius.circular(8),
          blurSigma: 20,
          shadowOpacity: isDark ? 0.25 : 0.06,
          padding: const EdgeInsets.all(8),
          borderColor: isDark
              ? IOS26Colors.liquidGlassDarkTint
              : IOS26Colors.liquidGlassSmallLightBorder,
        );
    }
  }
}

class _LiquidGlassConfig {
  const _LiquidGlassConfig({
    required this.backgroundColor,
    required this.borderRadius,
    required this.blurSigma,
    required this.shadowOpacity,
    required this.padding,
    this.borderColor,
  });

  final Color backgroundColor;
  final BorderRadius borderRadius;
  final double blurSigma;
  final double shadowOpacity;
  final EdgeInsetsGeometry padding;
  final Color? borderColor;
}

// =============================================================================
// Background Material
// =============================================================================

/// Blur intensity variant for background materials.
enum BackgroundMaterialVariant {
  /// 75% white, blur 50px. Heaviest frosted glass.
  chrome,

  /// 84% white over 34% tint, blur 100px.
  thick,

  /// 60% white over 25% tint, blur 100px. Default system material.
  regular,

  /// 40% white over 5% tint, blur 100px.
  thin,

  /// 3% white over 7% tint, blur 100px. Most transparent.
  ultrathin,
}

/// iOS 26 Background Material blur effect.
///
/// Simulates the system background materials (UIBlurEffect) using
/// [BackdropFilter] and layered semi-transparent containers.
///
/// Usage:
///   BackgroundMaterial(
///     variant: BackgroundMaterialVariant.regular,
///     child: NavigationContent(),
///   )
class BackgroundMaterial extends StatelessWidget {
  const BackgroundMaterial({
    super.key,
    required this.child,
    this.variant = BackgroundMaterialVariant.regular,
    this.borderRadius,
  });

  /// The content rendered on top of the blurred material.
  final Widget child;

  /// Blur intensity and opacity variant.
  final BackgroundMaterialVariant variant;

  /// Optional border radius for clipping.
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final config = _resolveConfig(isDark);
    final radius = borderRadius ?? BorderRadius.zero;

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: config.blurSigma,
          sigmaY: config.blurSigma,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radius,
            color: config.tintColor,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: radius,
              color: config.overlayColor,
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  _BackgroundMaterialConfig _resolveConfig(bool isDark) {
    // Dark mode uses inverted opacities with black base.
    final Color baseWhite = isDark ? Colors.black : Colors.white;
    final Color baseTint = isDark
        ? Colors.white.withValues(alpha: 0.04)
        : Colors.black.withValues(alpha: 0.02);

    switch (variant) {
      case BackgroundMaterialVariant.chrome:
        return _BackgroundMaterialConfig(
          blurSigma: 25, // 50px CSS blur ~= 25 sigma
          tintColor: baseTint,
          overlayColor: baseWhite.withValues(alpha: isDark ? 0.60 : 0.75),
        );

      case BackgroundMaterialVariant.thick:
        return _BackgroundMaterialConfig(
          blurSigma: 50, // 100px CSS blur ~= 50 sigma
          tintColor: baseWhite.withValues(alpha: isDark ? 0.20 : 0.34),
          overlayColor: baseWhite.withValues(alpha: isDark ? 0.60 : 0.84),
        );

      case BackgroundMaterialVariant.regular:
        return _BackgroundMaterialConfig(
          blurSigma: 50,
          tintColor: baseWhite.withValues(alpha: isDark ? 0.15 : 0.25),
          overlayColor: baseWhite.withValues(alpha: isDark ? 0.40 : 0.60),
        );

      case BackgroundMaterialVariant.thin:
        return _BackgroundMaterialConfig(
          blurSigma: 50,
          tintColor: baseWhite.withValues(alpha: isDark ? 0.03 : 0.05),
          overlayColor: baseWhite.withValues(alpha: isDark ? 0.25 : 0.40),
        );

      case BackgroundMaterialVariant.ultrathin:
        return _BackgroundMaterialConfig(
          blurSigma: 50,
          tintColor: baseWhite.withValues(alpha: isDark ? 0.04 : 0.07),
          overlayColor: baseWhite.withValues(alpha: isDark ? 0.02 : 0.03),
        );
    }
  }
}

class _BackgroundMaterialConfig {
  const _BackgroundMaterialConfig({
    required this.blurSigma,
    required this.tintColor,
    required this.overlayColor,
  });

  final double blurSigma;
  final Color tintColor;
  final Color overlayColor;
}

// =============================================================================
// Scroll Edge Effect
// =============================================================================

/// Edge position for scroll fade effects.
enum ScrollEdge {
  top,
  bottom,
  leading,
  trailing,
}

/// Scroll edge appearance mode.
enum ScrollEdgeMode {
  /// Soft gradient fade + blur (10px + 60px).
  soft,

  /// Hard blur boundary (60px).
  hard,
}

/// iOS 26 Scroll Edge Effect.
///
/// Applies a gradient fade and optional blur at the edges of a scrollable
/// area, matching the iOS 26 scroll edge behavior.
///
/// Usage:
///   ScrollEdgeEffect(
///     edges: {ScrollEdge.top, ScrollEdge.bottom},
///     child: ListView(...),
///   )
class ScrollEdgeEffect extends StatelessWidget {
  const ScrollEdgeEffect({
    super.key,
    required this.child,
    this.edges = const {ScrollEdge.top, ScrollEdge.bottom},
    this.mode = ScrollEdgeMode.soft,
    this.extent = 40,
  });

  /// The scrollable content.
  final Widget child;

  /// Which edges to apply the fade effect.
  final Set<ScrollEdge> edges;

  /// Visual mode of the edge effect.
  final ScrollEdgeMode mode;

  /// Size of the fade gradient in logical pixels.
  final double extent;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        final List<double> stops = [];
        final List<Color> colors = [];

        // Calculate vertical stops.
        final topFraction = extent / bounds.height;
        final bottomFraction = 1.0 - (extent / bounds.height);

        if (edges.contains(ScrollEdge.top)) {
          colors.addAll([Colors.transparent, Colors.white]);
          stops.addAll([0.0, topFraction.clamp(0.0, 1.0)]);
        } else {
          colors.add(Colors.white);
          stops.add(0.0);
        }

        if (edges.contains(ScrollEdge.bottom)) {
          colors.addAll([Colors.white, Colors.transparent]);
          stops.addAll([bottomFraction.clamp(0.0, 1.0), 1.0]);
        } else {
          colors.add(Colors.white);
          stops.add(1.0);
        }

        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors,
          stops: stops,
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: child,
    );
  }
}

// =============================================================================
// Liquid Glass Navigation Bar (convenience widget)
// =============================================================================

/// A pre-built navigation bar using the Liquid Glass material.
///
/// Matches the iOS 26 floating toolbar pattern.
///
/// Usage:
///   LiquidGlassNavBar(
///     leading: BackButton(),
///     title: Text('Settings'),
///     trailing: Icon(Icons.more_horiz),
///   )
class LiquidGlassNavBar extends StatelessWidget {
  const LiquidGlassNavBar({
    super.key,
    this.leading,
    this.title,
    this.trailing,
    this.size = LiquidGlassSize.large,
  });

  /// Left-side widget (typically a back button).
  final Widget? leading;

  /// Center title widget.
  final Widget? title;

  /// Right-side widget (typically action buttons).
  final Widget? trailing;

  /// Glass size variant.
  final LiquidGlassSize size;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: LiquidGlass(
          size: size,
          child: SizedBox(
            height: 44,
            child: Row(
              children: [
                if (leading != null) leading!,
                if (leading != null) const SizedBox(width: 8),
                if (title != null) Expanded(child: Center(child: title!)),
                if (trailing != null) const SizedBox(width: 8),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Liquid Glass Tab Bar Item (convenience widget)
// =============================================================================

/// A single tab item styled with Liquid Glass Small material when selected.
///
/// Usage:
///   LiquidGlassTabItem(
///     icon: Icons.house_rounded,
///     label: 'Home',
///     isSelected: currentIndex == 0,
///     onTap: () => setIndex(0),
///   )
class LiquidGlassTabItem extends StatelessWidget {
  const LiquidGlassTabItem({
    super.key,
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  /// Tab icon.
  final IconData icon;

  /// Tab label text.
  final String label;

  /// Whether this tab is currently selected.
  final bool isSelected;

  /// Tap callback.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final activeColor = IOS26Colors.blue;
    final inactiveColor = brightness == Brightness.dark
        ? IOS26Colors.gray
        : IOS26Colors.gray;

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 22,
          color: isSelected
              ? (isSelected ? IOS26Colors.liquidGlassPrimaryIcon : activeColor)
              : inactiveColor,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: IOS26Typography.caption2.copyWith(
            color: isSelected ? activeColor : inactiveColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );

    final wrappedContent = isSelected
        ? LiquidGlass(
            size: LiquidGlassSize.small,
            mode: LiquidGlassMode.primary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: content,
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: content,
          );

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: wrappedContent,
    );
  }
}
