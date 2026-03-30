<p align="center">
  <img src="https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96_2x.png" width="80" alt="iOS 26 icon" />
</p>

<h1 align="center">iOS 26 Design System</h1>

<p align="center">
  <strong>The most comprehensive open-source iOS 26 / iPadOS 26 design system</strong><br/>
  Tokens, Components, Templates, Sections, and Pages — extracted from the official Figma Community Kit
</p>

<p align="center">
  <a href="./README.ko.md">한국어</a> · <a href="./README.ja.md">日本語</a> · <a href="./README.zh.md">中文</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/iOS_26-Liquid_Glass-007AFF?style=for-the-badge" alt="iOS 26" />
  <img src="https://img.shields.io/badge/Frameworks-4-34C759?style=for-the-badge" alt="4 frameworks" />
  <img src="https://img.shields.io/badge/Components-31-FF9500?style=for-the-badge" alt="31 components" />
  <img src="https://img.shields.io/badge/Pages-48-FF2D55?style=for-the-badge" alt="48 pages" />
  <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge" alt="MIT" />
</p>

---

## Why This Exists

Apple announced **Liquid Glass** and a radical new design language at WWDC25. Designers got a Figma kit. **Developers got nothing.**

This project bridges that gap. Every token, every component spec, every layout rule — extracted from the [official Figma Community Kit](https://www.figma.com/community/file/1527721578857867021) and translated into code you can use **today**, across **4 frameworks**.

## Install

```bash
# Design tokens (CSS variables, JS/TS, Dart)
npm install @ios26/tokens

# Framework-specific packages
npm install @ios26/svelte          # Svelte 5
npm install @ios26/rails           # Rails 8 + Hotwire
npm install @ios26/svelte-inertia  # Svelte 5 + Inertia.js

# Component specs, page recipes (for docs/AI context)
npm install @ios26/metadata
```

## What's Inside

```
ios26-design-system/                 # pnpm monorepo + Turborepo
├── packages/
│   ├── tokens/                      # @ios26/tokens
│   │   ├── src/                     # Source JSON (5 files)
│   │   │   ├── colors.json          # 79 variables × 4 modes
│   │   │   ├── typography.json      # 11 styles × 4 variants + Dynamic Type
│   │   │   ├── materials.json       # Liquid Glass + Background Materials
│   │   │   ├── spacing.json         # 8pt grid, radius, safe areas
│   │   │   └── animations.json      # Spring curves, Liquid Glass morphing
│   │   ├── dist/                    # Built outputs (auto-generated)
│   │   │   ├── css/                 # CSS custom properties
│   │   │   ├── index.js / .cjs     # JS/TS modules
│   │   │   └── dart/                # Flutter Dart classes
│   │   └── build.js                 # Token transformation pipeline
│   │
│   ├── svelte/                      # @ios26/svelte
│   ├── rails/                       # @ios26/rails
│   ├── svelte-inertia/              # @ios26/svelte-inertia
│   ├── flutter/                     # pub.dev: ios26_design
│   └── metadata/                    # @ios26/metadata
│       ├── components/specs/        # 31 component specifications
│       ├── templates/               # 5 layout composition patterns
│       ├── sections/                # 5 screen region specs
│       └── pages/                   # 48 page recipes (iPhone + iPad)
│
├── skills/                          # Claude Code / AI skills
│   └── ios26-design.md              # Complete token + component reference
│
├── turbo.json                       # Build orchestration
└── pnpm-workspace.yaml              # Monorepo workspace
```

## Framework Support

| Package | Framework | Tokens | Components | Status |
|---------|-----------|--------|------------|--------|
| `@ios26/tokens` | Any | JSON, CSS, JS/TS, Dart | — | `npm install @ios26/tokens` |
| `@ios26/svelte` | Svelte 5 | CSS Custom Properties | Runes mode | `npm install @ios26/svelte` |
| `@ios26/svelte-inertia` | Svelte 5 + Inertia.js | CSS Custom Properties | + Rails layouts | `npm install @ios26/svelte-inertia` |
| `@ios26/rails` | Rails 8 + Hotwire | CSS + Stimulus | ERB partials | `npm install @ios26/rails` |
| `@ios26/metadata` | Any | — | 31 specs + 48 pages | `npm install @ios26/metadata` |
| `ios26_design` | Flutter 3.x | Dart constants | Material + Cupertino | pub.dev (coming) |

## Quick Start

### Tokens (any framework)

```bash
npm install @ios26/tokens
```

```js
// ES Module — import token objects
import { colors, typography, materials } from '@ios26/tokens';

// CSS — import as custom properties
import '@ios26/tokens/css';              // colors
import '@ios26/tokens/css/typography';   // typography classes
import '@ios26/tokens/css/materials';    // Liquid Glass utilities
import '@ios26/tokens/css/animations';   // spring curves + durations

// Raw JSON — for custom build pipelines
import colors from '@ios26/tokens/json/colors';
```

### Svelte 5

```bash
npm install @ios26/svelte
```

```svelte
<script>
  import '@ios26/svelte/tokens.css';
  import '@ios26/svelte/typography.css';
  import '@ios26/svelte/materials.css';
</script>

<button class="ios26-button ios26-liquid-glass-sm">Done</button>
```

### Flutter

```dart
// pubspec.yaml: ios26_design: ^1.0.0
import 'package:ios26_design/ios26_theme.dart';

MaterialApp(
  theme: iOS26Theme.light(),
  darkTheme: iOS26Theme.dark(),
);
```

### Rails 8

```erb
<%# Gemfile or importmap: pin "@ios26/rails" %>
<%= stylesheet_link_tag "ios26/tokens" %>
<%= render "shared/ios26/toolbar", title: "Settings" %>
```

## Component Specs

Every component spec includes:

| Section | Description |
|---------|-------------|
| **Dimensions** | Exact width, height, padding in pt |
| **Variants** | Every axis: Size × Style × State × Mode |
| **Token Mapping** | Which color/typography token maps where |
| **State Transitions** | Default → Pressed → Disabled |
| **Animations** | Spring curves, duration, easing |
| **Accessibility** | Min 44×44pt touch target, contrast ratios |
| **Framework Notes** | Implementation hints per framework |

### Component Coverage (31 total)

| Priority | Components |
|----------|-----------|
| **Core** | Tab Bar, Toolbar, Button (148 variants), List Row |
| **Feedback** | Alert, Sheet, Notifications, Progress Indicators |
| **Controls** | Segmented Control, Toggle, Slider, Stepper, Text Field, Picker |
| **Navigation** | Sidebars, Menus, Context Menus, Action Sheets, Popovers |
| **System** | Keyboards, Widgets, App Icons, Face ID, Windows, System UI |

## Page Recipes

Each page recipe decomposes a complete screen into its constituent template + components:

**iPhone (25 screens):** Home Feed, Settings, List, Sheet Form, Alerts, Notifications, Keyboard, Widgets, Lock Screen, Control Center, and more.

**iPad (23 screens):** Split View, Sidebar, Popovers, Multitasking, Window, Form Sheet, and more.

## Liquid Glass

The defining visual feature of iOS 26. This design system captures the complete Liquid Glass specification:

```
Liquid Glass = Frosted blur + Refraction + Depth shadow + Light angle

Parameters (from Figma variables):
├── lightAngle: -45°
├── opacity: 60%
├── refraction: 100%
├── frostRadius: 7px (small) / 12px (medium) / 14px (large)
├── depth: 16
├── splay: 6
└── shadowBlur: 40px (layer) / 80px (background)
```

The `animations.json` includes Liquid Glass morphing keyframes — the "blob-like" tab indicator animation that stretches during travel:

```json
{
  "liquidGlass": {
    "tabIndicator": {
      "duration": 0.45,
      "spring": "snappy",
      "cssApprox": "cubic-bezier(0.34, 1.56, 0.64, 1.0)"
    }
  }
}
```

## Source

All data is extracted from the official **iOS & iPadOS 26 Figma Community Kit** by Apple.

- **Figma Community Kit**: [iOS & iPadOS 26](https://www.figma.com/community/file/1527721578857867021)
- **Figma File Key**: `pDmGXdYu2k8xlf1SQoU9PW` (for Figma API / MCP access)
- **Extraction**: Figma MCP + manual verification
- **Modes**: Light, Dark, Increased Contrast Light, Increased Contrast Dark

## Architecture

Follows **Atomic Design** methodology:

```
Tokens (atoms) → Components (molecules) → Templates (organisms) → Sections → Pages
```

Each layer references the one below it. Component specs reference token values. Templates compose components. Pages instantiate templates.

## AI / Vibe Coding Integration

This design system ships with a **Claude Code skill** (`skills/ios26-design.md`) that gives AI assistants complete knowledge of iOS 26 tokens, components, and layout patterns.

To use it, copy the skill file to your Claude Code skills directory, or reference it in your project. The skill auto-activates when it detects iOS 26, Liquid Glass, or `@ios26/*` imports.

Also works as context for **Cursor Rules**, **GitHub Copilot**, or any AI coding assistant — the skill file contains a complete quick-reference of all token values, component dimensions, and animation parameters.

## Contributing

Contributions are welcome! Areas where help is needed:

- **New frameworks**: React Native, SwiftUI wrapper, Jetpack Compose, Angular
- **Dark mode refinement**: IC (Increased Contrast) mode validation
- **Accessibility audit**: WCAG AAA compliance checks
- **Animation demos**: Live Liquid Glass demos in each framework
- **Additional pages**: More real-world app screen recipes

Please open an issue to discuss before submitting large PRs.

## Roadmap

- [x] npm monorepo (`@ios26/tokens`, `@ios26/svelte`, `@ios26/rails`, ...)
- [x] Token build pipeline (JSON → CSS / JS / Dart)
- [x] Claude Code AI skill
- [x] GitHub Actions CI/CD
- [ ] Dart package on pub.dev
- [ ] Storybook / Histoire component gallery
- [ ] Interactive Liquid Glass playground
- [ ] React Native implementation
- [ ] SwiftUI wrapper components
- [ ] MCP server for design system queries

## License

MIT License. See [LICENSE](./LICENSE) for details.

Design tokens are derived from Apple's publicly available Figma Community Kit. Apple, iOS, iPadOS, and Liquid Glass are trademarks of Apple Inc.

---

<p align="center">
  Built by <a href="https://dcode-labs.com">Dcode Labs</a><br/>
  <sub>If this saved you time, a star helps others find it too.</sub>
</p>
