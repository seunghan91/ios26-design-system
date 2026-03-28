# Action Sheet — iPhone Full-Screen Example

> **References**
> - Components: `../../components/specs/action-sheets.md`
> - Tokens: `../../tokens/colors.json`, `../../tokens/spacing.json`, `../../tokens/typography.json`, `../../tokens/animations.json`, `../../tokens/materials.json`
> - Sections: `../../sections/`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24669")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Action Sheet (확인 대화상자) |
| **디바이스** | iPhone 17 Pro — 402 × 874pt (@3x, 1206 × 2622px) |
| **용도** | 현재 컨텍스트에서 수행 가능한 액션 중 하나를 선택 |
| **트리거** | 버튼 탭, 길게 누르기 후속 액션, 위험 동작 확인 |
| **프레젠테이션** | 하단 슬라이드 업 오버레이 (modal) |
| **iOS 26 특이사항** | Liquid Glass 반투명 배경, 본체/Cancel 분리 카드, spring 애니메이션 |

Action Sheet는 사용자에게 2개 이상의 선택지를 제시하고 하나를 고르게 하는 하단 모달이다. Destructive(위험) 액션은 빨간색으로 강조되며, Cancel 버튼은 본체와 8pt 간격으로 분리된 독립 카드다.

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

## 화면 구성 분해

### 전체 레이아웃 (ASCII 와이어프레임)

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │  ← Status Bar (59pt)
│                                              │
│  ┌──────────────────────────────────────────┐│
│  │                                          ││  ← Dimming Overlay
│  │     (이전 화면이 반투명하게 비침)          ││    overlays.default
│  │                                          ││    Light: rgba(0,0,0,0.2)
│  │                                          ││    Dark:  rgba(0,0,0,0.48)
│  │                                          ││
│  │                                          ││
│  │                                          ││
│  └──────────────────────────────────────────┘│
│                                              │
│  ← 16pt → ┌──── Action Sheet Body ────┐ ← 16pt
│            │                            │     ← cornerRadius: 14pt
│            │    이 사진을 삭제할까요?     │     ← Title (Subheadline/Semibold)
│            │    삭제하면 복구할 수 없습니다.│     ← Message (Footnote/Regular)
│            ├────────────────────────────┤     ← separator (nonOpaque)
│            │       다른 곳에 저장         │     ← Action (Body/Regular, 57pt)
│            ├────────────────────────────┤     ← separator
│            │     ⛔ 사진 삭제            │     ← Destructive (Body/Regular, red, 57pt)
│            └────────────────────────────┘     ← Liquid Glass 배경
│                         ↕ 8pt gap
│  ← 16pt → ┌────────────────────────────┐ ← 16pt
│            │        **취소**             │     ← Cancel (Body/Semibold, 57pt)
│            └────────────────────────────┘     ← 별도 Liquid Glass 카드
│                         ↕ 8pt bottom padding
│  ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔│  ← Home Indicator (34pt safe area)
└─────────────────────────────────────────────┘
```

### 치수 계산 (402pt 화면 기준)

```
Sheet 너비         = 402 - 16 × 2 = 370pt
Title 패딩 Top     = 16pt
Title 패딩 Bottom  = 16pt
Title 패딩 H       = 16pt
Action 높이        = 57pt (각)
Cancel 높이        = 57pt
Cancel Gap         = 8pt
Bottom Padding     = 8pt
Safe Area Bottom   = 34pt

총 시트 영역 높이 (Title + Message + 2 Actions):
  = 16 + 20 + 4 + 18 + 16 + 57 + 57 = ~188pt (본체)
  + 8 + 57 = 65pt (Cancel 카드)
  + 8 + 34 = 42pt (하단 여백 + safe area)
총 점유 높이 ≈ 295pt (화면 하단 ~34%)
```

---

## 컴포넌트별 토큰 참조

### Dimming Overlay

| 역할 | 토큰 | Light | Dark |
|------|------|-------|------|
| 배경 | `colors.overlays.default` | `rgba(0,0,0,0.2)` | `rgba(0,0,0,0.48)` |
| 탭 동작 | — | Sheet dismiss | Sheet dismiss |

### Action Sheet Body (본체 카드)

| 역할 | 토큰 | Light | Dark |
|------|------|-------|------|
| 배경 | Liquid Glass | `rgba(250,250,250,0.72)` | `rgba(28,28,30,0.82)` |
| Blur | backdrop-filter | `blur(20px) saturate(180%)` | `blur(20px) saturate(150%)` |
| cornerRadius | `spacing.radius.semantic.actionSheet` | 14pt | 14pt |
| 너비 | 화면 - 32pt | 370pt | 370pt |

### Title (선택 사항)

| 역할 | 토큰 | Light | Dark |
|------|------|-------|------|
| 색상 | `colors.labels.secondary` | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.7)` |
| 타이포 | `typography.styles.subheadline` | 15pt, Semibold | 15pt, Semibold |
| 정렬 | center | — | — |
| 패딩 | 16pt (상하좌우) | — | — |

