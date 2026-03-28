# Picker — iPhone Full-Screen Example

> **References**
> - Components: `../../components/specs/pickers.md`
> - Tokens: `../../tokens/colors.json`, `../../tokens/spacing.json`, `../../tokens/typography.json`, `../../tokens/animations.json`, `../../tokens/materials.json`
> - Sections: `../../sections/`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24680")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Picker (날짜/시간 선택기) |
| **디바이스** | iPhone 17 Pro — 402 × 874pt (@3x, 1206 × 2622px) |
| **용도** | 날짜, 시간, 또는 사용자 정의 값을 wheel/compact 방식으로 선택 |
| **트리거** | Compact 칩 탭 (확장), 리스트 행 내 인라인 배치 |
| **프레젠테이션** | Inline (리스트 내 확장) 또는 Compact (칩 → popover/inline 확장) |
| **iOS 26 특이사항** | Liquid Glass 선택 영역 하이라이트, spring wheel 스크롤, 콤팩트 칩 디자인 |

이 문서는 두 가지 Picker variant를 다룬다: **Inline** (wheel picker, 리스트 내 인라인)과 **Compact** (날짜/시간 칩, 탭으로 확장).

---

## 디바이스 컨텍스트

```
iPhone 17 Pro
├─ 화면 크기: 402 × 874pt
├─ Safe Area Top: 59pt (Dynamic Island)
├─ Safe Area Bottom: 34pt (Home Indicator)
├─ Pixel Density: @3x (1206 × 2622px)
└─ 색상 공간: P3 Wide Color
```

---

## Variant 1: Inline Wheel Picker (리스트 내 인라인)

### 전체 레이아웃

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │  ← Status Bar (59pt)
├─────────────────────────────────────────────┤
│  ← 뒤로             알림 설정                │  ← Navigation Bar (44pt)
├─────────────────────────────────────────────┤  ← backgroundsGrouped.primary
│                                              │
│  ← 16pt → ┌──────────────────────┐ ← 16pt  │  ← Grouped Card
│            │  🔔 알림 반복     매일 › │         │  ← 행 탭 → 아래 Picker 확장
│            ├──────────────────────┤         │
│            │                      │         │
│            │  ┌──────┬──────┬──┐ │         │  ← Inline Wheel Picker
│            │  │  1일 │  1시 │AM│ │         │    높이: 216pt
│            │  │  2일 │  2시 │PM│ │         │    5행 표시 (가운데 선택)
│            │  │─────────────────│ │         │  ← 선택 영역 하이라이트
│            │  │  3일 │  3시 │  │ │         │    높이: 43.2pt
│            │  │─────────────────│ │         │    배경: fills.quaternary
│            │  │  4일 │  4시 │  │ │         │    cornerRadius: 8pt
│            │  │  5일 │  5시 │  │ │         │
│            │  └──────┴──────┴──┘ │         │
│            │                      │         │
│            ├──────────────────────┤         │
│            │  ⏰ 시간          오전 9:00 │         │  ← 다른 행 (접힌 상태)
│            └──────────────────────┘         │
│                                              │
│  ← 16pt → ┌──────────────────────┐ ← 16pt  │
│            │  📝 메모             › │         │
│            └──────────────────────┘         │
│                                              │
├─────────────────────────────────────────────┤
│  [🏠홈] [🔍탐색] [＋] [🔔벨] [👤프로필]      │  ← Tab Bar (83pt)
└─────────────────────────────────────────────┘
```

### Wheel Picker 치수

| 항목 | 값 | 토큰 |
|------|-----|------|
| 전체 높이 | 216pt | — |
| 표시 행 수 | 5행 | — |
| 행 높이 | 43.2pt (= 216 / 5) | — |
| 선택 영역 위치 | 정중앙 (top offset: 86.4pt) | — |
| 선택 영역 배경 | `fills.quaternary` | Light: `rgba(116,116,128,0.08)`, Dark: `rgba(118,118,128,0.18)` |
| 선택 영역 cornerRadius | 8pt | `spacing.radius.sm` |
| 선택 영역 높이 | 43.2pt (1행) | — |
| 열 구분 | 투명 간격 (구분선 없음) | — |
| 텍스트 (선택됨) | `labels.primary`, Body (17pt, Regular) | — |
| 텍스트 (비선택) | `labels.secondary`, Body (17pt, Regular) | 불투명도로 구분 |
| 스크롤 방향 | 세로 (각 열 독립) | — |
| Haptic | UISelectionFeedbackGenerator — 행 경계 통과 시 | — |

### 확장/축소 애니메이션

```yaml
expand:
  trigger: 행 탭 (picker 확장)
  duration: 0.3s
  easing: easeInOut — cubic-bezier(0.42, 0, 0.58, 1.0)
  properties:
    picker_height: 0 → 216pt (높이 확장)
    opacity: 0 → 1
    list_rows: 아래 행들이 밀려남

