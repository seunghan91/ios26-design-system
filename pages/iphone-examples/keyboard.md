# Keyboard — iPhone Full-Screen Example

> **References**
> - Components: `../../components/specs/keyboards.md`
> - Tokens: `../../tokens/colors.json`, `../../tokens/spacing.json`, `../../tokens/typography.json`, `../../tokens/animations.json`, `../../tokens/materials.json`
> - Sections: `../../sections/`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24674")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Keyboard (소프트웨어 키보드) |
| **디바이스** | iPhone 17 Pro — 402 × 874pt (@3x, 1206 × 2622px) |
| **용도** | 텍스트 입력을 위한 시스템 소프트웨어 키보드 |
| **트리거** | 텍스트 필드/뷰 포커스 (First Responder) |
| **프레젠테이션** | 화면 하단에서 슬라이드 업 |
| **iOS 26 특이사항** | Liquid Glass 배경, 반투명 키 배경, 블러 처리로 아래 콘텐츠가 비침 |

Keyboard는 시스템이 관리하는 입력 UI로, 5가지 주요 variant를 이 문서에서 다룬다: Text(알파벳), Numeric(숫자), Emoji, Find Bar, Find and Replace.

---

## 디바이스 컨텍스트

```
iPhone 17 Pro
├─ 화면 크기: 402 × 874pt
├─ Safe Area Top: 59pt (Dynamic Island)
├─ Safe Area Bottom: 34pt (Home Indicator)
├─ 키보드 높이 (QWERTY): 216pt + 34pt(safe area) = 250pt
├─ 키보드 높이 (이모지): 258pt + 34pt = 292pt
└─ 콘텐츠 가용 영역: 874 - 59 - 44(NavBar) - 250(KB) = 521pt
```

---

## Variant 1: Text Keyboard (QWERTY 알파벳)

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │  ← Status Bar (59pt)
├─────────────────────────────────────────────┤
│  ← 뒤로          새 메시지           [보내기] │  ← Navigation Bar (44pt)
├─────────────────────────────────────────────┤
│                                              │
│  ┌─ Text Field ──────────────────────────┐  │  ← 입력 필드 (활성)
│  │  메시지를 입력하세요...  |              │  │    커서: accents.blue, 1pt
│  └───────────────────────────────────────┘  │    깜빡임: 0.5s on/off
│                                              │
│  ← 콘텐츠 영역 (키보드에 의해 축소됨) ──────── │
│                                              │
│                                              │
│                                              │
├═══════════════════════════════════════════════┤  ← 키보드 상단 경계
│  ┌─ QuickType Bar ───────────────────────┐  │  ← 예측 입력 바 (44pt)
│  │  "안녕"    "하세요"    "감사합니다"      │  │    Callout 16pt
│  └───────────────────────────────────────┘  │    labels.primary
│                                              │
│  ┌─ Keyboard (216pt) ───────────────────┐  │  ← Liquid Glass 배경
│  │  ┌─┐┌─┐┌─┐┌─┐┌─┐┌─┐┌─┐┌─┐┌─┐┌─┐  │  │    Row 1: Q W E R T Y U I O P
│  │  └─┘└─┘└─┘└─┘└─┘└─┘└─┘└─┘└─┘└─┘  │  │    키 높이: ~42pt
│  │   ┌─┐┌─┐┌─┐┌─┐┌─┐┌─┐┌─┐┌─┐┌─┐   │  │    Row 2: A S D F G H J K L
│  │   └─┘└─┘└─┘└─┘└─┘└─┘└─┘└─┘└─┘   │  │
│  │  ┌──┐┌─┐┌─┐┌─┐┌─┐┌─┐┌─┐┌─┐┌──┐  │  │    Row 3: ⇧ Z X C V B N M ⌫
│  │  └──┘└─┘└─┘└─┘└─┘└─┘└─┘└─┘└──┘  │  │
│  │  ┌───┐┌──┐┌──────────────┐┌──┐┌──┐│  │    Row 4: 123 🌐 [Space] . 확인
│  │  └───┘└──┘└──────────────┘└──┘└──┘│  │
│  └───────────────────────────────────┘  │
│  ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔│  ← Home Indicator (34pt)
└─────────────────────────────────────────────┘
```

### 키보드 치수

| 항목 | 값 | 토큰 |
|------|-----|------|
| 전체 높이 (키보드 본체) | 216pt | — |
| QuickType Bar 높이 | 44pt | — |
| Home Indicator 영역 | 34pt | `spacing.safeArea.iphone16Pro.bottom` |
| 총 점유 높이 | 216 + 44 + 34 = 294pt | — |
| 키 높이 | ~42pt | — |
| 키 간격 | 6pt (수평), 12pt (수직) | — |
| 키 cornerRadius | 5pt | — |
| 키 배경 (Light) | `#ffffff` | `colors.miscellaneous.keyboards.keys.light` |
| 키 배경 (Dark) | `#454545` | `colors.miscellaneous.keyboards.keys.dark` |
| 키보드 배경 | Liquid Glass (반투명 블러) | `materials.liquidGlass` |

