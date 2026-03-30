# iPad Sheets — iOS 26 iPad 페이지 레시피

> **References**
> - Templates: `../../templates/`
> - Components: `../../components/specs/sheet.md`
> - Tokens: `../../tokens/`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24684")`

---

## 화면 개요

iPad에서 Sheet는 iPhone과 다르게 **Form Sheet(가운데 카드)**로 표시된다. 화면 전체를 덮지 않고, 디밍된 배경 위에 고정 크기 카드가 중앙에 나타난다. Grabber(핸들)로 크기 조절이 가능하며, iOS 26에서는 Liquid Glass 소재가 Sheet 배경에 적용된다.

| 항목 | 값 |
|------|-----|
| **적용 디바이스** | iPad Pro 13" (1210x834pt landscape) |
| **프레젠테이션** | Form Sheet (centered card) |
| **iPhone 대응** | Bottom Sheet (full-width, 하단에서 슬라이드 업) |
| **기본 크기** | `540pt x 620pt` (HIG 권장) |
| **Dimming Backdrop** | 전체 화면 (`overlays.default`) |
| **Grabber Handle** | 상단 중앙, `36x5pt` |
| **Corner Radius** | `38pt` (iPad Sheet) |
| **배경 소재** | Liquid Glass |

---

## Device Context

```
iPad Pro 13" Landscape
─────────────────────────────
화면 크기      : 1210 x 834pt
Safe Area Top  : 24pt           ← spacing.json > safeArea.ipadLandscape.top
Safe Area Bot  : 20pt           ← spacing.json > safeArea.ipadLandscape.bottom
Form Sheet 중앙: x=605, y=417  ← (1210/2, 834/2)
```

---

## Screen Composition Breakdown

### Form Sheet (기본 표시)

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░  ┌─────────────────────────────────────────────────┐  ░░░░░░░░░░  │
│  ░░░░░░░░░  │                    ━━━━━━━━━━━                  │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │  Grabber Handle (36x5pt, pill)                  │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │                                                 │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │  HEADER                                         │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │  [취소]      새 이벤트 만들기          [추가]   │  ░░░░░░░░░░  │
│  ░ DIMMING  │  ─────────────────────────────────────────────  │  DIMMING ░░  │
│  ░░░░░░░░░  │                                                 │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │  제목                                           │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │  ┌───────────────────────────────────────────┐  │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │  │ 이벤트 제목 입력                           │  │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │  └───────────────────────────────────────────┘  │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │                                                 │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │  위치                                           │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │  ┌───────────────────────────────────────────┐  │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │  │ 위치 또는 화상 통화 추가                    │  │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │  └───────────────────────────────────────────┘  │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │                                                 │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │  시작    2026년 3월 28일  오후 2:00  ▼          │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │  ──────────────────────────────────────────── │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │  종료    2026년 3월 28일  오후 3:00  ▼          │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │  ──────────────────────────────────────────── │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │  하루 종일                             [○]    │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │                                                 │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │  캘린더  개인                              ▶   │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │  ──────────────────────────────────────────── │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │  알림    없음                              ▶   │  ░░░░░░░░░░  │
│  ░░░░░░░░░  │                                                 │  ░░░░░░░░░░  │
│  ░░░░░░░░░  └─────────────────────────────────────────────────┘  ░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## Form Sheet 상세 치수

### 크기 및 레이아웃

| 속성 | 값 | 토큰 |
|------|-----|------|
| Width | `540pt` | HIG 권장 (조정 가능) |
| Height | `620pt` (기본) | 콘텐츠에 따라 가변 |
| Max Height | `790pt` (834 - 24 - 20) | Safe Area 기반 |
| Corner Radius | `38pt` | `spacing.json` > `radius.semantic.sheet.ipad` |
| Grabber Width | `36pt` | `spacing.json` > `components.sheet.grabberWidth` |
| Grabber Height | `5pt` | `spacing.json` > `components.sheet.grabberHeight` |
| Grabber Top | `8pt` | `spacing.json` > `components.sheet.grabberTop` |
| Grabber Corner Radius | `9999pt` (pill) | `spacing.json` > `radius.full` |
| Content Padding H | `20pt` | `spacing.json` > `contentMargin.ipad.horizontal` |
| Header Height | `44pt` | `spacing.json` > `components.navigationBar.height` |

