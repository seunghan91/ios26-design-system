# iPad Sidebar — iOS 26 iPad 페이지 레시피

> **References**
> - Templates: `../../templates/`
> - Components: `../../components/specs/sidebars.md`
> - Tokens: `../../tokens/`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:26013")`

---

## 화면 개요

iPad Sidebar는 `UISplitViewController`의 좌측 열로, 앱의 최상위 내비게이션을 담당한다. 2가지 variant를 다룬다: **Standard List Sidebar(단일 레벨)**와 **Multi-level Sidebar(중첩 섹션)**. iPad에서는 항상 표시되며(Regular width), Compact width에서는 숨겨진다. iOS 26에서는 선택된 행에 Liquid Glass 배경이 적용된다.

| 항목 | 값 |
|------|-----|
| **적용 디바이스** | iPad Pro 13" (1210x834pt landscape) |
| **너비 (13")** | `320pt` |
| **너비 (11")** | `280pt` |
| **Row Height** | `44pt` |
| **선택 상태** | Liquid Glass 배경 |
| **Collapse/Expand** | 토글 버튼 또는 스와이프 |
| **UIKit** | `UISplitViewController`, `UICollectionViewCompositionalLayout.list(using: .sidebar)` |
| **SwiftUI** | `NavigationSplitView { Sidebar } detail: { Detail }` |

---

## Device Context

```
iPad Pro 13" Landscape
─────────────────────────────
화면 크기      : 1210 x 834pt
Safe Area Top  : 24pt           ← spacing.json > safeArea.ipadLandscape.top
Safe Area Bot  : 20pt           ← spacing.json > safeArea.ipadLandscape.bottom
Sidebar 너비   : 320pt          ← sidebars.md > iPad Pro 13"
Detail 너비    : 890pt          ← 1210 - 320
```

---

## Variant 1: Standard List Sidebar

### 전체 화면 레이아웃

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           STATUS BAR (24pt)                                     │
├────────────────────┬────────────────────────────────────────────────────────────┤
│  SIDEBAR (320pt)   │  DETAIL AREA (890pt)                                      │
│                    │                                                            │
│  ┌──────────────┐ │  NAVIGATION BAR (44pt)                                    │
│  │ 🔍 검색      │ │  [받은편지함]                              [편집] [✏️]    │
│  └──────────────┘ │                                                            │
│                    ├────────────────────────────────────────────────────────────┤
│  FAVORITES         │                                                            │
│  ─────────────── │  메일 상세 콘텐츠                                           │
│  📥 받은편지함 (42)│  ...                                                       │
│  ✉️ 보낸편지함     │                                                            │
│  ⭐ 중요           │                                                            │
│  📝 임시저장 (3)   │                                                            │
│  🗑️ 휴지통        │                                                            │
│                    │                                                            │
│  LABELS            │                                                            │
│  ─────────────── │                                                            │
│  🔵 업무       (7)│                                                            │
│  🟢 개인       (3)│                                                            │
│  🔴 긴급       (1)│                                                            │
│  🟡 나중에         │                                                            │
│                    │                                                            │
│  ACCOUNTS          │                                                            │
│  ─────────────── │                                                            │
│  📧 iCloud         │                                                            │
│  📧 Gmail          │                                                            │
│  📧 회사 메일      │                                                            │
│                    │                                                            │
│  ─────────────── │                                                            │
│  [편집]            │                                                            │
│                    │                                                            │
└────────────────────┴────────────────────────────────────────────────────────────┘
```

### Standard Sidebar 상세 구조

```
┌────────────────────────────────┐  ← width: 320pt
│  [앱 타이틀 / Toolbar]          │  ← height: 44pt + Safe Area top (24pt)
│  ┌──────────────────────────┐ │
│  │ 🔍 검색                   │ │  ← Search Field: height 36pt
│  └──────────────────────────┘ │    cornerRadius: 10pt
│                                │    bg: fills.tertiary
│  FAVORITES                     │  ← Section Header: 28pt
│  ─────────────────────────────│    footnote/Regular (13pt), UPPERCASE
│  ┌──────────────────────────┐ │    color: labels.secondary
│  │ 16│📥 24x24│12│받은편지함│(42)│16│ │  ← Sidebar Row: 44pt
│  └──────────────────────────┘ │    Leading: SF Symbol 24x24
│  ┌──────────────────────────┐ │    Label: body/Regular (17pt)
│  │    │✉️     │  │보낸편지함│   │  │ │    Trailing: Badge count
│  └──────────────────────────┘ │
│  ┌──────────────────────────┐ │  ← Selected Row
│  │[LG]│⭐     │  │중요 ████│   │  │ │    Liquid Glass 배경
│  └──────────────────────────┘ │    fillSelected 적용
│  ...                           │
│                                │
│  LABELS                        │  ← Section Header
│  ─────────────────────────────│
│  │ 16│🔵 16x16│12│업무 │(7)  │16│ │  ← Label Row
│  │    │ color dot │  │     │badge │  │ │    Color dot: 16x16pt circle
│  ...                           │
│                                │
│  ─────────────────────────────│  ← Bottom separator
│  [편집]                        │  ← Edit Button: 44pt + Safe Area bottom
└────────────────────────────────┘
```

---

## Variant 2: Multi-level Sidebar (중첩 섹션)

### 전체 화면 레이아웃

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           STATUS BAR (24pt)                                     │
├────────────────────┬────────────────────────────────────────────────────────────┤
│  SIDEBAR (320pt)   │  DETAIL AREA (890pt)                                      │
│                    │                                                            │
│  ┌──────────────┐ │  NAVIGATION BAR (44pt)                                    │
│  │ 🔍 검색      │ │  [파일 브라우저]                         [정렬] [+] [⋯]   │
│  └──────────────┘ │                                                            │
│                    ├────────────────────────────────────────────────────────────┤
│  FAVORITES         │                                                            │
│  ─────────────── │  파일 그리드 또는 리스트                                    │
│  ⭐ 즐겨찾기       │  ...                                                       │
│  🕐 최근 항목      │                                                            │
│  📤 공유됨         │                                                            │
│                    │                                                            │
│  LOCATIONS         │                                                            │
│  ─────────────── │                                                            │
│  ▼ iCloud Drive   │  ← Disclosure (펼쳐진 상태)                                │
│    📁 문서         │  ← Child depth 1 (들여쓰기 20pt)                           │
│    📁 데스크탑     │                                                            │
│    📁 다운로드     │                                                            │
│  ▶ 내 iPad        │  ← Disclosure (접힌 상태)                                  │
│  ▶ 외부 저장소    │                                                            │
│                    │                                                            │
│  TAGS              │                                                            │
│  ─────────────── │                                                            │
│  ▼ 색상 태그      │  ← Disclosure Group (펼쳐진 상태)                          │
│    🔴 빨강         │  ← Child depth 1                                           │
│    🟠 주황         │                                                            │
│    🟡 노랑         │                                                            │
│    🟢 초록         │                                                            │
│    🔵 파랑         │                                                            │
│  ▶ 사용자 태그    │  ← 접힌 상태                                               │
│                    │                                                            │
│  ─────────────── │                                                            │
│  [편집]            │                                                            │
└────────────────────┴────────────────────────────────────────────────────────────┘
```

### Multi-level 상세 구조

```
┌────────────────────────────────┐
│  LOCATIONS                     │  ← Section Header (28pt)
│  ─────────────────────────────│
│                                │
│  ▼ iCloud Drive               │  ← Disclosure Row (expanded)
│  │ 16│▼ 12pt│12│iCloud Drive │ │    ▼ chevron.down, rotation 0°
│  ─────────────────────────────│
│       📁 문서                  │  ← Child Row (depth 1)
│       │ 36│📁│12│문서│        │    indentation: 20pt (depth * 20)
│  ─────────────────────────────│    total leading: 16 + 20 = 36pt
│       📁 데스크탑              │
│  ─────────────────────────────│
│       📁 다운로드              │
│  ─────────────────────────────│
│                                │
│  ▶ 내 iPad                    │  ← Disclosure Row (collapsed)
│  │ 16│▶ 12pt│12│내 iPad │     │    ▶ chevron.right, rotation -90°
│  ─────────────────────────────│
│                                │
│  ▶ 외부 저장소                │
│  ─────────────────────────────│
└────────────────────────────────┘

Depth 들여쓰기:
  depth 0: leading 16pt
  depth 1: leading 16pt + 20pt = 36pt
  depth 2: leading 16pt + 40pt = 56pt (최대 권장)
```

---

## 상세 치수

### Sidebar 너비 (기기별)

| 기기 | Sidebar 너비 | 출처 |
|------|-------------|------|
| iPad Pro 13" | `320pt` | `sidebars.md` |
| iPad Pro 11" / iPad Air | `280pt` | `sidebars.md` |
| iPad mini | `260pt` | `sidebars.md` |
| iPhone (Compact) | 전체 너비 (overlay) | `sidebars.md` |

### Row 치수

| 속성 | 값 | 토큰 |
|------|-----|------|
| Row Height | `44pt` | `sidebars.md` > `4.2` |
| Section Header Height | `28pt` | `sidebars.md` > `4.2` |
| Search Field Height | `36pt` | `sidebars.md` > `4.2` |
| Toolbar Height | `44pt` | `sidebars.md` > `4.2` |
| Edit Button Height | `44pt` + Safe Area | `sidebars.md` > `4.2` |

### Row 내부 레이아웃

| 속성 | 값 | 토큰 |
|------|-----|------|
| Leading Padding | `16pt` | `sidebars.md` > `4.4` |
| Icon Size | `24x24pt` | SF Symbol 기본 |
| Icon-Label Gap | `12pt` | `sidebars.md` > `4.4` |
| Trailing Padding | `16pt` | `sidebars.md` > `4.4` |
| Trailing-Badge Gap | `8pt` | `sidebars.md` > `4.4` |
| Depth Indent | `20pt` per level | `sidebars.md` > `4.3` |

---

## Sidebar Collapse / Expand

### Toggle 동작

```
Expanded (기본):                     Collapsed:
┌──────┬──────────────┐             ┌──────────────────────┐
│Sidebar│   Detail     │   →→→     │       Detail (전체)    │
│320pt  │   890pt      │  collapse  │       1210pt          │
│       │              │            │                        │
└──────┴──────────────┘             │  [≡] ← 토글 버튼      │
                                     └──────────────────────┘
```

### Collapse 트리거

| 방법 | 동작 |
|------|------|
| **토글 버튼** | Navigation Bar에 sidebar toggle 버튼 ([≡] 또는 [sidebar.left]) |
| **스와이프** | Sidebar 좌측 가장자리에서 좌로 스와이프 |
| **키보드 단축키** | `Cmd+Shift+S` (앱 구현에 따라) |
| **자동** | 앱이 Compact width로 전환 시 자동 접힘 |

### Collapse Animation

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.35s` | `animations.json` > `duration.semantic.pageTransition` |
| Easing | spring.gentle | `animations.json` > `spring.presets.gentle` |
| CSS 근사 | `cubic-bezier(0.25, 0.46, 0.45, 0.94)` | `animations.json` > `easing.spring.gentle` |
| Sidebar | `translateX(0) → translateX(-320pt)` | Sidebar 너비만큼 좌측으로 |
| Detail | 너비 890pt → 1210pt 확장 | Sidebar 공간 흡수 |

### Overlay Mode (Compact Width)

Compact width에서 Sidebar는 Detail 위에 **Overlay**로 표시된다.

```
┌──────────────────────────────────────────┐
│  Detail (전체 너비)                       │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ┌──────────┐░░░░░░░░░░░░░░░░░░░░░░░  │
│  │ Sidebar  │  DIMMING                  │
│  │ (overlay)│  바깥 탭 → 닫기           │
│  │  320pt   │░░░░░░░░░░░░░░░░░░░░░░░  │
│  │          │░░░░░░░░░░░░░░░░░░░░░░░  │
│  └──────────┘░░░░░░░░░░░░░░░░░░░░░░░  │
└──────────────────────────────────────────┘
```

| 속성 | 값 | 토큰 |
|------|-----|------|
| Overlay Dimming | `rgba(#000000, 0.2)` | `colors.json` > `overlays.default.light` |
| Shadow | blur 40pt | `materials.json` > `liquidGlass.regular.large.*.shadow` |
| Dismiss | 바깥 영역 탭 | — |

---

## Component Usage (토큰 참조)

### Sidebar Background

| 속성 | 값 | 토큰 |
|------|-----|------|
| Light | `#f2f2f7` | `colors.json` > `backgrounds.secondary.light` |
| Dark | `#1c1c1e` | `colors.json` > `backgrounds.secondary.dark` |

### Row States

| 상태 | 값 | 토큰 |
|------|-----|------|
| Default | transparent | `sidebars.md` > `5. 색상 토큰` |
| Selected | Liquid Glass (`#ffffff` light / `rgba(#8e8e93, 0.25)` dark) | `colors.json` > `miscellaneous.sidebar.fillSelected` |
| Hovered | `fills.tertiary` | `colors.json` > `fills.tertiary` |
| Pressed | `fills.secondary` | `colors.json` > `fills.secondary` |
| Drag Active | elevated shadow | `colors.json` > `miscellaneous.sidebar.shadowDragOver` |

### Icon Colors

| 상태 | 값 | 토큰 |
|------|-----|------|
| Default | labels.secondary | `colors.json` > `labels.secondary` |
| Selected | accents.blue | `colors.json` > `accents.blue` |

### Label Colors

| 상태 | 값 | 토큰 |
|------|-----|------|
| Default | labels.primary | `colors.json` > `labels.primary` |
| Selected | labels.primary | `colors.json` > `labels.primary` |
| Secondary | labels.secondary | `colors.json` > `labels.secondary` |
| Disabled | labels.quaternary | `colors.json` > `labels.quaternary` |

### Badge

| 속성 | 값 | 토큰 |
|------|-----|------|
| Background | fills.tertiary | `colors.json` > `fills.tertiary` |
| Label | labels.secondary | `colors.json` > `labels.secondary` |
| Font | caption2/Semibold (11pt) | `typography.json` > `styles.caption2.emphasized` |
| Min Width | `20pt` | 시스템 기본 |
| Height | `20pt` | 시스템 기본 |
| Corner Radius | `9999pt` (pill) | `spacing.json` > `radius.full` |
| Padding H | `6pt` | `spacing.json` > `scale.1` + α |

### Disclosure Chevron

| 상태 | 아이콘 | 회전 |
|------|--------|------|
| Expanded (▼) | `chevron.down` | 0° |
| Collapsed (▶) | `chevron.right` | -90° (또는 별도 아이콘) |
| Animation | 회전 0.2s | spring.snappy |

### Section Separator

| 속성 | 값 | 토큰 |
|------|-----|------|
| Color | separators.opaque | `colors.json` > `separators.opaque` |
| Height | `0.5pt` | 시스템 기본 |
| Inset | `16pt` leading | `sidebars.md` > `4.4` |

---

## iPad-Specific Adaptations

### Pointer Support

| 상호작용 | 동작 |
|---------|------|
| **Hover on Row** | `fills.tertiary` 배경 하이라이트 |
| **Click** | 행 선택, Detail 영역 업데이트 |
| **Right-Click** | Context Menu (이름 변경, 삭제 등) |
| **Drag Row** | 편집 모드에서 행 재정렬 |
| **Hover on Disclosure** | 셰브론 강조 |
| **Click on Disclosure** | 하위 항목 펼치기/접기 |

### Keyboard Shortcuts

| 단축키 | 동작 |
|--------|------|
| `↑` / `↓` | 행 간 포커스 이동 |
| `Return` | 선택된 행 열기 |
| `→` | Disclosure 펼치기 / Detail로 포커스 이동 |
| `←` | Disclosure 접기 / Sidebar 내 상위로 이동 |
| `Cmd+Shift+S` | Sidebar 토글 (접기/펼치기) |
| `Cmd+F` | 검색 필드 포커스 |
| `Delete` | 편집 모드에서 선택 항목 삭제 |

### Editing Mode

```
편집 모드 진입: [편집] 버튼 탭

┌────────────────────────────────┐
│  ─────────────────────────────│
│  [⊖] 📥 받은편지함     [≡]   │  ← ⊖ 삭제 버튼, ≡ 재정렬 핸들
│  ─────────────────────────────│    삭제: accents.red circle
│  [⊖] ✉️ 보낸편지함     [≡]   │    핸들: labels.tertiary
│  ─────────────────────────────│
│  [⊖] ⭐ 중요           [≡]   │
│  ─────────────────────────────│
│  [⊕]                          │  ← ⊕ 추가 버튼: accents.green
│  ─────────────────────────────│
│  [완료]                        │  ← 편집 모드 종료
└────────────────────────────────┘
```

---

## Light / Dark Mode 차이

### Light Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| Sidebar BG | `#f2f2f7` | `colors.json` > `backgrounds.secondary.light` |
| Selected Row | `#ffffff` | `colors.json` > `miscellaneous.sidebar.fillSelected.light` |
| Row Label | `#000000` | `colors.json` > `labels.primary.light` |
| Icon Default | `rgba(#3c3c43, 0.6)` | `colors.json` > `labels.secondary.light` |
| Icon Selected | `#0088ff` | `colors.json` > `accents.blue.light` |
| Section Header | `rgba(#3c3c43, 0.6)` | `colors.json` > `labels.secondary.light` |
| Separator | `#c6c6c8` | `colors.json` > `separators.opaque.light` |
| Search Field BG | `rgba(#767680, 0.12)` | `colors.json` > `fills.tertiary.light` |

### Dark Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| Sidebar BG | `#1c1c1e` | `colors.json` > `backgrounds.secondary.dark` |
| Selected Row | `rgba(#8e8e93, 0.25)` | `colors.json` > `miscellaneous.sidebar.fillSelected.dark` |
| Row Label | `#ffffff` | `colors.json` > `labels.primary.dark` |
| Icon Default | `rgba(#ebebf5, 0.7)` | `colors.json` > `labels.secondary.dark` |
| Icon Selected | `#0091ff` | `colors.json` > `accents.blue.dark` |
| Section Header | `rgba(#ebebf5, 0.7)` | `colors.json` > `labels.secondary.dark` |
| Separator | `#38383a` | `colors.json` > `separators.opaque.dark` |
| Search Field BG | `rgba(#767680, 0.24)` | `colors.json` > `fills.tertiary.dark` |

---

## Multitasking Considerations

### Split View

- 50/50 Split (605pt): Sidebar가 Overlay 모드로 전환 가능
- 66/33 Split 넓은 쪽 (807pt): Sidebar 320pt + Detail 487pt 유지
- 33/66 Split 좁은 쪽 (403pt): Sidebar 숨김 → Overlay 또는 Navigation push

### Slide Over

- Slide Over 앱 (320pt): Compact size class → Navigation push (iPhone 스타일)
- Sidebar 행 탭 → Detail이 push 전환으로 표시

### Stage Manager

- 넓은 윈도우: 2-column (Sidebar 항상 표시)
- 중간 윈도우: 2-column (Sidebar 좁아짐, 최소 260pt)
- 좁은 윈도우: 1-column (Navigation push)
- 윈도우 리사이즈 시 자동 전환

---

## Animation Spec

### Row Selection

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.2s` | `animations.json` > `duration.fast` |
| Easing | easeOut | `animations.json` > `easing.easeOut` |
| Effect | Liquid Glass 배경 fade-in | — |

### Disclosure 펼치기/접기

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.25s` | `animations.json` > `transitions.scale.in.duration` |
| Easing | spring.snappy | `animations.json` > `easing.spring.snappy` |
| Chevron | 회전 0° ↔ -90° | — |
| Children | 높이 0 → 자연 높이 (또는 역) | clip + height animation |

### Sidebar Collapse/Expand

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.35s` | `animations.json` > `duration.semantic.pageTransition` |
| Easing | spring.gentle | `animations.json` > `spring.presets.gentle` |
| Sidebar | `translateX(0) ↔ translateX(-320pt)` | Sidebar 너비 |
| Detail | 너비 확장/축소 | 동시 |

### Drag Reorder

| 속성 | 값 |
|------|-----|
| Lift Duration | `0.2s` |
| Lift Scale | `1.0 → 1.02` |
| Shadow | elevated shadow (sidebar.shadowDragOver) |
| Drop | spring.snappy + shadow 제거 |

---

## Accessibility

| 항목 | 구현 |
|------|------|
| **VoiceOver** | Sidebar 행 읽기: "받은편지함, 42개 읽지 않음" |
| **Disclosure** | "iCloud Drive, 접혀있음" / "iCloud Drive, 펼쳐져 있음" |
| **Keyboard Navigation** | 화살표 키로 행 이동, Return으로 선택 |
| **Sidebar Toggle** | "사이드바 보이기" / "사이드바 숨기기" |
| **Touch Target** | 모든 행 44pt 높이 보장 |
| **Dynamic Type** | 레이블 크기 증가, 행 높이 자동 확장 |
| **Reduce Motion** | Collapse/expand → 즉시 전환 |
| **Bold Text** | 레이블 weight 증가 |
| **Increased Contrast** | 선택 배경 불투명도 증가 |