---

## Variant 2: Numeric Keyboard (숫자패드)

```
┌─────────────────────────────────────────────┐
│  ← 이전 화면 + 입력 필드 ─────────────────── │
│                                              │
├═══════════════════════════════════════════════┤
│  ┌─ Numeric Keyboard (216pt) ───────────┐  │
│  │                                       │  │
│  │    ┌───┐  ┌───┐  ┌───┐              │  │  ← Row 1: 1  2  3
│  │    │ 1 │  │ 2 │  │ 3 │              │  │
│  │    └───┘  └───┘  └───┘              │  │
│  │    ┌───┐  ┌───┐  ┌───┐              │  │  ← Row 2: 4  5  6
│  │    │ 4 │  │ 5 │  │ 6 │              │  │
│  │    └───┘  └───┘  └───┘              │  │
│  │    ┌───┐  ┌───┐  ┌───┐              │  │  ← Row 3: 7  8  9
│  │    │ 7 │  │ 8 │  │ 9 │              │  │
│  │    └───┘  └───┘  └───┘              │  │
│  │    ┌───┐  ┌───┐  ┌───┐              │  │  ← Row 4: (빈) 0 ⌫
│  │    │   │  │ 0 │  │ ⌫ │              │  │
│  │    └───┘  └───┘  └───┘              │  │
│  └───────────────────────────────────────┘  │
│  ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔│
└─────────────────────────────────────────────┘
```

| 항목 | 값 |
|------|-----|
| 레이아웃 | 3×4 그리드 |
| 키 크기 | ~85 × 46pt (화면 너비 3등분) |
| keyboardType | `.numberPad` |

---

## Variant 3: Emoji Keyboard

```
┌─────────────────────────────────────────────┐
│  ← 이전 화면 ──────────────────────────────── │
│                                              │
├═══════════════════════════════════════════════┤
│  ┌─ Search Bar ──────────────────────────┐  │  ← 🔍 이모지 검색 (36pt)
│  │  🔍 이모지 검색                        │  │
│  └───────────────────────────────────────┘  │
│  ┌─ Category Tabs ───────────────────────┐  │  ← 카테고리 탭 (32pt)
│  │  😀  🐻  🍕  ⚽  🚗  💡  🔣  🏳️    │  │    수평 스크롤
│  └───────────────────────────────────────┘  │
│  ┌─ Emoji Grid (258pt) ─────────────────┐  │  ← 이모지 그리드
│  │  😀 😃 😄 😁 😆 😅 🤣 😂            │  │    셀 크기: ~40pt
│  │  🙂 🙃 🫠 😉 😊 😇 🥰 😍            │  │    8열 그리드
│  │  🤩 😘 😗 ☺️ 😚 😙 🥲 😋            │  │    수직 스크롤
│  │  😛 😜 🤪 😝 🤑 🤗 🤭 🫢            │  │
│  │  ...                                 │  │
│  └───────────────────────────────────────┘  │
│  ┌─ Bottom Bar ──────────────────────────┐  │  ← 하단 바 (44pt)
│  │  [ABC]   [🔍]   [🎤]   [⌫]          │  │    키보드 전환
│  └───────────────────────────────────────┘  │
│  ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔│
└─────────────────────────────────────────────┘
```

| 항목 | 값 |
|------|-----|
| 전체 높이 | 258pt + 34pt = 292pt |
| 이모지 셀 크기 | ~40 × 40pt |
| 열 수 | 8열 (iPhone) |
| 카테고리 | 최근, 스마일, 동물, 음식, 활동, 여행, 사물, 기호, 깃발 |
| 검색 바 | 36pt 높이, 상단 고정 |

---

## Variant 4: Find Bar (검색 바)

```
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │  ← Status Bar
├─────────────────────────────────────────────┤
│  [완료]                                      │  ← Navigation Bar
├─────────────────────────────────────────────┤
│                                              │
│  Lorem ipsum dolor sit amet, consectetur     │  ← 콘텐츠 (하이라이트된 검색 결과)
│  adipiscing elit. [Sed] do eiusmod tempor   │    [Sed] = 노란 하이라이트
│  incididunt ut labore et dolore magna        │    현재 결과: 주황 하이라이트
│  aliqua. Ut enim ad minim veniam.            │
│                                              │
├═══════════════════════════════════════════════┤
│  ┌─ Find Bar (Input Accessory) ──────────┐  │  ← 키보드 위 Find Bar (44pt)
│  │  🔍 [검색어 입력      ] [▲] [▼] [완료] │  │    accents.yellow 하이라이트
│  │     "2/5 결과"                         │  │    ▲▼: 이전/다음 결과
│  └───────────────────────────────────────┘  │
│  ┌─ Keyboard (216pt) ───────────────────┐  │
│  │  ...QWERTY 키보드...                   │  │
│  └───────────────────────────────────────┘  │
│  ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔│
└─────────────────────────────────────────────┘
```