### Form Sheet 내부 구조

```
┌─────────────────────────────────────────────────┐  ← cornerRadius: 38pt
│                  ━━━━━━━━━━━                    │  ← Grabber: 36x5pt, top: 8pt
│                                                  │     cornerRadius: 9999pt (pill)
│  paddingTop: 8pt (grabber) + 12pt               │
│                                                  │
│  ┌──────────────────────────────────────────┐   │  ← Header Bar (44pt)
│  │ [취소]      제목 텍스트         [추가]    │   │    title: headline/Semibold
│  └──────────────────────────────────────────┘   │    button: body/Regular, blue
│  ─────────────────────────────────────────────  │  ← separator
│                                                  │
│  CONTENT AREA (스크롤 가능)                      │  ← paddingH: 20pt
│  ...                                             │
│                                                  │
│  paddingBottom: 20pt + Safe Area                │
└─────────────────────────────────────────────────┘
   ← width: 540pt →
```

### iPhone vs iPad Sheet 비교

| 항목 | iPad (Form Sheet) | iPhone (Bottom Sheet) |
|------|-------------------|----------------------|
| **형태** | 중앙 카드 (floating) | 하단에서 슬라이드 업 |
| **너비** | 540pt (고정) | 화면 전체 너비 |
| **높이** | 620pt (기본, 리사이즈 가능) | Detent 기반 (25%, 50%, 100%) |
| **위치** | 화면 정중앙 | 화면 하단 |
| **Dimming** | 전체 화면 | 전체 화면 |
| **Corner Radius** | 38pt (전체) | 34pt (상단만) |
| **Grabber** | 있음 (드래그로 리사이즈) | 있음 (드래그로 detent 전환) |
| **닫기** | 바깥 탭 / 아래로 드래그 / 취소 버튼 | 아래로 드래그 / 취소 버튼 |

---

## Component Usage (토큰 참조)

### Container

| 속성 | 값 | 토큰 |
|------|-----|------|
| Background | Liquid Glass large | `materials.json` > `liquidGlass.regular.large` |
| Frost Radius | `14pt` | `materials.json` > `liquidGlass.regular.large.frostRadius` |
| Light BG | `rgba(#fafafa, 0.7)` | `materials.json` > `liquidGlass.regular.large.light.bg` |
| Dark BG | `rgba(#000000, 0.8)` | `materials.json` > `liquidGlass.regular.large.dark.bg` |
| Dark Tint | `rgba(#ffffff, 0.06)` | `materials.json` > `liquidGlass.regular.large.dark.tint` |
| Shadow | blur 40pt | `materials.json` > `liquidGlass.regular.large.*.shadow` |

### Dimming Backdrop

| 속성 | 값 | 토큰 |
|------|-----|------|
| Light | `rgba(#000000, 0.2)` | `colors.json` > `overlays.default.light` |
| Dark | `rgba(#000000, 0.48)` | `colors.json` > `overlays.default.dark` |

### Grabber Handle

| 속성 | 값 | 토큰 |
|------|-----|------|
| Size | `36x5pt` | `spacing.json` > `components.sheet.grabber*` |
| Corner Radius | `9999pt` | `spacing.json` > `radius.full` |
| Color Light | `rgba(#3c3c43, 0.3)` | `colors.json` > `labels.tertiary.light` |
| Color Dark | `rgba(#ebebf5, 0.3)` | `colors.json` > `labels.tertiary.dark` |

