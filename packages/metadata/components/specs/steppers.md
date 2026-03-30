# Steppers Component Spec

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="5415:17683")`

---

## 1. Overview

iOS 26의 Stepper 컴포넌트. `-` / `+` 버튼을 탭하여 숫자값을 증감하는 컨트롤. 두 개의 독립 세그먼트(`_Decrement`, `_Increment`)가 얇은 구분선으로 나뉘어 하나의 유닛처럼 보인다. 폼, 수량 선택, 날짜/시간 조절에 주로 사용된다.

- **Figma Node**: Page `507:24687`, Section `5415:17683`
- **내부 레이어**:
  - `_Decrement`: `5415:17684` (3 variants: Default, Pressed, Disabled)
  - `_Increment`: `5415:17691` (3 variants: Default, Pressed, Disabled)
- **Light 예시**: `5433:18793` (2가지)
- **Dark 예시**: `5433:18797` (2가지)
- **UIKit 클래스**: `UIStepper`
- **SwiftUI**: `Stepper`

---

## 2. Dimensions

| 속성 | 값 |
|------|-----|
| 전체 높이 | 29 pt |
| 각 세그먼트 너비 | 44 pt |
| 전체 너비 | ~94 pt (44 + 0.5 divider + 44 + 패딩) |
| Corner radius | 7 pt (외곽 모서리만) |
| 세그먼트 구분선 너비 | 0.5 pt |
| 아이콘 크기 | 17 pt (SF Symbol `minus` / `plus`) |
| 터치 타겟 | 44 × 44 pt (세그먼트 각각, HIG 준수) |

```
전체 레이아웃:
┌──────────────┬──────────────┐
│      −       │      +       │  29pt 높이
└──────────────┴──────────────┘
     44pt    0.5pt   44pt
     ←────── ~94pt ──────→
```

---

## 3. Variants

| Variant | `_Decrement` | `_Increment` | 설명 |
|---------|-------------|-------------|------|
| Default | Default | Default | 기본 상태 |
| Decrement Pressed | **Pressed** | Default | 빼기 버튼 눌림 |
| Increment Pressed | Default | **Pressed** | 더하기 버튼 눌림 |
| Decrement Disabled | **Disabled** | Default | 최솟값 도달 시 |
| Increment Disabled | Default | **Disabled** | 최댓값 도달 시 |
| Both Disabled | **Disabled** | **Disabled** | 전체 비활성화 |

각 세그먼트는 독립적으로 Pressed/Disabled 상태를 가진다.

---

## 4. Color Tokens

### 배경 색상

| 상태 | Light | Dark | 토큰 |
|------|-------|------|------|
| Default | `rgba(118,118,128, 0.12)` | `rgba(118,118,128, 0.24)` | `fills.tertiary` |
| Pressed | `rgba(118,118,128, 0.20)` | `rgba(118,118,128, 0.36)` | `fills.secondary` |
| Disabled | `rgba(118,118,128, 0.06)` | `rgba(118,118,128, 0.12)` | `fills.tertiary` @ 50% |

### 아이콘 색상

| 상태 | Light | Dark | 토큰 |
|------|-------|------|------|
| Default | `#000000` | `#ffffff` | `labels.primary` |
| Pressed | `#000000` | `#ffffff` | `labels.primary` (변화 없음) |
| Disabled | `rgba(60,60,67, 0.3)` | `rgba(235,235,245, 0.3)` | `labels.tertiary` |

### 구분선 색상

| Light | Dark | 토큰 |
|-------|------|------|
| `#c6c6c8` | `#38383a` | `separators.opaque` |

---

## 5. Typography

Stepper 자체의 심볼은 SF Symbol이므로 텍스트 폰트 설정 불필요.

함께 표시되는 현재값 레이블:

| 역할 | 스타일 | 크기 | Weight |
|------|--------|------|--------|
| 현재값 | Body | 17pt | Regular |
| 단위 | Footnote | 13pt | Regular |
| 레이블 | Subheadline | 15pt | Regular |

---

## 6. State Transitions

```
Default ──(탭 Decrement)──→ Decrement Pressed (즉시)
Decrement Pressed ──(릴리즈)──→ Default (값 감소 완료)
Default ──(탭 Increment)──→ Increment Pressed (즉시)
Increment Pressed ──(릴리즈)──→ Default (값 증가 완료)

값 = minimumValue ──→ Decrement Disabled (자동)
값 = maximumValue ──→ Increment Disabled (자동)
값 < maximumValue ──→ Increment Default 복귀 (자동)
값 > minimumValue ──→ Decrement Default 복귀 (자동)
```

### 롱프레스 동작

- 0.5초 롱프레스 → 반복 증감 시작
- 반복 간격: 처음 0.1s, 가속하여 최소 0.04s
- 릴리즈 → 반복 중단

---

## 7. Animation

### Pressed 상태 피드백

| 속성 | 값 |
|------|-----|
| 배경 변화 | `fills.tertiary` → `fills.secondary`, duration: 0.05s |
| 릴리즈 복귀 | duration: 0.1s, `cubic-bezier(0.0, 0, 0.58, 1.0)` |
| 스케일 | 없음 (배경 색상만 변화) |

### Haptic Feedback

| 이벤트 | 패턴 |
|--------|------|
| 값 변경 | `.selection` |
| 한계값 도달 | `.impact(.light)` |

---

## 8. Accessibility

| 속성 | 값 |
|------|-----|
| `accessibilityTraits` | `.adjustable` (UIStepper 전체) |
| `accessibilityValue` | 현재 숫자값 |
| `accessibilityLabel` | "스테퍼" 또는 컨텍스트 레이블 |
| `accessibilityIncrement()` | Increment 버튼 동작 |
| `accessibilityDecrement()` | Decrement 버튼 동작 |
| 각 버튼 개별 레이블 | "빼기" / "더하기" |
| Disabled 버튼 | `isAccessibilityElement = true`, `.notEnabled` trait |

