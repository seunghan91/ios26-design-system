# iPad Menus — iOS 26 iPad 페이지 레시피

> **References**
> - Templates: `../../templates/`
> - Components: `../../components/specs/menus.md`
> - Tokens: `../../tokens/`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24676")`

---

## 화면 개요

iPad에서 Menu는 2가지 주요 variant로 사용된다: **Edit Menu(텍스트 선택 메뉴)**와 **Menu + Submenu(드롭다운 중첩 메뉴)**. 두 메뉴 모두 Liquid Glass 소재를 배경으로 사용하며, iPad에서는 **Pointer hover 상태**와 **키보드 단축키**가 추가된다. Context Menu와 달리 Preview 없이 즉시 등장한다.

| 항목 | 값 |
|------|-----|
| **적용 디바이스** | iPad Pro 13" (1210x834pt landscape) |
| **Edit Menu** | 텍스트 선택 시 floating bar 형태 |
| **Dropdown Menu** | 버튼 탭 시 Liquid Glass 드롭다운 |
| **배경 소재** | Liquid Glass (`materials.json` > `liquidGlass.regular.small`) |
| **트리거** | 텍스트 선택 (Edit Menu) / 버튼 탭 (Dropdown Menu) |

---

## Device Context

```
iPad Pro 13" Landscape
─────────────────────────────
화면 크기      : 1210 x 834pt
Safe Area Top  : 24pt           ← spacing.json > safeArea.ipadLandscape.top
Safe Area Bot  : 20pt           ← spacing.json > safeArea.ipadLandscape.bottom
Content Margin : 20pt           ← spacing.json > contentMargin.ipad.horizontal
```

---

## Variant 1: Edit Menu (텍스트 선택 메뉴)

### 전체 화면 레이아웃

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           STATUS BAR (24pt)                                     │
├─────────────────────────────────────────────────────────────────────────────────┤
│  NAVIGATION BAR (Liquid Glass, 44pt)                                            │
│  [< 뒤로]    [메모]                                              [공유] [⋯]   │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│  CONTENT AREA                                                                   │
│                                                                                 │
│  Lorem ipsum dolor sit amet, consectetur                                        │
│  adipiscing elit. Sed do eiusmod tempor                                         │
│  incididunt ut labore et dolore magna                                           │
│                                                                                 │
│       ┌──────────────────────────────────────────────────────┐                 │
│       │ [잘라내기] [복사] [붙여넣기] [전체선택] [찾아보기] [›] │  ← Edit Menu  │
│       └──────────────────────────────────────────────────────┘                 │
│                        ▼ arrow (선택 텍스트 방향)                               │
│  aliqua. ████████████████████████████████                                       │
│  ████████████████████████████████████████                                       │
│  Ut enim ad minim veniam, quis nostrud                                          │
│  exercitation ullamco laboris nisi ut                                            │
│  aliquip ex ea commodo consequat.                                               │
│                                                                                 │
│                                                                                 │
│                                                                                 │
├─────────────────────────────────────────────────────────────────────────────────┤
│  TOOLBAR-BOTTOM (44pt, Liquid Glass)                                            │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### Edit Menu 상세 치수

```
┌──────────────────────────────────────────────────────────────────────┐
│  [잘라내기]  │  [복사]  │  [붙여넣기]  │  [전체선택]  │  [찾아보기]  │  [›]  │
└──────────────────────────────────────────────────────────────────────┘
  ↑ Liquid Glass small 배경
  ↑ cornerRadius: 8pt (pill 형태)
  ↑ shadow: blur 40pt
```

| 속성 | 값 | 토큰 |
|------|-----|------|
| Height | `44pt` | `spacing.json` > `components.touchTarget.minimum` |
| Corner Radius | `8pt` | `spacing.json` > `radius.sm` |
| Background | Liquid Glass small | `materials.json` > `liquidGlass.regular.small` |
| Frost Radius | `7pt` | `materials.json` > `liquidGlass.regular.small.frostRadius` |
| Item Padding Horizontal | `12pt` | `spacing.json` > `inset.sm` |
| Item Font | callout/Regular (16pt) | `typography.json` > `styles.callout` |
| Item Color | labels.primary | `colors.json` > `labels.primary` |
| Separator | `1pt` vertical | `colors.json` > `separators.nonOpaque` |
| Arrow | 선택 텍스트 방향, `6pt` | 시스템 기본 |
| Overflow Indicator | `›` (더 많은 항목) | labels.secondary |

