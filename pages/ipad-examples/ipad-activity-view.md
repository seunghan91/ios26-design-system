# iPad Activity View (Share Sheet) — iOS 26 iPad 페이지 레시피

> **References**
> - Templates: `../../templates/`
> - Components: `../../components/specs/activity-views.md`
> - Tokens: `../../tokens/`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24670")`

---

## 화면 개요

iPad에서 Activity View(Share Sheet)는 iPhone과 달리 **Bottom Sheet가 아닌 Popover**로 표시된다. Share 버튼을 탭하면 해당 버튼 위치에서 화살표가 가리키는 형태로 나타나며, 배경 콘텐츠를 가리지 않고 바깥 영역 탭으로 닫을 수 있다. iOS 26에서는 Liquid Glass 소재가 Popover 배경에 적용된다.

| 항목 | 값 |
|------|-----|
| **적용 디바이스** | iPad Pro 13" (1210x834pt landscape) |
| **프레젠테이션** | Popover (UIPopoverPresentationController) |
| **iPhone 대응** | Bottom Sheet (UISheetPresentationController) |
| **Popover 너비** | `320pt` |
| **최대 높이** | 화면 높이의 80% (~667pt) |
| **Arrow 방향** | 트리거 버튼 위치에 따라 자동 결정 |
| **Dismiss** | 바깥 영역 탭 / Esc 키 |
| **배경 소재** | Liquid Glass (`materials.json` > `liquidGlass.regular.medium`) |

---

## Device Context

```
iPad Pro 13" Landscape
─────────────────────────────
화면 크기      : 1210 x 834pt
Safe Area Top  : 24pt           ← spacing.json > safeArea.ipadLandscape.top
Safe Area Bot  : 20pt           ← spacing.json > safeArea.ipadLandscape.bottom
Content Margin : 20pt           ← spacing.json > contentMargin.ipad.horizontal
Status Bar     : 24pt (iPad landscape)
```

---

## iPad Popover 치수

### Popover 크기

```
Popover 너비        : 320pt     ← components/specs/activity-views.md > iPad Popover
코너 반경            : 14pt      ← spacing.json > radius.semantic.popover
Arrow 높이           : 12pt      ← 시스템 기본
내부 상단 패딩       : 16pt      ← spacing.json > inset.md
내부 좌우 패딩       : 0pt       ← List Row는 full-width
내부 하단 패딩       : 8pt
최대 높이            : 667pt     ← 화면 높이 834pt x 80%
```

### Arrow 위치 계산

```
트리거 = Toolbar 상단 Share 버튼:
  Arrow 방향 = UP (↑)
  Popover.top = toolbar.bottom + 4pt

트리거 = 콘텐츠 하단 Share 버튼:
  Arrow 방향 = DOWN (↓)
  Popover.bottom = button.top - 4pt

트리거 = 화면 우측 Near-Edge:
  Arrow 방향 = RIGHT (→)
  Popover 좌측으로 오프셋
```

---

## Screen Composition Breakdown

### 전체 화면 구조 (1210x834pt)

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           STATUS BAR (24pt)                                     │
├─────────────────────────────────────────────────────────────────────────────────┤
│  NAVIGATION BAR (Liquid Glass)                                                  │
│  [< Back]    [문서 제목 — 긴 제목이 올 수 있음]           [검색🔍] [공유↑] [⋯]  │
│  height: 44pt                                                                   │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│                                                          ▲ Arrow (12pt)         │
│                                              ┌───────────┴──────────┐           │
│                                              │  ACTIVITY VIEW       │           │
│                                              │  (Popover, 320pt)    │           │
│  CONTENT AREA                                │  Liquid Glass BG     │           │
│  (문서, 이미지 등                             │                      │           │
│   공유할 콘텐츠가                             │  ┌──────────────────┐│           │
│   배치된 메인 화면)                           │  │ Header Preview   ││           │
│                                              │  │ [🔗 URL 미리보기] ││           │
│                                              │  │ 제목 + 설명 텍스트││           │
│                                              │  └──────────────────┘│           │
│                                              │                      │           │
│                                              │  ● AirDrop 대상 Row  │           │
│                                              │  [👤][👤][👤] [+]   │           │
│                                              │                      │           │
│                                              │  ─────────────────── │           │
│                                              │  [📱] Messages       │           │
│                                              │  ─────────────────── │           │
│                                              │  [📧] Mail           │           │
│                                              │  ─────────────────── │           │
│                                              │  [📝] Notes          │           │
│                                              │  ─────────────────── │           │
│                                              │  [🔗] Copy Link      │           │
│                                              │  ─────────────────── │           │
│                                              │  [📑] Add to Reading │           │
│                                              │       List           │           │
│                                              │  ─────────────────── │           │
│                                              │  [🖨️] Print          │           │
│                                              └──────────────────────┘           │
│                                                                                 │
│  (배경은 dimming 없음 — popover 바깥 영역 탭 가능)                               │
│                                                                                 │
├─────────────────────────────────────────────────────────────────────────────────┤
│  TOOLBAR-BOTTOM (선택)                                                          │
│  Liquid Glass background | height: 44pt                                         │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## Component Usage (토큰 참조)

