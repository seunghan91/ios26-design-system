# iPad List — iOS 26 iPad 페이지 레시피

> **References**
> - Templates: `../../templates/`
> - Components: `../../components/specs/list-row.md`, `../../components/specs/sidebars.md`
> - Tokens: `../../tokens/`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="550:50430")`

---

## 화면 개요

iPad에서 List는 iPhone보다 넓은 행(row)과 더 많은 콘텐츠를 한 화면에 표시한다. UISplitViewController와 통합되어 **Sidebar + Detail** 패턴이 표준이며, 선택(selection) 모드와 드래그-앤-드롭을 네이티브로 지원한다. iOS 26에서는 insetGrouped 리스트 배경에 Liquid Glass 소재가 적용된다.

| 항목 | 값 |
|------|-----|
| **적용 디바이스** | iPad Pro 13" (1210x834pt landscape) |
| **리스트 스타일** | `.insetGrouped` (기본), `.sidebar`, `.plain` |
| **Sidebar 통합** | UISplitViewController 2/3-column |
| **Selection Mode** | 단일 선택, 다중 선택 (편집 모드) |
| **Drag & Drop** | 행 재정렬 + 크로스앱 드래그 지원 |
| **Row Height** | 44pt (Regular), 58pt (Large), 36pt (Small) |

---

## Device Context

```
iPad Pro 13" Landscape
─────────────────────────────
화면 크기      : 1210 x 834pt
Safe Area Top  : 24pt           ← spacing.json > safeArea.ipadLandscape.top
Safe Area Bot  : 20pt           ← spacing.json > safeArea.ipadLandscape.bottom
Content Margin : 20pt           ← spacing.json > contentMargin.ipad.horizontal
Sidebar 너비   : 320pt          ← sidebars.md > iPad Pro 13"
Detail 너비    : 890pt          ← 1210 - 320
```

---

## Screen Composition Breakdown

### Sidebar + List Detail (2-Column)

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           STATUS BAR (24pt)                                     │
├────────────────────┬────────────────────────────────────────────────────────────┤
│  SIDEBAR (320pt)   │  DETAIL AREA (890pt)                                      │
│  Liquid Glass sel. │  NAVIGATION BAR (44pt)                                    │
│                    │  [< 뒤로]    [받은편지함 (42)]               [편집] [⋯]   │
│  ┌──────────────┐ ├────────────────────────────────────────────────────────────┤
│  │ 🔍 검색      │ │                                                            │
│  └──────────────┘ │  SECTION HEADER: "오늘"                                    │
│                    │  ──────────────────────────────────────────────────────── │
│  모든 메일         │  │ [👤 40pt]  보낸 사람 이름                        11:32 │ │
│  ● 받은편지함 (42)│  │            메일 제목이 여기에 표시됩니다            [⭐] │ │
│  ─────────────── │  │            미리보기 텍스트 한 줄...                     │ │
│  보낸편지함        │  │ height: 76pt                                          │ │
│  중요              │  ──────────────────────────────────────────────────────── │
│  스팸              │  │ [👤 40pt]  다른 보낸 사람                        10:15 │ │
│  ─────────────── │  │            두 번째 메일 제목                       [⭐] │ │
│  LABELS            │  │            미리보기 텍스트...                          │ │
│  ─────────────── │  ──────────────────────────────────────────────────────── │
│  🔵 업무          │  │ [👤 40pt]  세 번째 보낸 사람                      09:48 │ │
│  🟢 개인          │  │            세 번째 메일 제목                           │ │
│  🔴 긴급          │  │            미리보기 텍스트...                          │ │
│                    │  ──────────────────────────────────────────────────────── │
│  ─────────────── │                                                            │
│  [편집]            │  SECTION HEADER: "어제"                                    │
│                    │  ──────────────────────────────────────────────────────── │
│                    │  │ ... 더 많은 메일 행들 ...                              │ │
│                    │  ──────────────────────────────────────────────────────── │
│                    │                                                            │
└────────────────────┴────────────────────────────────────────────────────────────┘
```

### Selection Mode (다중 선택)