### Header Bar

| 속성 | 값 | 토큰 |
|------|-----|------|
| Height | `44pt` | `spacing.json` > `components.navigationBar.height` |
| Title Font | headline/Semibold (17pt) | `typography.json` > `styles.headline` |
| Title Color | labels.primary | `colors.json` > `labels.primary` |
| Button Font | body/Regular (17pt) | `typography.json` > `styles.body` |
| Cancel Color | accents.blue | `colors.json` > `accents.blue` |
| Confirm Color | accents.blue, Semibold | `colors.json` > `accents.blue` |

### Form Content

| 속성 | 값 | 토큰 |
|------|-----|------|
| TextField Height | `44pt` | `spacing.json` > `components.listRow.heightRegular` |
| TextField BG | textField.bg | `colors.json` > `miscellaneous.textField.bg` |
| TextField Border | textField.outline | `colors.json` > `miscellaneous.textField.outline` |
| TextField Corner Radius | `10pt` | `spacing.json` > `radius.md` |
| Row Separator | separators.opaque | `colors.json` > `separators.opaque` |
| Toggle (Switch) | accents.green (on) | `colors.json` > `accents.green` |

---

## iPad-Specific Adaptations

### Pointer Support

| 상호작용 | 동작 |
|---------|------|
| **Hover (버튼)** | 취소/추가 버튼 hover → `fills.tertiary` 하이라이트 |
| **Hover (Row)** | Disclosure 행 hover → 배경 하이라이트 |
| **Click** | 탭과 동일 |
| **Drag (Grabber)** | Sheet 크기 조절 |
| **Click Outside** | Sheet 닫기 |

### Keyboard Shortcuts

| 단축키 | 동작 |
|--------|------|
| `Esc` | 취소 (Sheet 닫기) |
| `Cmd+Return` | 추가/저장 (Confirm) |
| `Tab` | 다음 입력 필드로 이동 |
| `Shift+Tab` | 이전 입력 필드로 이동 |

### External Keyboard + Form Sheet

- 외장 키보드 연결 시: Form Sheet 위치 변동 없음 (정중앙 유지)
- Tab 키로 필드 간 이동
- Cmd+Return으로 저장 가능

### Resize 동작

```
기본 크기: 540 x 620pt
최소 크기: 540 x 300pt (Grabber로 축소)
최대 크기: 540 x 790pt (Grabber로 확대)

Grabber 드래그:
  위로 드래그 → Sheet 확대 (최대 790pt)
  아래로 드래그 → Sheet 축소 (최소 300pt)
  크게 아래로 드래그 → Sheet 닫기 (dismiss)
```

---

## Light / Dark Mode 차이

### Light Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| Sheet BG | `rgba(#fafafa, 0.7)` + Liquid Glass frost | `materials.json` > `liquidGlass.regular.large.light` |
| Shadow | blur 40pt | `materials.json` > `liquidGlass.regular.large.light.shadow` |
| Dimming | `rgba(#000000, 0.2)` | `colors.json` > `overlays.default.light` |
| Grabber | `rgba(#3c3c43, 0.3)` | `colors.json` > `labels.tertiary.light` |
| Header Title | `#000000` | `colors.json` > `labels.primary.light` |
| Button | `#0088ff` | `colors.json` > `accents.blue.light` |
| Content BG | `#ffffff` | `colors.json` > `backgrounds.primary.light` |

### Dark Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| Sheet BG | `rgba(#000000, 0.8)` + Liquid Glass frost + tint | `materials.json` > `liquidGlass.regular.large.dark` |
| Tint | `rgba(#ffffff, 0.06)` | `materials.json` > `liquidGlass.regular.large.dark.tint` |
| Dimming | `rgba(#000000, 0.48)` | `colors.json` > `overlays.default.dark` |
| Grabber | `rgba(#ebebf5, 0.3)` | `colors.json` > `labels.tertiary.dark` |
| Header Title | `#ffffff` | `colors.json` > `labels.primary.dark` |
| Button | `#0091ff` | `colors.json` > `accents.blue.dark` |
| Content BG | `#000000` | `colors.json` > `backgrounds.primary.dark` |

