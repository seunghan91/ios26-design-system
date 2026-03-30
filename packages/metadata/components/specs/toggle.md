# Toggle (Switch) Component Spec

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="5433:20242")`

---

## 1. Overview

iOS 26의 표준 Toggle (Switch) 컴포넌트. UISwitch를 베이스로 하는 바이너리 On/Off 컨트롤로, 설정 화면, 폼, List Row 내부에서 주로 사용된다. Pill 형태의 track 위에서 흰색 knob이 수평으로 슬라이딩하며 상태를 표현한다.

- **Figma Node**: Page `507:24690`, Section `5433:20242`
- **Light 예시**: `5433:19059` (3가지 상태)
- **Dark 예시**: `5433:19063` (3가지 상태)
- **UIKit 클래스**: `UISwitch`
- **SwiftUI**: `Toggle`

---

## 2. Dimensions

| 속성 | 값 |
|------|-----|
| 전체 크기 | 51 × 31 pt |
| Track corner radius | 15.5 pt (완전한 pill 형태) |
| Knob 직경 | 27 pt |
| Knob OFF position X | track 좌측 끝 기준 +2 pt (knob center = 15.5 pt) |
| Knob ON position X | track 우측 끝 기준 -2 pt (knob center = 35.5 pt) |
| Knob 이동 거리 | 20 pt (35.5 - 15.5) |
| Touch target | 51 × 44 pt (HIG 최소 44pt 준수) |

```
OFF 상태:
┌─────────────────────────────────────────────────┐
│  ○·····                                         │  31pt
└─────────────────────────────────────────────────┘
                     51pt

ON 상태:
┌─────────────────────────────────────────────────┐
│                                           ·····○│  31pt
└─────────────────────────────────────────────────┘
```

---

## 3. Variants

| Variant | 설명 |
|---------|------|
| ON | 활성화 상태. Track = accents.blue, Knob = white |
| OFF | 비활성화 상태. Track = fills.tertiary, Knob = white |
| Disabled-ON | 비활성화된 ON 상태. ON 색상에 50% opacity 적용 |
| Disabled-OFF | 비활성화된 OFF 상태. OFF 색상에 50% opacity 적용 |

---

## 4. Color Tokens

### Track 색상

| 상태 | Light | Dark | 토큰 |
|------|-------|------|------|
| ON | `#0088ff` | `#0091ff` | `accents.blue` |
| OFF | `rgba(118,118,128, 0.12)` | `rgba(118,118,128, 0.24)` | `fills.tertiary` |
| Disabled-ON | `rgba(0,136,255, 0.5)` | `rgba(0,145,255, 0.5)` | `accents.blue` @ 50% |
| Disabled-OFF | `rgba(118,118,128, 0.06)` | `rgba(118,118,128, 0.12)` | `fills.tertiary` @ 50% |

### Knob 색상

| 속성 | 값 |
|------|-----|
| Fill | `#ffffff` (항상 흰색, 라이트/다크 무관) |
| Shadow type | DROP_SHADOW |
| Shadow color | `rgba(0,0,0, 0.3)` |
| Shadow blur | 3 pt |
| Shadow offset X | 0 pt |
| Shadow offset Y | 1 pt |

### Accessibility Label 색상

| 상태 | Light | Dark |
|------|-------|------|
| OFF 레이블 | `#b3b3b3` | `#a6a6a6` |
| (miscellaneous.toggle.axLabelOff 토큰) | | |

---

## 5. Typography

Toggle 자체에는 텍스트가 없다. List Row와 함께 사용될 때의 레이블 스타일:

| 역할 | 스타일 | 크기 | Weight |
|------|--------|------|--------|
| 주 레이블 | Body | 17pt | Regular |
| 보조 레이블 | Subheadline | 15pt | Regular |
| 색상 | `labels.primary` | | |

Dynamic Type을 지원해야 하며, 레이블 텍스트 크기는 사용자 설정에 따라 자동 조정된다.

---

## 6. State Transitions

```
OFF ──(탭)──→ ON
ON  ──(탭)──→ OFF
OFF ──(비활성화)──→ Disabled-OFF
ON  ──(비활성화)──→ Disabled-ON
Disabled-* ──(활성화)──→ 기존 상태 복원
```

### 인터랙션 세부사항

- **탭**: 즉시 상태 전환 + spring 애니메이션
- **드래그**: 수평 드래그로 직접 조작 가능 (UISwitch 기본 동작)
- **드래그 임계값**: 50% 이상 이동 시 해당 방향으로 확정

---

## 7. Animation

### 전환 애니메이션 사양

| 속성 | 값 |
|------|-----|
| 타입 | Spring (snappy) |
| Duration | 0.3s |
| Spring response | 0.3 |
| Spring damping ratio | 0.8 |
| CSS approximation | `cubic-bezier(0.34, 1.56, 0.64, 1.0)` |

### 애니메이션 대상 속성

