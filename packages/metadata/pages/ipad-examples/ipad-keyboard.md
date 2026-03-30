# iPad Keyboard — iOS 26 iPad 페이지 레시피

> **References**
> - Templates: `../../templates/`
> - Components: `../../components/specs/keyboards.md`
> - Tokens: `../../tokens/`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24674")`

---

## 화면 개요

iPad 소프트웨어 키보드는 iPhone과 크게 다른 2가지 특징을 가진다: **Shortcuts Bar(자동완성/단축키 바)**와 **Split Keyboard(분할 키보드)** 옵션. iPad의 넓은 화면에서 풀사이즈 QWERTY 레이아웃을 제공하며, iOS 26에서는 Liquid Glass 소재가 키보드 배경에 적용된다. 2가지 variant를 다룬다: Full-width Text (소문자/대문자) + Split Keyboard.

| 항목 | 값 |
|------|-----|
| **적용 디바이스** | iPad Pro 13" (1210x834pt landscape) |
| **키보드 variant 수** | 9종 (iPad, Figma 기준) |
| **배경 소재** | Liquid Glass (backdrop-filter: blur + tint) |
| **Shortcuts Bar** | 키보드 상단 44pt, 자동완성 + 도구 |
| **Split Keyboard** | 키보드를 좌/우로 분할 (엄지 입력용) |
| **외장 키보드** | 연결 시 소프트웨어 키보드 숨김, Shortcuts Bar만 유지 가능 |

---

## Device Context

```
iPad Pro 13" Landscape
─────────────────────────────
화면 크기      : 1210 x 834pt
Safe Area Top  : 24pt           ← spacing.json > safeArea.ipadLandscape.top
Safe Area Bot  : 20pt           ← spacing.json > safeArea.ipadLandscape.bottom
키보드 높이    : ~264pt (Shortcuts Bar 포함)
가용 콘텐츠    : 834 - 24 - 264 = 546pt
```

---

## Variant 1: Full-Width Keyboard (Lowercase)