### Edit Menu 항목

| 항목 | 키보드 단축키 | 조건 |
|------|-------------|------|
| 잘라내기 (Cut) | `Cmd+X` | 텍스트 선택 + 편집 가능 |
| 복사 (Copy) | `Cmd+C` | 텍스트 선택 |
| 붙여넣기 (Paste) | `Cmd+V` | 클립보드에 내용 있음 |
| 전체 선택 (Select All) | `Cmd+A` | 항상 |
| 찾아보기 (Look Up) | — | 텍스트 선택 |
| 번역 (Translate) | — | 텍스트 선택 |
| 공유 (Share) | — | 텍스트 선택 |

### Edit Menu 위치 규칙

```
기본: 선택 텍스트 위에 표시 (arrow down)
텍스트가 화면 상단 근처: 선택 텍스트 아래에 표시 (arrow up)
텍스트가 좌측 치우침: 메뉴를 우측으로 오프셋
텍스트가 우측 치우침: 메뉴를 좌측으로 오프셋
화면 가장자리에서 최소 8pt 여백 유지
```

---

## Variant 2: Menu and Submenu (중첩 드롭다운)

### 전체 화면 레이아웃

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           STATUS BAR (24pt)                                     │
├─────────────────────────────────────────────────────────────────────────────────┤
│  NAVIGATION BAR (Liquid Glass, 44pt)                                            │
│  [< 뒤로]    [문서]                           [정렬↕] [필터🔽] [⋯ 더보기]      │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│                                                   ┌─────────────────────────┐  │
│                                                   │  MENU (250pt)            │  │
│                                                   │  Liquid Glass BG         │  │
│  CONTENT AREA                                     │                          │  │
│                                                   │  📅 날짜순          ✓   │  │
│                                                   │  ──────────────────────  │  │
│                                                   │  📝 이름순              │  │
│                                                   │  ──────────────────────  │  │
│                                                   │  📊 크기순              │  │
│                                                   │  ──────────────────────  │  │
│                                                   │  📁 종류별         ›    │──┐│
│                                                   │  ──────────────────────  │  ││
│                                                   │  🔄 역순 정렬           │  ││
│                                                   └─────────────────────────┘  ││
│                                                                                 ││
│                                                     ┌──────────────────────────┘│
│                                                     │  SUBMENU (200pt)         │
│                                                     │  Liquid Glass BG          │
│                                                     │                           │
│                                                     │  📷 이미지               │
│                                                     │  ─────────────────────── │
│                                                     │  📄 문서                 │
│                                                     │  ─────────────────────── │
│                                                     │  🎵 오디오               │
│                                                     │  ─────────────────────── │
│                                                     │  🎬 비디오               │
│                                                     └──────────────────────────┘
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### Menu Card 상세 치수

```
┌───────────────────────────────┐  ← cornerRadius: 13pt
│                               │  ← Liquid Glass medium BG
│  Section Header (선택)        │  ← footnote (13pt), label.tertiary
│  ──────────────────────────  │  ← separator (nonOpaque, 0.5pt)
│  [📅] 날짜순             ✓  │  ← height: 44pt, body (17pt)
│  ──────────────────────────  │     ✓ = accents.blue, checkmark
│  [📝] 이름순                │  ← labels.primary
│  ──────────────────────────  │
│  [📊] 크기순                │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━  │  ← Inline section separator (두꺼운 선)
│  [📁] 종류별            ›   │  ← › 서브메뉴 인디케이터
│  ──────────────────────────  │    labels.tertiary
│  [🔄] 역순 정렬             │
│                               │
└───────────────────────────────┘

Submenu (종류별 ›):
┌──────────────────────────┐
│  [📷] 이미지              │  ← height: 44pt
│  ──────────────────────  │
│  [📄] 문서                │
│  ──────────────────────  │
│  [🎵] 오디오              │
│  ──────────────────────  │
│  [🎬] 비디오              │
└──────────────────────────┘
```