| 항목 | 값 | 토큰 |
|------|-----|------|
| Find Bar 높이 | 44pt | `spacing.components.toolbar.height` |
| 검색 필드 높이 | 36pt | — |
| 결과 하이라이트 (전체) | `accents.yellow` | Light: `#ffcc00`, Dark: `#ffd600` |
| 결과 하이라이트 (현재) | `accents.orange` | Light: `#ff8d28`, Dark: `#ff9230` |
| ▲▼ 버튼 크기 | 44 × 44pt (터치 타겟) | — |
| 완료 버튼 | `accents.blue`, Headline (17pt, Semibold) | — |

---

## Variant 5: Find and Replace

```
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │
├─────────────────────────────────────────────┤
│  [완료]                                      │
├─────────────────────────────────────────────┤
│                                              │
│  Lorem ipsum dolor sit amet...               │
│                                              │
├═══════════════════════════════════════════════┤
│  ┌─ Find & Replace Bar ─────────────────┐  │  ← 2행 Input Accessory (88pt)
│  │  🔍 [검색어 입력       ] [▲][▼][완료] │  │    Row 1: Find (44pt)
│  │  ↻  [대체 텍스트 입력   ] [교체][모두] │  │    Row 2: Replace (44pt)
│  └───────────────────────────────────────┘  │
│  ┌─ Keyboard (216pt) ───────────────────┐  │
│  │  ...QWERTY 키보드...                   │  │
│  └───────────────────────────────────────┘  │
│  ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔│
└─────────────────────────────────────────────┘
```

| 항목 | 값 |
|------|-----|
| Find & Replace Bar 총 높이 | 88pt (44pt × 2행) |
| "교체" 버튼 | `accents.blue`, Body (17pt, Regular) |
| "모두 교체" 버튼 | `accents.blue`, Body (17pt, Regular) |
| 총 키보드 점유 | 88 + 216 + 34 = 338pt |

---

## 공통 토큰 참조

### Keyboard 배경

| 역할 | Light | Dark | 토큰 |
|------|-------|------|------|
| 배경 | Liquid Glass (반투명) | Liquid Glass (반투명) | `materials.liquidGlass` |
| 키 배경 | `#ffffff` (하얀 키) | `#454545` (회색 키) | `colors.miscellaneous.keyboards.keys` |
| 키 텍스트 | `#000000` | `#ffffff` | `colors.labels.primary` |
| 특수 키 배경 (Shift, 123) | `#b0b0b5` (light gray) | `#333333` | — |
| 이모지/마이크 아이콘 | `rgba(34,43,89,0.63)` | `rgba(255,255,255,0.73)` | `colors.miscellaneous.keyboards.emojiMic` |
| 글리프 (Primary) | `#595959` | `#a6a6a6` | `colors.miscellaneous.keyboards.glyphsPrimary` |
| 글리프 (Secondary) | `#b3b3b3` | `#4d4d4d` | `colors.miscellaneous.keyboards.glyphsSecondary` |

### Input Accessory View (Find Bar 등)

| 역할 | Light | Dark |
|------|-------|------|
| 배경 | `backgrounds.secondary` = `#f2f2f7` | `#1c1c1e` |
| 구분선 (상단) | `separators.opaque` = `#c6c6c8` | `#38383a` |
| 텍스트 필드 배경 | `fills.quaternary` | Light: `rgba(116,116,128,0.08)`, Dark: `rgba(118,118,128,0.18)` |

---

## Light/Dark 모드 차이

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| 키보드 배경 | 밝은 Liquid Glass (반투명 밝은 회색) | 어두운 Liquid Glass (반투명 검정) |
| 키 배경 | `#ffffff` | `#454545` |
| 키 텍스트 | `#000000` | `#ffffff` |
| 특수 키 | 밝은 회색 | 어두운 회색 |
| QuickType 텍스트 | `labels.primary` | `labels.primary` |
| Find Bar 배경 | `#f2f2f7` | `#1c1c1e` |
| 키 그림자 | 미세한 drop shadow | 없음 |

---

## 애니메이션

### Keyboard Appear (등장)

