# Text Fields — iOS 26 페이지 레시피

> **References**
> - Components: `../../components/specs/text-field.md`, `../../components/specs/keyboards.md`
> - Tokens: `../../tokens/`
> - Sections: `../../sections/`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="5433:20204")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Text Field Variants |
| **디바이스** | iPhone 17 Pro, 402 × 874pt |
| **용도** | 사용자 텍스트 입력 — 로그인, 가입, 검색, 메모 작성 |
| **상태 수** | Empty, Focused, Filled, Error, Disabled |
| **iOS 26 특이사항** | 포커스 시 파란 2pt 테두리, 키보드 슬라이드업 연동 |

이 페이지는 Text Field의 4가지 variant를 보여준다: Plain, Secure (비밀번호), Search, Multiline. 각각 다른 사용 컨텍스트에서의 외관과 동작을 설명한다.

---

## 화면 구성 분해

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41          ⠿ ▐▌ ■               │  ← Status Bar (54pt)
├─────────────────────────────────────────────┤
│                                              │
│  계정                                        │  ← Large Title (34pt)
│                                              │
│  ╔═══════════════════════════════════════╗  │  ← Section: "로그인 정보"
│  ║                                       ║  │
│  ║  이메일                                ║  │  ← Label (subheadline 15pt)
│  ║  ┌───────────────────────────────┐    ║  │  ← Plain TextField
│  ║  │ user@example.com          ⓧ  │    ║  │    height: 44pt
│  ║  └───────────────────────────────┘    ║  │    border: 2pt blue (focused)
│  ║                                       ║  │
│  ║  비밀번호                              ║  │  ← Label
│  ║  ┌───────────────────────────────┐    ║  │  ← Secure TextField
│  ║  │ ••••••••••••              👁  │    ║  │    secureTextEntry: true
│  ║  └───────────────────────────────┘    ║  │    toggle visibility icon
│  ║                                       ║  │
│  ╚═══════════════════════════════════════╝  │
│                                              │
│  ╔═══════════════════════════════════════╗  │  ← Section: "검색"
│  ║  ┌───────────────────────────────┐    ║  │  ← Search TextField
│  ║  │ 🔍 검색어를 입력하세요          │    ║  │    leading icon: magnifying glass
│  ║  └───────────────────────────────┘    ║  │    radius: 10pt
│  ╚═══════════════════════════════════════╝  │
│                                              │
│  ╔═══════════════════════════════════════╗  │  ← Section: "메모"
│  ║  ┌───────────────────────────────┐    ║  │  ← Multiline (TextEditor)
│  ║  │ 메모를 입력하세요...            │    ║  │    minHeight: 88pt (~4 lines)
│  ║  │                                │    ║  │    expandable
│  ║  │                                │    ║  │
│  ║  │                                │    ║  │
│  ║  └───────────────────────────────┘    ║  │
│  ║  0/500                                ║  │  ← Counter (caption2 11pt)
│  ╚═══════════════════════════════════════╝  │
│                                              │
│  ╔═══════════════════════════════════════╗  │  ← Error state example
│  ║  전화번호                              ║  │
│  ║  ┌───────────────────────────────┐    ║  │  ← Error TextField
│  ║  │ abc                        ⓧ  │    ║  │    border: 2pt red
│  ║  └───────────────────────────────┘    ║  │    shake animation
│  ║  올바른 전화번호를 입력하세요           ║  │  ← Error message (12pt, red)
│  ╚═══════════════════════════════════════╝  │
│                                              │
│┌─────────────────────────────────────────────┐
││ q  w  e  r  t  y  u  i  o  p              ││  ← Keyboard
││ a  s  d  f  g  h  j  k  l                 ││    slideUp: 0.25s
││ ⇧ z  x  c  v  b  n  m  ⌫                 ││
││ 123  🌐  ␣ space ␣          return         ││
│└─────────────────────────────────────────────┘
└─────────────────────────────────────────────┘
```

---

## Variant 상세

### 1. Plain Text Field

| 속성 | 값 | 토큰 |
|------|-----|------|
| 높이 | 44pt | `text-field.md > 2. Dimensions` |
| 가로 패딩 | 12pt | — |
| 세로 패딩 | 11pt | — |
| Corner radius | 10pt | `spacing.json > radius.md` |
| Border (기본) | 0.5pt | — |
| Border (포커스) | 2pt | — |
| Border color (기본) | `rgba(60,60,67,0.29)` / `rgba(235,235,245,0.30)` | `colors.json > miscellaneous.textField.outline` |
| Border color (포커스) | `#0088ff` / `#0091ff` | `colors.json > accents.blue` |
| 배경 | `#f2f2f7` / `#1c1c1e` | `colors.json > backgrounds.secondary` |

### 2. Secure Text Field

| 속성 | 값 |
|------|-----|
| 기본 동작 | 입력 문자 → 0.3초 후 dot(•)으로 마스킹 |
| Toggle 아이콘 | SF Symbol `eye` / `eye.slash` |
| 아이콘 크기 | 17pt |
| 아이콘 색상 | `labels.tertiary` |
| `textContentType` | `.password` (자동완성 지원) |
| `autocorrectionType` | `.no` |

### 3. Search Text Field

| 속성 | 값 |
|------|-----|
| Leading 아이콘 | SF Symbol `magnifyingglass`, 17pt |
| 아이콘 색상 | `labels.tertiary` |
| Placeholder | "검색" 또는 커스텀 |
| `returnKeyType` | `.search` |
| Clear 버튼 | 입력 시 trailing에 표시 |

### 4. Multiline (TextEditor)