| 속성 | Main Menu | Submenu | 토큰 |
|------|-----------|---------|------|
| Width | `250pt` | `200pt` | menus.md 참조 |
| Corner Radius | `13pt` | `13pt` | `spacing.json` > `radius.semantic.menu` 근사 |
| Item Height | `44pt` | `44pt` | `spacing.json` > `components.listRow.heightRegular` |
| Padding Horizontal | `16pt` | `16pt` | `spacing.json` > `inset.md` |
| Icon Size | `20x20pt` | `20x20pt` | SF Symbol 기본 |
| Icon-Label Gap | `12pt` | `12pt` | `spacing.json` > `scale.3` |
| Background | Liquid Glass medium | Liquid Glass medium | `materials.json` > `liquidGlass.regular.medium` |
| Overlap | — | `4pt` | Main과 겹치는 양 |

### Checkmark / Selection States

| 상태 | 시각적 표현 |
|------|------------|
| **단일 선택 (✓)** | 우측에 checkmark, `accents.blue` |
| **토글 (on/off)** | 우측에 checkmark (on) 또는 없음 (off) |
| **혼합 상태** | `-` dash 표시 (일부 선택) |
| **비활성** | 텍스트 `labels.quaternary`, 탭 불가 |

---

## Component Usage (토큰 참조)

### Edit Menu

| 요소 | Light | Dark | 토큰 |
|------|-------|------|------|
| BG | `rgba(#f7f7f7, 1)` | `rgba(#000000, 0.6)` | `materials.json` > `liquidGlass.regular.small` |
| Border (Light) | `#dddddd` | — | `materials.json` > `liquidGlass.regular.small.light.default.border` |
| Item Label | `#000000` | `#ffffff` | `colors.json` > `labels.primary` |
| Separator | `rgba(#000000, 0.12)` | `rgba(#ffffff, 0.17)` | `colors.json` > `separators.nonOpaque` |
| Shadow | blur 40pt | blur 40pt | `materials.json` > `liquidGlass.regular.small.*.shadow` |

### Dropdown Menu

| 요소 | Light | Dark | 토큰 |
|------|-------|------|------|
| BG | `rgba(#f5f5f5, 0.6)` + frost | `rgba(#000000, 0.6)` + frost + tint | `materials.json` > `liquidGlass.regular.medium` |
| Label Normal | `#000000` | `#ffffff` | `colors.json` > `labels.primary` |
| Label Destructive | `#ff383c` | `#ff4245` | `colors.json` > `accents.red` |
| Checkmark | `#0088ff` | `#0091ff` | `colors.json` > `accents.blue` |
| Icon Default | `#0088ff` | `#0091ff` | `colors.json` > `accents.blue` |
| Chevron (›) | `rgba(#3c3c43, 0.3)` | `rgba(#ebebf5, 0.3)` | `colors.json` > `labels.tertiary` |
| Section Header | `rgba(#3c3c43, 0.3)` | `rgba(#ebebf5, 0.3)` | `colors.json` > `labels.tertiary` |
| Separator | `rgba(#000000, 0.12)` | `rgba(#ffffff, 0.17)` | `colors.json` > `separators.nonOpaque` |
| Hover BG | `rgba(#767680, 0.12)` | `rgba(#767680, 0.24)` | `colors.json` > `fills.tertiary` |

---

## iPad-Specific Adaptations

### Pointer Hover States

| 메뉴 타입 | Hover 동작 |
|---------|------------|
| **Edit Menu** | 각 항목 위에 포인터 → 배경 `fills.tertiary` 하이라이트 |
| **Dropdown Menu** | 항목 hover → `fills.tertiary` 하이라이트 |
| **Submenu (›)** | 항목 hover 0.3초 후 → 서브메뉴 자동 펼침 |
| **Submenu 벗어남** | 포인터가 서브메뉴 밖 0.5초 → 서브메뉴 자동 접힘 |
| **Destructive** | hover → `rgba(accents.red, 0.1)` 배경 |

### Keyboard Shortcuts

| 단축키 | 동작 (Edit Menu) |
|--------|-----------------|
| `Cmd+X` | 잘라내기 |
| `Cmd+C` | 복사 |
| `Cmd+V` | 붙여넣기 |
| `Cmd+A` | 전체 선택 |
| `Cmd+Z` | 실행취소 |
| `Cmd+Shift+Z` | 다시 실행 |

| 단축키 | 동작 (Dropdown Menu) |
|--------|---------------------|
| `Esc` | 메뉴 닫기 |
| `↑` / `↓` | 항목 간 포커스 이동 |
| `Return` | 선택된 항목 실행 |
| `→` | 서브메뉴 펼치기 |
| `←` | 서브메뉴 닫기 |