---

## Multitasking Considerations

### Split View

- Form Sheet는 **활성 앱 영역 내에서 중앙에 표시**
- 50/50 Split (605pt): Sheet 540pt → 좌우 여백 약 32pt씩 (표시 가능)
- 33/66 Split 좁은 쪽 (403pt): Sheet 540pt > 앱 너비 → **Full-screen Sheet로 폴백**
- Dimming은 해당 앱 영역에만 적용

```
50/50 Split (가능):
┌─────────────────────────────┬─────────────────────────────┐
│  APP A (605pt)              │  APP B                      │
│  ░░┌─────────────────┐░░  │                              │
│  ░░│  Form Sheet     │░░  │                              │
│  ░░│  (540pt)        │░░  │                              │
│  ░░└─────────────────┘░░  │                              │
└─────────────────────────────┴─────────────────────────────┘

33/66 Split 좁은 쪽 (폴백):
┌──────────────────┬──────────────────────────────────────────┐
│  APP A (403pt)   │  APP B                                    │
│  ┌────────────┐ │                                            │
│  │ Full-width │ │                                            │
│  │ Sheet      │ │                                            │
│  │ (bottom)   │ │                                            │
│  └────────────┘ │                                            │
└──────────────────┴──────────────────────────────────────────┘
```

### Slide Over

- Slide Over 앱 (320pt): Sheet 540pt > 앱 너비 → Full-screen Bottom Sheet로 폴백
- iPhone 스타일 Bottom Sheet (Detent 기반)

### Stage Manager

- 윈도우 너비 > 580pt: Form Sheet (540pt)
- 윈도우 너비 <= 580pt: Full-screen Bottom Sheet
- 윈도우 리사이즈 중 자동 전환

---

## Animation Spec

### Sheet 등장

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.5s` | `animations.json` > `duration.semantic.sheetPresent` |
| Easing | spring.gentle | `animations.json` > `spring.presets.gentle` |
| CSS 근사 | `cubic-bezier(0.25, 0.46, 0.45, 0.94)` | `animations.json` > `easing.spring.gentle` |
| Scale From | `0.9` | 커스텀 |
| Scale To | `1.0` | 커스텀 |
| Opacity From | `0` | 동시 |
| Opacity To | `1` | 동시 |
| Dimming | `0 → target opacity` | 동시 |

### Sheet 닫힘

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.3s` | `animations.json` > `duration.semantic.sheetDismiss` |
| Easing | appleEaseIn | `animations.json` > `easing.appleEaseIn` |
| Scale To | `0.9` | 커스텀 |
| Opacity To | `0` | 동시 |
| Dimming | `target → 0` | 동시 |

### Grabber 리사이즈

| 속성 | 값 |
|------|-----|
| Duration | Interactive (드래그 따라감) |
| Rubber Band | 최소/최대 크기 넘어서면 저항 증가 |
| Snap | 놓았을 때 가까운 크기로 스냅 (spring.snappy) |

---

## Accessibility

| 항목 | 구현 |
|------|------|
| **VoiceOver** | Sheet 표시 시 포커스가 Sheet 내부로 이동 |
| **Esc 키** | Sheet 닫기 (취소) |
| **Cmd+Return** | 확인/저장 |
| **Tab** | 입력 필드 간 이동 |
| **Reduce Motion** | Scale + spring → 즉시 표시 (fade only) |
| **Reduce Transparency** | Liquid Glass → 불투명 배경 |
| **Touch Target** | Header 버튼, 입력 필드 모두 44pt 최소 |
| **Trap Focus** | Sheet 표시 중 배경 요소에 포커스 이동 불가 |