```yaml
trigger: 텍스트 필드 포커스 (becomeFirstResponder)
duration: 0.25s
easing: appleEaseOut — cubic-bezier(0, 0, 0.6, 1.0)
properties:
  translateY: 100% → 0% (하단에서 슬라이드 업)
content_adjustment:
  scrollView.contentInset.bottom += keyboardHeight
  duration: 0.25s (키보드와 동기)
```

> 토큰: `animations.duration.semantic.keyboardSlide` = 0.25s

### Keyboard Dismiss (퇴장)

```yaml
trigger: resignFirstResponder / 아래 스와이프
duration: 0.25s
easing: appleEaseIn
properties:
  translateY: 0% → 100%
```

### Keyboard Type 전환

```yaml
trigger: keyboardType 변경 / 언어 전환 / 이모지 전환
duration: 0.15s
easing: easeInOut
properties:
  crossfade (현재 → 새 레이아웃)
```

### Reduce Motion

```yaml
prefers-reduced-motion:
  slide: 비활성화 → 즉시 표시/숨김
  crossfade: 유지 (최소한의 전환)
```

---

## 인터랙션 노트

| 인터랙션 | 동작 |
|---------|------|
| **텍스트 필드 탭** | 키보드 슬라이드 업 + 콘텐츠 인셋 조정 |
| **키 탭** | 문자 입력 + 키 확대 팝업 (알파벳) |
| **키 길게 누르기** | 대체 문자 팝업 (e.g., e → e e e e e) |
| **Space 더블 탭** | 마침표 + 공백 자동 입력 |
| **Shift 탭** | 대문자 모드 토글 |
| **Shift 더블 탭** | Caps Lock 활성화 |
| **123 탭** | 숫자/특수문자 레이아웃 전환 |
| **🌐 탭** | 언어 전환 (설정된 키보드 순환) |
| **🌐 길게 누르기** | 키보드 선택 메뉴 표시 |
| **🎤 탭** | 음성 입력(Dictation) 모드 |
| **아래 스와이프 (키보드 위)** | 키보드 dismiss (scrollView.keyboardDismissMode) |
| **Find Bar ▲▼** | 이전/다음 검색 결과로 스크롤 |

### Safe Area 처리

```
키보드 활성 시:
  콘텐츠 하단 safe area = 키보드 높이 (34pt 포함)
  UIScrollView.contentInset.bottom = keyboardFrame.height
  UIScrollView.scrollIndicatorInsets.bottom = keyboardFrame.height

키보드 비활성 시:
  콘텐츠 하단 safe area = 34pt (Home Indicator)
```

---

## 접근성 (Accessibility)

| 항목 | 요구사항 |
|------|---------|
| **VoiceOver** | 각 키: 문자명 읽기 ("Q", "스페이스", "삭제"), 입력 시 문자 + 단어 읽기 |
| **키보드 탐색** | VoiceOver 사용 시 키별 탐색, 더블 탭으로 입력 |
| **QuickType** | 예측 단어: `accessibilityLabel` 자동 설정 |
| **Find Bar** | 검색 필드: `accessibilityLabel: "검색"`, 결과 수: 자동 안내 |
| **터치 타겟** | 키 높이 ~42pt (44pt 근사), Find 버튼 44pt |
| **Dynamic Type** | QuickType, Find Bar 텍스트 크기 조정 |
| **Bold Text** | 키 레이블 굵기 자동 조정 |
| **Reduce Motion** | 키보드 슬라이드 비활성화 → 즉시 표시 |
| **Switch Control** | 키보드 스캐닝 모드 자동 지원 |
| **Full Keyboard Access** | 외부 키보드로 모든 기능 접근 가능 |

---

## 구현 체크리스트

- [ ] `keyboardType` 올바르게 설정 (`.default`, `.numberPad`, `.emailAddress` 등)
- [ ] `keyboardDismissMode` 설정 (`.interactive` 또는 `.onDrag`)
- [ ] `UIKeyboardWillShowNotification` / `UIKeyboardWillHideNotification` 처리
- [ ] `contentInset` 자동 조정 (키보드 높이만큼)
- [ ] `inputAccessoryView` 설정 (Find Bar, toolbar 등)
- [ ] 키보드 dismiss 제스처 구현 (배경 탭 또는 아래 스와이프)
- [ ] 가로 모드 대응 (높이 162pt)
- [ ] iPad 외부 키보드 연결 시 소프트웨어 키보드 자동 숨김
- [ ] Safe Area 대응 (Home Indicator 영역)
- [ ] VoiceOver 키보드 탐색 검증

---

## 관련 화면

| 화면 | 관계 |
|------|------|
| `sheet-form.md` | Sheet 내부 텍스트 입력 시 키보드 |
| `list.md` | 검색 바에서 키보드 활성화 |
| `menus.md` | 텍스트 선택 메뉴 (Edit Menu) |
