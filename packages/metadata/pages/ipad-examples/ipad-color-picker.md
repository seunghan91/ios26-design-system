# iPad Color Picker — iOS 26 iPad 페이지 레시피

> **References**
> - Templates: `../../templates/`
> - Components: `../../components/specs/color-pickers.md`
> - Tokens: `../../tokens/`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:26010")`

---

## 화면 개요

iPad에서 Color Picker는 iPhone보다 넓은 레이아웃을 활용한다. Popover 또는 Sheet로 표시되며, 넓은 화면 덕분에 Spectrum과 Sliders를 **나란히(side-by-side)** 배치하거나, 더 넓은 색상 그리드를 제공할 수 있다. iOS 26에서는 Liquid Glass 소재가 Color Picker 패널 배경에 적용된다.

| 항목 | 값 |
|------|-----|
| **적용 디바이스** | iPad Pro 13" (1210x834pt landscape) |
| **프레젠테이션** | Popover (기본) 또는 Sheet (커스텀) |
| **패널 너비** | `480pt` (iPad 확장) / `320pt` (Popover 기본) |
| **모드** | Grid, Spectrum, Sliders, Eyedropper, Favorites, Hex Input, Opacity |
| **배경 소재** | Liquid Glass |
| **UIKit** | `UIColorPickerViewController` |
| **SwiftUI** | `ColorPicker` |

---

## Device Context

```
iPad Pro 13" Landscape
─────────────────────────────
화면 크기      : 1210 x 834pt
Safe Area Top  : 24pt           ← spacing.json > safeArea.ipadLandscape.top
Safe Area Bot  : 20pt           ← spacing.json > safeArea.ipadLandscape.bottom
Content Margin : 20pt           ← spacing.json > contentMargin.ipad.horizontal
```

---

## Screen Composition Breakdown

### Variant A: Popover 프레젠테이션 (기본)

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           STATUS BAR (24pt)                                     │
├─────────────────────────────────────────────────────────────────────────────────┤
│  NAVIGATION BAR (Liquid Glass, 44pt)                                            │
│  [< 뒤로]    [메모 편집]                                         [완료]         │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│  CONTENT AREA                                                                   │
│  (메모, 그림 등)                                                                │
│                                                                                 │
│  텍스트 색상: [🔴] ← 탭                        ▲ Arrow (12pt)                   │
│                                     ┌───────────┴──────────────────┐            │
│                                     │  COLOR PICKER (Popover)      │            │
│                                     │  480pt 너비, Liquid Glass    │            │
│                                     │                              │            │
│                                     │  [Grid][Spec][Slid][Eye][Fav]│ ← Tab Bar │
│                                     │                              │            │
│                                     │  ┌──────────┬───────────────┐│            │
│                                     │  │ Spectrum │  Sliders      ││ ← Side by │
│                                     │  │ (Color   │  R [━━━━━━━] ││   Side     │
│                                     │  │  Wheel / │  G [━━━━━━━] ││            │
│                                     │  │  Gradient│  B [━━━━━━━] ││            │
│                                     │  │  Area)   │  A [━━━━━━━] ││            │
│                                     │  │          │               ││            │
│                                     │  └──────────┴───────────────┘│            │
│                                     │                              │            │
│                                     │  Preview: [████] #FF5733    │ ← 하단     │
│                                     └──────────────────────────────┘            │
│                                                                                 │
├─────────────────────────────────────────────────────────────────────────────────┤
│  TOOLBAR-BOTTOM (44pt, Liquid Glass)                                            │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### Variant B: Sheet 프레젠테이션 (Form Sheet)

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           STATUS BAR (24pt)                                     │
├─────────────────────────────────────────────────────────────────────────────────┤
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░  ┌───────────────────────────────────────────┐  ░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░  │              ━━━━━━━━━━━                  │  ░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░  │  COLOR PICKER (Form Sheet)                │  ░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░  │  540pt x 480pt, Liquid Glass              │  ░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░  │                                           │  ░░░░░░░░░░░░░  │
│  ░ DIMMING ░░  │  [Grid] [Spectrum] [Sliders] [Eye] [Fav]  │  ░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░  │                                           │  ░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░  │  ┌───────────────┬────────────────────┐  │  ░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░  │  │  Spectrum     │    Sliders         │  │  ░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░  │  │  (240x240)    │    R [━━━━━━━━━━] │  │  ░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░  │  │               │    G [━━━━━━━━━━] │  │  ░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░  │  │  [Crosshair]  │    B [━━━━━━━━━━] │  │  ░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░  │  │               │    A [━━━━━━━━━━] │  │  ░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░  │  └───────────────┴────────────────────┘  │  ░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░  │                                           │  ░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░  │  Preview: [████████] #FF5733  Hex: [____]│  ░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░  └───────────────────────────────────────────┘  ░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## Color Picker 패널 상세 치수