### Edit Menu iPad 특수 동작

| 기능 | 설명 |
|------|------|
| **3-finger pinch** | 복사 (세 손가락 오므리기) |
| **3-finger spread** | 붙여넣기 (세 손가락 펼치기) |
| **3-finger swipe left** | 실행취소 |
| **3-finger swipe right** | 다시 실행 |
| **Pointer double-click** | 단어 선택 → Edit Menu 표시 |
| **Pointer triple-click** | 문단 선택 → Edit Menu 표시 |

---

## Light / Dark Mode 차이

### Light Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| Edit Menu BG | `#f7f7f7` + shadow | `materials.json` > `liquidGlass.regular.small.light.default` |
| Dropdown BG | `rgba(#f5f5f5, 0.6)` + frost | `materials.json` > `liquidGlass.regular.medium.light` |
| Label | `#000000` | `colors.json` > `labels.primary.light` |
| Hover | `rgba(#767680, 0.12)` | `colors.json` > `fills.tertiary.light` |

### Dark Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| Edit Menu BG | `rgba(#000000, 0.6)` + frost | `materials.json` > `liquidGlass.regular.small.dark.default` |
| Dropdown BG | `rgba(#000000, 0.6)` + frost + tint | `materials.json` > `liquidGlass.regular.medium.dark` |
| Label | `#ffffff` | `colors.json` > `labels.primary.dark` |
| Hover | `rgba(#767680, 0.24)` | `colors.json` > `fills.tertiary.dark` |

---

## Multitasking Considerations

### Split View

- Edit Menu: 텍스트 선택 위치에 표시 (앱 영역 내)
- Dropdown Menu: 트리거 버튼 위치에 표시 (앱 영역 내)
- 메뉴가 앱 경계를 넘지 않도록 자동 조정
- 50/50 Split: 605pt 내 표시 — 250pt 메뉴 문제 없음

### Slide Over

- 320pt: 메뉴 250pt가 화면 대부분 차지
- Edit Menu는 좌우 여백 축소

### Stage Manager

- 각 윈도우 내에서 독립 표시
- 메뉴 밖(다른 윈도우) 클릭 시 메뉴 닫힘

---

## Animation Spec

### Edit Menu 등장

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.15s` | `animations.json` > `duration.fast` 미만 |
| Easing | easeOut | `animations.json` > `easing.easeOut` |
| Scale | `0.9 → 1.0` | 커스텀 |
| Opacity | `0 → 1` | `animations.json` > `transitions.fade.in` |

### Dropdown Menu 등장

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.2s` | `animations.json` > `duration.fast` |
| Easing | spring.snappy | `animations.json` > `easing.spring.snappy` |
| Scale | `0.85 → 1.0` | `animations.json` > `transitions.scale.in` |
| Opacity | `0 → 1` | `animations.json` > `transitions.scale.in` |
| Transform Origin | 트리거 버튼 위치 | 시스템 자동 |

### Submenu 펼침

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.15s` | 커스텀 |
| Easing | easeOut | `animations.json` > `easing.easeOut` |
| Direction | 주 메뉴 옆으로 슬라이드 | 시스템 자동 |
| Opacity | `0 → 1` | 동시 |

### 메뉴 닫힘 (공통)

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.1s` | `animations.json` > `duration.micro` |
| Easing | easeIn | `animations.json` > `easing.easeIn` |
| Scale | `1.0 → 0.95` | 커스텀 |
| Opacity | `1 → 0` | — |

---

## Accessibility

| 항목 | 구현 |
|------|------|
| **VoiceOver** | Edit Menu: "잘라내기, 복사, 붙여넣기..." 항목 읽기 |
| **VoiceOver (Dropdown)** | "메뉴, 날짜순 선택됨, 이름순, 크기순..." |
| **Esc 키** | 메뉴 닫기 |
| **Tab** | 항목 간 포커스 이동 |
| **Reduce Motion** | Scale → 즉시 표시 |
| **Reduce Transparency** | Liquid Glass → 불투명 배경 |
| **Dynamic Type** | 항목 텍스트 크기 증가 → 메뉴 너비 자동 확장 |
| **Touch Target** | 모든 항목 44pt 높이 |
