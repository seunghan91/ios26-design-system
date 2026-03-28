# Sliders Component Spec

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="7:53847")`

---

## 1. Overview

iOS 26의 Slider 컴포넌트. 연속값(Continuous) 또는 이산값(Stepped)을 선택하기 위한 수평/수직 트랙 기반 컨트롤. 볼륨, 밝기, 타이머 등 연속적인 수치 조절에 사용된다. 4가지 내부 레이어(`_Ticks`, `_Track`, `_Fill`, `_Knob`)로 구성되며, 5가지 Variant를 제공한다.

- **Figma Node**: `7:53847` (Sliders COMPONENT_SET, 5 variants)
- **내부 레이어**:
  - `_Ticks`: `5430:5333` — 스텝 표시 눈금
  - `_Track`: `5428:5456` — 배경 트랙
  - `_Fill`: `5441:3942` — 채워진 트랙 (진행률)
  - `_Knob`: `520:49468` — 드래그 가능한 원형 핸들
- **Light 예시**: `5430:1471` (4가지)
- **Dark 예시**: `5430:2054` (4가지)
- **UIKit 클래스**: `UISlider`
- **SwiftUI**: `Slider`

---

## 2. Dimensions

### 공통 트랙

| 속성 | 값 |
|------|-----|
| Track 높이 | 4 pt |
| Track corner radius | 2 pt (완전한 pill) |
| Touch target 높이 | 44 pt (HIG 준수, 실제 트랙보다 큰 히트 에어리어) |

### Knob

| 속성 | 값 |
|------|-----|
| Knob 직경 | 28 pt |
| Shadow type | DROP_SHADOW |
| Shadow blur | 4 pt |
| Shadow offset Y | 2 pt |
| Shadow color | `rgba(0,0,0, 0.3)` |

### Tick (스텝 마크)

| 속성 | 값 |
|------|-----|
| 너비 | 2 pt |
| 높이 | 4 pt |
| Track 중앙과 정렬 | 수직 중앙 정렬 |

### Vertical Slider (볼륨)

| 속성 | 값 |
|------|-----|
| 너비 | 4 pt (트랙 기준) |
| 총 높이 | 사용 가능 공간에 맞게 확장 |
| Knob | 동일 (28pt 원형) |

---

## 3. Variants

| Variant | 설명 | 특이사항 |
|---------|------|---------|
| Horizontal (continuous) | 표준 수평 연속 슬라이더 | Ticks 없음 |
| Horizontal (stepped) | 이산값 슬라이더 | Ticks 표시, 스냅 동작 |
| Horizontal (both-sided) | 양방향 슬라이더 | 중앙에서 양쪽으로 확장 (EQ, 온도 등) |
| Volume | 볼륨 전용 수평 슬라이더 | 스피커/볼륨 아이콘 좌우에 배치 |
| Vertical | 수직 방향 슬라이더 | 주로 음악 앱 EQ에서 사용 |

---

## 4. Color Tokens

### 트랙 색상

| 요소 | Light | Dark | 토큰 |
|------|-------|------|------|
| Track (배경) | `rgba(118,118,128, 0.12)` | `rgba(118,118,128, 0.24)` | `fills.tertiary` |
| Fill (진행) | `#0088ff` | `#0091ff` | `accents.blue` |
| Both-sided Fill (중앙→양방향) | `#0088ff` | `#0091ff` | `accents.blue` |

### Knob 색상

| 요소 | 값 |
|------|-----|
| Knob fill | `#ffffff` |
| Shadow | `rgba(0,0,0, 0.3)` |

### Tick 색상

| 상태 | Light | Dark | 토큰 |
|------|-------|------|------|
| Track 위 (미진행 구간) | `rgba(60,60,67, 0.6)` | `rgba(235,235,245, 0.7)` | `labels.secondary` |
| Fill 위 (진행 구간) | `#ffffff` (반전) | `#ffffff` | |

---

## 5. Typography

Slider 자체에는 텍스트가 없다. 함께 사용되는 보조 레이블:

