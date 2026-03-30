# iOS 26 Layout Patterns & Page Recipes

## 5 Templates

### Standard Screen
```
┌─────────────────────┐
│   Status Bar (54pt)  │
├─────────────────────┤
│  Nav Bar (44/96pt)   │  ← Liquid Glass on scroll
├─────────────────────┤
│                     │
│   Content Region    │  ← 16pt horizontal margin
│                     │
├─────────────────────┤
│   Tab Bar (83pt)    │  ← Liquid Glass pill
├─────────────────────┤
│  Home Indicator 34pt │
└─────────────────────┘
```
Total chrome: ~225pt top+bottom on iPhone 16

### Sheet Overlay
```
┌─────────────────────┐
│  Dimmed Background   │
│  ┌─────────────────┐│
│  │ Grabber 36×5pt  ││  ← 8pt from top, radius 34pt
│  │ Toolbar 44pt    ││
│  │                 ││
│  │ Content         ││  ← Detents: 25/50/100%
│  └─────────────────┘│
└─────────────────────┘
```
Present: 0.5s gentle spring. Dismiss: 0.3s ease-in.
Keyboard avoidance: sheet pushes up, never covers input.

### Navigation Stack
- Push: new screen from right (translateX 100%→0), 0.35s
- Pop: current screen exits right (0→100%), 0.35s
- Large Title collapses 96pt→44pt on scroll with spring

### Tab Bar Layout
- Liquid Glass indicator morphs between tabs
- Stretches horizontally during travel (blob effect)
- Duration: 0.45s snappy spring
- 2-5 tabs. Icon 24pt + caption2 label below

### Alert Modal
- Centered card 270pt wide
- Scale 0.85→1.0 + opacity 0→1, 0.2s stiff
- Dimming: light #29293a/0.23, dark #121212/0.56
- 1-2 buttons (side-by-side or stacked)

## Screen Region Specs

| Region | iPhone | iPad | Key Rule |
|--------|--------|------|----------|
| Status Bar | 54pt | 24pt | Dynamic Island on notch models |
| Navigation | 44pt standard, 96pt large title | Same | Collapses on scroll |
| Content | Safe area: top 59, bottom 34 | top 24, bottom 20 | 16/20pt margin |
| Overlay | Sheet detents 25/50/100% | Form sheet centered | Alert always centered |
| System | Home indicator 134×5pt | Same | Keyboard 216pt portrait |

## 48 Page Recipes Summary

### iPhone (25 screens)
| Screen | Template | Key Components |
|--------|----------|---------------|
| Home Feed | Standard | Nav + scrollable cards + Tab Bar |
| Settings | Standard | Nav + grouped list sections |
| List | Standard | Nav + inset/full-width rows |
| Detail View | Standard | Nav + hero + content |
| Sheet Form | Sheet | Grabber + toolbar + form fields |
| Sheets | Sheet | Fullscreen / Stack / Inspector |
| Alert Flow | Alert Modal | Standard + text field alerts |
| Tab Bar | Standard | Standard + split search variant |
| Toolbars | Standard | Top 5 + bottom 3 variants |
| Text Fields | Standard | Plain / secure / search / multiline |
| Notifications | Overlay | Collapsed stack + expanded |
| Keyboard | System | 5 variants (text/numeric/emoji) |
| Lock Screen | System | Time + widgets + Dynamic Island |
| Home Screen | System | App grid + dock + widgets |
| Control Center | System | Toggle grid + media + sliders |
| Context Menu | Overlay | Long-press preview + menu |
| Action Sheet | Sheet | Bottom actions + cancel |
| Activity View | Sheet | Share (app grid + action rows) |
| Color Picker | Sheet | Spectrum + sliders + hex |
| Menus | Overlay | Edit menu + standard menu |
| Picker | Standard | Inline wheel + compact date |
| Slider Stepper | Standard | Controls in list rows |
| Widgets | Standard | Small/medium/large + Smart Stack |
| Empty States | Standard | 3 variants (icon/text/button) |
| Face ID | System | Authenticating + success |

### iPad (23 screens)
| Screen | Template | Key Components |
|--------|----------|---------------|
| Split View | iPad Split | Sidebar + detail |
| Sidebar | iPad Split | Standard + multi-level |
| List | Standard | Wide rows + sidebar + drag-drop |
| Tab Bars | Standard | Top tab bar + search |
| Toolbars | Standard | 4 top toolbar variants |
| Sheets | Sheet | Form sheet centered card |
| Alert | Alert Modal | Standard + with keyboard |
| Popover | Overlay | 4 arrow directions + content |
| Popover Menu | Overlay | Popover menu recipe |
| Context Menu | Overlay | Long-press + right-click |
| Action Sheet | Overlay | Popover presentation |
| Activity View | Overlay | Share sheet as popover |
| Notifications | Overlay | 600pt centered cards |
| Keyboard | System | Full-width + split + floating |
| Widgets | Standard | 4 sizes (incl. Extra Large) |
| Menus | Overlay | Edit menu + submenu |
| Color Picker | Sheet | Wide layout spectrum + sliders |
| Home Screen | System | 76pt icon grid + App Library |
| Quick Actions | Overlay | App icon context menu |
| Lock Screen | System | Centered time + widget areas |
| Control Center | System | Larger module grid landscape |
| Multitasking | System | Split View + Slide Over |
| Window | System | Stage Manager windowed mode |
