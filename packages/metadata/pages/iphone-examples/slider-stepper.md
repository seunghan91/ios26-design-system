# Slider & Stepper — iOS 26 페이지 레시피

> **References**
> - Components: `../../components/specs/sliders.md`, `../../components/specs/steppers.md`, `../../components/specs/list-row.md`
> - Tokens: `../../tokens/`
> - Sections: `../../sections/`
> - Figma (최후 수단): Slider `get_screenshot(nodeId="7:53847")`, Stepper `get_screenshot(nodeId="5415:17683")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Slider & Stepper Controls |
| **디바이스** | iPhone 17 Pro, 402 × 874pt |
| **용도** | 설정 화면 내 수치 조절 — 볼륨, 밝기, 수량 등 |
| **iOS 26 특이사항** | Slider track + Liquid Glass thumb, Stepper fills.tertiary 배경 |

이 페이지는 Settings-style Grouped Inset List 내에서 Slider와 Stepper가 사용되는 컨텍스트를 보여준다. Slider는 연속/이산값 조절에, Stepper는 정수 단위 증감에 사용된다.

---

## 화면 구성 분해

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41          ⠿ ▐▌ ■               │  ← Status Bar (54pt)
├─────────────────────────────────────────────┤
│                                              │
│  디스플레이                                   │  ← Large Title (34pt Regular)
│                                              │    letterSpacing: 0.4
├─────────────────────────────────────────────┤
│                                              │
│  ╔═══════════════════════════════════════╗  │  ← Section: "밝기"
│  ║  ☀︎  ────────●──────────── ☀︎         ║  │  ← Slider (continuous)
│  ║      ↑ accents.blue fill  ↑ white knob ║  │    track h: 4pt
│  ╚═══════════════════════════════════════╝  │    knob: 28pt circle
│                                              │
│  ╔═══════════════════════════════════════╗  │  ← Section: "텍스트 크기"
│  ║  A  ──────────────●───── A           ║  │  ← Slider (stepped, 7 ticks)
│  ║  (small)     ticks ↑     (large)     ║  │    각 tick: 2×4pt
│  ╚═══════════════════════════════════════╝  │    snap: spring snappy 0.3s
│  [기본 텍스트 크기로 앱의 콘텐츠가 표시됩니다]  │  ← Footer (13pt, secondary)
│                                              │
│  ╔═══════════════════════════════════════╗  │  ← Section: "수량 설정"
│  ║  알림 횟수          5   [−][+]       ║  │  ← Row: Label + Value + Stepper
│  ║─────────────────────────────────────║  │
│  ║  지연 시간 (초)     30  [−][+]       ║  │  ← Row: Label + Value + Stepper
│  ║─────────────────────────────────────║  │
│  ║  최대 재시도        3   [−][+]       ║  │
│  ╚═══════════════════════════════════════╝  │
│  [0으로 설정하면 재시도하지 않습니다]          │  ← Footer
│                                              │
│  ╔═══════════════════════════════════════╗  │  ← Section: "볼륨"
│  ║  🔈  ──────────●──────── 🔊         ║  │  ← Volume slider variant
│  ╚═══════════════════════════════════════╝  │
│                                              │
│  ╔═══════════════════════════════════════╗  │  ← Section: "EQ 조절"
│  ║   32Hz  125Hz  500Hz  2kHz  8kHz     ║  │  ← Both-sided sliders
│  ║    │      │      │      │      │     ║  │    중앙에서 양방향 fill
│  ║    ●      ●      ●      ●      ●     ║  │    each is vertical variant
│  ║    │      │      │      │      │     ║  │
│  ╚═══════════════════════════════════════╝  │
│                                              │
├─────────────────────────────────────────────┤
│  ■ Home  ■ Search  ■ Settings  ■ Profile   │  ← Tab Bar (49pt)
└─────────────────────────────────────────────┘
          ─────                                  ← Home Indicator (134×5pt)
```

---

## Slider 상세 스펙

### Dimensions

| 속성 | 값 | 토큰 |
|------|-----|------|
| Track 높이 | 4pt | `sliders.md > 2. Dimensions` |
| Track cornerRadius | 2pt (pill) | — |
| Knob 직경 | 28pt | `sliders.md > 2. Dimensions` |
| Knob shadow | blur 4pt, offsetY 2pt, `rgba(0,0,0,0.3)` | — |
| Touch target 높이 | 44pt | `spacing.json > components.touchTarget.minimum` |
| Tick 크기 (stepped) | 2 × 4pt | `sliders.md > 2. Dimensions` |

### Color Tokens