collapse:
  trigger: 다른 행 탭 / 동일 행 재탭
  duration: 0.25s
  easing: easeInOut
  properties:
    picker_height: 216pt → 0
    opacity: 1 → 0
```

---

## Variant 2: Compact Picker (날짜/시간 칩)

### 접힌 상태 (Collapsed)

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │  ← Status Bar (59pt)
├─────────────────────────────────────────────┤
│  ← 뒤로             이벤트 추가              │  ← Navigation Bar (44pt)
├─────────────────────────────────────────────┤
│                                              │
│  ← 16pt → ┌──────────────────────┐ ← 16pt  │
│            │  제목                  │         │  ← 텍스트 필드
│            ├──────────────────────┤         │
│            │  위치                  │         │
│            ├──────────────────────┤         │
│            │  종일                🔘│         │  ← Toggle
│            ├──────────────────────┤         │
│            │  시작  [2026.3.28] [오전 9:00]│  │  ← Compact Date + Time 칩
│            ├──────────────────────┤         │    날짜 칩: 파란 배경 + 흰 텍스트
│            │  종료  [2026.3.28] [오전 10:00]│  │    시간 칩: 파란 배경 + 흰 텍스트
│            ├──────────────────────┤         │
│            │  반복           없음  › │         │
│            ├──────────────────────┤         │
│            │  알림       15분 전  › │         │
│            └──────────────────────┘         │
│                                              │
├─────────────────────────────────────────────┤
│  [🏠홈] [🔍탐색] [＋] [🔔벨] [👤프로필]      │
└─────────────────────────────────────────────┘
```

### 확장 상태 (Expanded — 날짜 칩 탭 후)

```
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │
├─────────────────────────────────────────────┤
│  ← 뒤로             이벤트 추가              │
├─────────────────────────────────────────────┤
│                                              │
│  ← 16pt → ┌──────────────────────┐ ← 16pt  │
│            │  제목                  │         │
│            ├──────────────────────┤         │
│            │  시작  [2026.3.28] [오전 9:00]│  │  ← 날짜 칩 = 선택(강조)
│            ├──────────────────────┤         │
│            │ ┌──────────────────┐ │         │  ← 확장된 Date Picker
│            │ │  ◄  2026년 3월  ►  │ │         │    캘린더 그리드 뷰
│            │ │                    │ │         │    ~320pt 높이
│            │ │  일 월 화 수 목 금 토│ │         │
│            │ │                    │ │         │
│            │ │       1  2  3  4  5│ │         │
│            │ │  6  7  8  9 10 11 12│ │         │
│            │ │ 13 14 15 16 17 18 19│ │         │
│            │ │ 20 21 22 23 24 25 26│ │         │
│            │ │ 27[28]29 30 31      │ │         │  ← [28] = 선택된 날짜
│            │ │                    │ │         │    원형 배경: accents.blue
│            │ └──────────────────┘ │         │
│            ├──────────────────────┤         │
│            │  종료  [2026.3.28] [오전 10:00]│  │
│            └──────────────────────┘         │
│                                              │
├─────────────────────────────────────────────┤
│  [🏠홈] [🔍탐색] [＋] [🔔벨] [👤프로필]      │
└─────────────────────────────────────────────┘
```

### Compact 칩 치수

| 항목 | 값 | 토큰 |
|------|-----|------|
| 칩 높이 | 34pt | — |
| 칩 최소 너비 | 날짜: 120pt, 시간: 80pt | — |
| 칩 패딩 | 수평 12pt | — |
| 칩 cornerRadius | 8pt | — |
| 칩 간 간격 | 8pt | — |
| 배경 (기본) | `fills.quaternary` | Light: `rgba(116,116,128,0.08)`, Dark: `rgba(118,118,128,0.18)` |
| 배경 (선택/활성) | `accents.blue` | Light: `#0088ff`, Dark: `#0091ff` |
| 텍스트 (기본) | `accents.blue` | — |
| 텍스트 (선택/활성) | `#ffffff` | — |
| 타이포 | Callout (16pt, Regular) | `typography.styles.callout` |