1. **Knob 위치**: `translateX(0)` → `translateX(20pt)` (OFF→ON)
2. **Track 색상**: `fills.tertiary` ↔ `accents.blue` (크로스페이드)
3. **Knob 크기**: 터치 시 살짝 스퀴시 (27pt → 25pt), 릴리즈 시 복귀 (선택적)

```
OFF → ON 타임라인 (0.3s):
0%    : knob at x=2, track=fills.tertiary
15%   : track 색상 전환 시작
50%   : knob 중간 지점, track 색상 전환 완료
100%  : knob at x=22, track=accents.blue
```

---

## 8. Accessibility

| 속성 | 값 |
|------|-----|
| `accessibilityTraits` | `.button`, `.selected` (ON일 때) |
| `accessibilityValue` | "1" (ON) / "0" (OFF) |
| `accessibilityLabel` | 연결된 레이블 텍스트 |
| 최소 터치 타겟 | 44 × 44 pt (HIG 준수) |
| VoiceOver 읽기 | "[레이블], [켜짐/꺼짐], 스위치" |

비활성화(Disabled) 상태에서는 `isAccessibilityElement = true`를 유지하되 상태를 "흐리게" 표현한다. VoiceOver가 "비활성화됨"을 읽도록 `accessibilityTraits`에 `.notEnabled`를 추가한다.

---

## 9. Framework Notes

### UIKit

```swift
// 기본 사용
let toggle = UISwitch()
toggle.isOn = false
toggle.onTintColor = UIColor(hex: "#0088FF") // accents.blue light
toggle.addTarget(self, action: #selector(toggleChanged), for: .valueChanged)

// Dynamic color 지원
toggle.onTintColor = UIColor { traitCollection in
    traitCollection.userInterfaceStyle == .dark
        ? UIColor(hex: "#0091FF")  // accents.blue dark
        : UIColor(hex: "#0088FF")  // accents.blue light
}

// Disabled 상태
toggle.isEnabled = false
toggle.alpha = 0.5
```

### SwiftUI

```swift
struct SettingsRow: View {
    @State private var isEnabled = false

    var body: some View {
        Toggle("알림 허용", isOn: $isEnabled)
            .tint(Color(hex: "#0088FF")) // iOS에서 자동으로 다크 모드 색상 사용
    }
}

// 커스텀 스타일이 필요한 경우
Toggle("알림 허용", isOn: $isEnabled)
    .toggleStyle(SwitchToggleStyle(tint: .blue))
    .disabled(false)
```

### Flutter

```dart
// 기본 Switch
Switch(
  value: _isEnabled,
  onChanged: (bool value) {
    setState(() { _isEnabled = value; });
  },
  activeColor: Colors.white,
  activeTrackColor: const Color(0xFF0088FF), // accents.blue light
  inactiveThumbColor: Colors.white,
  inactiveTrackColor: const Color(0x1F767680), // fills.tertiary light (12%)
)

// 다크 모드 대응
Switch(
  value: _isEnabled,
  onChanged: _isEnabled ? null : (value) => setState(() => _isEnabled = value),
  activeTrackColor: Theme.of(context).brightness == Brightness.dark
      ? const Color(0xFF0091FF)  // dark
      : const Color(0xFF0088FF), // light
  // 애니메이션은 Flutter Switch가 기본적으로 spring-like curve 사용
)

// 커스텀 Spring 애니메이션 (정확한 iOS 재현)
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  curve: const Cubic(0.34, 1.56, 0.64, 1.0), // spring snappy 근사
  // ...
)
```

### CSS / Svelte

```svelte
<script>
  let isOn = false;

  // spring snappy 커브 = cubic-bezier(0.34, 1.56, 0.64, 1.0)
</script>

<button
  role="switch"
  aria-checked={isOn}
  class="toggle"
  class:on={isOn}
  on:click={() => isOn = !isOn}
>
  <span class="knob" />
</button>

<style>
  .toggle {
    position: relative;
    width: 51px;
    height: 31px;
    border-radius: 15.5px;
    border: none;
    cursor: pointer;
    padding: 0;
    background-color: rgba(118, 118, 128, 0.12); /* fills.tertiary light */
    transition: background-color 0.3s cubic-bezier(0.34, 1.56, 0.64, 1.0);
  }

  @media (prefers-color-scheme: dark) {
    .toggle {
      background-color: rgba(118, 118, 128, 0.24); /* fills.tertiary dark */
    }
  }

  .toggle.on {
    background-color: #0088ff; /* accents.blue light */
  }

  @media (prefers-color-scheme: dark) {
    .toggle.on {
      background-color: #0091ff; /* accents.blue dark */
    }
  }

  .toggle:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }

  .knob {
    position: absolute;
    top: 2px;
    left: 2px;
    width: 27px;
    height: 27px;
    border-radius: 50%;
    background: #ffffff;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
    transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1.0);
  }

  .toggle.on .knob {
    transform: translateX(20px);
  }
</style>
```