```
┌────────────────────┬────────────────────────────────────────────────────────────┐
│  SIDEBAR (320pt)   │  DETAIL — EDIT MODE                                       │
│                    │  NAVIGATION BAR                                            │
│                    │  [선택 해제]   [3개 선택됨]              [전체 선택] [완료] │
│                    ├────────────────────────────────────────────────────────────┤
│                    │                                                            │
│                    │  │ [●]  [👤]  보낸 사람 1              ← 선택됨 (✓)      │ │
│                    │  │      배경: fills.quaternary + accents.blue tint        │ │
│                    │  ──────────────────────────────────────────────────────── │
│                    │  │ [○]  [👤]  보낸 사람 2              ← 미선택          │ │
│                    │  ──────────────────────────────────────────────────────── │
│                    │  │ [●]  [👤]  보낸 사람 3              ← 선택됨 (✓)      │ │
│                    │  ──────────────────────────────────────────────────────── │
│                    │  │ [●]  [👤]  보낸 사람 4              ← 선택됨 (✓)      │ │
│                    │  ──────────────────────────────────────────────────────── │
│                    │  │ [○]  [👤]  보낸 사람 5              ← 미선택          │ │
│                    │  ──────────────────────────────────────────────────────── │
│                    │                                                            │
│                    ├────────────────────────────────────────────────────────────┤
│                    │  TOOLBAR-BOTTOM                                            │
│                    │  [🗑️ 삭제]    [📁 이동]    [📤 공유]    [📧 답장]         │
│                    │  Liquid Glass, 44pt                                        │
└────────────────────┴────────────────────────────────────────────────────────────┘
```

### Drag & Drop

```
┌────────────────────┬────────────────────────────────────────────────────────────┐
│  SIDEBAR           │  DETAIL LIST                                               │
│                    │                                                            │
│                    │  │ [👤]  메일 1                                           │ │
│                    │  ──────────────────────────────────────────────────────── │
│                    │  │ [👤]  메일 2   ← 드래그 중 (lifted, shadow 표시)       │ │
│                    │  │               ┌─────────────────────────┐              │ │
│                    │  │               │  🔵 메일 2 (드래그 카드) │              │ │
│                    │  │               │  elevated shadow        │              │ │
│                    │  │               │  scale: 1.02            │              │ │
│                    │  ───────────────│──────────────────────────┘             ─ │
│                    │  │ [👤]  메일 3   ← drop indicator (파란 줄)               │ │
│                    │  ──────────────────────────────────────────────────────── │
│                    │  │ [👤]  메일 4                                           │ │
│                    │                                                            │
└────────────────────┴────────────────────────────────────────────────────────────┘
```

---

## 상세 치수

### List Row (iPad 기준)

| 속성 | 값 | 토큰 |
|------|-----|------|
| Height (Regular) | `44pt` | `spacing.json` > `components.listRow.heightRegular` |
| Height (Large/Tall) | `58pt` | `spacing.json` > `components.listRow.heightLarge` |
| Height (Small) | `36pt` | `spacing.json` > `components.listRow.heightSmall` |
| Padding Horizontal | `20pt` | `spacing.json` > `contentMargin.ipad.horizontal` |
| Padding Vertical | `11pt` | `spacing.json` > `components.listRow.paddingVertical` |
| Separator Inset | `16pt` | `spacing.json` > `components.listRow.separatorInset` |
| Separator Inset (이미지 있음) | `56~76pt` | 이미지 우측 + 16pt |

### iPad 리스트 Inset (insetGrouped)

| 속성 | 값 | 비고 |
|------|-----|------|
| 좌우 inset | `20pt` | contentMargin.ipad.horizontal |
| 섹션 간 간격 | `32pt` | `spacing.json` > `scale.8` |
| 섹션 Corner Radius | `12pt` | `spacing.json` > `radius.semantic.card` |
| 섹션 Background | backgrounds.secondary | `colors.json` > `backgrounds.secondary` |

### Section Header

| 속성 | 값 | 토큰 |
|------|-----|------|
| Height | `28pt` | 시스템 기본 |
| Font | footnote/Regular (13pt) | `typography.json` > `styles.footnote` |
| Color | labels.secondary | `colors.json` > `labels.secondary` |
| Text Transform | uppercase | HIG 기본 |
| Padding Left | `20pt` | `spacing.json` > `contentMargin.ipad.horizontal` |

### Selection Circle (편집 모드)

