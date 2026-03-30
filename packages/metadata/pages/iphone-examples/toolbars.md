# Toolbars — iOS 26 페이지 레시피

> **References**
> - Components: `../../components/specs/toolbar.md`
> - Tokens: `../../tokens/`
> - Sections: `../../sections/`
> - Figma (최후 수단): Top `get_screenshot(nodeId="1:54472")`, Bottom `get_screenshot(nodeId="4:55732")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Toolbars (Top 5 + Bottom 3 Variants) |
| **디바이스** | iPhone 17 Pro, 402 × 874pt |
| **용도** | 화면 상단 탐색 + 하단 액션 제어 |
| **iOS 26 특이사항** | Liquid Glass backdrop-filter, Large Title → Inline 스크롤 축소 |

Top Toolbar(Navigation Bar)는 5가지, Bottom Toolbar는 3가지 variant를 다룬다. iOS 26에서는 Liquid Glass 소재가 toolbar 배경에 기본 적용된다.

---

## Top Toolbar — 5 Variants

### Variant 1: Default (Inline Title)

```
┌─────────────────────────────────────────────┐
│  ● ●●  9:41          ⠿ ▐▌ ■               │  ← Status Bar (54pt)
├─────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────┐│
│  │  ‹ Back         제목         [+] [⋮]  ││  ← Toolbar Inline: 44pt
│  │  (blue)       (center)     (symbols)   ││    Liquid Glass bg
│  └─────────────────────────────────────────┘│    blur(12px)
│  ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌ │  ← separator: 0.5pt
│   Content Area                               │
```

| 속성 | 값 | 토큰 |
|------|-----|------|
| 높이 | 44pt | `spacing.json > components.toolbar.height` |
| paddingH | 16pt | `spacing.json > components.toolbar.paddingHorizontal` |
| Back 버튼 색상 | `#0088ff` / `#0091ff` | `colors.json > accents.blue` |
| 제목 | Headline Semibold 17pt, center | `typography.json > styles.headline` |
| Symbol 버튼 | `labels.primary`, 44×44pt min | `colors.json > labels.primary` |
| 배경 blur | 12px | `materials.json > liquidGlass.regular.medium.frostRadius` |
| 배경 색상 | `rgba(255,255,255,0.85)` / `rgba(0,0,0,0.85)` | — |

### Variant 2: Compact Large Title

```
┌─────────────────────────────────────────────┐
│  ● ●●  9:41          ⠿ ▐▌ ■               │
├─────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────┐│
│  │              (inline hidden)    [+] [⋮] ││  ← 44pt top section
│  │                                          ││
│  │  대제목                                   ││  ← Large Title area
│  │  (34pt Regular, left-aligned)            ││    total: 96pt
│  └─────────────────────────────────────────┘│
│   Scrollable Content                         │
```

| 속성 | 값 | 토큰 |
|------|-----|------|
| 전체 높이 | 96pt | `spacing.json > components.navigationBar.largeTitleHeight` |
| Large Title | largeTitle Regular 34pt | `typography.json > styles.largeTitle` |
| letterSpacing | 0.4 | — |
| 색상 | `labels.primary` | `colors.json > labels.primary` |

### Variant 3: Large Title (표준)

Large Title + 검색바 통합. 스크롤 시 Inline으로 축소.

```
┌─────────────────────────────────────────────┐
│  ┌─────────────────────────────────────────┐│
│  │                             [+] [⋮]    ││  ← 44pt buttons area
│  │                                          ││
│  │  피드                                     ││  ← Large Title: 34pt
│  │                                          ││
│  │  [🔍 검색]                               ││  ← Search bar (integrated)
│  └─────────────────────────────────────────┘│    total: ~140pt
```

### Scroll Collapse Animation

```yaml
trigger: 스크롤 > 0pt
duration: 0.3s                    # toolbar.md > 7. Animation
easing: appleEaseOut              # cubic-bezier(0.0, 0, 0.6, 1.0)
properties:
  height: 96pt → 44pt
  large_title_opacity: 1 → 0 (0.2s, easeOut)
  inline_title_opacity: 0 → 1 (0.2s, easeOut, delay 0.05s)
```

### Variant 4: 2-Line Title

```
┌─────────────────────────────────────────────┐
│  ┌─────────────────────────────────────────┐│
│  │  ‹ Back      제목 텍스트        [완료]  ││  ← Line 1: title (headline)
│  │              부제목 텍스트               ││  ← Line 2: subtitle (subheadline)
│  └─────────────────────────────────────────┘│    height: ~52pt
```

| 요소 | Style | Size | Weight |
|------|-------|------|--------|
| 제목 | Headline | 17pt | Semibold |
| 부제목 | Subheadline | 15pt | Regular |