### Message (선택 사항)

| 역할 | 토큰 | Light | Dark |
|------|------|-------|------|
| 색상 | `colors.labels.secondary` | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.7)` |
| 타이포 | `typography.styles.footnote` | 13pt, Regular | 13pt, Regular |
| 간격 (Title → Message) | — | 4pt | 4pt |

### Action Buttons

| 역할 | 토큰 | Light | Dark |
|------|------|-------|------|
| 텍스트 색상 (기본) | `colors.labels.primary` | `#000000` | `#ffffff` |
| 텍스트 색상 (Destructive) | `colors.accents.red` | `#ff383c` | `#ff4245` |
| 타이포 | `typography.styles.body` | 17pt, Regular | 17pt, Regular |
| 높이 | — | 57pt | 57pt |
| 구분선 | `colors.separators.nonOpaque` | `rgba(0,0,0,0.12)` | `rgba(255,255,255,0.17)` |
| Pressed 배경 | `colors.fills.tertiary` | `rgba(118,118,128,0.12)` | `rgba(118,118,128,0.24)` |

### Cancel Button (별도 카드)

| 역할 | 토큰 | Light | Dark |
|------|------|-------|------|
| 텍스트 색상 | `colors.labels.primary` | `#000000` | `#ffffff` |
| 텍스트 굵기 | `typography.styles.body` (Semibold) | 17pt, **Semibold** | 17pt, **Semibold** |
| 배경 | Liquid Glass (본체와 동일) | — | — |
| cornerRadius | 14pt | — | — |
| 본체와 간격 | 8pt | — | — |

---

## Light/Dark 모드 차이

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| Dimming 오버레이 | `rgba(0,0,0,0.2)` | `rgba(0,0,0,0.48)` |
| 카드 배경 | `rgba(250,250,250,0.72)` + blur 20px | `rgba(28,28,30,0.82)` + blur 20px |
| 제목/메시지 | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.7)` |
| 일반 액션 텍스트 | `#000000` | `#ffffff` |
| Destructive 텍스트 | `#ff383c` | `#ff4245` |
| Cancel 텍스트 | `#000000` (Semibold) | `#ffffff` (Semibold) |
| 구분선 | `rgba(0,0,0,0.12)` | `rgba(255,255,255,0.17)` |
| Pressed 상태 | `rgba(118,118,128,0.12)` | `rgba(118,118,128,0.24)` |
| Status Bar | `.darkContent` | `.lightContent` |

---

## 애니메이션

### Present (등장)

```yaml
trigger: Action Sheet 표시 요청
duration: 0.45s
spring:
  stiffness: 280
  damping: 36
  css_approx: cubic-bezier(0.34, 1.56, 0.64, 1.0)
properties:
  body_translateY: 100% → 0%
  liquidGlass_blur: 0 → 20px (점진적 frosting)
overlay:
  opacity: 0 → 1
  duration: 0.35s
  easing: easeOut — cubic-bezier(0, 0, 0.58, 1.0)
cancel_card:
  translateY: 100% → 0%
  delay: 0.04s  # 본체보다 40ms 늦게 (스태거 효과)
```

### Dismiss (퇴장)

```yaml
trigger: 버튼 탭 / Cancel 탭 / 배경 탭
duration: 0.3s
easing: easeIn — cubic-bezier(0.42, 0, 1.0, 1.0)
properties:
  translateY: 0% → 100%
overlay:
  opacity: 1 → 0
  duration: 0.25s
```

### Reduce Motion

```yaml
prefers-reduced-motion:
  translateY: 비활성화 (움직임 없음)
  opacity: 0 → 1 (fade only, 0.2s)
  spring: easeOut로 대체
```

---

## 인터랙션 노트