### 1. Popover Container

| 속성 | 값 | 토큰 |
|------|-----|------|
| Width | `320pt` | `spacing.json` > `components.activityView.ipadPopoverWidth` |
| Corner Radius | `14pt` | `spacing.json` > `radius.semantic.popover` |
| Background | Liquid Glass medium | `materials.json` > `liquidGlass.regular.medium` |
| Frost Radius | `12pt` | `materials.json` > `liquidGlass.regular.medium.frostRadius` |
| Shadow Blur | `40pt` | `materials.json` > `liquidGlass.regular.medium.light.shadow.blur` |
| Arrow Size | `12pt` height | 시스템 기본 |

### 2. Header Preview 영역

| 속성 | 값 | 토큰 |
|------|-----|------|
| Height | ~88pt | `spacing.json` > `components.activityView.headerHeight` |
| Padding Horizontal | `16pt` | `spacing.json` > `inset.md` |
| Title | body/Semibold (17pt) | `typography.json` > `styles.body` |
| URL/Description | footnote/Regular (13pt) | `typography.json` > `styles.footnote` |
| Title Color | labels.primary | `colors.json` > `labels.primary` |
| Description Color | labels.secondary | `colors.json` > `labels.secondary` |

### 3. Contact Row (AirDrop)

| 속성 | 값 | 토큰 |
|------|-----|------|
| Row Height | ~88pt | `spacing.json` > `components.activityView.contactRowHeight` |
| Avatar Size | `60pt` | 시스템 기본 |
| Avatar Corner Radius | `9999pt` (circle) | `spacing.json` > `radius.full` |
| Name Label | caption1/Regular (12pt) | `typography.json` > `styles.caption1` |
| Horizontal Scroll | 가능 | 4+ 대상 시 스크롤 |

### 4. Action Row

| 속성 | 값 | 토큰 |
|------|-----|------|
| Row Height | `44pt` | `spacing.json` > `components.listRow.heightRegular` |
| Icon Size | `24x24pt` | 시스템 SF Symbol |
| Icon Color | `accents.blue` | `colors.json` > `accents.blue` |
| Label | body/Regular (17pt) | `typography.json` > `styles.body` |
| Label Color | labels.primary | `colors.json` > `labels.primary` |
| Separator | 0.5pt | `colors.json` > `separators.nonOpaque` |
| Separator Inset | `16pt` leading | `spacing.json` > `components.listRow.separatorInset` |

### 5. Close Button (iPad Popover에서는 미표시)

iPad Popover에서는 Close(X) 버튼이 **표시되지 않는다**. iPhone Bottom Sheet에서만 우상단에 30x30pt Close 버튼이 나타난다. iPad에서는 Popover 바깥 탭으로 닫는다.

---

## iPad-Specific Adaptations

### Popover vs Bottom Sheet

| 항목 | iPad (Popover) | iPhone (Bottom Sheet) |
|------|----------------|----------------------|
| **프레젠테이션** | 버튼 위치에서 Arrow 표시 | 화면 하단에서 슬라이드 업 |
| **너비** | 320pt (고정) | 화면 전체 너비 |
| **배경 Dimming** | 없음 | 있음 (overlays.activityView) |
| **Close 버튼** | 없음 (바깥 탭) | 우상단 X 버튼 |
| **Grabber** | 없음 | 있음 (36x5pt) |
| **Detent** | 없음 (고정 높이) | medium / large |
| **바깥 영역** | 탭 가능 (상호작용 유지) | 탭 시 닫힘 (dimming 영역) |

### Pointer Support

| 상호작용 | 동작 |
|---------|------|
| **Hover** | Action Row 위에 포인터 올리면 `fills.tertiary` 하이라이트 |
| **Click** | 탭과 동일 — 해당 액션 실행 |
| **Right-Click** | 미지원 (Popover 내부에서) |
| **Scroll** | 트랙패드 스크롤로 긴 목록 내비게이션 |

### Keyboard Shortcuts

| 단축키 | 동작 |
|--------|------|
| `Esc` | Popover 닫기 |
| `↑` / `↓` | 액션 항목 간 이동 (키보드 포커스 모드) |
| `Return` | 선택된 액션 실행 |

---

## Light / Dark Mode 차이

### Light Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| Popover BG | `rgba(#f5f5f5, 0.6)` | `materials.json` > `liquidGlass.regular.medium.light.bg` |
| Shadow | blur 40pt | `materials.json` > `liquidGlass.regular.medium.light.shadow` |
| Label Primary | `#000000` | `colors.json` > `labels.primary.light` |
| Label Secondary | `rgba(#3c3c43, 0.6)` | `colors.json` > `labels.secondary.light` |
| Separator | `rgba(#000000, 0.12)` | `colors.json` > `separators.nonOpaque.light` |
| Action Icon | `#0088ff` | `colors.json` > `accents.blue.light` |

