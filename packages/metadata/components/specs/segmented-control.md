> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="6:57374")`

# Segmented Control — Component Spec

## 1. Overview

iOS 26 Segmented Control은 2~5개의 옵션 중 하나를 선택하는 수평 탭 선택 UI다. 선택된 segment는 흰색(Light mode) 또는 반투명 흰색(Dark mode)의 sliding indicator로 표시되며, indicator가 부드럽게 슬라이드하는 spring 애니메이션이 핵심 인터랙션이다.

| 항목 | 값 |
|------|-----|
| Figma Node | `6:57374` (Segmented control COMPONENT_SET) |
| Variant 수 | 14 variants |
| Light 예시 | `2666:17069` |
| Dark 예시 | `2666:17070` |

---

## 2. Dimensions

| 속성 | 값 | 출처 |
|------|-----|------|
| Height | `32pt` | Apple HIG standard |
| Outer cornerRadius | `9pt` | 계산: `height/2 - 7` 근사 |
| Selected Indicator cornerRadius | `7pt` | Inner corner (outer - 2pt gap) |
| Padding Horizontal (container) | `2pt` | indicator와 outer 경계 gap |
| Padding Vertical (container) | `2pt` | 상하 gap |
| Segment Min Width | 전체 너비 / segment 수 (균등 분할) | |
| Indicator 크기 | `(전체너비 - 4pt) / N` × 높이 `28pt` | N = segment 수 |
| Typography padding H | `8pt` minimum | |

### 세그먼트 수별 최소 권장 너비

| Segments | 최소 전체 너비 |
|----------|-------------|
| 2 | 150pt |
| 3 | 200pt |
| 4 | 270pt |
| 5 | 320pt |

### 내부 레이아웃 구조

```
┌─────────────────────────────────────────────────────┐ ← height: 32pt, cornerRadius: 9pt
│  ┌──────────────┐  ──────────────  ──────────────  │ ← paddingAll: 2pt
│  │  [Selected]  │   Segment 2    │   Segment 3    │ ← indicator: 28pt height, r:7pt
│  └──────────────┘                                   │
└─────────────────────────────────────────────────────┘

indicator는 선택된 segment 아래에 겹쳐 표시되는 별도 레이어.
텍스트는 indicator 위에 위치 (z-index 높음).
```

---

## 3. Variants

variant 조합 구성: **Segments × Selected × Mode**

### 3-1. Segments 수 (2/3/4/5)
- `Segments=2`: 옵션 2개
- `Segments=3`: 옵션 3개
- `Segments=4`: 옵션 4개
- `Segments=5`: 옵션 5개

### 3-2. Selected 위치 (First/Second/Third/Fourth/Fifth)
- 각 segment 수에 따라 가능한 selected position이 달라짐
- e.g., `Segments=3`이면 `First`, `Second`, `Third`만 유효

### 3-3. Mode (Light/Dark)
- `Mode=Light`: 라이트 모드
- `Mode=Dark`: 다크 모드

### 14 Variants 전체 목록
실제 Figma 컴포넌트 셋에는 가장 자주 사용되는 조합이 포함됨:
- `Segments=2, Selected=First, Light`
- `Segments=2, Selected=Second, Light`
- `Segments=3, Selected=First, Light`
- `Segments=3, Selected=Second, Light`
- `Segments=3, Selected=Third, Light`
- `Segments=4, Selected=*` (Light)
- `Segments=5, Selected=*` (Light)
- Dark variants 동일 구성

---

## 4. Color Tokens

### Container (배경)
| 상태 | 토큰 경로 | Light | Dark |
|------|----------|-------|------|
| Container 배경 | `fills.tertiary` | `#767680 / a:0.12` | `#767680 / a:0.24` |

### Selected Indicator
| 상태 | 토큰 경로 | Light | Dark |
|------|----------|-------|------|
| Indicator fill (Light) | `miscellaneous.segmentedControlSelectedFill` | `#ffffff / a:1.0` | — |
| Indicator fill (Dark) | `miscellaneous.segmentedControlSelectedFill` | — | `#ffffff / a:0.27` |
| Indicator shadow (Light) | drop shadow | `rgba(0,0,0,0.12)` | — |

> **Note:** Light 모드에서 indicator는 순백색 solid fill. Dark 모드에서는 `fills.tertiarySystemFill`에 해당하는 `#ffffff at 27% opacity`로 반투명하게 표현.

### 텍스트
| 상태 | 토큰 경로 | Light | Dark |
|------|----------|-------|------|
| Selected 텍스트 | `labels.primary` | `#000000 / a:1` | `#ffffff / a:1` |
| Unselected 텍스트 | `labels.secondary` | `#3c3c43 / a:0.6` | `#ebebf5 / a:0.7` |
| Disabled 텍스트 | `labels.tertiary` | `#3c3c43 / a:0.3` | `#ebebf5 / a:0.3` |

### Indicator Shadow (Light mode)
```css
box-shadow:
  0 3px 8px rgba(0, 0, 0, 0.12),
  0 3px 1px rgba(0, 0, 0, 0.04);
```

---

## 5. Typography

| 요소 | Style | Font | Weight | Size | Line Height |
|------|-------|------|--------|------|-------------|
| Segment 텍스트 (기본) | Footnote | SF Pro Text | Regular | 13pt | 18pt |
| Segment 텍스트 (selected, iOS 26) | Footnote | SF Pro Text | Semibold | 13pt | 18pt |

텍스트 정렬: center. Truncation: `.byTruncatingTail` (말줄임).

> iOS 26에서는 선택된 segment의 텍스트 weight가 Regular → Semibold로 자동 전환되며, 이 전환도 cross-fade 애니메이션으로 처리된다.

---

## 6. State Transitions