### 캘린더 그리드 (확장 시)

| 항목 | 값 | 토큰 |
|------|-----|------|
| 전체 높이 | ~320pt | — |
| 요일 헤더 높이 | 28pt | — |
| 날짜 셀 크기 | ~44 × 44pt (7열 그리드) | — |
| 선택 날짜 배경 | `accents.blue` (원형) | Light: `#0088ff`, Dark: `#0091ff` |
| 선택 날짜 텍스트 | `#ffffff` | — |
| 오늘 날짜 | Bold 텍스트, 밑줄 또는 원형 테두리 | `accents.blue` |
| 비활성 날짜 (다른 달) | `labels.tertiary` | — |
| 월 이동 화살표 | SF Symbol `chevron.left` / `chevron.right` | `accents.blue` |
| 월 타이포 | Headline (17pt, Semibold) | `typography.styles.headline` |

---

## 공통 토큰 참조

### 색상

| 역할 | 토큰 | Light | Dark |
|------|------|-------|------|
| 선택 강조 | `colors.accents.blue` | `#0088ff` | `#0091ff` |
| Wheel 선택 배경 | `colors.fills.quaternary` | `rgba(116,116,128,0.08)` | `rgba(118,118,128,0.18)` |
| 칩 기본 배경 | `colors.fills.quaternary` | `rgba(116,116,128,0.08)` | `rgba(118,118,128,0.18)` |
| 칩 활성 배경 | `colors.accents.blue` | `#0088ff` | `#0091ff` |
| 텍스트 (선택됨) | `colors.labels.primary` | `#000000` | `#ffffff` |
| 텍스트 (비선택) | `colors.labels.secondary` | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.7)` |
| 비활성 날짜 | `colors.labels.tertiary` | `rgba(60,60,67,0.3)` | `rgba(235,235,245,0.3)` |

### Typography

| 요소 | 스타일 | 크기 | 굵기 |
|------|--------|------|------|
| Wheel 항목 | Body | 17pt | Regular |
| 칩 텍스트 | Callout | 16pt | Regular |
| 캘린더 월 | Headline | 17pt | Semibold |
| 캘린더 날짜 | Body | 17pt | Regular (오늘: Bold) |
| 요일 헤더 | Caption1 | 12pt | Regular |

---

## Light/Dark 모드 차이

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| 화면 배경 | `#f2f2f7` | `#000000` |
| 카드 배경 | `#ffffff` | `#1c1c1e` |
| Wheel 선택 배경 | `rgba(116,116,128,0.08)` | `rgba(118,118,128,0.18)` |
| 칩 기본 배경 | `rgba(116,116,128,0.08)` | `rgba(118,118,128,0.18)` |
| 칩 활성 배경 | `#0088ff` | `#0091ff` |
| 칩 텍스트 (기본) | `#0088ff` | `#0091ff` |
| 칩 텍스트 (활성) | `#ffffff` | `#ffffff` |
| 선택 날짜 배경 | `#0088ff` | `#0091ff` |
| 비활성 날짜 | `rgba(60,60,67,0.3)` | `rgba(235,235,245,0.3)` |

---

## 애니메이션

### Wheel Scroll

```yaml
trigger: 열 수직 드래그
type: gesture-driven (1:1 추적)
deceleration: UIScrollView deceleration rate
snap: 가장 가까운 행 중앙에 snap
spring: gentle (response 0.55, dampingRatio 0.825) — snap 시
haptic: UISelectionFeedbackGenerator — 행 경계 통과마다
```

### Compact Chip 토글

```yaml
trigger: 칩 탭
expand:
  duration: 0.3s
  easing: easeInOut
  properties:
    chip_background: quaternary → accents.blue
    chip_text: accents.blue → white
    picker_height: 0 → 320pt (캘린더) 또는 0 → 216pt (wheel)
    opacity: 0 → 1
    list_rows: 아래 행들이 spring으로 밀려남

collapse:
  duration: 0.25s
  properties: 역방향
```

### Calendar Month 전환