| 속성 | 값 | 토큰 |
|------|-----|------|
| Size | `24pt` | 시스템 기본 |
| Unselected | hollow circle, `fills.tertiary` border | `colors.json` > `fills.tertiary` |
| Selected | filled circle, `accents.blue` + checkmark | `colors.json` > `accents.blue` |
| Checkmark Color | `#ffffff` | `colors.json` > `grays.white` |
| Left Margin | `16pt` | `spacing.json` > `inset.md` |

---

## Component Usage (토큰 참조)

### Typography

| 요소 | 스타일 | 토큰 |
|------|--------|------|
| Row Title | body/Regular (17pt) | `typography.json` > `styles.body` |
| Row Subtitle | subheadline/Regular (15pt) | `typography.json` > `styles.subheadline` |
| Row Detail (trailing) | subheadline/Regular (15pt) | `typography.json` > `styles.subheadline` |
| Section Header | footnote/Regular (13pt) | `typography.json` > `styles.footnote` |
| Badge Count | caption2/Semibold (11pt) | `typography.json` > `styles.caption2.emphasized` |

### Colors

| 요소 | Light | Dark | 토큰 |
|------|-------|------|------|
| Row Background | `#ffffff` | `#1c1c1e` | `colors.json` > `backgrounds.secondary` |
| Row Title | `#000000` | `#ffffff` | `colors.json` > `labels.primary` |
| Row Subtitle | `rgba(#3c3c43, 0.6)` | `rgba(#ebebf5, 0.7)` | `colors.json` > `labels.secondary` |
| Separator | `#c6c6c8` | `#38383a` | `colors.json` > `separators.opaque` |
| Selected Row BG | `accents.blue` 기반 tint | — | 시스템 자동 |
| Disclosure Chevron | `rgba(#3c3c43, 0.3)` | `rgba(#ebebf5, 0.3)` | `colors.json` > `labels.tertiary` |

### Swipe Actions

| 방향 | 액션 | 색상 | 토큰 |
|------|------|------|------|
| Leading (우측으로 스와이프) | 읽지 않음 / 고정 | `accents.blue` | `colors.json` > `accents.blue` |
| Trailing (좌측으로 스와이프) | 삭제 | `accents.red` | `colors.json` > `accents.red` |
| Trailing | 더보기 / 이동 | `grays.gray` | `colors.json` > `grays.gray` |

---

## iPad-Specific Adaptations

### Sidebar Integration

