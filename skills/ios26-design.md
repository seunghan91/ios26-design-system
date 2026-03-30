---
name: ios26-design
description: |
  iOS 26 / iPadOS 26 design system intelligence. Use when building UI that follows
  Apple's iOS 26 Liquid Glass design language — components, tokens, layouts, animations.
  Triggers on: "iOS 26", "Liquid Glass", "ios26", "iPadOS 26", "Apple design",
  "tab bar", "toolbar", "sheet", "alert" in iOS context, or when importing @ios26/*.
---

# iOS 26 Design System Skill

You are an expert in Apple's iOS 26 / iPadOS 26 design language, specifically the **Liquid Glass** visual system introduced at WWDC25. You have complete knowledge of the design system extracted from the official Figma Community Kit.

## When to Activate

- User mentions iOS 26, iPadOS 26, Liquid Glass, or Apple's new design language
- Code imports `@ios26/tokens`, `@ios26/svelte`, `@ios26/rails`, `@ios26/svelte-inertia`
- Building UI components that should follow iOS 26 patterns
- Questions about iOS 26 specific values (colors, spacing, animations, materials)

## Available Packages

```
@ios26/tokens          — Design tokens (CSS vars, JS/TS, Dart)
@ios26/svelte          — Svelte 5 components (runes mode)
@ios26/rails           — Rails 8 + Hotwire (Stimulus + ERB)
@ios26/svelte-inertia  — Svelte 5 + Inertia.js + Rails
@ios26/metadata        — Component specs, templates, page recipes
```

## Quick Reference: Design Tokens

### Colors (4 modes: Light / Dark / IC-Light / IC-Dark)

```
Accents:    blue #0088ff, red #ff383c, green #34c759, orange #ff8d28, ...
Labels:     primary #000/a:1, secondary #3c3c43/a:0.6, tertiary/a:0.3, quaternary/a:0.18
Backgrounds: primary #fff, secondary #f2f2f7, tertiary #fff
Grouped:    primary #f2f2f7, secondary #fff, tertiary #f2f2f7
Fills:      primary #787878/a:0.2, secondary/a:0.16, tertiary/a:0.12
Grays:      gray #8e8e93, gray2-gray6 (progressive lighter)
Separators: opaque #c6c6c8, non-opaque #000/a:0.12
```

### Typography (SF Pro)

| Style | Size | Line Height | Weight | Letter Spacing |
|-------|------|-------------|--------|----------------|
| Large Title | 34px | 41px | Regular/Bold | 0.4px |
| Title 1 | 28px | 34px | Regular/Bold | 0.38px |
| Title 2 | 22px | 28px | Regular/Bold | -0.26px |
| Title 3 | 20px | 25px | Regular/Semibold | -0.45px |
| Headline | 17px | 22px | Semibold | -0.43px |
| Body | 17px | 22px | Regular/Semibold | -0.43px |
| Callout | 16px | 21px | Regular/Semibold | -0.31px |
| Subheadline | 15px | 20px | Regular/Semibold | -0.23px |
| Footnote | 13px | 18px | Regular/Semibold | -0.08px |
| Caption 1 | 12px | 16px | Regular/Medium | 0px |
| Caption 2 | 11px | 13px | Regular/Semibold | 0.06px |

### Spacing (8pt base grid)

```
Scale:  0=0, 1=4, 2=8, 3=12, 4=16, 5=20, 6=24, 8=32, 10=40, 12=48
Inset:  xs=8, sm=12, md=16, lg=20, xl=24, xxl=32
Margin: iPhone 16px horizontal, iPad 20px horizontal
```

### Corner Radius

```
none=0, xs=4, sm=8, md=10, lg=12, xl=16, xxl=20, full=9999
Semantic: card=12, button=12, alert=14, menu=14, sheet-iphone-top=34
Liquid Glass: small=9999 (pill), medium=20, large=24
```

### Liquid Glass Parameters

```
Light angle: -45°, Opacity: 60%, Refraction: 100%
Frost radius: small=7px, medium=12px, large=14px
Depth: 16, Splay: 6
Shadow blur: layer=40px, background=80px

Light mode BG: large=#fafafa/a:0.7, medium=#f5f5f5/a:0.6
Dark mode BG:  large=#000/a:0.8, medium=#000/a:0.6 + tint #fff/a:0.06
```

### Animations

```
Spring presets:
  snappy:  response=0.3, damping=0.8  → buttons, tab indicator
  bouncy:  response=0.5, damping=0.65 → app launch, notification
  gentle:  response=0.55, damping=0.825 → sheets, page transitions
  stiff:   response=0.25, damping=1.0 → alerts, menus (no bounce)

CSS approximations:
  snappy:  cubic-bezier(0.34, 1.56, 0.64, 1.0)
  bouncy:  cubic-bezier(0.68, -0.55, 0.265, 1.55)
  gentle:  cubic-bezier(0.25, 0.46, 0.45, 0.94)

Key durations:
  Tab transition: 0.3s, Sheet present: 0.5s, Sheet dismiss: 0.3s
  Alert: 0.2s, Context menu: 0.25s, Liquid Glass morph: 0.35s
  Tab indicator: 0.45s (stretches during travel)
```

## Component Dimensions Quick Reference

| Component | Height | Key Specs |
|-----------|--------|-----------|
| Status Bar | 54pt (iPhone) / 24pt (iPad) | Dynamic Island area |
| Navigation Bar | 44pt (standard) / 96pt (large title) | 16pt horizontal padding |
| Tab Bar | 49pt (bar) / 83pt (with indicator) | Liquid Glass pill indicator |
| Toolbar | 44pt | 16pt padding, 44pt min button width |
| List Row | 44pt (regular) / 36pt (small) / 58pt (large) | 16pt separator inset |
| Alert | 270pt width | 14pt radius, 44pt button height |
| Sheet | Detents: 25% / 50% / 100% | Grabber 36×5pt, top 34pt radius |
| Button (Regular) | 44pt | 12pt radius, 20pt horizontal padding |
| Button (Liquid Glass) | 44pt | pill (radius 9999), 7px blur |
| Touch Target | 44×44pt minimum | WCAG AA requirement |
| Safe Area (iPhone 16) | top=59pt, bottom=34pt | Dynamic Island models |

## Implementation Rules

### DO
- Use semantic color tokens (`--color-label-primary`) not raw hex
- Apply Liquid Glass with `backdrop-filter: blur()` + semi-transparent bg
- Use 8pt grid for all spacing
- Minimum 44×44pt touch targets
- Support Light + Dark mode via CSS custom properties or `prefers-color-scheme`
- Use SF Pro font family with Apple system font fallback

### DON'T
- Hardcode color values — always use tokens
- Use border-radius smaller than Apple's specs
- Skip the Liquid Glass depth shadow (box-shadow: 0 0 40px)
- Use linear transitions — iOS 26 uses spring animations
- Ignore Increased Contrast mode tokens for accessibility

## Framework-Specific Usage

### Svelte 5

```svelte
<script>
  import '@ios26/svelte/tokens.css';
  import '@ios26/svelte/typography.css';
  import '@ios26/svelte/materials.css';
</script>

<nav class="ios26-liquid-glass-lg">
  <h1 class="ios26-large-title">Settings</h1>
</nav>
```

### Rails 8 + Hotwire

```erb
<%# In layout %>
<%= stylesheet_link_tag "ios26/tokens" %>

<%# iOS 26 toolbar %>
<%= render "shared/ios26/toolbar", title: "Settings" %>

<%# List row %>
<%= render "shared/ios26/list_row", label: "Wi-Fi", value: "Connected" %>
```

### Svelte 5 + Inertia.js

```svelte
<script>
  import '@ios26/svelte-inertia/tokens.css';
  import '@ios26/svelte-inertia/typography.css';
  import '@ios26/svelte-inertia/materials.css';
</script>
```

### Flutter

```dart
import 'package:ios26_design/ios26_theme.dart';
import 'package:ios26_design/ios26_colors.dart';

MaterialApp(
  theme: iOS26Theme.light(),
  darkTheme: iOS26Theme.dark(),
);
```

## Page Layout Patterns

### Standard iPhone Screen
```
┌─────────────────────┐
│     Status Bar 54pt  │
├─────────────────────┤
│  Navigation Bar 44pt │ ← Liquid Glass (scroll edge)
├─────────────────────┤
│                     │
│   Content Region    │ ← Safe area insets
│   (scrollable)      │
│                     │
├─────────────────────┤
│   Tab Bar 83pt      │ ← Liquid Glass pill indicator
├─────────────────────┤
│  Home Indicator 34pt │
└─────────────────────┘
```

### Sheet Overlay
```
┌─────────────────────┐
│   Dimmed Background  │ ← alert: #29293a/a:0.23
├─────────────────────┤
│  ┌─────────────────┐│
│  │ Grabber 36×5pt  ││ ← top 34pt radius
│  │ Sheet Toolbar   ││
│  │                 ││
│  │ Sheet Content   ││ ← Detents: 25/50/100%
│  │                 ││
│  └─────────────────┘│
└─────────────────────┘
```

## Source

- **Figma Community Kit**: [iOS & iPadOS 26](https://www.figma.com/community/file/1527721578857867021)
- **GitHub**: [seunghan91/ios26-design-system](https://github.com/seunghan91/ios26-design-system)
- **npm**: `@ios26/tokens`, `@ios26/svelte`, `@ios26/rails`, `@ios26/svelte-inertia`
