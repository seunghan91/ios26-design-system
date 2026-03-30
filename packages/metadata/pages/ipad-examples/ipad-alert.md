# iPad Alert — iOS 26 iPad 페이지 레시피

> **References**
> - Templates: `../../templates/`
> - Components: `../../components/specs/alert.md`
> - Tokens: `../../tokens/`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="63:57121")`

---

## 화면 개요

iPad에서 Alert는 iPhone과 동일한 형태로 **화면 정중앙**에 270pt 고정 너비 카드로 표시된다. iPad의 넓은 화면에서도 크기가 변하지 않으며, 키보드가 올라온 상태에서도 Alert는 **화면 정중앙을 유지**한다(iPhone은 키보드 위로 올라감). 2가지 variant를 다룬다: Standard Alert(텍스트 전용)와 Alert with Keyboard(텍스트 필드 입력).

| 항목 | 값 |
|------|-----|
| **적용 디바이스** | iPad Pro 13" (1210x834pt landscape) |
| **Alert 너비** | `270pt` (고정, 디바이스 무관) |
| **위치** | 화면 정중앙 (수평 + 수직) |
| **Dimming Overlay** | 전체 화면 |
| **배경 소재** | Liquid Glass (`materials.json` > `liquidGlass.regular.medium`) |
| **Corner Radius** | `14pt` |
| **키보드 영향** | iPad: 없음 (정중앙 유지), iPhone: 키보드 위로 이동 |

---

## Device Context

```
iPad Pro 13" Landscape
─────────────────────────────
화면 크기      : 1210 x 834pt
Safe Area Top  : 24pt           ← spacing.json > safeArea.ipadLandscape.top
Safe Area Bot  : 20pt           ← spacing.json > safeArea.ipadLandscape.bottom
Alert 중앙 위치 : x=605, y=417  ← (1210/2, 834/2)
```

---

## Variant 1: Standard Alert (텍스트 전용)

### 레이아웃 구조

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           STATUS BAR (24pt)                                     │
├─────────────────────────────────────────────────────────────────────────────────┤
│  NAVIGATION BAR (Liquid Glass, 44pt)                                            │
│  [< Back]    [설정]                                            [편집]           │
├─────────────────────────────────────────────────────────────────────────────────┤
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░  ┌─────────────────────────┐  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░  │                         │  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░  │   항목을 삭제할까요?     │  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░  │                         │  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░ DIMMING OVERLAY ░░░  │  이 작업은 되돌릴 수    │  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░ 전체 화면 적용 ░░░░  │  없습니다.              │  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░  │                         │  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░  ├────────────┬────────────┤  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░  │   취소     │    삭제    │  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░  └────────────┴────────────┘  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### Alert Card 상세 치수

```
        ← 270pt →
┌─────────────────────────────────────┐  ← cornerRadius: 14pt
│          paddingTop: 20pt           │
│                                     │
│   항목을 삭제할까요?                 │  ← Title: headline/Semibold (17pt)
│                                     │    color: labels.primary
│          gap: 4pt                   │
│                                     │
│   이 작업은 되돌릴 수 없습니다.      │  ← Message: footnote/Regular (13pt)
│                                     │    color: labels.secondary
│          paddingBottom: 20pt        │    textAlign: center
│                                     │
├─────────────────────────────────────┤  ← separator: separators.nonOpaque (0.5pt)
│                                     │
│   취소          │       삭제        │  ← 2-button horizontal, 각 135pt
│   17pt Regular  │  17pt Semibold    │    height: 44pt
│   accents.blue  │  accents.red      │
│                                     │
└─────────────────────────────────────┘
     ↑ vertical separator (0.5pt)
