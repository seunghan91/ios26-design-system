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

This project bridges that gap. Every token, every component spec, every layout rule — extracted from the [official Figma Community Kit](https://www.figma.com/community/file/pDmGXdYu2k8xlf1SQoU9PW) and translated into code you can use **today**, across **4 frameworks**.

## What's Inside

```
ios26-design-system/
├── tokens/                    # Design tokens (JSON)
│   ├── colors.json            # 79 variables × 4 modes (Light/Dark/IC-Light/IC-Dark)
│   ├── typography.json        # 11 styles × 4 variants + Dynamic Type (7 sizes)
│   ├── materials.json         # Liquid Glass + Background Materials + Scroll Edge
│   ├── spacing.json           # 8pt grid, radius, safe areas, component dimensions
│   └── animations.json        # Spring curves, durations, Liquid Glass morphing
│
├── components/specs/          # 31 component specifications
│   ├── button.md              # 148 variants (Content Area + Liquid Glass)
│   ├── tab-bar.md             # iPhone + iPad, Liquid Glass indicator
│   ├── toolbar.md             # Top/Bottom/Sheet/iPad variants
│   ├── list-row.md            # Row, Swipe, Header, Index Bar
│   ├── sheet.md               # Detents, Liquid Glass grabber
│   ├── alert.md               # Standard + Text Field
│   └── ... (25 more)          # Every component from the Figma kit
│
├── templates/                 # 5 layout composition patterns
│   ├── standard-screen.md     # Status Bar + Nav + Content + Tab Bar
│   ├── sheet-overlay.md       # Detent 25/50/100%, keyboard avoidance
│   ├── navigation-stack.md    # Push/Pop, Large Title collapse
│   ├── tab-bar-layout.md      # Liquid Glass indicator morphing
│   └── alert-modal.md         # 270pt card, scale + fade animation
│
├── sections/                  # 5 screen region specifications
│   ├── status-bar.md          # Heights: 54pt (iPhone) / 24pt (iPad)
│   ├── navigation-region.md   # Standard 44pt / Large Title 96pt
│   ├── content-region.md      # Safe areas, scroll behavior, section spacing
│   ├── overlay-region.md      # Sheet detents, alert positioning, dimming
│   └── system-region.md       # Home Indicator, Dynamic Island, Keyboard
│
├── pages/                     # 48 complete page recipes
│   ├── iphone-examples/       # 25 iPhone screens
│   └── ipad-examples/         # 23 iPad screens
│
├── svelte/                    # Svelte 5 implementation
├── svelte-inertia/            # Svelte 5 + Inertia.js + Rails implementation
├── rails/                     # Rails 8 + Hotwire implementation
└── flutter/                   # Flutter 3.x implementation
```

## Framework Support

| Framework | Tokens | Components | Status |
|-----------|--------|------------|--------|
| **Svelte 5** | CSS Custom Properties | Runes mode (`$props()`) | Ready |
| **Svelte 5 + Inertia.js** | CSS Custom Properties | Svelte 5 + Rails backend | Ready |
| **Rails 8 + Hotwire** | CSS + Stimulus | ERB partials + Turbo | Ready |
| **Flutter 3.x** | Dart constants | Material + Cupertino themes | Ready |

## Quick Start

### Design Tokens (Framework-agnostic JSON)

All tokens live in `tokens/*.json` and can be consumed by any build tool:

```json
// tokens/colors.json — Liquid Glass blue accent
{
  "accents": {
    "blue": {
      "light": "#0088ff",
      "dark": "#0091ff",
      "icLight": "#1e6ef4",
      "icDark": "#5cb8ff"
    }
  }
}
```

```json
// tokens/materials.json — Liquid Glass blur parameters
{
  "liquidGlass": {
    "regular": {
      "large": { "frostRadius": 14, "depth": 16, "splay": 6 },
      "medium": { "frostRadius": 12, "depth": 16, "splay": 6 },
      "small": { "frostRadius": 7, "depth": 16, "splay": 6 }
    }
  }
}
```

### Svelte 5

```css
/* Import tokens */
@import 'ios26/tokens.css';
@import 'ios26/typography.css';
@import 'ios26/materials.css';
```

```svelte
<button class="ios26-button ios26-liquid-glass-sm">
  Done
</button>
```

### Flutter

```dart
import 'theme/ios26/ios26.dart';

MaterialApp(
  theme: iOS26Theme.light(),
  darkTheme: iOS26Theme.dark(),
);
```

### Rails 8

```erb
<!-- In your layout -->
<%= stylesheet_link_tag "ios26/tokens" %>

<!-- iOS 26 toolbar partial -->
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

- **Figma File**: [`pDmGXdYu2k8xlf1SQoU9PW`](https://www.figma.com/community/file/pDmGXdYu2k8xlf1SQoU9PW)
- **Extraction**: Figma MCP + manual verification
- **Modes**: Light, Dark, Increased Contrast Light, Increased Contrast Dark

## Architecture

Follows **Atomic Design** methodology:

```
Tokens (atoms) → Components (molecules) → Templates (organisms) → Sections → Pages
```

Each layer references the one below it. Component specs reference token values. Templates compose components. Pages instantiate templates.

## Contributing

Contributions are welcome! Areas where help is needed:

- **New frameworks**: React Native, SwiftUI wrapper, Jetpack Compose, Angular
- **Dark mode refinement**: IC (Increased Contrast) mode validation
- **Accessibility audit**: WCAG AAA compliance checks
- **Animation demos**: Live Liquid Glass demos in each framework
- **Additional pages**: More real-world app screen recipes

Please open an issue to discuss before submitting large PRs.

## Roadmap

- [ ] NPM package (`@ios26/tokens`)
- [ ] Dart package on pub.dev
- [ ] Storybook / Histoire component gallery
- [ ] Interactive Liquid Glass playground
- [ ] Figma plugin for token sync
- [ ] React Native implementation
- [ ] SwiftUI wrapper components

## License

MIT License. See [LICENSE](./LICENSE) for details.

Design tokens are derived from Apple's publicly available Figma Community Kit. Apple, iOS, iPadOS, and Liquid Glass are trademarks of Apple Inc.

---

<p align="center">
  Built by <a href="https://dcode-labs.com">Dcode Labs</a><br/>
  <sub>If this saved you time, a star helps others find it too.</sub>
</p>