### iPad 확장 레이아웃 (Side-by-Side)

```
┌─────────────────────────────────────────────────────────┐
│  [Grid] [Spectrum] [Sliders] [Eyedropper] [Favorites]  │ ← Tab Bar: 44pt
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌────────────────────┐  ┌────────────────────────────┐│
│  │                    │  │  COLOR MODE: RGB           ││ ← 12pt footnote
│  │  SPECTRUM AREA     │  │                            ││
│  │  240 x 240pt       │  │  Red     [━━━━━━━━━━] 255 ││ ← 슬라이더 44pt
│  │                    │  │  Green   [━━━━━━━━━━] 100 ││
│  │  그라디언트 스펙트럼 │  │  Blue    [━━━━━━━━━━]  51 ││
│  │  + Crosshair 커서  │  │                            ││
│  │                    │  │  Opacity [━━━━━━━━━━] 100%││
│  │                    │  │                            ││
│  └────────────────────┘  └────────────────────────────┘│
│         ↑ gap: 16pt ↑                                   │
│                                                         │
├─────────────────────────────────────────────────────────┤
│  [████████]  #FF5733    Hex: [FF5733]    [복사]        │ ← 하단 Preview
│  40x40pt preview                                        │   height: 52pt
└─────────────────────────────────────────────────────────┘
   ← 전체 너비: 480pt (Popover) / 540pt (Sheet) →
```

### 치수 정리

| 속성 | Popover (기본) | Sheet (확장) | 토큰 |
|------|---------------|-------------|------|
| 전체 너비 | `480pt` | `540pt` | 커스텀 |
| Tab Bar 높이 | `44pt` | `44pt` | `spacing.json` > `components.toolbar.height` |
| Spectrum Area | `220x220pt` | `240x240pt` | 커스텀 |
| Sliders Area 너비 | `220pt` | `260pt` | 계산값 |
| Slider 높이 | `44pt` | `44pt` | `spacing.json` > `components.touchTarget.minimum` |
| Gap (Spectrum↔Sliders) | `16pt` | `16pt` | `spacing.json` > `inset.md` |
| Preview 영역 높이 | `52pt` | `52pt` | 커스텀 |
| Preview 색상 박스 | `40x40pt` | `40x40pt` | 커스텀 |
| 내부 패딩 | `16pt` | `20pt` | `spacing.json` > `inset.md` / `inset.lg` |
| Corner Radius | `14pt` | `38pt` (sheet) | `spacing.json` > `radius.semantic.popover` / `.sheet.ipad` |

### Grid 모드 (iPad 확장)

```
┌─────────────────────────────────────────────────────────┐
│  [Grid] [Spectrum] [Sliders] [Eye] [Fav]               │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ● ● ● ● ● ● ● ● ● ● ● ● ● ● ● ●                   │ ← 16열 (iPad)
│  ● ● ● ● ● ● ● ● ● ● ● ● ● ● ● ●                   │    vs 12열 (iPhone)
│  ● ● ● ● ● ● ● ● ● ● ● ● ● ● ● ●                   │
│  ● ● ● ● ● ● ● ● ● ● ● ● ● ● ● ●                   │ ← 색상 원형 24pt
│  ● ● ● ● ● ● ● ● ● ● ● ● ● ● ● ●                   │    간격 4pt
│  ● ● ● ● ● ● ● ● ● ● ● ● ● ● ● ●                   │
│  ● ● ● ● ● ● ● ● ● ● ● ● ● ● ● ●                   │
│                                                         │
├─────────────────────────────────────────────────────────┤
│  [████████]  #FF5733    Hex: [FF5733]                   │
└─────────────────────────────────────────────────────────┘
```

---

## Component Usage (토큰 참조)

### Container

