# Sheets — iOS 26 페이지 레시피

> **References**
> - Templates: `../../templates/`
> - Components: `../../components/specs/sheet.md`, `../../components/specs/toolbar.md`
> - Tokens: `../../tokens/`
> - Sections: `../../sections/`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24684")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Sheets (3 Variants) |
| **디바이스** | iPhone 17 Pro, 402 × 874pt |
| **용도** | 모달 콘텐츠 표시 — 폼 입력, 상세 정보, 설정 패널 |
| **iOS 26 특이사항** | Liquid Glass 배경 소재, Grabber 핸들, Detent 시스템, Sheet 내부 Navigation Stack |

Sheet는 화면 하단에서 올라오는 모달 패널이다. iOS 26에서는 Liquid Glass 소재가 기본 배경으로 적용되어 아래 콘텐츠가 블러 처리된 상태로 비친다. 3가지 주요 variant를 다룬다: Fullscreen Sheet, Fullscreen Stack (Navigation 내장), Inspector (Half-height).

---

## Variant 1: Fullscreen Sheet

### 화면 구성 분해

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41          ⠿ ▐▌ ■               │  ← Status Bar (54pt)
├─────────────────────────────────────────────┤
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  │  ← Parent view (dimmed overlay)
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  │    overlay: rgba(0,0,0,0.2) light
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  │    overlay: rgba(0,0,0,0.48) dark
│ ╭───────────────────────────────────────────╮│
│ │             ━━━━━━━━━━━                  ││  ← Grabber: 36×5pt, top: 8pt
│ │                                           ││    color: #000000/a:0.18 (L)
│ │  ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌  ││    color: #ffffff/a:0.18 (D)
│ │                                           ││
│ │   Sheet Content Area                      ││  ← paddingH: 16pt
│ │   (Scrollable when at large detent)       ││
│ │                                           ││
│ │                                           ││  ← Liquid Glass background
│ │                                           ││    light: rgba(250,250,250,0.7)
│ │                                           ││    dark: rgba(0,0,0,0.8)
│ │                                           ││    blur: 14px (frostRadius)
│ │                                           ││    shadow: blur 40
│ │                                           ││
│ ╰───────────────────────────────────────────╯│
│      ↑ cornerRadius top: 34pt               │
│      ↑ cornerRadius bottom: 58pt            │
└─────────────────────────────────────────────┘
                    ← Home Indicator (134×5pt)
```

### Detent 설정

| Detent | 높이 비율 | 설명 |
|--------|----------|------|
| Large | `1.0` (100%) | 전체 화면 (safe area 제외). `spacing.json > components.sheet.largeDetent` |

### 컴포넌트 사용

| 컴포넌트 | 스펙 참조 | 토큰 참조 |
|---------|----------|----------|
| Grabber Handle | `sheet.md > 2. Dimensions` | `spacing.json > components.sheet.grabberWidth: 36`, `grabberHeight: 5`, `grabberTop: 8` |
| Liquid Glass Background | `sheet.md > 4. Color Tokens` | `materials.json > liquidGlass.regular.large` |
| Overlay Dimming | `sheet.md > 4. Color Tokens` | `colors.json > overlays.default` |
| Corner Radius (top) | `sheet.md > 2. Dimensions` | `spacing.json > radius.semantic.sheet.iphoneTop: 34` |
| Corner Radius (bottom) | `sheet.md > 2. Dimensions` | `spacing.json > radius.semantic.sheet.iphoneBottom: 58` |

### 애니메이션

**Present (등장)**
```yaml
duration: 0.5s                    # animations.json > duration.semantic.sheetPresent
easing: spring.gentle             # cubic-bezier(0.25, 0.46, 0.45, 0.94)
spring: response 0.55, damping 0.825
properties:
  translateY: 100% → 0%
  Liquid Glass blur: 0 → 14px
overlay:
  opacity: 0 → 1
  duration: 0.5s
  easing: easeOut
```

**Dismiss (퇴장)**
```yaml
duration: 0.3s                    # animations.json > duration.semantic.sheetDismiss
easing: easeIn                    # cubic-bezier(0.42, 0, 1.0, 1.0)
properties:
  translateY: 0% → 100%
overlay:
  opacity: 1 → 0
