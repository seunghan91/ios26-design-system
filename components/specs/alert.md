> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="63:57121")`

# Alert — Component Spec

## 1. Overview

iOS 26 Alert는 사용자에게 중요한 정보를 전달하거나 확인/취소 결정을 요구하는 모달 다이얼로그 컴포넌트다. 화면 중앙에 오버레이와 함께 표시되며, 버튼 수에 따라 2가지 variant를 제공한다.

| 항목 | 값 |
|------|-----|
| Figma Node | `63:57121` (Alert COMPONENT_SET) |
| Variant 수 | 2 (1-button, 2-button) |
| 내부 컴포넌트 | `_Buttons` (`5446:6653`, 6 variants), `_Text Field Background` (`5469:8384`, 2 variants), `Overlay - Alerts` (`5446:7633`) |

---

## 2. Dimensions

| 속성 | 값 | 출처 |
|------|-----|------|
| Width | `270pt` (fixed) | `spacing.json` > `components.alert.width` |
| cornerRadius | `14pt` | `spacing.json` > `radius.semantic.alert` |
| Padding Horizontal | `16pt` | `spacing.json` > `components.alert.paddingHorizontal` |
| Padding Vertical (top/bottom) | `20pt` | `spacing.json` > `components.alert.paddingVertical` |
| Button Height | `44pt` (minimum tap target) | `spacing.json` > `components.alert.buttonHeight` |
| Title → Message gap | `4pt` | `spacing.json` > `scale.1` |
| Message → Button divider gap | `0pt` | 구분선(separator)으로 대체 |

### 내부 레이아웃 구조

```
┌─────────────────────────────────────┐  ← width: 270pt, cornerRadius: 14pt
│                                     │  ← paddingTop: 20pt
│  Title                              │  ← labels.primary, Headline/Semibold
│  Message body text here             │  ← labels.secondary, Footnote/Regular
│                                     │  ← paddingBottom: 20pt
├─────────────────────────────────────┤  ← separator (separators.nonOpaque)
│            [Button]                 │  ← 1-button variant: full width, 44pt h
└─────────────────────────────────────┘
```

```
┌─────────────────────────────────────┐
│  Title                              │
│  Message body text here             │
├─────────────────────────────────────┤
│  [Cancel]      │     [Confirm]      │  ← 2-button variant: 각 50% width
└─────────────────────────────────────┘
```

---

## 3. Variants

### 3-1. 1-Button Variant (단일 버튼)
- 버튼 1개, 하단 전체 너비 (135pt 기준 좌우 정렬)
- 주로 정보 전달용 알림 (`확인`, `OK`)
- Button style: Regular weight (not Bold)

### 3-2. 2-Button Variant (나란히 버튼)
- 버튼 2개, 세로 구분선(divider)으로 좌/우 50% 분할
- 왼쪽: Cancel/Secondary action (labels.primary, Regular weight)
- 오른쪽: Confirm/Primary action (accents.blue, Semibold weight)
- Destructive action: accents.red, Semibold weight

### 3-3. _Buttons 내부 컴포넌트 (`5446:6653`)
6가지 variant (내부 전용, 외부 노출 안 됨):
- `default` — 일반 액션 (labels.primary, Regular)
- `default-bold` — 강조 액션 (labels.primary, Semibold)
- `primary` — 주요 액션 (accents.blue, Semibold)
- `destructive` — 위험 액션 (accents.red, Semibold)
- `destructive-disabled` — 비활성 위험 (miscellaneous.buttons.labelDestructiveDisabled, Regular)
- `cancel` — 취소 (labels.primary, Regular, 항상 왼쪽)

### 3-4. _Text Field Background (`5469:8384`)
2가지 variant:
- `default` — 일반 텍스트 필드 배경 (miscellaneous.textField.bg + outline)
- `focused` — 포커스 상태 (파란 테두리 적용)

---

## 4. Color Tokens

| 역할 | 토큰 경로 | Light | Dark |
|------|----------|-------|------|
| Alert 배경 | `fills.systemBackground` → `backgrounds.primary` | `#ffffff` | `#000000` |
| Title 텍스트 | `labels.primary` | `#000000 / a:1` | `#ffffff / a:1` |
| Message 텍스트 | `labels.secondary` | `#3c3c43 / a:0.6` | `#ebebf5 / a:0.7` |
| 버튼 구분선 | `separators.nonOpaque` | `#000000 / a:0.12` | `#ffffff / a:0.17` |
| Primary 버튼 텍스트 | `accents.blue` | `#0088ff` | `#0091ff` |
| Destructive 버튼 텍스트 | `accents.red` | `#ff383c` | `#ff4245` |
| Destructive 배경 (pressed) | `miscellaneous.buttons.bgDestructive` | `#ff383c / a:0.14` | `#ff4245 / a:0.14` |
| 오버레이 배경 | `overlays.alert` | `#29293a / a:0.23` | `#121212 / a:0.56` |

> **Note:** iOS 26에서 Alert 배경은 Liquid Glass를 사용하지 않고 불투명한 `backgrounds.primary`를 사용한다. Liquid Glass는 Sheet, Notification 등 상위 레이어에 적용된다.

---

## 5. Typography

| 요소 | Style | Font | Weight | Size | Line Height |
|------|-------|------|--------|------|-------------|
| Title | Headline | SF Pro Text | Semibold | 17pt | 22pt |
| Message | Footnote | SF Pro Text | Regular | 13pt | 18pt |
| Button (일반) | Callout | SF Pro Text | Regular | 16pt | 21pt |
| Button (primary/destructive) | Callout | SF Pro Text | Semibold | 16pt | 21pt |

텍스트 정렬: 중앙(center) 정렬. Title과 Message 모두.

---