### Dark Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| Popover BG | `rgba(#000000, 0.6)` | `materials.json` > `liquidGlass.regular.medium.dark.bg` |
| Tint Overlay | `rgba(#ffffff, 0.06)` | `materials.json` > `liquidGlass.regular.medium.dark.tint` |
| Shadow | blur 40pt | `materials.json` > `liquidGlass.regular.medium.dark.shadow` |
| Label Primary | `#ffffff` | `colors.json` > `labels.primary.dark` |
| Label Secondary | `rgba(#ebebf5, 0.7)` | `colors.json` > `labels.secondary.dark` |
| Separator | `rgba(#ffffff, 0.17)` | `colors.json` > `separators.nonOpaque.dark` |
| Action Icon | `#0091ff` | `colors.json` > `accents.blue.dark` |

---

## Multitasking Considerations

### Split View (50/50 또는 33/66)

```
┌──────────────────────────────┬──────────────────────────────┐
│  APP A (605pt width)         │  APP B (605pt width)         │
│                              │                              │
│  [공유↑] ← 탭               │                              │
│       ▲                      │                              │
│  ┌────┴─────────────┐       │                              │
│  │  Activity View   │       │                              │
│  │  Popover (320pt) │       │                              │
│  │  ...내용...       │       │                              │
│  └──────────────────┘       │                              │
│                              │                              │
└──────────────────────────────┴──────────────────────────────┘
```

- **50/50 Split**: 각 앱 605pt. Popover 320pt는 문제없이 표시
- **33/66 Split**: 좁은 쪽 403pt. Popover가 잘릴 수 있으므로 Arrow 방향 자동 조정
- **Compact Width**: 앱이 Compact horizontal size class로 전환 → **Bottom Sheet로 폴백**

### Slide Over

- Slide Over 앱 (320pt 너비): Compact size class → Bottom Sheet로 자동 전환
- 배경 앱에서 Activity View 열기: 정상 Popover 표시

### Stage Manager (iPadOS 26)

- 자유 크기 조절 윈도우에서도 `horizontalSizeClass` 기반으로 자동 전환
- Regular → Popover, Compact → Bottom Sheet
- 윈도우 크기가 아닌 size class가 기준

---

## Animation Spec

### Popover 등장

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.25s` | `animations.json` > `transitions.scale.in.duration` |
| Easing | spring.snappy | `animations.json` > `easing.spring.snappy` |
| Scale From | `0.85` | `animations.json` > `transitions.scale.in.from.scale` |
| Scale To | `1.0` | `animations.json` > `transitions.scale.in.to.scale` |
| Opacity From | `0` | `animations.json` > `transitions.scale.in.from.opacity` |
| Opacity To | `1` | `animations.json` > `transitions.scale.in.to.opacity` |
| Transform Origin | Arrow tip 위치 | 시스템 자동 |

### Popover 닫힘

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.15s` | `animations.json` > `transitions.scale.out.duration` |
| Easing | easeIn | `animations.json` > `easing.easeIn` |
| Scale To | `0.85` | `animations.json` > `transitions.scale.out.to.scale` |
| Opacity To | `0` | `animations.json` > `transitions.scale.out.to.opacity` |

---

## 구현 참고 (UIKit / SwiftUI)

### UIKit

```swift
let activityVC = UIActivityViewController(
    activityItems: [url],
    applicationActivities: nil
)

// iPad Popover 설정 (필수 — 없으면 crash)
activityVC.popoverPresentationController?.barButtonItem = shareButton
// 또는 sourceView/sourceRect 지정
activityVC.popoverPresentationController?.sourceView = view
activityVC.popoverPresentationController?.sourceRect = button.frame

// Arrow 방향 제한 (선택)
activityVC.popoverPresentationController?.permittedArrowDirections = [.up, .down]

present(activityVC, animated: true)
```

### SwiftUI

```swift
ShareLink(item: url) {
    Label("Share", systemImage: "square.and.arrow.up")
}
// SwiftUI는 iPad에서 자동으로 Popover로 표시
```

> **주의**: iPad에서 `UIActivityViewController`를 `popoverPresentationController` 설정 없이 present하면 **런타임 크래시**가 발생한다. 반드시 sourceView/sourceRect 또는 barButtonItem을 지정해야 한다.

---

## Accessibility

| 항목 | 구현 |
|------|------|
| **VoiceOver** | Popover 표시 시 포커스가 Activity View 내부로 이동 |
| **Esc 키** | Popover 닫기 (accessibilityPerformEscape) |
| **Tab 네비게이션** | Action Row 간 Tab 키 이동 |
| **Touch Target** | 모든 Action Row 최소 44pt 높이 |
| **Reduce Transparency** | Liquid Glass → 불투명 배경 폴백 |
| **Reduce Motion** | Spring 애니메이션 → 단순 fade |