```

---

## Variant 2: Fullscreen Stack (Navigation Inside Sheet)

### 화면 구성 분해

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41          ⠿ ▐▌ ■               │  ← Status Bar (54pt)
├─────────────────────────────────────────────┤
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ dimmed ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  │
│ ╭───────────────────────────────────────────╮│
│ │             ━━━━━━━━━━━                  ││  ← Grabber: 36×5pt
│ │                                           ││
│ │  ┌─────────────────────────────────────┐  ││  ← Sheet Toolbar (Top)
│ │  │  취소        제목         완료       │  ││    height: 44pt
│ │  │  (blue)    (center)    (blue bold)  │  ││    Toolbar - Top - Sheet variant
│ │  └─────────────────────────────────────┘  ││
│ │  ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌  ││  ← separator: nonOpaque
│ │                                           ││
│ │   Navigation Content                      ││
│ │   (Can push/pop within sheet)             ││
│ │                                           ││
│ │   ┌─────────────────────────────────┐     ││
│ │   │  Form fields / List content     │     ││
│ │   │  ...                            │     ││
│ │   └─────────────────────────────────┘     ││
│ │                                           ││
│ │  ┌─────────────────────────────────────┐  ││  ← Liquid Glass Bottom Toolbar
│ │  │   [icon]    [icon]    [icon]        │  ││    height: 44pt
│ │  │   (Liquid Glass small buttons)      │  ││    bg: liquidGlass.regular.medium
│ │  └─────────────────────────────────────┘  ││    blur: 12px
│ │                                           ││
│ ╰───────────────────────────────────────────╯│
└─────────────────────────────────────────────┘
```

### Sheet Toolbar (Toolbar - Top - Sheet)

Figma Node: `5726:33474` — 5 variants

| 요소 | 스타일 | 토큰 |
|------|--------|------|
| 취소 버튼 | Body Regular (17pt) | `colors.json > accents.blue` — light: `#0088ff`, dark: `#0091ff` |
| 완료 버튼 | Body Semibold (17pt) | `colors.json > accents.blue` |
| 제목 | Headline Semibold (17pt) | `colors.json > labels.primary` |
| 분리선 | 0.5pt hairline | `colors.json > separators.nonOpaque` |

### Liquid Glass Bottom Toolbar

| 속성 | 값 | 토큰 |
|------|-----|------|
| 높이 | 44pt | `spacing.json > components.toolbar.height` |
| 배경 blur | 12px | `materials.json > liquidGlass.regular.medium.frostRadius` |
| 배경 색상 (light) | `rgba(245,245,245,0.6)` | `materials.json > liquidGlass.regular.medium.light.bg` |
| 배경 색상 (dark) | `rgba(0,0,0,0.6)` | `materials.json > liquidGlass.regular.medium.dark.bg` |
| 버튼 최소 크기 | 44×44pt | `spacing.json > components.touchTarget.minimum` |

### Navigation Stack 내부 전환

Sheet 내부에서 Push/Pop이 발생할 때:

```yaml
push:
  enter_from: translateX(100%)
  enter_to: translateX(0)
  exit_from: translateX(0)
  exit_to: translateX(-30%)
  duration: 0.35s             # animations.json > transitions.push
  easing: appleEaseOut        # cubic-bezier(0.0, 0, 0.6, 1.0)
```

---

## Variant 3: Inspector (Half-Height)

### 화면 구성 분해

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41          ⠿ ▐▌ ■               │  ← Status Bar (54pt)
├─────────────────────────────────────────────┤
│                                              │
│   Parent Content (visible above)             │  ← 상단 50% 콘텐츠 보임
│   (no dimming or partial dim)                │
│                                              │
│                                              │
├─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─┤  ← 화면 50% 지점
│ ╭───────────────────────────────────────────╮│
│ │             ━━━━━━━━━━━                  ││  ← Grabber
│ │                                           ││
│ │   Inspector 속성 패널                      ││  ← Medium detent content
│ │                                           ││
│ │   ╔═════════════════════════════════╗     ││  ← Grouped list section
│ │   ║  크기          1080 × 1920      ║     ││
│ │   ║─────────────────────────────────║     ││
│ │   ║  포맷          PNG              ║     ││
│ │   ║─────────────────────────────────║     ││
│ │   ║  색공간        Display P3       ║     ││
│ │   ╚═════════════════════════════════╝     ││
│ │                                           ││
│ │   ╔═════════════════════════════════╗     ││
│ │   ║  투명도    ─────●──── 80%      ║     ││  ← Slider inside list
│ │   ╚═════════════════════════════════╝     ││
│ │                                           ││
│ ╰───────────────────────────────────────────╯│
└─────────────────────────────────────────────┘
```

### Detent 설정

| Detent | 높이 비율 | 설명 |
|--------|----------|------|
| Small | `0.25` (25%) | 축소 모드. 제목만 보임 |
| Medium | `0.5` (50%) | 기본 표시. 속성 리스트 |
| Large | `1.0` (100%) | 전체 확장 |

### Detent Snap 애니메이션

```yaml
trigger: 드래그 제스처 릴리즈
duration: 0.35s
easing: spring.gentle             # cubic-bezier(0.25, 0.46, 0.45, 0.94)
spring: response 0.55, damping 0.825
properties:
  translateY: current → target detent position