## 6. State Transitions

| 상태 | 시각 변화 |
|------|----------|
| 버튼 기본 (default) | 배경 없음, 텍스트 색상만 |
| 버튼 Highlighted (pressed) | `fills.tertiary` 배경 오버레이 (0.12 opacity) |
| 버튼 Disabled | 텍스트 opacity 0.3 감소 |
| Destructive Highlighted | `miscellaneous.buttons.bgDestructive` 배경 |
| Text Field Focused | `accents.blue` 1pt 테두리 |
| Alert Present | fade + scale in (0.85→1.0) |
| Alert Dismiss | fade out (opacity 1→0) |

---

## 7. Animation

### Present (등장)
```yaml
trigger: 화면에 Alert 표시 시
duration: 0.2s  # animations.json > duration.semantic.alertPresent
easing: spring.stiff  # cubic-bezier(0.5, 0, 0.75, 0) — 튕김 없음
properties:
  opacity: 0 → 1
  scale: 0.85 → 1.0
  transform-origin: center
overlay:
  opacity: 0 → 1  # overlays.alert 색상으로
  duration: 0.2s
  easing: easeOut
```

### Dismiss (퇴장)
```yaml
trigger: 버튼 탭 또는 오버레이 탭 (설정에 따라)
duration: 0.15s  # animations.json > duration.semantic.alertDismiss
easing: easeIn
properties:
  opacity: 1 → 0
  scale: 1.0 → 0.95
overlay:
  opacity: 1 → 0
  duration: 0.15s
```

### iOS Native 구현 (UIKit)
```swift
// UIAlertController는 시스템이 자동으로 애니메이션 처리
// 커스텀 구현 시:
let animator = UISpringTimingParameters(
    response: 0.25,      // spring.stiff.response
    dampingRatio: 1.0    // spring.stiff.dampingRatio (no bounce)
)
```

### Flutter 구현
```dart
// SpringDescription for alert present
const spring = SpringDescription(
  mass: 1,
  stiffness: 400,  // stiff spring
  damping: 40,
);
// AnimationController + CurvedAnimation
// scale: Tween(begin: 0.85, end: 1.0)
// opacity: Tween(begin: 0.0, end: 1.0)
```

### CSS/Svelte 구현
```css
@keyframes alert-in {
  from {
    opacity: 0;
    transform: scale(0.85);
  }
  to {
    opacity: 1;
    transform: scale(1.0);
  }
}

.alert-enter {
  animation: alert-in 0.2s cubic-bezier(0.5, 0, 0.75, 0) forwards;
}
```

---

## 8. Accessibility

| 항목 | 요구사항 |
|------|---------|
| 최소 탭 타겟 | 버튼 높이 `44pt` — Apple HIG + WCAG 2.1 AA |
| 색상 대비 | 버튼 텍스트 vs 배경: 최소 4.5:1 (WCAG AA) |
| VoiceOver role | Alert: `UIAccessibilityTraitAlert`, 버튼: `UIAccessibilityTraitButton` |
| VoiceOver 포커스 | Alert 등장 시 첫 번째 요소(Title)로 자동 포커스 이동 |
| accessibilityLabel | Title + Message를 조합하여 읽음 |
| Dynamic Type | 텍스트 크기 `.body` ~ `.accessibilityLarge` 지원 |
| 오버레이 tap dismiss | `isAccessibilityElement = false` — 실수 닫기 방지 |
| 키보드 탐색 (iPadOS) | Tab 키로 버튼 간 이동 지원 |
| Reduce Motion | scale 애니메이션 비활성화, fade만 유지 (`UIAccessibility.isReduceMotionEnabled`) |

---

## 9. Framework Notes

### UIKit (Native)
```swift
// 1-button variant
let alert = UIAlertController(
    title: "제목",
    message: "메시지 내용",
    preferredStyle: .alert
)
alert.addAction(UIAlertAction(title: "확인", style: .default))
present(alert, animated: true)

// 2-button variant (destructive)
alert.addAction(UIAlertAction(title: "삭제", style: .destructive))
alert.addAction(UIAlertAction(title: "취소", style: .cancel))
```

### SwiftUI
```swift
.alert("제목", isPresented: $showAlert) {
    Button("확인") { }
    Button("삭제", role: .destructive) { }
    Button("취소", role: .cancel) { }
} message: {
    Text("메시지 내용")
}
```

### Flutter (커스텀 구현)
```dart
showDialog(
  context: context,
  barrierColor: Color(0x29293A3B), // overlays.alert light
  builder: (_) => AlertDialog(
    title: Text('제목'),
    content: Text('메시지'),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14), // radius.semantic.alert
    ),
    titleTextStyle: TextStyle(
      fontSize: 17, fontWeight: FontWeight.w600
    ),
    contentTextStyle: TextStyle(
      fontSize: 13, color: Color(0x993C3C43) // labels.secondary light
    ),
  ),
);
```

### Svelte/CSS (웹 구현)
```svelte
<!-- width: 270px, border-radius: 14px -->
<!-- overlay: background: rgba(41, 41, 58, 0.23) light mode -->
<!-- 2-button: display: flex, 각 button flex: 1 -->
```

### 주의사항
- Alert는 항상 사용자 인터랙션을 요구하는 상황에만 사용. 정보 전달만 필요하면 Banner/Toast 사용 권장.
- `UIAlertController.message`의 NSAttributedString은 iOS 26에서 일부 지원. 기본 style을 벗어나는 커스텀은 지양.
- 3개 이상 버튼이 필요하면 `ActionSheet` (`UIAlertController.preferredStyle = .actionSheet`) 사용.
- TextField variant는 `addTextField(configurationHandler:)`로 추가. 키보드 표시 시 Alert 위치 자동 조정됨.