### Variant 5: 2-Line Left Aligned

```
┌─────────────────────────────────────────────┐
│  ┌─────────────────────────────────────────┐│
│  │  제목 텍스트                      [⋮]  ││  ← title left-aligned
│  │  부제목 텍스트                          ││  ← subtitle left-aligned
│  └─────────────────────────────────────────┘│
```

---

## Bottom Toolbar — 3 Variants

### Variant 1: Text Buttons

```
┌─────────────────────────────────────────────┐
│   Content Area                               │
│                                              │
├─────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────┐│
│  │  삭제         이동           완료        ││  ← Bottom toolbar: 44pt
│  │  (red)      (blue)        (blue bold)  ││    + safe area bottom 34pt
│  └─────────────────────────────────────────┘│    Liquid Glass bg
│                                              │
└─────────────────────────────────────────────┘
```

| 버튼 스타일 | 색상 | Weight |
|-----------|------|--------|
| Default | `accents.blue` | Regular |
| Bold | `accents.blue` | Semibold |
| Destructive | `accents.red` | Regular |
| Disabled | `labels.tertiary` | Regular |

### Variant 2: Symbol Buttons

```
│  ┌─────────────────────────────────────────┐│
│  │  ◀  ▶     📤  📑     ✏️               ││  ← Symbol icons
│  │  (均등 분배, 각 44×44pt)                 ││    color: labels.primary
│  └─────────────────────────────────────────┘│
```

### Variant 3: Search (Bottom)

```
│  ┌─────────────────────────────────────────┐│
│  │  [🔍 검색어 입력...]                    ││  ← Search field in bottom toolbar
│  └─────────────────────────────────────────┘│
```

---

## Common Toolbar Properties

### Liquid Glass Background

```css
.toolbar-bg {
  backdrop-filter: blur(12px);              /* frost medium: 12px */
  -webkit-backdrop-filter: blur(12px);
  background: rgba(255, 255, 255, 0.85);   /* light */
  border-bottom: 0.5px solid rgba(0, 0, 0, 0.12);  /* separators.nonOpaque */
}

@media (prefers-color-scheme: dark) {
  .toolbar-bg {
    background: rgba(0, 0, 0, 0.85);
    border-bottom-color: rgba(255, 255, 255, 0.17);
  }
}
```

### Button Tap Feedback

```yaml
trigger: 버튼 터치
property: opacity
from: 1.0
to: 0.4
duration: 0.1s
easing: ease-in-out
```

### Toolbar Appear Animation

```yaml
trigger: 화면 진입
duration: 0.35s                   # animations.json > transitions.push.duration
easing: appleEaseOut
properties:
  opacity: 0 → 1
  translateY: -8px → 0
```

---

## Light / Dark 모드 차이

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| Toolbar 배경 | `rgba(255,255,255,0.85)` + blur(12px) | `rgba(0,0,0,0.85)` + blur(12px) |
| 제목 텍스트 | `#000000` | `#ffffff` |
| Back 버튼 | `#0088ff` | `#0091ff` |
| Symbol 버튼 | `#000000` | `#ffffff` |
| Destructive | `#ff383c` | `#ff4245` |
| Disabled | `rgba(60,60,67,0.3)` | `rgba(235,235,245,0.3)` |
| Separator | `rgba(0,0,0,0.12)` | `rgba(255,255,255,0.17)` |

---

## 인터랙션 노트

- **Back 버튼**: 좌측 가장자리 스와이프 (edge swipe)로도 이전 화면 복귀
- **Large Title 스크롤**: 콘텐츠 스크롤에 따라 Large Title → Inline 자연스럽게 축소
- **Bottom toolbar**: Tab Bar와 동시에 표시될 경우, Tab Bar 위에 위치
- **Highlighted 상태**: 버튼 누름 시 opacity 0.4로 감소

---

## 접근성 고려사항

| 항목 | 요구사항 |
|------|---------|
| 최소 터치 타겟 | 44×44pt |
| Back 버튼 label | "뒤로" / `accessibilityLabel: "Back"` |
| 타이틀 ARIA | `role="heading"` level=1 (Large Title), level=2 (Inline) |
| VoiceOver 순서 | 왼쪽 버튼 → 타이틀 → 오른쪽 버튼 |
| Reduce Motion | Scroll collapse 즉시 전환, spring 비활성화 |
| 키보드 내비게이션 | Tab 키로 버튼 순서 탐색 |
| 대비 | 타이틀 `labels.primary` — WCAG AA 충족 |
| | 버튼 `accents.blue` (#0088ff) on white — 3.5:1 (Large Text 기준 충족) |
| Dynamic Type | 모든 텍스트 시스템 크기 설정 반영 |