velocity: 제스처 속도 연동
```

---

## Light / Dark 모드 차이

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| Sheet 배경 | `rgba(250,250,250,0.7)` + blur(14px) | `rgba(0,0,0,0.8)` + tint `rgba(255,255,255,0.06)` + blur(14px) |
| Grabber 색상 | `#000000 / a:0.18` | `#ffffff / a:0.18` |
| Overlay (dimming) | `rgba(0,0,0,0.2)` | `rgba(0,0,0,0.48)` |
| Sheet Toolbar 버튼 | `#0088ff` | `#0091ff` |
| 제목 텍스트 | `#000000` | `#ffffff` |
| Separator | `rgba(0,0,0,0.12)` | `rgba(255,255,255,0.17)` |
| Shadow | blur 40, light intensity | blur 40, dark intensity |
| Bottom Toolbar bg | `rgba(245,245,245,0.6)` | `rgba(0,0,0,0.6)` + tint |

---

## 인터랙션 노트

### 제스처
- **아래로 스와이프** (Grabber 또는 콘텐츠 영역): 다음 작은 detent로 이동 또는 dismiss
- **위로 스와이프**: 다음 큰 detent로 이동
- **배경 탭**: dismiss (기본 동작, `presentsWithGrabber` 설정에 따라 변경 가능)
- **스크롤 콘텐츠**: Large detent에서만 스크롤 가능. 스크롤 상단 도달 시 drag-to-dismiss 활성화

### 키보드 연동
- Sheet 내부 TextField 포커스 시: Sheet가 키보드 위로 자동 이동
- `keyboardDismissMode = .interactive`: 아래로 드래그하면 키보드도 함께 내려감
- 키보드 슬라이드 애니메이션: 0.25s (`animations.json > duration.semantic.keyboardSlide`)

### 상태 전환
```
Presenting → Dragging (Grabber) → Detent Snapping → Idle
Presenting → Scrolling (내부) → Large detent에서만
Idle → Dismissing (스와이프 down 또는 배경 탭)
```

---

## 접근성 고려사항

| 항목 | 요구사항 |
|------|---------|
| Grabber accessibilityLabel | "크기 조절 핸들" |
| Grabber accessibilityHint | "드래그하여 패널 크기를 조절하세요" |
| Grabber 더블 탭 | 다음 detent로 이동 |
| VoiceOver 포커스 | Sheet 등장 시 첫 번째 interactive element로 포커스 이동 |
| Dynamic Type | Sheet 내 모든 텍스트 Dynamic Type 지원 |
| Reduce Motion | Spring 효과 → 단순 fade + 짧은 translateY (50px만 이동) |
| 키보드 내비게이션 | Tab 키로 Sheet 내부 요소 순차 탐색 |
| 최소 탭 타겟 | 모든 버튼 44×44pt (`spacing.json > components.touchTarget.minimum`) |
| Safe Area | `.ignoresSafeArea(edges: .bottom)` 로 bottom safe area 확장 처리 |
| Dismiss 방법 | 배경 탭 + 스와이프 + 취소 버튼 — 최소 2가지 dismiss 경로 제공 |

---

## 구현 참조

### SwiftUI
```swift
.sheet(isPresented: $isPresented) {
    NavigationStack {
        ContentView()
            .navigationTitle("제목")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") { isPresented = false }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("완료") { save(); isPresented = false }
                }
            }
    }
    .presentationDetents([.fraction(0.25), .medium, .large])
    .presentationDragIndicator(.visible)
    .presentationCornerRadius(34)
    .presentationBackground(.regularMaterial)
}
```

### CSS Token 매핑
```css
.sheet-background {
  background: rgba(250, 250, 250, 0.7);       /* liquidGlass.regular.large.light.bg */
  backdrop-filter: blur(14px) saturate(180%);  /* frostRadius: 14 */
  -webkit-backdrop-filter: blur(14px) saturate(180%);
  box-shadow: 0 0 40px rgba(0, 0, 0, 0.15);   /* shadow.blur: 40 */
  border-radius: 34px 34px 0 0;                /* radius.semantic.sheet.iphoneTop */
}

@media (prefers-color-scheme: dark) {
  .sheet-background {
    background: rgba(0, 0, 0, 0.8);            /* liquidGlass.regular.large.dark.bg */
    backdrop-filter: blur(14px) saturate(150%);
  }
}

.sheet-enter {
  animation: sheet-slide-up 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
}
.sheet-exit {
  animation: sheet-slide-down 0.3s cubic-bezier(0.42, 0, 1.0, 1.0) forwards;
}
```