| 요소 | Light | Dark | 토큰 경로 |
|------|-------|------|----------|
| Track (배경) | `rgba(118,118,128,0.12)` | `rgba(118,118,128,0.24)` | `colors.json > fills.tertiary` |
| Fill (진행) | `#0088ff` | `#0091ff` | `colors.json > accents.blue` |
| Knob fill | `#ffffff` | `#ffffff` | — |
| Knob shadow | `rgba(0,0,0,0.3)` | `rgba(0,0,0,0.3)` | — |
| Tick (미진행 구간) | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.7)` | `colors.json > labels.secondary` |
| Tick (진행 구간) | `#ffffff` | `#ffffff` | — |
| Min/Max 레이블 | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.7)` | `colors.json > labels.secondary` |

### Animation

| 상태 | 애니메이션 | 토큰 |
|------|-----------|------|
| 터치 시작 | Knob scale 28→30pt, 0.1s easeOut | `animations.json > easing.easeOut` |
| 터치 종료 | Knob scale 30→28pt, 0.15s spring.snappy | `animations.json > spring.presets.snappy` |
| Stepped 스냅 | spring snappy, 0.3s | `cubic-bezier(0.34, 1.56, 0.64, 1.0)` |
| 드래그 중 fill | 실시간 (no animation) | — |

### Haptic Feedback

| 이벤트 | 패턴 |
|--------|------|
| 스텝 통과 (stepped slider) | `.selection` |
| 최솟값/최댓값 도달 | `.impact(.light)` |

---

## Stepper 상세 스펙

### Dimensions

| 속성 | 값 | 토큰 |
|------|-----|------|
| 전체 높이 | 29pt | `steppers.md > 2. Dimensions` |
| 각 세그먼트 너비 | 44pt | — |
| 전체 너비 | ~94pt | — |
| Corner radius | 7pt | — |
| 구분선 너비 | 0.5pt | — |
| 아이콘 크기 | 17pt (SF Symbol `minus` / `plus`) | — |
| 터치 타겟 | 44 × 44pt | `spacing.json > components.touchTarget.minimum` |

### Color Tokens

| 요소 | Light | Dark | 토큰 경로 |
|------|-------|------|----------|
| 배경 (default) | `rgba(118,118,128,0.12)` | `rgba(118,118,128,0.24)` | `colors.json > fills.tertiary` |
| 배경 (pressed) | `rgba(118,118,128,0.20)` | `rgba(118,118,128,0.36)` | `colors.json > fills.secondary` |
| 아이콘 (default) | `#000000` | `#ffffff` | `colors.json > labels.primary` |
| 아이콘 (disabled) | `rgba(60,60,67,0.3)` | `rgba(235,235,245,0.3)` | `colors.json > labels.tertiary` |
| 구분선 | `#c6c6c8` | `#38383a` | `colors.json > separators.opaque` |

### Animation

| 속성 | 값 |
|------|-----|
| Pressed 배경 변화 | `fills.tertiary` → `fills.secondary`, 0.05s |
| 릴리즈 복귀 | 0.1s, easeOut |
| 롱프레스 반복 시작 | 0.5초 후, 간격 0.1s → 가속 → 최소 0.04s |

---

## Settings List Context

### Row Layout (Stepper가 포함된 List Row)

```
┌───────────────────────────────────────────────┐
│ 16pt │ 알림 횟수    5    [−│+]         │ 16pt │
│      │ (body 17pt)  (body, mono)  (stepper)  │
└───────────────────────────────────────────────┘
       ↑ height: 44pt (listRow.heightRegular)
```

| 요소 | Typography | 토큰 |
|------|-----------|------|
| Row 레이블 | Body Regular 17pt | `typography.json > styles.body` |
| 현재값 | Body Regular 17pt, monospacedDigit | `typography.json > styles.body` |
| Section Header | Footnote Regular 13pt, uppercase | `typography.json > styles.footnote` |
| Section Footer | Footnote Regular 13pt | `colors.json > labels.secondary` |

---

## Light / Dark 모드 차이

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| Slider fill | `#0088ff` | `#0091ff` |
| Slider track bg | `rgba(118,118,128,0.12)` | `rgba(118,118,128,0.24)` |
| Stepper bg | `rgba(118,118,128,0.12)` | `rgba(118,118,128,0.24)` |
| Stepper divider | `#c6c6c8` | `#38383a` |
| List bg (grouped primary) | `#f2f2f7` | `#000000` |
| List section bg | `#ffffff` | `#1c1c1e` |
| 레이블 텍스트 | `#000000` | `#ffffff` |
| Footer 텍스트 | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.7)` |

---

## 인터랙션 노트

### Slider
- **드래그**: 트랙 또는 Knob 위 아무 곳 드래그로 값 변경
- **탭**: 트랙 위 특정 지점 탭 → 해당 위치로 즉시 이동 (stepped: 가장 가까운 스텝)
- **VoiceOver**: 좌/우 스와이프로 값 증감 (increment/decrement)

### Stepper
- **탭**: 단일 탭으로 1 증감
- **롱프레스**: 0.5초 후 반복 증감 시작 (가속)
- **한계값**: 최솟값/최댓값 도달 시 해당 방향 버튼 disabled
- **VoiceOver**: 오른쪽 스와이프 위 = 증가, 오른쪽 스와이프 아래 = 감소

---

## 접근성 고려사항

| 항목 | Slider | Stepper |
|------|--------|---------|
| accessibilityTraits | `.adjustable` | `.adjustable` |
| accessibilityValue | 현재 값 (숫자 또는 "%") | 현재 정수값 |
| accessibilityLabel | 역할 설명 ("밝기", "볼륨") | 역할 설명 ("알림 횟수") |
| Increment/Decrement | 좌우 스와이프 | 상하 스와이프 |
| Haptic feedback | `.selection` (스텝), `.impact(.light)` (한계) | `.selection` (변경), `.impact(.light)` (한계) |
| Reduce Motion | 스냅 애니메이션 비활성화, 즉시 전환 | 변화 없음 (단순 색상 전환만) |
| 최소 터치 타겟 | 44pt 높이 확보 | 각 세그먼트 44×44pt |
| Dynamic Type | Min/Max 레이블 크기 조정 | 값 레이블 크기 조정 |