```

---

## Variant 2: Alert with Keyboard (텍스트 필드 입력)

### 키보드 + Alert 레이아웃 (iPad)

iPad에서는 키보드가 올라와도 Alert가 화면 정중앙을 유지한다. 이는 iPad 화면이 충분히 크기 때문이다. iPhone에서는 키보드가 화면 하반부를 차지하므로 Alert가 키보드 위 영역의 중앙으로 이동한다.

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           STATUS BAR (24pt)                                     │
├─────────────────────────────────────────────────────────────────────────────────┤
│  NAVIGATION BAR (44pt)                                                          │
├─────────────────────────────────────────────────────────────────────────────────┤
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░  ┌─────────────────────────┐  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░  │                         │  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░  │   폴더 이름 입력         │  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░  │                         │  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░  │   새 폴더의 이름을      │  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░  │   입력하세요.           │  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░ Alert는 화면 ░░░░░  │                         │  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░ 정중앙 유지 ░░░░░░  │  ┌───────────────────┐  │  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░ (키보드와 무관) ░░░  │  │ 새 폴더           │  │  ← TextField (36pt)    │
│  ░░░░░░░░░░░░░░░░░░░░░  │  └───────────────────┘  │  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░  │                         │  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░  ├────────────┬────────────┤  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░  │   취소     │    저장    │  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░  └────────────┴────────────┘  ░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│                                                                                 │
│  ┌─────────────────────────────────────────────────────────────────────────────┐│
│  │  KEYBOARD (iPad full-width, Liquid Glass background)                       ││
│  │  height: ~264pt                                                            ││
│  │  shortcuts bar: 44pt                                                       ││
│  │  ┌────────────────────────────────────────────────────────────────────────┐││
│  │  │  [자동완성]  [붙여넣기]  [실행취소]                        [키보드 ⌨️] │││
│  │  ├────────────────────────────────────────────────────────────────────────┤││
│  │  │  Q  W  E  R  T  Y  U  I  O  P                                        │││
│  │  │  A  S  D  F  G  H  J  K  L                                           │││
│  │  │  Z  X  C  V  B  N  M  ⌫                                              │││
│  │  │  [123]  [🌐]  [________space________]  [return]                       │││
│  │  └────────────────────────────────────────────────────────────────────────┘││
│  └─────────────────────────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────────────────────────┘
```

### Alert with TextField 상세 치수

```
        ← 270pt →
┌─────────────────────────────────────┐
│          paddingTop: 20pt           │
│                                     │
│   폴더 이름 입력                     │  ← Title: headline/Semibold (17pt)
│                                     │
│          gap: 4pt                   │
│                                     │
│   새 폴더의 이름을 입력하세요.       │  ← Message: footnote/Regular (13pt)
│                                     │
│          gap: 8pt                   │
│                                     │
│   ┌─────────────────────────────┐  │  ← TextField Background
│   │ 새 폴더                     │  │    width: 238pt (270 - 16*2)
│   └─────────────────────────────┘  │    height: 36pt
│                                     │    cornerRadius: 8pt
│          paddingBottom: 20pt        │    bg: colors.json > miscellaneous.textField.bg
│                                     │    border: miscellaneous.textField.outline
├─────────────────────────────────────┤
│   취소          │       저장        │
└─────────────────────────────────────┘
```

---

## Component Usage (토큰 참조)

### Alert Container

| 속성 | 값 | 토큰 |
|------|-----|------|
| Width | `270pt` | `spacing.json` > `components.alert.width` |
| Corner Radius | `14pt` | `spacing.json` > `components.alert.cornerRadius` |
| Padding Horizontal | `16pt` | `spacing.json` > `components.alert.paddingHorizontal` |
| Padding Vertical | `20pt` | `spacing.json` > `components.alert.paddingVertical` |
| Button Height | `44pt` | `spacing.json` > `components.alert.buttonHeight` |
| Background | Liquid Glass medium | `materials.json` > `liquidGlass.regular.medium` |
| Frost Radius | `12pt` | `materials.json` > `liquidGlass.regular.medium.frostRadius` |

### Dimming Overlay

| 속성 | 값 | 토큰 |
|------|-----|------|
| Light | `rgba(#29293a, 0.23)` | `colors.json` > `overlays.alert.light` |
| Dark | `rgba(#121212, 0.56)` | `colors.json` > `overlays.alert.dark` |

### Typography

