---
name: ios26-design
description: |
  iOS 26 / iPadOS 26 Liquid Glass design system for web and app development.
  Exact design tokens, component specs, layout patterns, and animation parameters
  from Apple's official Figma Community Kit.

  Use when:
  - Building UI with iOS 26, iPadOS 26, or Liquid Glass design language
  - User mentions "iOS 26", "Liquid Glass", "iPadOS 26", "Apple design"
  - Code imports @ios26_design_system/* packages
  - Creating tab bars, toolbars, sheets, alerts, buttons in Apple style
  - Needing Apple color values, typography scales, spacing, or spring animations
  - Implementing dark mode with Apple's 4-mode system
  - Questions about Liquid Glass blur, refraction, depth parameters

  Do NOT use for: SwiftUI/UIKit native dev (use Apple docs), general CSS unrelated to iOS 26.
---

# iOS 26 Design System

Build iOS 26 Liquid Glass interfaces on web and cross-platform.
Source: [Apple Figma Community Kit](https://www.figma.com/community/file/1527721578857867021)

## Packages

```bash
npm install @ios26_design_system/tokens          # CSS/JS/Dart tokens
npm install @ios26_design_system/svelte           # Svelte 5
npm install @ios26_design_system/rails            # Rails 8 + Hotwire
npm install @ios26_design_system/svelte-inertia   # Svelte 5 + Inertia.js
npm install @ios26_design_system/metadata         # 31 specs + 48 pages
```

## Typography (SF Pro)

| Style | Size | Line Height | Weight | Spacing |
|-------|------|-------------|--------|---------|
| Large Title | 34 | 41 | Regular/Bold | 0.4 |
| Title 1 | 28 | 34 | Regular/Bold | 0.38 |
| Title 2 | 22 | 28 | Regular/Bold | -0.26 |
| Title 3 | 20 | 25 | Regular/Semibold | -0.45 |
| Headline | 17 | 22 | Semibold | -0.43 |
| Body | 17 | 22 | Regular/Semibold | -0.43 |
| Callout | 16 | 21 | Regular/Semibold | -0.31 |
| Subheadline | 15 | 20 | Regular/Semibold | -0.23 |
| Footnote | 13 | 18 | Regular/Semibold | -0.08 |
| Caption 1 | 12 | 16 | Regular/Medium | 0 |
| Caption 2 | 11 | 13 | Regular/Semibold | 0.06 |

Font stack: `"SF Pro", -apple-system, system-ui, sans-serif`

## Spacing (8pt grid)

```
Scale:  0=0, 1=4, 2=8, 3=12, 4=16, 5=20, 6=24, 8=32, 10=40
Inset:  xs=8, sm=12, md=16, lg=20, xl=24, xxl=32
Margin: iPhone=16px, iPad=20px
Radius: none=0, xs=4, sm=8, md=10, lg=12, xl=16, xxl=20, full=9999
```

## Liquid Glass

```
frostRadius: small=7px, medium=12px, large=14px
depth: 16, splay: 6, lightAngle: -45°
shadowBlur: layer=40px, background=80px

Light: large=#fafafa/0.7, medium=#f5f5f5/0.6
Dark:  large=#000/0.8, medium=#000/0.6 (+tint #fff/0.06)
Pill:  small=9999px, medium=20px, large=24px
```

## Animations

```
Springs (response / damping → CSS):
  snappy:  0.3 / 0.8  → cubic-bezier(0.34, 1.56, 0.64, 1.0)   [buttons, tabs]
  bouncy:  0.5 / 0.65 → cubic-bezier(0.68, -0.55, 0.265, 1.55) [launch, notification]
  gentle:  0.55 / 0.825 → cubic-bezier(0.25, 0.46, 0.45, 0.94) [sheets, pages]
  stiff:   0.25 / 1.0 → no bounce                                [alerts, menus]

Durations: tab=0.3s, sheet-present=0.5s, sheet-dismiss=0.3s,
  alert=0.2s, context-menu=0.25s, tab-indicator=0.45s
```

## Component Dimensions

| Component | Height | Key Specs |
|-----------|--------|-----------|
| Status Bar | 54pt iPhone / 24pt iPad | Dynamic Island |
| Nav Bar | 44pt / 96pt large title | 16pt h-padding |
| Tab Bar | 49pt / 83pt with indicator | Liquid Glass pill |
| Toolbar | 44pt | 16pt padding |
| List Row | 44pt / 36pt sm / 58pt lg | 16pt separator inset |
| Alert | 270pt wide | 14pt radius |
| Sheet | Detents 25/50/100% | Grabber 36×5pt, radius 34pt |
| Button | 44pt regular | 12pt radius, 20pt h-padding |
| Button LG | 44pt | pill 9999, blur 7px |
| Touch Target | 44×44pt minimum | WCAG AA |
| Safe Area | top=59pt, bottom=34pt | iPhone 16 |

## Rules

**DO**: Use semantic tokens (`--color-label-primary`), 8pt grid, min 44pt touch, spring animations, Light+Dark support.

**DON'T**: Hardcode hex colors, skip Liquid Glass shadow, use linear easing, forget Increased Contrast tokens.

## Detailed References

- **Full color tokens** (79 vars × 4 modes): [references/tokens.md](references/tokens.md)
- **31 component specs**: [references/components.md](references/components.md)
- **Layout patterns + 48 pages**: [references/layouts.md](references/layouts.md)
- **Framework code examples**: [references/frameworks.md](references/frameworks.md)