```yaml
trigger: ◄ / ► 화살표 탭
duration: 0.3s
easing: easeInOut
properties:
  direction: ← (이전 월) 또는 → (다음 월)
  current_month: translateX 0 → ∓50%, opacity 1 → 0
  new_month: translateX ±50% → 0, opacity 0 → 1
```

### Reduce Motion

```yaml
prefers-reduced-motion:
  wheel_snap: 즉시 (spring 제거)
  chip_toggle: opacity만 (0.15s)
  month_transition: crossfade (슬라이드 제거)
```

---

## 인터랙션 노트

### Inline Wheel

| 인터랙션 | 동작 |
|---------|------|
| **행 탭** | Wheel Picker 인라인 확장 |
| **열 드래그** | 해당 열 값 변경 (다른 열 독립) |
| **드래그 릴리스** | 가장 가까운 행에 snap |
| **행 경계 통과** | 햅틱 피드백 (selection) |
| **다른 행 탭** | 현재 Picker 축소 → 새 행 확장 |

### Compact Date/Time

| 인터랙션 | 동작 |
|---------|------|
| **날짜 칩 탭** | 캘린더 그리드 인라인 확장 |
| **시간 칩 탭** | 시간 Wheel 인라인 확장 |
| **날짜 셀 탭** | 해당 날짜 선택 (원형 하이라이트) |
| **월 화살표 탭** | 이전/다음 월 슬라이드 전환 |
| **활성 칩 재탭** | Picker 축소 |
| **다른 칩 탭** | 현재 Picker 축소 → 다른 Picker 확장 |
| **종일 토글 ON** | 시간 칩 숨김, 날짜만 표시 |

---

## 접근성 (Accessibility)

| 항목 | 요구사항 |
|------|---------|
| **VoiceOver (Wheel)** | `accessibilityTraits: .adjustable`, 위아래 스와이프로 값 변경 |
| **VoiceOver (Compact)** | 칩: "시작 날짜, 2026년 3월 28일, 버튼, 이중 탭하여 날짜 선택" |
| **VoiceOver (Calendar)** | 각 날짜: "3월 28일 토요일", 선택 시 "선택됨" 추가 |
| **터치 타겟** | 칩: 34pt (44pt 미만 — 주변 공간으로 히트 영역 확장 필요) |
| **터치 타겟 (Calendar)** | 날짜 셀: 44 × 44pt (Apple HIG 충족) |
| **Dynamic Type** | 칩 텍스트, 날짜 텍스트 크기 조정 |
| **색상 대비** | 칩 텍스트 vs 배경: WCAG AA (4.5:1+) |
| **색상 대비 (활성 칩)** | 흰 텍스트 vs blue 배경: ~4.6:1 (AA 충족) |
| **Reduce Motion** | wheel snap 즉시, 월 전환 crossfade |
| **Bold Text** | 오늘 날짜 Bold 자동 대응 |
| **키보드 탐색** | 화살표 키로 날짜 이동, Enter로 선택 |

---

## 구현 체크리스트

- [ ] UIKit: `UIDatePicker` with `preferredDatePickerStyle` (`.inline` / `.compact` / `.wheels`)
- [ ] SwiftUI: `DatePicker` with `datePickerStyle` (`.graphical` / `.compact` / `.wheel`)
- [ ] Locale 설정 (날짜/시간 형식)
- [ ] 최소/최대 날짜 제한 (`minimumDate` / `maximumDate`)
- [ ] 시간 간격 설정 (`minuteInterval`: 1, 5, 15, 30)
- [ ] 종일 토글 시 시간 컴포넌트 숨김/표시
- [ ] Light/Dark 모드 색상 토큰
- [ ] Inline 확장/축소 애니메이션
- [ ] Wheel 햅틱 피드백
- [ ] 캘린더 월 전환 애니메이션
- [ ] VoiceOver: adjustable trait (Wheel), 날짜 읽기 (Calendar)
- [ ] Dynamic Type 대응
- [ ] Reduce Motion 대응

---

## 관련 화면

| 화면 | 관계 |
|------|------|
| `list.md` | 리스트 행 내 인라인 Picker 배치 |
| `sheet-form.md` | Sheet 폼 내 Compact Picker 사용 |
| `keyboard.md` | 시간 입력 대안 (직접 타이핑) |
| `color-picker.md` | 유사 Picker 인터랙션 패턴 (슬라이더/그리드) |