| 속성 | 값 | 토큰 |
|------|-----|------|
| Corner Radius (Popover) | `14pt` | `spacing.json` > `radius.semantic.popover` |
| Corner Radius (Sheet) | `38pt` | `spacing.json` > `radius.semantic.sheet.ipad` |
| Background | Liquid Glass medium | `materials.json` > `liquidGlass.regular.medium` |
| Frost Radius | `12pt` | `materials.json` > `liquidGlass.regular.medium.frostRadius` |

### Tab Bar (모드 전환)

| 속성 | 값 | 토큰 |
|------|-----|------|
| Height | `44pt` | `spacing.json` > `components.toolbar.height` |
| Selected Tab | accents.blue | `colors.json` > `accents.blue` |
| Unselected Tab | labels.secondary | `colors.json` > `labels.secondary` |
| Tab Font | caption1/Regular (12pt) | `typography.json` > `styles.caption1` |
| Tab Icon Size | `22x22pt` | SF Symbol 기본 |

### Spectrum Area

| 속성 | 값 | 토큰 |
|------|-----|------|
| Size (iPad) | `240x240pt` | 커스텀 (iPhone: 280x280) |
| Crosshair Size | `20pt` | 커스텀 |
| Crosshair Border | `2pt` white | `colors.json` > `grays.white` |
| Corner Radius | `8pt` | `spacing.json` > `radius.sm` |

### Sliders

| 속성 | 값 | 토큰 |
|------|-----|------|
| Slider Height | `44pt` | `spacing.json` > `components.touchTarget.minimum` |
| Track Height | `8pt` | 시스템 기본 |
| Track Corner Radius | `4pt` | `spacing.json` > `radius.xs` |
| Thumb Size | `28pt` | 시스템 기본 |
| Thumb Shadow | blur 4pt | 시스템 기본 |
| Label Font | subheadline/Regular (15pt) | `typography.json` > `styles.subheadline` |
| Label Color | labels.primary | `colors.json` > `labels.primary` |
| Value Font | body/Semibold (17pt) | `typography.json` > `styles.body.emphasized` |

### Hex Input

| 속성 | 값 | 토큰 |
|------|-----|------|
| Height | `36pt` | 시스템 기본 |
| Corner Radius | `8pt` | `spacing.json` > `radius.sm` |
| BG | textField.bg | `colors.json` > `miscellaneous.textField.bg` |
| Border | textField.outline | `colors.json` > `miscellaneous.textField.outline` |
| Font | body/Regular (17pt), monospace | `typography.json` > `styles.body` |

### Preview Color Box

| 속성 | 값 | 토큰 |
|------|-----|------|
| Size | `40x40pt` | 커스텀 |
| Corner Radius | `8pt` | `spacing.json` > `radius.sm` |
| Border | `1pt` separators.opaque | `colors.json` > `separators.opaque` |

---

## iPad-Specific Adaptations

### iPhone vs iPad 레이아웃 비교

| 항목 | iPhone | iPad |
|------|--------|------|
| **프레젠테이션** | Sheet (full-width) | Popover 또는 Form Sheet |
| **패널 너비** | `320pt` (화면 너비) | `480~540pt` |
| **Grid 열 수** | 12열 | 16열 |
| **Spectrum + Sliders** | 세로 스택 (위아래) | 가로 나란히 (side-by-side) |
| **Hex Input** | Preview 아래 | Preview 옆 (공간 여유) |
| **Eyedropper** | 손가락 드래그 | 포인터 클릭 + 드래그 |

### Pointer Support

| 상호작용 | 동작 |
|---------|------|
| **Hover (Grid 색상)** | 색상 원형 확대 (scale 1.2) + 색상 코드 툴팁 |
| **Click (Spectrum)** | Crosshair 이동, 즉시 색상 업데이트 |
| **Drag (Spectrum)** | 포인터 드래그로 Crosshair 연속 이동 |
| **Drag (Slider)** | Thumb 정밀 드래그 |
| **Scroll (Grid)** | 트랙패드 스크롤로 색상 그리드 탐색 |

### Keyboard Shortcuts

| 단축키 | 동작 |
|--------|------|
| `Esc` | Color Picker 닫기 |
| `Tab` | 모드 탭 / 슬라이더 간 이동 |
| `↑` / `↓` | 슬라이더 값 미세 조정 (1단위) |
| `Shift + ↑` / `↓` | 슬라이더 값 큰 단위 조정 (10단위) |
| `Cmd + V` | Hex 값 붙여넣기 |
| `Cmd + C` | 현재 색상 Hex 복사 |