| 요소 | 스타일 | 토큰 |
|------|--------|------|
| Title | headline/Semibold (17pt, lh 22pt) | `typography.json` > `styles.headline` |
| Message | footnote/Regular (13pt, lh 18pt) | `typography.json` > `styles.footnote` |
| Cancel Button | body/Regular (17pt) | `typography.json` > `styles.body` |
| Confirm Button | body/Semibold (17pt) | `typography.json` > `styles.body.emphasized` |
| Destructive Button | body/Semibold (17pt) | `typography.json` > `styles.body.emphasized` |

### Colors

| 요소 | Light | Dark | 토큰 |
|------|-------|------|------|
| Title | `#000000` | `#ffffff` | `colors.json` > `labels.primary` |
| Message | `rgba(#3c3c43, 0.6)` | `rgba(#ebebf5, 0.7)` | `colors.json` > `labels.secondary` |
| Cancel | `#0088ff` | `#0091ff` | `colors.json` > `accents.blue` |
| Confirm | `#0088ff` | `#0091ff` | `colors.json` > `accents.blue` |
| Destructive | `#ff383c` | `#ff4245` | `colors.json` > `accents.red` |
| Separator | `rgba(#000000, 0.12)` | `rgba(#ffffff, 0.17)` | `colors.json` > `separators.nonOpaque` |

### TextField (Alert with Keyboard)

| 속성 | 값 | 토큰 |
|------|-----|------|
| Width | `238pt` (270 - 16*2) | 계산값 |
| Height | `36pt` | 시스템 기본 |
| Corner Radius | `8pt` | `spacing.json` > `radius.sm` |
| BG Light | `#ffffff` | `colors.json` > `miscellaneous.textField.bg.light` |
| BG Dark | `#000000` | `colors.json` > `miscellaneous.textField.bg.dark` |
| Border Light | `rgba(#3c3c43, 0.29)` | `colors.json` > `miscellaneous.textField.outline.light` |
| Border Dark | `rgba(#ebebf5, 0.3)` | `colors.json` > `miscellaneous.textField.outline.dark` |
| Placeholder | footnote/Regular (13pt) | `typography.json` > `styles.footnote` |
| Placeholder Color | labels.tertiary | `colors.json` > `labels.tertiary` |

---

## iPad-Specific Adaptations

### Alert 위치 비교: iPad vs iPhone

| 상황 | iPad | iPhone |
|------|------|--------|
| **키보드 없음** | 화면 정중앙 (605, 417) | 화면 정중앙 (195, 422) |
| **키보드 있음** | 화면 정중앙 유지 (변동 없음) | 키보드 위 가용 영역의 중앙으로 이동 |
| **세로 모드** | 동일 (정중앙) | 동일 (키보드에 따라 이동) |

> iPad 화면 높이(834pt) - 키보드 높이(~264pt) = 570pt. Alert 높이(~160pt)는 570pt 내에 충분히 들어가므로 중앙 유지가 가능하다.

### Pointer Support

| 상호작용 | 동작 |
|---------|------|
| **Hover (버튼)** | 버튼 위 포인터 → `fills.tertiary` 하이라이트 |
| **Click** | 탭과 동일 |
| **TextField Click** | 즉시 포커스 + 키보드 표시 |

### Keyboard Shortcuts

| 단축키 | 동작 |
|--------|------|
| `Esc` | Cancel 버튼과 동일 (Alert 닫기) |
| `Return` | Confirm/Primary 버튼 실행 |
| `Tab` | 버튼 간 포커스 이동 |

### External Keyboard with Alert

iPad에서 외장 키보드 연결 시:
- 소프트웨어 키보드가 표시되지 않음
- Alert는 화면 정중앙 (변동 없음)
- TextField는 하드웨어 키보드로 입력
- `Return`으로 Confirm, `Esc`으로 Cancel

---

## Light / Dark Mode 차이

### Light Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| Alert BG | `rgba(#f5f5f5, 0.6)` + Liquid Glass frost | `materials.json` > `liquidGlass.regular.medium.light` |
| Dimming | `rgba(#29293a, 0.23)` | `colors.json` > `overlays.alert.light` |
| Title | `#000000` | `colors.json` > `labels.primary.light` |
| Message | `rgba(#3c3c43, 0.6)` | `colors.json` > `labels.secondary.light` |
| Button Text | `#0088ff` | `colors.json` > `accents.blue.light` |
| Separator | `rgba(#000000, 0.12)` | `colors.json` > `separators.nonOpaque.light` |