| 항목 | 값 | 참조 |
|------|-----|------|
| Sidebar 너비 (13") | `320pt` | `sidebars.md` |
| Sidebar 너비 (11") | `280pt` | `sidebars.md` |
| Detail 너비 (13") | `890pt` | 1210 - 320 |
| Sidebar Row Height | `44pt` | `sidebars.md` |
| Sidebar Selected | Liquid Glass BG | `colors.json` > `miscellaneous.sidebar.fillSelected` |
| Sidebar Icon | `24x24pt` SF Symbol | `sidebars.md` |

### Wider Row Layout (iPad)

iPad에서는 넓은 행 공간을 활용하여 더 많은 정보를 한 행에 표시할 수 있다.

```
iPhone Row (390pt):
┌────────────────────────────────────────┐
│ [👤] 제목                      11:32  │
│      미리보기...                       │
└────────────────────────────────────────┘

iPad Row (890pt Detail):
┌──────────────────────────────────────────────────────────────────────────┐
│ [👤 40pt] 보낸 사람 이름                                         11:32 │
│           메일 제목이 여기에 길게 표시됩니다                         [⭐] │
│           미리보기 텍스트가 두 줄까지 표시될 수 있는 넓은 공간...        │
└──────────────────────────────────────────────────────────────────────────┘
```

### Pointer Support

| 상호작용 | 동작 |
|---------|------|
| **Hover on Row** | 행 배경 `fills.quaternary` 하이라이트 |
| **Click** | 행 선택 |
| **Double-Click** | 행 열기 (Detail 표시) |
| **Right-Click** | Context Menu 표시 |
| **Drag** | 행 드래그 시작 (편집 모드 또는 시스템 드래그) |
| **Multi-Select** | Cmd+Click으로 다중 선택 |

### Keyboard Shortcuts

| 단축키 | 동작 |
|--------|------|
| `↑` / `↓` | 행 간 포커스 이동 |
| `Return` | 선택된 행 열기 |
| `Space` | 선택된 행 미리보기 (Quick Look) |
| `Delete` | 선택된 행 삭제 |
| `Cmd+A` | 전체 선택 |
| `Cmd+Shift+A` | 전체 선택 해제 |
| `Cmd+F` | 검색 |

### Drag & Drop (Cross-App)

| 기능 | 설명 |
|------|------|
| **앱 내 재정렬** | 행을 길게 눌러 드래그 → 다른 위치에 드롭 |
| **크로스앱 드래그** | 행을 드래그 → Split View 반대편 앱에 드롭 |
| **다중 드래그** | 첫 번째 행 드래그 중 다른 행 탭으로 추가 (stack) |
| **Drop Indicator** | 드롭 위치에 파란색 수평 줄 표시 |
| **Elevated State** | 드래그 중 행이 살짝 확대 (scale 1.02) + 그림자 |

---

## Light / Dark Mode 차이

### Light Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| List BG (grouped) | `#f2f2f7` | `colors.json` > `backgroundsGrouped.primary.light` |
| Section BG | `#ffffff` | `colors.json` > `backgroundsGrouped.secondary.light` |
| Row Title | `#000000` | `colors.json` > `labels.primary.light` |
| Separator | `#c6c6c8` | `colors.json` > `separators.opaque.light` |
| Sidebar BG | `#f2f2f7` | `colors.json` > `backgrounds.secondary.light` |
| Sidebar Selected | `#ffffff` | `colors.json` > `miscellaneous.sidebar.fillSelected.light` |

### Dark Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| List BG (grouped) | `#000000` | `colors.json` > `backgroundsGrouped.primary.dark` |
| Section BG | `#1c1c1e` | `colors.json` > `backgroundsGrouped.secondary.dark` |
| Row Title | `#ffffff` | `colors.json` > `labels.primary.dark` |
| Separator | `#38383a` | `colors.json` > `separators.opaque.dark` |
| Sidebar BG | `#1c1c1e` | `colors.json` > `backgrounds.secondary.dark` |
| Sidebar Selected | `rgba(#8e8e93, 0.25)` | `colors.json` > `miscellaneous.sidebar.fillSelected.dark` |

---

## Multitasking Considerations

### Split View

- 50/50 Split: Sidebar + Detail → Sidebar가 숨겨지거나 overlay 모드
- 66/33 Split: 넓은 쪽은 Sidebar + Detail 유지, 좁은 쪽은 단일 리스트
- Compact Width: Sidebar → Navigation push (iPhone 스타일)

### Slide Over

- 320pt: 단일 리스트 뷰 (Sidebar 없음)
- Compact size class로 전환

### Stage Manager

- 큰 윈도우: 2-column (Sidebar + Detail)
- 작은 윈도우: 1-column (Navigation push)
- 윈도우 리사이즈 시 자동 전환

---

## Animation Spec

### Row Selection

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.2s` | `animations.json` > `duration.fast` |
| Easing | easeOut | `animations.json` > `easing.easeOut` |
| Effect | 배경색 fade-in | — |

### Swipe Action 노출

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.2s` | `animations.json` > `duration.semantic.listRowSwipe` |
| Easing | appleEaseOut | `animations.json` > `easing.appleEaseOut` |
| Threshold | 60pt 스와이프 시 액션 노출 | 시스템 기본 |

### Row Drag Lift

| 속성 | 값 |
|------|-----|
| Duration | `0.2s` |
| Scale | `1.0 → 1.02` |
| Shadow | 0 → `0 8pt 24pt rgba(0,0,0,0.2)` |
| Easing | spring.snappy |

---

## Accessibility

| 항목 | 구현 |
|------|------|
| **VoiceOver** | 행 내용 읽기 → Swipe Up/Down으로 다음/이전 행 |
| **Rotor Actions** | 삭제, 이동 등 스와이프 액션 접근 |
| **Keyboard Navigation** | 화살표 키로 행 이동, Return으로 열기 |
| **Touch Target** | 최소 44pt 행 높이 보장 |
| **Dynamic Type** | 행 높이 자동 확장, 최대 3줄 텍스트 |
| **Reduce Motion** | 스와이프 애니메이션 → 즉시 표시 |
| **Bold Text** | 제목 weight 증가, 보조 텍스트 유지 |