| 상태 | 시각 변화 |
|------|----------|
| Default (unselected) | 텍스트: `labels.secondary`, 배경 없음 |
| Selected | Indicator 표시, 텍스트: `labels.primary` + Semibold |
| Highlighted (pressed) | 살짝 어두워짐 (fills.primary overlay 적용) |
| Disabled (전체) | container opacity 0.5 감소 |
| Disabled (개별 segment) | 해당 segment 텍스트 `labels.tertiary`, 탭 불가 |

---

## 7. Animation

### Indicator Slide (선택 변경)
```yaml
trigger: 다른 segment 탭
duration: 0.3s  # spring.snappy 근사
easing: spring.snappy  # cubic-bezier(0.34, 1.56, 0.64, 1.0)
properties:
  - translateX: 현재 segment 위치 → 새 segment 위치
  - width: 변경 없음 (모든 segment 동일 너비)
cross-fade:
  - unselected → selected 텍스트 weight 전환: 0.15s fade
```

> **Note:** Snappy spring은 살짝 오버슈트(튀어남)가 있어 액션의 생동감을 표현. Indicator가 살짝 앞으로 나갔다 정확한 위치에 안착하는 느낌.

### iOS Native 구현 (UIKit)
```swift
// UISegmentedControl은 자동으로 sliding 애니메이션 처리
// iOS 26에서 UISpringTimingParameters(response:0.3, dampingRatio:0.8) 내부 적용
let segmented = UISegmentedControl(items: ["첫번째", "두번째", "세번째"])
segmented.selectedSegmentIndex = 0
segmented.addTarget(self, action: #selector(changed), for: .valueChanged)
```

### SwiftUI
```swift
Picker("옵션", selection: $selected) {
    Text("첫번째").tag(0)
    Text("두번째").tag(1)
    Text("세번째").tag(2)
}
.pickerStyle(.segmented)
```

### Flutter 커스텀 구현
```dart
// AnimatedContainer로 indicator 위치 애니메이션
AnimatedPositioned(
  duration: Duration(milliseconds: 300),
  curve: Curves.easeOutBack, // spring.snappy approximation
  left: selectedIndex * (totalWidth / segmentCount),
  child: Container(
    width: totalWidth / segmentCount - 4,
    height: 28,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(7),
      boxShadow: [
        BoxShadow(blurRadius: 8, color: Colors.black12),
        BoxShadow(blurRadius: 1, color: Colors.black.withOpacity(0.04)),
      ],
    ),
  ),
)
```

### CSS/Svelte 구현
```css
/* Indicator transition */
.segmented-indicator {
  transition:
    transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1.0),
    width 0.3s cubic-bezier(0.34, 1.56, 0.64, 1.0);
  will-change: transform;
}

/* Container */
.segmented-control {
  background: rgba(118, 118, 128, 0.12); /* fills.tertiary light */
  border-radius: 9px;
  padding: 2px;
  height: 32px;
}

/* Dark mode */
@media (prefers-color-scheme: dark) {
  .segmented-control {
    background: rgba(118, 118, 128, 0.24);
  }
  .segmented-indicator {
    background: rgba(255, 255, 255, 0.27); /* miscellaneous.segmentedControlSelectedFill dark */
    box-shadow: none;
  }
}
```

---

## 8. Accessibility

| 항목 | 요구사항 |
|------|---------|
| 최소 탭 타겟 | 각 segment 너비는 최소 `44pt` 확보 (iOS HIG) — 필요시 invisible hit area 확장 |
| VoiceOver role | `UIAccessibilityTraitButton` (각 segment), `UIAccessibilityTraitSelected` (선택된 것) |
| accessibilityLabel | 각 segment 텍스트 사용, 선택 상태 포함: "첫번째, 선택됨" / "두번째, 2개 중 2번째" |
| accessibilityHint | "탭하여 선택" (선택 안 된 segment에만) |
| 키보드 (iPadOS) | 방향키로 이동, Space로 선택 |
| Dynamic Type | 텍스트 크기 증가 시 control 높이 auto-grow (iOS 17+) |
| Reduce Motion | indicator가 slide 없이 즉시 이동 (duration: 0) |
| 색상 대비 | Unselected text(`labels.secondary`) vs container 배경: 최소 3:1 (대형 텍스트 기준) |

---

## 9. Framework Notes

### UIKit 커스텀 스타일
```swift
// iOS 26 기본 스타일 사용 권장
// 커스텀 배경 필요 시:
segmented.setBackgroundImage(
    UIImage(color: .systemFill),
    for: .normal, barMetrics: .default
)
segmented.setBackgroundImage(
    UIImage(color: .systemBackground),
    for: .selected, barMetrics: .default
)

// Font 커스텀
segmented.setTitleTextAttributes(
    [.font: UIFont.systemFont(ofSize: 13, weight: .regular)],
    for: .normal
)
segmented.setTitleTextAttributes(
    [.font: UIFont.systemFont(ofSize: 13, weight: .semibold)],
    for: .selected
)
```

### 이미지 + 텍스트 혼합
- `setImage(_:forSegmentAt:)` + `setTitle(_:forSegmentAt:)` 동시 사용 시 이미지가 텍스트를 대체함
- 이미지와 텍스트를 동시 표시하려면 커스텀 SegmentedControl 구현 필요

### 주의사항
- Segment가 5개를 초과하면 사용성이 급격히 저하됨. 5개 이상은 `UIMenu` 또는 별도 탭 인터페이스 권장.
- `UISegmentedControl`의 내부 indicator 애니메이션은 iOS 26에서 spring 기반으로 업데이트됨.
- 텍스트가 긴 경우 truncation 전에 폰트 크기를 자동 축소(`adjustsFontSizeToFitWidth`)하는 옵션 고려.