### Dark Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| Alert BG | `rgba(#000000, 0.6)` + Liquid Glass frost + tint | `materials.json` > `liquidGlass.regular.medium.dark` |
| Tint | `rgba(#ffffff, 0.06)` | `materials.json` > `liquidGlass.regular.medium.dark.tint` |
| Dimming | `rgba(#121212, 0.56)` | `colors.json` > `overlays.alert.dark` |
| Title | `#ffffff` | `colors.json` > `labels.primary.dark` |
| Message | `rgba(#ebebf5, 0.7)` | `colors.json` > `labels.secondary.dark` |
| Button Text | `#0091ff` | `colors.json` > `accents.blue.dark` |
| Separator | `rgba(#ffffff, 0.17)` | `colors.json` > `separators.nonOpaque.dark` |

---

## Multitasking Considerations

### Split View

- Alert는 **활성 앱(foreground app) 영역 내에서 중앙에 표시**
- 50/50 Split: 각 앱 605pt 너비. Alert 270pt는 해당 앱 영역 중앙에 위치
- Dimming Overlay도 해당 앱 영역에만 적용 (전체 화면 아님)

```
┌────────────────────────────┬────────────────────────────┐
│  APP A                     │  APP B                     │
│  ░░░░░░░░░░░░░░░░░░░░░░░  │                            │
│  ░░  ┌────────────┐  ░░░  │  (정상 표시,               │
│  ░░  │  Alert     │  ░░░  │   dimming 없음)            │
│  ░░  │  270pt     │  ░░░  │                            │
│  ░░  └────────────┘  ░░░  │                            │
│  ░░░░░░░░░░░░░░░░░░░░░░░  │                            │
└────────────────────────────┴────────────────────────────┘
```

### Slide Over

- Slide Over 앱 (320pt): Alert 270pt가 표시됨 (좌우 여백 25pt)
- Dimming은 Slide Over 앱 영역에만 적용

### Stage Manager

- 윈도우 크기에 관계없이 Alert는 해당 윈도우 중앙에 표시
- 윈도우가 매우 작은 경우(300pt 이하): Alert가 거의 전체를 차지하지만 여전히 270pt 고정

---

## Animation Spec

### Alert 등장

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.2s` | `animations.json` > `duration.semantic.alertPresent` |
| Easing | spring.stiff | `animations.json` > `spring.presets.stiff` |
| Scale From | `1.15` | 시스템 기본 (확대→축소) |
| Scale To | `1.0` | 시스템 기본 |
| Opacity From | `0` | `animations.json` > `transitions.fade.in.from` |
| Opacity To | `1` | `animations.json` > `transitions.fade.in.to` |

### Alert 닫힘

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.15s` | `animations.json` > `duration.semantic.alertDismiss` |
| Easing | easeIn | `animations.json` > `easing.easeIn` |
| Scale To | `1.05` | 약간 확대 후 fade |
| Opacity To | `0` | `animations.json` > `transitions.fade.out.to` |

### Dimming 등장/닫힘

| 속성 | 등장 | 닫힘 |
|------|------|------|
| Duration | `0.2s` | `0.15s` |
| Opacity From/To | `0 → 1` | `1 → 0` |
| Easing | easeOut | easeIn |

---

## Accessibility

| 항목 | 구현 |
|------|------|
| **VoiceOver** | Alert 표시 시 Title → Message → Buttons 순서로 읽기 |
| **Esc 키** | Cancel 동작 (accessibilityPerformEscape) |
| **Bold Text** | Title은 이미 Semibold, Message는 Semibold로 변경 |
| **Larger Text** | 버튼이 세로 배열로 전환 (수평 공간 부족 시) |
| **Reduce Transparency** | Liquid Glass → 불투명 배경 폴백 |
| **Reduce Motion** | Spring scale → 단순 fade |
| **Touch Target** | 버튼 높이 44pt 보장 |
