# iOS 26 Design Guide for Flutter

Complete iOS 26 design system implementation for Flutter 3.x with null safety.

Extracted from the iOS & iPadOS 26 Figma Community Kit (`pDmGXdYu2k8xlf1SQoU9PW`).

---

## Files

| File | Description |
|------|-------------|
| `ios26_colors.dart` | ~50 color tokens: system, labels, backgrounds, fills, grays, separators, vibrant, liquid glass |
| `ios26_typography.dart` | 11 text styles with Regular/Emphasized/Italic/Loose variants |
| `ios26_theme.dart` | ThemeData (light/dark) + CupertinoThemeData (light/dark) |
| `ios26_materials.dart` | LiquidGlass, BackgroundMaterial, ScrollEdgeEffect widgets |
| `components.md` | Component mapping with Flutter code examples |

---

## Setup

### Option A: Copy files into your project

```
lib/
  theme/
    ios26/
      ios26_colors.dart
      ios26_typography.dart
      ios26_theme.dart
      ios26_materials.dart
```

No additional dependencies required. All implementations use `dart:ui` and `package:flutter/material.dart`.

### Option B: Single barrel export

Create `lib/theme/ios26/ios26.dart`:

```dart
export 'ios26_colors.dart';
export 'ios26_typography.dart';
export 'ios26_theme.dart';
export 'ios26_materials.dart';
```

Then import with:

```dart
import 'package:your_app/theme/ios26/ios26.dart';
```

---

## Usage with MaterialApp

```dart
import 'package:your_app/theme/ios26/ios26.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My iOS 26 App',
      theme: IOS26Theme.light(),
      darkTheme: IOS26Theme.dark(),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
```

---

## Usage with CupertinoApp

For a fully native iOS look, use `CupertinoApp` with the Cupertino theme:

```dart
import 'package:your_app/theme/ios26/ios26.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    final theme = brightness == Brightness.dark
        ? IOS26Theme.cupertinoDark()
        : IOS26Theme.cupertinoLight();

    return CupertinoApp(
      title: 'My iOS 26 App',
      theme: theme,
      home: const HomeScreen(),
    );
  }
}
```

---

## Using Colors Directly

```dart
import 'package:your_app/theme/ios26/ios26_colors.dart';

// Static access
Container(color: IOS26Colors.blue)
Text('Hello', style: TextStyle(color: IOS26Colors.labelSecondary))

// Brightness-aware access
final label = IOS26Colors.label(Theme.of(context).brightness, level: 1);
final bg = IOS26Colors.background(Theme.of(context).brightness, grouped: true);
```

---

## Using Typography Directly

```dart
import 'package:your_app/theme/ios26/ios26_typography.dart';

// Standard text styles
Text('Large Title', style: IOS26Typography.largeTitle)
Text('Bold Body', style: IOS26Typography.bodyEmphasized)
Text('Footnote', style: IOS26Typography.footnote)

// Loose leading for multiline
Text(
  'This is a longer paragraph that wraps to multiple lines.',
  style: IOS26Typography.bodyLoose,
)

// With color override
Text(
  'Secondary text',
  style: IOS26Typography.subheadline.copyWith(
    color: IOS26Colors.labelSecondary,
  ),
)
```

---

## Using Liquid Glass

```dart
import 'package:your_app/theme/ios26/ios26_materials.dart';

// Floating toolbar
LiquidGlass(
  size: LiquidGlassSize.large,
  child: Row(
    children: [
      Icon(CupertinoIcons.back),
      Expanded(child: Center(child: Text('Title'))),
      Icon(CupertinoIcons.share),
    ],
  ),
)

// Pre-built navigation bar
LiquidGlassNavBar(
  leading: BackButton(),
  title: Text('Settings'),
  trailing: Icon(CupertinoIcons.ellipsis),
)

// Tab bar item with glass effect
LiquidGlassTabItem(
  icon: CupertinoIcons.house_fill,
  label: 'Home',
  isSelected: true,
  onTap: () {},
)
```

---

## Using Background Materials

```dart
import 'package:your_app/theme/ios26/ios26_materials.dart';

// Blurred overlay
BackgroundMaterial(
  variant: BackgroundMaterialVariant.regular,
  child: Container(
    height: 44,
    alignment: Alignment.center,
    child: Text('Navigation Bar'),
  ),
)

// Chrome (heaviest blur)
BackgroundMaterial(
  variant: BackgroundMaterialVariant.chrome,
  borderRadius: BorderRadius.circular(14),
  child: content,
)
```

---

## Using Scroll Edge Effects

```dart
import 'package:your_app/theme/ios26/ios26_materials.dart';

ScrollEdgeEffect(
  edges: {ScrollEdge.top, ScrollEdge.bottom},
  mode: ScrollEdgeMode.soft,
  extent: 40,
  child: ListView.builder(
    itemCount: 100,
    itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
  ),
)
```

---

## Font Note

The typography tokens use `fontFamily: null`, which lets Flutter resolve to the platform default font. On iOS this is SF Pro, on Android it is Roboto.

If you need SF Pro on all platforms (not recommended for Android), install the font manually and set:

```dart
// In ios26_typography.dart, change:
static const String? fontFamily = 'SF Pro';
```

And add to `pubspec.yaml`:

```yaml
flutter:
  fonts:
    - family: SF Pro
      fonts:
        - asset: assets/fonts/SF-Pro-Text-Regular.otf
        - asset: assets/fonts/SF-Pro-Text-Bold.otf
          weight: 700
        # ... other weights
```

---

## Requirements

- Flutter 3.x
- Dart 3.x (null safety)
- No additional packages required