### Eyedropper (iPad 특화)

| 항목 | iPhone | iPad |
|------|--------|------|
| **트리거** | 탭 → 손가락 드래그 | 탭 → 포인터가 Eyedropper 커서로 변경 |
| **확대 루페** | 손가락 위에 표시 | 포인터 옆에 표시 |
| **정밀도** | 손가락 크기 제한 | 포인터로 1px 단위 선택 가능 |
| **범위** | 현재 앱 화면 | 현재 앱 화면 (시스템 Eyedropper는 전체 화면) |

---

## Light / Dark Mode 차이

### Light Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| Panel BG | `rgba(#f5f5f5, 0.6)` + frost | `materials.json` > `liquidGlass.regular.medium.light` |
| Shadow | blur 40pt | `materials.json` > `liquidGlass.regular.medium.light.shadow` |
| Label | `#000000` | `colors.json` > `labels.primary.light` |
| Secondary Label | `rgba(#3c3c43, 0.6)` | `colors.json` > `labels.secondary.light` |
| Selected Tab | `#0088ff` | `colors.json` > `accents.blue.light` |
| Slider Track BG | `rgba(#787878, 0.2)` | `colors.json` > `fills.primary.light` |
| Hex Field BG | `#ffffff` | `colors.json` > `miscellaneous.textField.bg.light` |

### Dark Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| Panel BG | `rgba(#000000, 0.6)` + frost + tint | `materials.json` > `liquidGlass.regular.medium.dark` |
| Tint | `rgba(#ffffff, 0.06)` | `materials.json` > `liquidGlass.regular.medium.dark.tint` |
| Label | `#ffffff` | `colors.json` > `labels.primary.dark` |
| Secondary Label | `rgba(#ebebf5, 0.7)` | `colors.json` > `labels.secondary.dark` |
| Selected Tab | `#0091ff` | `colors.json` > `accents.blue.dark` |
| Slider Track BG | `rgba(#787880, 0.36)` | `colors.json` > `fills.primary.dark` |
| Hex Field BG | `#000000` | `colors.json` > `miscellaneous.textField.bg.dark` |

---

## Multitasking Considerations

### Split View

- Popover: 각 앱 영역 내에서 표시, 넘치지 않음
- 좁은 쪽 (403pt): Side-by-side → 세로 스택으로 자동 전환
- Compact width: Sheet로 폴백 (iPhone 스타일)

### Slide Over

- 320pt 너비: Compact size class → Sheet (세로 스택 레이아웃)
- Grid는 12열로 축소

### Stage Manager

- 윈도우 크기에 따라 Popover 또는 Sheet 자동 전환
- 작은 윈도우: 세로 스택, 큰 윈도우: side-by-side

---

## Animation Spec

### Panel 등장 (Popover)

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.25s` | `animations.json` > `transitions.scale.in.duration` |
| Easing | spring.snappy | `animations.json` > `easing.spring.snappy` |
| Scale | `0.85 → 1.0` | `animations.json` > `transitions.scale.in` |
| Opacity | `0 → 1` | `animations.json` > `transitions.scale.in` |

### Tab 전환

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.2s` | `animations.json` > `duration.fast` |
| Easing | easeInOut | `animations.json` > `easing.easeInOut` |
| Content | crossfade (opacity) | 이전 모드 fadeOut → 새 모드 fadeIn |

### Crosshair 이동

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.1s` | `animations.json` > `duration.micro` |
| Easing | linear | `animations.json` > `easing.linear` |

---

## Accessibility

| 항목 | 구현 |
|------|------|
| **VoiceOver** | 현재 색상 값 읽기 ("빨강 255, 초록 100, 파랑 51") |
| **Voice Control** | "빨강 슬라이더 200으로 설정" |
| **Larger Text** | 라벨 크기 증가, 슬라이더 Track 높이 유지 |
| **Reduce Transparency** | Liquid Glass → 불투명 배경 |
| **Switch Control** | Tab 기반 탐색으로 각 슬라이더/탭 접근 |
| **Color Blind** | 색상 값(RGB/Hex)이 항상 표시되어 수치 기반 선택 가능 |