| 속성 | 값 | 토큰 |
|------|-----|------|
| 최소 높이 | 88pt (~4행) | `text-field.md > 2. Dimensions` |
| 최대 높이 | 제한 없음 (스크롤) | — |
| 가로 패딩 | 12pt | — |
| 세로 패딩 | 11pt | — |
| 스크롤 | 내용 초과 시 자동 | — |

---

## Typography

| 요소 | Style | Size | Weight | Letter Spacing | 토큰 |
|------|-------|------|--------|---------------|------|
| 입력 텍스트 | Body | 17pt | Regular | -0.43 | `typography.json > styles.body` |
| Placeholder | Body | 17pt | Regular | -0.43 | — |
| 상단 레이블 | Subheadline | 15pt | Regular | -0.23 | `typography.json > styles.subheadline` |
| 에러/힌트 메시지 | Caption1 | 12pt | Regular | 0 | `typography.json > styles.caption1` |
| 카운터 | Caption2 | 11pt | Regular | 0.06 | `typography.json > styles.caption2` |

---

## Color Tokens

### 텍스트 색상

| 역할 | Light | Dark | 토큰 |
|------|-------|------|------|
| 입력 텍스트 | `#000000` | `#ffffff` | `labels.primary` |
| Placeholder | `rgba(60,60,67,0.3)` | `rgba(235,235,245,0.3)` | `labels.tertiary` |
| Disabled | `labels.tertiary` + 50% opacity | — | — |
| 에러 메시지 | `#ff383c` | `#ff4245` | `accents.red` |
| 보조 레이블 | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.7)` | `labels.secondary` |

### Clear 버튼

| 속성 | 값 |
|------|-----|
| 아이콘 | SF Symbol `xmark.circle.fill` |
| 크기 | 17pt |
| 색상 | `labels.tertiary` |
| 출현 | fade in 0.1s |
| 위치 | trailing edge - 12pt |

---

## Validation States

### Error State

```yaml
trigger: 유효성 검사 실패
border_color: accents.red (#ff383c / #ff4245)
border_width: 2pt
shake_animation:
  keyframes:
    0%:   translateX(0)
    15%:  translateX(-6px)
    30%:  translateX(6px)
    45%:  translateX(-4px)
    60%:  translateX(4px)
    75%:  translateX(-2px)
    90%:  translateX(2px)
    100%: translateX(0)
  duration: 0.4s
  easing: linear
error_message:
  text: "올바른 값을 입력하세요"
  style: caption1 (12pt)
  color: accents.red
  margin_top: 4pt
  margin_left: 12pt
```

### 포커스 전환 애니메이션

```yaml
focus_in:
  border_color: separator → accents.blue
  border_width: 0.5pt → 2pt
  duration: 0.2s
  easing: easeOut  # cubic-bezier(0.0, 0, 0.58, 1.0)
  keyboard_slide: 0.25s  # animations.json > duration.semantic.keyboardSlide

focus_out:
  border_color: accents.blue → separator
  border_width: 2pt → 0.5pt
  duration: 0.2s
  easing: easeOut
```

---

## Keyboard Attachment

| 속성 | 값 |
|------|-----|
| 슬라이드 duration | 0.25s |
| 슬라이드 easing | 시스템 키보드 커브 |
| 자동 스크롤 | 키보드에 의해 가려지면 ScrollView 자동 조정 |
| Dismiss mode | `.interactive` (아래 드래그로 키보드 내림) |
| Input accessory | 선택적 (Done 버튼, 포맷 버튼 등) |

---

## Light / Dark 모드 차이

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| 배경 | `#f2f2f7` | `#1c1c1e` |
| Border (기본) | `rgba(60,60,67,0.29)` | `rgba(235,235,245,0.30)` |
| Border (포커스) | `#0088ff` | `#0091ff` |
| Border (에러) | `#ff383c` | `#ff4245` |
| 입력 텍스트 | `#000000` | `#ffffff` |
| Placeholder | `rgba(60,60,67,0.3)` | `rgba(235,235,245,0.3)` |
| 키보드 스타일 | `.light` | `.dark` |

---

## 인터랙션 노트

### 포커스 시퀀스
1. 필드 탭 → 0ms: `becomeFirstResponder()`
2. 0~25ms: border crossfade (separator → blue)
3. 0~250ms: 키보드 슬라이드업
4. 가려지는 경우: 자동 스크롤

### Clear 버튼
- 텍스트가 1자 이상 입력되면 trailing edge에 clear 버튼 표시
- 탭 시 텍스트 전체 삭제 + 포커스 유지

### Return Key 동작
- `.next`: 다음 필드로 포커스 이동
- `.done`: 키보드 닫기
- `.search`: 검색 실행
- `.send`: 메시지 전송

---

## 접근성 고려사항

| 항목 | 요구사항 |
|------|---------|
| accessibilityLabel | 연결된 레이블 또는 placeholder |
| accessibilityHint | 입력 형식 가이드 ("이메일 주소를 입력하세요") |
| accessibilityValue | 현재 입력된 텍스트 |
| keyboardType | 내용에 맞는 키보드 (.emailAddress, .numberPad, .URL) |
| textContentType | 자동완성 지원 (.emailAddress, .password, .name) |
| VoiceOver 에러 | 에러 발생 시 `UIAccessibility.post(notification: .announcement)` |
| Dynamic Type | 모든 텍스트 Dynamic Type 지원 (Body 17pt 기준) |
| Reduce Motion | shake 애니메이션 비활성화, 에러 표시만 |
| 최소 높이 | 44pt (터치 타겟) |
| 안전한 비밀번호 | Secure field에서 autocapitalization/autocorrection 비활성화 |