| 인터랙션 | 동작 |
|---------|------|
| **일반 액션 탭** | 해당 액션 실행 → Sheet dismiss |
| **Destructive 액션 탭** | 위험 동작 실행 → Sheet dismiss |
| **Cancel 탭** | 아무 동작 없이 Sheet dismiss |
| **배경 Dimming 탭** | Cancel과 동일 (Sheet dismiss) |
| **버튼 Press (down)** | `fills.tertiary` 배경 오버레이 (즉시) |
| **버튼 Release** | 배경 오버레이 제거 (0.1s fade) |
| **VoiceOver Escape** | 두 손가락 Z제스처 → Cancel 동작 |
| **외부 키보드 Escape** | Cancel 동작 |

---

## 접근성 (Accessibility)

| 항목 | 요구사항 |
|------|---------|
| **VoiceOver role** | 컨테이너: `UIAccessibilityTraitNone` + modal context |
| **VoiceOver 포커스** | Sheet 등장 시 → 첫 번째 액션 버튼으로 포커스 이동 |
| **버튼 역할** | 각 버튼: `accessibilityTraits: .button` |
| **Destructive 안내** | VoiceOver가 "삭제, 버튼" 읽음 — 레이블에 위험성 명시 권장 |
| **Cancel** | 항상 접근 가능, ESC 키 → Cancel 트리거 |
| **Dimming 배경** | `isAccessibilityElement = false` (탐색 제외) |
| **터치 타겟** | 57pt 높이 — Apple HIG 44pt 초과 |
| **Dynamic Type** | Body 텍스트 스타일 → `.accessibilityLarge` 지원. 텍스트 증가 시 높이 자동 확장 |
| **색상 대비** | 일반 텍스트 vs Liquid Glass 배경: 4.5:1 이상 (WCAG AA) |
| **색상 대비 (Destructive)** | `#ff383c` vs 흰 배경: ~4.0:1 (AA Large 충족) |
| **Reduce Motion** | 슬라이드 → fade only |
| **키보드 탐색** | Tab: 액션 간 이동, Space/Enter: 선택, Escape: Cancel |
| **Smart Invert** | Liquid Glass 배경은 반전 제외 |

---

## Variant 예시

### Variant 1: 기본 (액션만)

```
┌────────────────────────────┐
│       공유하기               │  ← 57pt, Body/Regular
├────────────────────────────┤
│       복사하기               │  ← 57pt
└────────────────────────────┘
         ↕ 8pt
┌────────────────────────────┐
│       **취소**              │  ← 57pt, Body/Semibold
└────────────────────────────┘
```

### Variant 2: Title + Destructive

```
┌────────────────────────────┐
│   이 사진을 삭제할까요?      │  ← Title: Subheadline/Semibold
│   삭제하면 복구할 수 없습니다.│  ← Message: Footnote/Regular
├────────────────────────────┤
│       다른 곳에 저장         │  ← 57pt, 일반 액션
├────────────────────────────┤
│     ⛔ 사진 삭제            │  ← 57pt, accents.red
└────────────────────────────┘
         ↕ 8pt
┌────────────────────────────┐
│       **취소**              │
└────────────────────────────┘
```

### Variant 3: Title만

```
┌────────────────────────────┐
│   정렬 순서 선택             │  ← Title only
├────────────────────────────┤
│       이름순                 │
├────────────────────────────┤
│       날짜순                 │
├────────────────────────────┤
│       크기순                 │
└────────────────────────────┘
         ↕ 8pt
┌────────────────────────────┐
│       **취소**              │
└────────────────────────────┘
```

---

## 구현 체크리스트

- [ ] UIKit: `UIAlertController(preferredStyle: .actionSheet)` 사용
- [ ] SwiftUI: `.confirmationDialog()` 사용
- [ ] Destructive 액션에 `.destructive` style/role 설정
- [ ] Cancel 항상 포함 (사용자 탈출구)
- [ ] iPad: `popoverPresentationController` 필수 설정 (미설정 시 크래시)
- [ ] Light/Dark Liquid Glass 소재 올바르게 적용
- [ ] 등장 spring 애니메이션 (stiffness 280, damping 36)
- [ ] Cancel 카드 40ms 지연 스태거 효과
- [ ] Reduce Motion → fade only
- [ ] VoiceOver 포커스 순서 검증
- [ ] Dynamic Type 대응 (높이 자동 확장)

---

## 관련 화면

| 화면 | 관계 |
|------|------|
| `alert-flow.md` | Alert vs Action Sheet 선택 기준 |
| `activity-view.md` | 유사 바텀 시트 패턴 |
| `context-menu.md` | Long press 대안 (선택지 제공) |