| 역할 | 스타일 | 크기 | 색상 |
|------|--------|------|------|
| 현재값 표시 (Popover) | Footnote | 13pt | `labels.primary` |
| Min/Max 레이블 | Caption1 | 12pt | `labels.secondary` |
| 스텝 수치 | Caption2 | 11pt | `labels.tertiary` |

---

## 6. State Transitions

```
Idle ──(터치 시작)──→ Tracking (Knob 살짝 확대: 28pt → 30pt)
Tracking ──(드래그)──→ Tracking (값 연속 업데이트)
Tracking ──(스냅, stepped만)──→ 가장 가까운 스텝으로 스냅
Tracking ──(터치 종료)──→ Idle (Knob 원래 크기 복귀)
* ──(비활성화)──→ Disabled (50% opacity)
```

### Stepped Slider 스냅 동작

- 드래그 중: 연속적으로 이동 (실시간 피드백)
- 릴리즈 시: `spring snappy (0.3s)`로 가장 가까운 스텝으로 스냅
- Haptic: `.selection` (각 스텝 통과 시)

---

## 7. Animation

### Knob 인터랙션 애니메이션

| 상태 | 애니메이션 |
|------|-----------|
| 터치 시작 | Knob 스케일 28pt → 30pt, duration: 0.1s, easeOut |
| 터치 종료 | Knob 스케일 30pt → 28pt, duration: 0.15s, spring snappy |
| Stepped 스냅 | `cubic-bezier(0.34, 1.56, 0.64, 1.0)`, 0.3s |

### Fill 애니메이션

| 속성 | 값 |
|------|-----|
| 드래그 중 | 실시간 (no animation, 즉각 반응) |
| 프로그래매틱 변경 | `linear`, duration: 비례 (값 변화량에 비례) |

### Haptic Feedback

| 이벤트 | 패턴 |
|--------|------|
| 스텝 통과 (stepped) | `.selection` |
| 최솟값/최댓값 도달 | `.impact(.light)` |

---

## 8. Accessibility

| 속성 | 값 |
|------|-----|
| `accessibilityTraits` | `.adjustable` |
| `accessibilityValue` | 현재 값 (숫자 또는 "50%") |
| `accessibilityLabel` | 슬라이더 역할 설명 ("볼륨", "밝기") |
| `accessibilityIncrement()` | 우측 스와이프 → 값 증가 |
| `accessibilityDecrement()` | 좌측 스와이프 → 값 감소 |
| 스텝 단위 | `accessibilityIncrement/Decrement`에서 적절한 단위 사용 |
| VoiceOver 읽기 | "[레이블], [값], 조정 가능한 컨트롤" |

---

## 9. Framework Notes

### UIKit

```swift
// 기본 연속 슬라이더
let slider = UISlider()
slider.minimumValue = 0
slider.maximumValue = 100
slider.value = 50
slider.minimumTrackTintColor = UIColor(hex: "#0088FF") // accents.blue
slider.maximumTrackTintColor = UIColor(
    red: 118/255, green: 118/255, blue: 128/255, alpha: 0.12
) // fills.tertiary light
slider.thumbTintColor = .white

// Stepped 슬라이더 (UISlider 자체는 stepped 미지원 — 커스텀 필요)
// UISlider + snapping 로직
slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)

@objc func sliderChanged(_ sender: UISlider) {
    let steps: Float = 10
    let roundedValue = (sender.value / (sender.maximumValue / steps)).rounded() * (sender.maximumValue / steps)
    UIView.animate(withDuration: 0.3,
                   delay: 0,
                   usingSpringWithDamping: 0.8,
                   initialSpringVelocity: 0) {
        sender.setValue(roundedValue, animated: false)
    }
    UISelectionFeedbackGenerator().selectionChanged()
}
```

### SwiftUI

