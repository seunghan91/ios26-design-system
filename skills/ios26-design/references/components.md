# iOS 26 Component Specs — Quick Reference

31 components extracted from Apple's Figma Community Kit.

## Core Components

### Tab Bar
- Height: 49pt (bar only), 83pt (with Liquid Glass indicator)
- Liquid Glass indicator: pill shape (radius 9999), blur 7px
- Indicator morphing: 0.45s snappy spring, stretches during travel
- 2-5 tabs, icon 24×24 + caption2 label
- iPad: top tab bar variant, larger width

### Toolbar
- Standard height: 44pt
- Large Title: 96pt (collapses to 44pt on scroll)
- Horizontal padding: 16pt
- Button min width: 44pt
- Variants: Top (5), Bottom (3), Sheet (2), iPad (4)
- Liquid Glass scroll edge effect on scroll

### Button
- **Content Area** (148 variants):
  - Mini: 28pt h, 8pt radius
  - Small: 34pt h, 10pt radius
  - Regular: 44pt h, 12pt radius
  - Large: 50pt h, 14pt radius
  - XLarge: 56pt h, 16pt radius
  - Styles: filled, tinted, gray, plain, destructive
- **Liquid Glass Text**: 44pt h, pill radius 9999, blur 7px
- **Liquid Glass Symbol**: 44×44pt, circle radius 9999, blur 7px

### List Row
- Small: 36pt, Regular: 44pt, Large: 58pt
- Horizontal padding: 16pt, Vertical: 11pt
- Separator inset: 16pt left
- Variants: standard, subtitle, button, swipe actions
- Section headers, index bar (iPad)

## Feedback Components

### Alert
- Width: 270pt, radius: 14pt
- Padding: 16pt horizontal, 20pt vertical
- Button height: 44pt
- Animation: scale(0.85→1) + fade, 0.2s stiff spring
- Dimming: #29293a a:0.23 (light), #121212 a:0.56 (dark)

### Sheet
- Detents: 25%, 50%, 100%
- Grabber: 36×5pt, 8pt from top
- Top radius: 34pt (iPhone), 38pt (iPad)
- Present: 0.5s gentle spring, Dismiss: 0.3s ease-in
- Liquid Glass grabber on large sheets

### Notifications
- Standard: card with app icon + title + body
- Grouped: stack with count badge
- Slide-in: 0.4s gentle spring from top
- iPhone: full-width, iPad: 600pt centered

### Progress Indicators
- Circular: 20pt default diameter
- Linear bar: 4pt height, rounded caps
- Activity indicator: spinning, 20pt

## Control Components

### Segmented Control
- Height: 32pt
- 14 variants (2-5 segments × styles)
- Selected fill: #fff (light), #fff a:0.27 (dark)

### Toggle
- Width: 51pt, Height: 31pt
- On: accent color, Off: fill tertiary
- Thumb: 27pt circle, white
- Animation: 0.2s snappy spring

### Slider
- Track height: 4pt
- Thumb: 28pt circle
- Min track: accent blue, Max track: fill primary

### Stepper
- Height: 36pt, Width: 94pt
- – and + buttons, divider in center
- 3 variants: default, with value, compact

### Text Field
- Height: 44pt (single-line)
- Outline: #3c3c43 a:0.29 (light)
- Radius: 10pt
- Padding: 12pt horizontal
- Variants: plain, secure, search, multiline

### Picker
- Inline wheel: row height 32pt
- Compact date: tinted button style
- Popover on iPad

## Navigation Components

### Sidebars (iPad)
- Width: 320pt default
- Row height: 44pt
- Selected fill: #fff (light), #8e8e93 a:0.25 (dark)
- Multi-level hierarchy support

### Menus
- Row height: 44pt
- Radius: 14pt
- Max width: 250pt
- Separator between groups
- Supports icons, checkmarks, submenus

### Context Menu
- Long-press trigger (0.5s)
- Preview card + menu below
- Scale-in: 0.25s snappy spring
- Radius: 14pt

### Action Sheet
- iPhone: bottom sheet with cancel button
- iPad: popover from source

### Popover (iPad)
- Arrow: 12pt, 4 directions
- Radius: 14pt
- Min width: 320pt

## System Components

### Keyboard
- Height: 216pt (portrait), 162pt (landscape)
- 33 variants (alphabetic, numeric, emoji, etc.)

### Widgets
- Small: 170×170pt, Medium: 364×170pt
- Large: 364×382pt, Extra Large (iPad): 788×382pt
- Radius: 22pt (small), 26pt (medium/large)

### App Icons
- iPhone: 60×60pt (display), 1024×1024 (store)
- Radius: ~26pt (superellipse)

### Windows (iPadOS Stage Manager)
- Title bar: 28pt
- Close/minimize/maximize: traffic light style
- Resizable with corner handles