VoiceOver 제스처: 오른쪽 스와이프 위로 = 증가, 오른쪽 스와이프 아래로 = 감소.

---

## 9. Framework Notes

### UIKit

```swift
let stepper = UIStepper()
stepper.minimumValue = 0
stepper.maximumValue = 10
stepper.value = 5
stepper.stepValue = 1
stepper.wraps = false // 한계값에서 멈춤
stepper.autorepeat = true // 롱프레스 반복
stepper.isContinuous = true

// 커스텀 색상 적용
stepper.tintColor = UIColor { trait in
    trait.userInterfaceStyle == .dark
        ? UIColor(white: 1, alpha: 1)
        : UIColor(white: 0, alpha: 1)
}

stepper.addTarget(self, action: #selector(stepperChanged(_:)), for: .valueChanged)

@objc func stepperChanged(_ stepper: UIStepper) {
    let generator = UISelectionFeedbackGenerator()
    generator.selectionChanged()
    countLabel.text = "\(Int(stepper.value))"
}
```

### SwiftUI

```swift
struct CounterView: View {
    @State private var count = 5

    var body: some View {
        HStack {
            Text("\(count)")
                .font(.body)
                .monospacedDigit()
                .frame(minWidth: 40)

            Stepper("수량", value: $count, in: 0...10, step: 1)
                .labelsHidden()
                // iOS 26: 자동으로 fills.tertiary 배경, labels.primary 아이콘
        }
    }
}

// 커스텀 스텝 동작
Stepper(
    value: $count,
    in: 0...100,
    step: 5,
    onEditingChanged: { isEditing in
        if !isEditing {
            UISelectionFeedbackGenerator().selectionChanged()
        }
    }
) {
    Text("수량: \(count)")
}
```

### Flutter

```dart
class IOSStepper extends StatelessWidget {
  const IOSStepper({
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
    this.minValue = 0,
    this.maxValue = 100,
  });

  final int value;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;
  final int minValue, maxValue;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark
        ? const Color(0x3D767680)  // fills.tertiary dark
        : const Color(0x1F767680); // fills.tertiary light
    final pressedBg = isDark
        ? const Color(0x52787880)  // fills.secondary dark
        : const Color(0x29787880); // fills.secondary light

    bool canDecrement = value > minValue;
    bool canIncrement = value < maxValue;

    Widget buildButton({
      required IconData icon,
      required bool enabled,
      required VoidCallback? onTap,
      bool isLeft = false,
    }) {
      return GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          width: 44,
          height: 29,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.horizontal(
              left: isLeft ? const Radius.circular(7) : Radius.zero,
              right: !isLeft ? const Radius.circular(7) : Radius.zero,
            ),
          ),
          child: Icon(
            icon,
            size: 17,
            color: enabled
                ? (isDark ? Colors.white : Colors.black)
                : (isDark
                    ? const Color(0x4CEBEBF5) // labels.tertiary dark
                    : const Color(0x4C3C3C43)), // labels.tertiary light
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildButton(
          icon: CupertinoIcons.minus,
          enabled: canDecrement,
          onTap: onDecrement,
          isLeft: true,
        ),
        Container(
          width: 0.5,
          height: 29,
          color: isDark ? const Color(0xFF38383A) : const Color(0xFFC6C6C8),
        ),
        buildButton(
          icon: CupertinoIcons.plus,
          enabled: canIncrement,
          onTap: onIncrement,
        ),
      ],
    );
  }
}
```

### CSS / Svelte

```svelte
<script>
  let value = 5;
  const min = 0, max = 10;

  $: canDecrement = value > min;
  $: canIncrement = value < max;

  function decrement() {
    if (canDecrement) value -= 1;
  }
  function increment() {
    if (canIncrement) value += 1;
  }
</script>

<div class="stepper" role="group" aria-label="수량 조절">
  <button
    class="segment left"
    disabled={!canDecrement}
    on:click={decrement}
    aria-label="빼기"
  >
    <span class="icon">−</span>
  </button>
  <div class="divider" />
  <button
    class="segment right"
    disabled={!canIncrement}
    on:click={increment}
    aria-label="더하기"
  >
    <span class="icon">+</span>
  </button>
</div>

<style>
  .stepper {
    display: inline-flex;
    align-items: center;
    height: 29px;
  }

  .segment {
    width: 44px;
    height: 29px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(118, 118, 128, 0.12); /* fills.tertiary light */
    border: none;
    cursor: pointer;
    transition: background 0.05s ease;
  }

  @media (prefers-color-scheme: dark) {
    .segment {
      background: rgba(118, 118, 128, 0.24); /* fills.tertiary dark */
    }
  }

  .segment.left { border-radius: 7px 0 0 7px; }
  .segment.right { border-radius: 0 7px 7px 0; }

  .segment:active:not(:disabled) {
    background: rgba(120, 120, 128, 0.20);
  }

  .segment:disabled {
    cursor: not-allowed;
    opacity: 0.5;
  }

  .icon {
    font-size: 17px;
    color: #000000;
    line-height: 1;
  }

  @media (prefers-color-scheme: dark) {
    .icon { color: #ffffff; }
  }

  .segment:disabled .icon {
    color: rgba(60, 60, 67, 0.3);
  }

  .divider {
    width: 0.5px;
    height: 29px;
    background: #c6c6c8; /* separators.opaque light */
  }

  @media (prefers-color-scheme: dark) {
    .divider { background: #38383a; }
  }
</style>
```