```swift
struct IOSSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    var step: Double? = nil

    var body: some View {
        Group {
            if let step = step {
                // Stepped
                Slider(
                    value: $value,
                    in: range,
                    step: step
                ) {
                    Text("슬라이더")
                } minimumValueLabel: {
                    Image(systemName: "speaker.fill")
                } maximumValueLabel: {
                    Image(systemName: "speaker.wave.3.fill")
                }
            } else {
                // Continuous
                Slider(value: $value, in: range)
                    .tint(Color(hex: "#0088FF"))
            }
        }
        .accentColor(Color(hex: "#0088FF"))
    }
}

// 볼륨 슬라이더
import MediaPlayer
let volumeView = MPVolumeView()
// 또는 SwiftUI에서
AVAudioSession.sharedInstance().outputVolume // 읽기
MPVolumeView() // UIViewRepresentable로 래핑
```

### Flutter

```dart
class IOSSlider extends StatefulWidget {
  const IOSSlider({
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
  });
  final double value;
  final ValueChanged<double> onChanged;
  final double min, max;
  final int? divisions;

  @override
  State<IOSSlider> createState() => _IOSSliderState();
}

class _IOSSliderState extends State<IOSSlider> {
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CupertinoSlider(
      value: widget.value,
      min: widget.min,
      max: widget.max,
      divisions: widget.divisions,
      activeColor: isDark ? const Color(0xFF0091FF) : const Color(0xFF0088FF),
      thumbColor: CupertinoColors.white,
      onChanged: widget.onChanged,
      onChangeStart: (_) => setState(() => _isDragging = true),
      onChangeEnd: (_) => setState(() => _isDragging = false),
    );

    // 커스텀 슬라이더 (더 세밀한 제어)
    // SliderTheme(
    //   data: SliderThemeData(
    //     trackHeight: 4,
    //     thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14),
    //     activeTrackColor: const Color(0xFF0088FF),
    //     inactiveTrackColor: const Color(0x1F767680),
    //     thumbColor: Colors.white,
    //     overlayShape: SliderComponentShape.noOverlay,
    //   ),
    //   child: Slider(value: widget.value, onChanged: widget.onChanged),
    // )
  }
}
```

### CSS / Svelte

```svelte
<script>
  let value = 50;
  let isDragging = false;

  function handleInput(e) {
    value = parseFloat(e.target.value);
  }
</script>

<div class="slider-wrapper">
  <input
    type="range"
    min="0"
    max="100"
    bind:value
    class="ios-slider"
    class:dragging={isDragging}
    on:mousedown={() => isDragging = true}
    on:mouseup={() => isDragging = false}
    on:touchstart={() => isDragging = true}
    on:touchend={() => isDragging = false}
    style:--fill-percent="{value}%"
  />
</div>

<style>
  .ios-slider {
    -webkit-appearance: none;
    appearance: none;
    width: 100%;
    height: 44px; /* 터치 타겟 높이 */
    background: transparent;
    cursor: pointer;
  }

  /* Track */
  .ios-slider::-webkit-slider-runnable-track {
    height: 4px;
    border-radius: 2px;
    background: linear-gradient(
      to right,
      #0088ff 0%,
      #0088ff var(--fill-percent, 50%),
      rgba(118, 118, 128, 0.12) var(--fill-percent, 50%),
      rgba(118, 118, 128, 0.12) 100%
    );
  }

  @media (prefers-color-scheme: dark) {
    .ios-slider::-webkit-slider-runnable-track {
      background: linear-gradient(
        to right,
        #0091ff 0%,
        #0091ff var(--fill-percent, 50%),
        rgba(118, 118, 128, 0.24) var(--fill-percent, 50%),
        rgba(118, 118, 128, 0.24) 100%
      );
    }
  }

  /* Thumb (Knob) */
  .ios-slider::-webkit-slider-thumb {
    -webkit-appearance: none;
    width: 28px;
    height: 28px;
    border-radius: 50%;
    background: #ffffff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
    margin-top: -12px; /* (28px - 4px) / 2 */
    transition: transform 0.1s cubic-bezier(0.0, 0, 0.58, 1.0);
  }

  .ios-slider.dragging::-webkit-slider-thumb {
    transform: scale(1.07); /* 28→30pt */
  }
</style>
```