### 전체 화면 레이아웃

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           STATUS BAR (24pt)                                     │
├─────────────────────────────────────────────────────────────────────────────────┤
│  NAVIGATION BAR (Liquid Glass, 44pt)                                            │
│  [< 뒤로]    [메모 편집]                                         [완료]         │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│  CONTENT AREA (가용: ~502pt 높이)                                               │
│                                                                                 │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │  커서가 깜빡이는 텍스트 입력 영역                                        │   │
│  │  Lorem ipsum dolor sit amet, consectetur adipiscing elit.|              │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                 │
├─────────────────────────────────────────────────────────────────────────────────┤
│  SHORTCUTS BAR (44pt)                                                           │
│  [실행취소] [붙여넣기] [자동완성1] [자동완성2] [자동완성3]    [키보드 숨기기 ⌨️] │
├─────────────────────────────────────────────────────────────────────────────────┤
│  KEYBOARD (Liquid Glass background)                                             │
│  height: ~220pt                                                                 │
│                                                                                 │
│   [` ] [1 ] [2 ] [3 ] [4 ] [5 ] [6 ] [7 ] [8 ] [9 ] [0 ] [- ] [= ] [⌫  ]    │
│   [Tab ] [q ] [w ] [e ] [r ] [t ] [y ] [u ] [i ] [o ] [p ] [[ ] [] ] [\ ]    │
│   [Caps ] [a ] [s ] [d ] [f ] [g ] [h ] [j ] [k ] [l ] [; ] [' ] [Return]    │
│   [Shift  ] [z ] [x ] [c ] [v ] [b ] [n ] [m ] [, ] [. ] [/ ] [Shift   ]    │
│   [.?123] [🌐] [Cmd] [______________space______________] [Cmd] [.?123] [⌨️ ]  │
│                                                                                 │
│  Safe Area Bottom: 20pt                                                         │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### Full-Width Keyboard (Uppercase / Caps Lock)

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│  KEYBOARD (Liquid Glass background)                                             │
│                                                                                 │
│   [~ ] [! ] [@ ] [# ] [$ ] [% ] [^ ] [& ] [* ] [( ] [) ] [_ ] [+ ] [⌫  ]    │
│   [Tab ] [Q ] [W ] [E ] [R ] [T ] [Y ] [U ] [I ] [O ] [P ] [{ ] [} ] [| ]    │
│   [CAPS●] [A ] [S ] [D ] [F ] [G ] [H ] [J ] [K ] [L ] [: ] [" ] [Return]   │
│   [Shift  ] [Z ] [X ] [C ] [V ] [B ] [N ] [M ] [< ] [> ] [? ] [Shift   ]    │
│   [.?123] [🌐] [Cmd] [______________space______________] [Cmd] [.?123] [⌨️ ]  │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘

Caps Lock 표시:
  - Shift 키에 ● 인디케이터 (accents.blue 또는 white)
  - 모든 문자 키가 대문자로 표시
```

---

## Variant 2: Split Keyboard

### Split Keyboard 레이아웃

Split Keyboard는 키보드를 화면 좌/우로 분리하여 iPad를 양손으로 들고 엄지로 타이핑할 때 사용한다.

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           STATUS BAR (24pt)                                     │
├─────────────────────────────────────────────────────────────────────────────────┤
│  NAVIGATION BAR (44pt)                                                          │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│  CONTENT AREA (확장됨 — 키보드가 화면 하단을 차지하지 않음)                       │
│                                                                                 │
│  ┌───────────────────────────────────────────────────────────────────────────┐  │
│  │  텍스트 입력 영역                                                         │  │
│  └───────────────────────────────────────────────────────────────────────────┘  │
│                                                                                 │
│                                                                                 │
│                                                                                 │
│                                                                                 │
├────────────────────────────────── ─── ──────────────────────────────────────────┤
│  SHORTCUTS BAR (44pt, 전체 너비)                                                │
│  [실행취소] [붙여넣기] [자동완성]                              [키보드 숨기기 ⌨️]│
├───────────────────────┐                     ┌───────────────────────────────────┤
│  LEFT HALF            │     (빈 공간)       │  RIGHT HALF                       │
│  (Liquid Glass)       │                     │  (Liquid Glass)                   │
│                       │                     │                                   │
│  [q ] [w ] [e ] [r ] [t ]             [y ] [u ] [i ] [o ] [p ]                │
│  [a ] [s ] [d ] [f ] [g ]             [h ] [j ] [k ] [l ] [⌫ ]               │
│  [⇧ ] [z ] [x ] [c ] [v ]             [b ] [n ] [m ] [. ] [↩ ]               │
│  [123] [🌐] [___space___]             [___space___] [123]                      │
│                       │                     │                                   │
└───────────────────────┘                     └───────────────────────────────────┘
```

### Split Keyboard 치수

| 속성 | 값 | 비고 |
|------|-----|------|
| 각 반쪽 너비 | ~340pt | 화면 너비의 ~28% |
| 중앙 간격 | ~530pt | 나머지 공간 |
| 키보드 높이 | ~180pt | Full-width보다 약간 낮음 |
| 세로 위치 | 화면 하단 (기본) | 드래그로 위로 이동 가능 |
| 키 크기 | 일반 키의 ~85% | 엄지 입력 최적화 |

---

## Shortcuts Bar (iPad 전용)

### 구조

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│ [실행취소] [붙여넣기] │ [자동완성 1] │ [자동완성 2] │ [자동완성 3] │   [⌨️ ↓]  │
│  좌측 도구 영역       │        중앙 자동완성 영역          │  키보드 숨기기     │
│  ~ 160pt             │             flex                   │   44pt            │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### Shortcuts Bar 치수

| 속성 | 값 | 토큰 |
|------|-----|------|
| Height | `44pt` | `spacing.json` > `components.toolbar.height` |
| Background | Liquid Glass (키보드와 동일) | `materials.json` > `liquidGlass.regular.medium` |
| Left Tools Width | ~160pt | 커스텀 |
| Autocomplete Item Height | `36pt` | 시스템 기본 |
| Autocomplete Item Padding | `12pt` horizontal | `spacing.json` > `inset.sm` |
| Autocomplete Font | body/Regular (17pt) | `typography.json` > `styles.body` |
| Separator | `1pt` vertical | `colors.json` > `separators.opaque` |
| Hide Keyboard Button | `44x44pt` | `spacing.json` > `components.touchTarget.minimum` |

### Shortcuts Bar 도구 항목

| 도구 | 아이콘 | 설명 |
|------|--------|------|
| 실행취소 (Undo) | `arrow.uturn.backward` | 마지막 입력 취소 |
| 붙여넣기 (Paste) | `doc.on.clipboard` | 클립보드 내용 붙여넣기 |
| 자동완성 1~3 | 텍스트 | 입력 중인 단어의 추천 완성어 |
| 키보드 숨기기 | `keyboard.chevron.compact.down` | 키보드 접기 |

---

## Component Usage (토큰 참조)

### Keyboard Background

| 속성 | 값 | 토큰 |
|------|-----|------|
| Background | Liquid Glass | `materials.json` > `liquidGlass.regular.medium` |
| Frost Radius | `12pt` | `materials.json` > `liquidGlass.regular.medium.frostRadius` |
| Light BG | `rgba(#f5f5f5, 0.6)` | `materials.json` > `liquidGlass.regular.medium.light.bg` |
| Dark BG | `rgba(#000000, 0.6)` | `materials.json` > `liquidGlass.regular.medium.dark.bg` |

### Key Styling

| 속성 | Light | Dark | 토큰 |
|------|-------|------|------|
| Letter Key BG | `#ffffff` (약간 투명) | `rgba(#454545, 0.8)` | 시스템 기본 |
| Special Key BG | `rgba(#767680, 0.12)` | `rgba(#767680, 0.24)` | `colors.json` > `fills.tertiary` |
| Key Label | `#141414` | `#ffffff` | `colors.json` > `miscellaneous.keyboards.keys` 참조 |
| Key Corner Radius | `5pt` | `5pt` | 시스템 기본 |
| Key Shadow | `0 1pt 0 rgba(0,0,0,0.35)` | `0 1pt 0 rgba(0,0,0,0.5)` | 시스템 기본 |
| Key Font | subheadline/Regular (15pt) | — | `typography.json` > `styles.subheadline` |
| Emoji/Mic Key | `rgba(#222b59, 0.63)` | `rgba(#ffffff, 0.73)` | `colors.json` > `miscellaneous.keyboards.emojiMic` |

### Key Sizes (iPad Full-Width, Landscape)

| 키 종류 | 너비 | 높이 | 비고 |
|---------|------|------|------|
| Letter Key | ~52pt | ~44pt | 10열 기준 |
| Number Key | ~52pt | ~38pt | 상단 숫자 행 |
| Space Bar | ~440pt | ~44pt | 중앙 넓은 키 |
| Shift | ~90pt | ~44pt | 좌우 Shift |
| Return | ~80pt | ~44pt | 우측 |
| Backspace | ~70pt | ~44pt | 우측 상단 |
| Tab | ~70pt | ~44pt | 좌측 |
| Caps Lock | ~80pt | ~44pt | 좌측 |

---

## iPad-Specific Adaptations

### iPad vs iPhone 키보드 비교

| 항목 | iPad | iPhone |
|------|------|--------|
| **너비** | 화면 전체 (1210pt) | 화면 전체 (390pt) |
| **행 수** | 5행 (숫자 행 포함) | 4행 (숫자 행 없음) |
| **Tab 키** | 있음 | 없음 |
| **Caps Lock** | 있음 | 없음 (Shift 더블탭으로 대체) |
| **숫자 행** | 상단 별도 행 | 모드 전환 필요 |
| **Shortcuts Bar** | 있음 (44pt) | 없음 |
| **Split Keyboard** | 가능 | 불가 |
| **Undock** | 키보드를 화면 중간으로 이동 가능 | 불가 |

### Pointer Support

| 상호작용 | 동작 |
|---------|------|
| **Hover on Key** | 키 배경 약간 밝아짐 (hover state) |
| **Click** | 탭과 동일 — 문자 입력 |
| **Drag on Space** | 트랙패드로 Space Bar 드래그 → 커서 이동 (trackpad cursor mode) |

### External Keyboard 연결 시

| 상태 | 소프트웨어 키보드 | Shortcuts Bar |
|------|-----------------|--------------|
| 외장 키보드 연결 | 숨김 | 기본 숨김 (설정으로 표시 가능) |
| 외장 키보드 해제 | 자동 표시 | 자동 표시 |
| TextField 포커스 + 외장 | 숨김 유지 | 설정에 따라 표시 |

### Floating Keyboard (미니 키보드)

iPad에서 키보드를 **pinch-in** 하면 iPhone 크기의 미니 키보드로 전환된다.

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                                                                                 │
│  CONTENT AREA (키보드가 작아져서 콘텐츠 가용 영역 확대)                           │
│                                                                                 │
│                                                                                 │
│                                                                                 │
│                                    ┌──────────────────────┐                    │
│                                    │  FLOATING KEYBOARD    │                    │
│                                    │  (~320pt x 216pt)     │                    │
│                                    │  iPhone 크기          │                    │
│                                    │  드래그로 이동 가능    │                    │
│                                    │  Liquid Glass BG      │                    │
│                                    └──────────────────────┘                    │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

| 속성 | 값 |
|------|-----|
| 너비 | ~320pt (iPhone 크기) |
| 높이 | ~216pt |
| 트리거 | Pinch-in 제스처 또는 키보드 축소 버튼 |
| 복원 | Pinch-out 또는 확대 버튼 |
| 이동 | 하단 바를 드래그하여 화면 내 자유 이동 |
| 숫자 행 | 없음 (iPhone 레이아웃) |
| Shortcuts Bar | 없음 |

---

## Light / Dark Mode 차이

### Light Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| Keyboard BG | Liquid Glass light | `materials.json` > `liquidGlass.regular.medium.light` |
| Letter Key BG | `#ffffff` | 시스템 기본 |
| Special Key BG | `rgba(#767680, 0.12)` | `colors.json` > `fills.tertiary.light` |
| Key Label | `#141414` | `colors.json` > `miscellaneous.keyboards.keys.light` |
| Glyph Primary | `#595959` | `colors.json` > `miscellaneous.keyboards.glyphsPrimary.light` |
| Glyph Secondary | `#b3b3b3` | `colors.json` > `miscellaneous.keyboards.glyphsSecondary.light` |

### Dark Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| Keyboard BG | Liquid Glass dark | `materials.json` > `liquidGlass.regular.medium.dark` |
| Letter Key BG | `rgba(#454545, 0.8)` | 시스템 기본 |
| Special Key BG | `rgba(#767680, 0.24)` | `colors.json` > `fills.tertiary.dark` |
| Key Label | `#ffffff` | 시스템 기본 |
| Glyph Primary | `#a6a6a6` | `colors.json` > `miscellaneous.keyboards.glyphsPrimary.dark` |
| Glyph Secondary | `#4d4d4d` | `colors.json` > `miscellaneous.keyboards.glyphsSecondary.dark` |

---

## Multitasking Considerations

### Split View

- 50/50 Split: 각 앱 605pt → 키보드는 해당 앱 너비에 맞춰 축소
- 키보드가 화면 전체가 아닌 **활성 앱 영역**에만 표시될 수 있음 (iPadOS 26)
- 작은 앱: Floating Keyboard가 더 적합

### Slide Over

- Slide Over 앱 (320pt): 자동으로 Floating Keyboard 사용
- 배경 앱의 키보드와 독립

### Stage Manager

- 각 윈도우에서 독립적으로 키보드 표시
- 활성 윈도우의 키보드만 표시
- 윈도우 전환 시 키보드 자동 숨김/표시

---

## Animation Spec

### 키보드 슬라이드 업

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.25s` | `animations.json` > `duration.semantic.keyboardSlide` |
| Easing | appleEaseOut | `animations.json` > `easing.appleEaseOut` |
| From | `translateY(100%)` | 화면 하단 밖 |
| To | `translateY(0)` | 최종 위치 |

### 키보드 슬라이드 다운

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.25s` | `animations.json` > `duration.semantic.keyboardSlide` |
| Easing | appleEaseIn | `animations.json` > `easing.appleEaseIn` |

### Split Keyboard 전환

| 속성 | 값 |
|------|-----|
| Duration | `0.35s` |
| Easing | spring.gentle |
| Animation | 중앙에서 좌/우로 분리 (또는 합체) |

---

## Accessibility

| 항목 | 구현 |
|------|------|
| **VoiceOver** | 키 탐색 모드 — 키 위에 손가락 올리면 읽기, 떼면 입력 |
| **Larger Text** | 키 라벨 크기 증가 (제한적) |
| **Bold Text** | 키 라벨 weight 증가 |
| **Reduce Motion** | 키보드 슬라이드 → 즉시 표시 |
| **Full Keyboard Access** | 외장 키보드로 화면 내 모든 요소 탐색 |
| **Switch Control** | 키 스캔 모드 (행 → 개별 키) |
| **Key Repeat** | 길게 누르면 반복 입력 (Repeat Rate 설정 가능) |
