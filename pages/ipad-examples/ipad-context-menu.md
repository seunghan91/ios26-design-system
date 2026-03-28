# iPad Context Menu — iOS 26 iPad 페이지 레시피

> **References**
> - Templates: `../../templates/`
> - Components: `../../components/specs/context-menus.md`
> - Tokens: `../../tokens/`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:25994")`

---

## 화면 개요

iPad에서 Context Menu는 **Long-press와 Right-click(트랙패드/마우스) 모두**로 트리거된다. Preview 영역 + 액션 메뉴 카드 구성은 iPhone과 동일하지만, iPad에서는 **Pointer hover 지원**과 **넓은 화면에서의 위치 자동 조정**이 추가된다. iOS 26에서는 Liquid Glass 소재가 메뉴 카드 배경에 적용된다.

| 항목 | 값 |
|------|-----|
| **적용 디바이스** | iPad Pro 13" (1210x834pt landscape) |
| **트리거** | Long-press (0.5초) / Right-click (마우스/트랙패드) |
| **Dimming** | 전체 화면 반투명 블러 |
| **배경 소재** | Liquid Glass (`materials.json` > `liquidGlass.regular.medium`) |
| **Preview** | 탭/클릭한 요소의 확대 미리보기 |
| **메뉴 카드 너비** | `250pt` |
| **Corner Radius** | `14pt` |

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

## Screen Composition Breakdown

### Context Menu — 콘텐츠 아이템 (사진 등)

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░  DIMMING OVERLAY (전체 화면)                                          ░░  │
│  ░░  Liquid Glass blur 배경                                               ░░  │
│  ░░                                                                       ░░  │
│  ░░                  ┌─────────────────────────────┐                      ░░  │
│  ░░                  │                             │                      ░░  │
│  ░░                  │     PREVIEW AREA             │                      ░░  │
│  ░░                  │     (탭한 요소 확대)          │                      ░░  │
│  ░░                  │                             │                      ░░  │
│  ░░                  │     예: 사진 미리보기        │                      ░░  │
│  ░░                  │     280 x 200pt             │                      ░░  │
│  ░░                  │     cornerRadius: 12pt      │                      ░░  │
│  ░░                  │                             │                      ░░  │
│  ░░                  └─────────────────────────────┘                      ░░  │
│  ░░                                   ↕ 8pt gap                           ░░  │
│  ░░                  ┌─────────────────────────────┐                      ░░  │
│  ░░                  │  MENU CARD (250pt)           │                      ░░  │
│  ░░                  │  Liquid Glass BG             │                      ░░  │
│  ░░                  │  ──────────────────────────  │                      ░░  │
│  ░░                  │  [📋]  복사                   │                      ░░  │
│  ░░                  │  ──────────────────────────  │                      ░░  │
│  ░░                  │  [📤]  공유              ›   │ ← 서브메뉴 있음      ░░  │
│  ░░                  │  ──────────────────────────  │                      ░░  │
│  ░░                  │  [⭐]  즐겨찾기에 추가        │                      ░░  │
│  ░░                  │  ──────────────────────────  │                      ░░  │
│  ░░                  │  [🗑️]  삭제             🔴   │ ← Destructive        ░░  │
│  ░░                  └─────────────────────────────┘                      ░░  │
│  ░░                                                                       ░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### Context Menu — 텍스트 선택

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░                                                                       ░░  │
│  ░░       ┌─────────────────────────────────────────┐                     ░░  │
│  ░░       │                                         │                     ░░  │
│  ░░       │  Lorem ipsum dolor sit amet,            │                     ░░  │
│  ░░       │  consectetur adipiscing elit.           │  ← Preview          ░░  │
│  ░░       │  ████████████████████████               │    (선택된 텍스트    ░░  │
│  ░░       │  ████████████████ sed do                │     하이라이트)      ░░  │
│  ░░       │  eiusmod tempor incididunt.             │                     ░░  │
│  ░░       │                                         │                     ░░  │
│  ░░       └─────────────────────────────────────────┘                     ░░  │
│  ░░                                ↕ 8pt                                  ░░  │
│  ░░       ┌────────────────────────────┐                                  ░░  │
│  ░░       │  [📋]  복사                │                                  ░░  │
│  ░░       │  ────────────────────────  │                                  ░░  │
│  ░░       │  [✂️]  오려두기            │                                  ░░  │
│  ░░       │  ────────────────────────  │                                  ░░  │
│  ░░       │  [📝]  찾아보기            │                                  ░░  │
│  ░░       │  ────────────────────────  │                                  ░░  │
│  ░░       │  [🔗]  링크 공유      ›    │                                  ░░  │
│  ░░       └────────────────────────────┘                                  ░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## 상세 치수

### Preview 영역

| 속성 | 값 | 토큰 |
|------|-----|------|
| 최대 너비 | `320pt` (iPad) | 커스텀 |
| 최대 높이 | `400pt` | 커스텀 |
| Corner Radius | `12pt` | `spacing.json` > `radius.lg` |
| Shadow | `drop-shadow(0 4pt 12pt rgba(0,0,0,0.15))` | 시스템 기본 |
| Scale Animation | `0.95 → 1.0` (lift-up) | 커스텀 |
| Background | 원본 콘텐츠 캡처 | 시스템 자동 |

### Menu Card

| 속성 | 값 | 토큰 |
|------|-----|------|
| Width | `250pt` | `spacing.json` > `radius.semantic.contextMenu` 참조 |
| Corner Radius | `14pt` | `spacing.json` > `radius.semantic.contextMenu` |
| Background | Liquid Glass medium | `materials.json` > `liquidGlass.regular.medium` |
| Frost Radius | `12pt` | `materials.json` > `liquidGlass.regular.medium.frostRadius` |
| Shadow Blur | `40pt` | `materials.json` > `liquidGlass.regular.medium.*.shadow.blur` |

### Menu Item Row

| 속성 | 값 | 토큰 |
|------|-----|------|
| Height | `44pt` | `spacing.json` > `components.listRow.heightRegular` |
| Padding Horizontal | `16pt` | `spacing.json` > `inset.md` |
| Icon Size | `20x20pt` | SF Symbol 기본 |
| Icon-Label Gap | `12pt` | `spacing.json` > `scale.3` |
| Label Font | body/Regular (17pt) | `typography.json` > `styles.body` |
| Label Color (Normal) | labels.primary | `colors.json` > `labels.primary` |
| Label Color (Destructive) | accents.red | `colors.json` > `accents.red` |
| Trailing Chevron | `›` 14pt | labels.tertiary |
| Separator | `0.5pt` | `colors.json` > `separators.nonOpaque` |
| Separator Inset | `16pt` leading | `spacing.json` > `inset.md` |

### Preview-Menu Gap

| 속성 | 값 | 토큰 |
|------|-----|------|
| Gap | `8pt` | `spacing.json` > `scale.2` |

### Dimming Overlay

| 속성 | 값 | 토큰 |
|------|-----|------|
| Light | `rgba(#000000, 0.2)` | `colors.json` > `overlays.default.light` |
| Dark | `rgba(#000000, 0.48)` | `colors.json` > `overlays.default.dark` |
| Blur | Background blur (ultrathin material) | `materials.json` > `backgroundMaterials.ultrathin` |

---

## Component Usage (토큰 참조)

### Typography

| 요소 | 스타일 | 토큰 |
|------|--------|------|
| Menu Item Label | body/Regular (17pt) | `typography.json` > `styles.body` |
| Section Header | footnote/Regular (13pt), uppercase | `typography.json` > `styles.footnote` |
| Destructive Label | body/Regular (17pt) | `typography.json` > `styles.body` |
| Submenu Indicator | caption1 (12pt) | `typography.json` > `styles.caption1` |

### Colors

| 요소 | Light | Dark | 토큰 |
|------|-------|------|------|
| Normal Icon | `#0088ff` | `#0091ff` | `colors.json` > `accents.blue` |
| Normal Label | `#000000` | `#ffffff` | `colors.json` > `labels.primary` |
| Destructive | `#ff383c` | `#ff4245` | `colors.json` > `accents.red` |
| Separator | `rgba(#000000, 0.12)` | `rgba(#ffffff, 0.17)` | `colors.json` > `separators.nonOpaque` |
| Section Header | `rgba(#3c3c43, 0.3)` | `rgba(#ebebf5, 0.3)` | `colors.json` > `labels.tertiary` |

---

## iPad-Specific Adaptations

### Right-Click Support (핵심 차이)

iPad에서 Context Menu는 **right-click으로도 트리거**된다. 트랙패드 또는 마우스의 보조 버튼 클릭이 Long-press와 동일한 Context Menu를 띄운다.

| 트리거 | 제스처 | 결과 |
|--------|--------|------|
| **Long-press** | 0.5초 이상 누르기 | Preview + Menu 등장 |
| **Right-click** | 트랙패드 2-finger tap / 마우스 우클릭 | Preview + Menu 즉시 등장 (지연 없음) |
| **Force Touch** | 미지원 (iPad에 없음) | — |

> Right-click 시에는 Long-press의 0.5초 지연이 없으므로 **즉시(~0.1s) 등장**한다.

### Pointer Hover States

| 상태 | 시각적 효과 |
|------|------------|
| **Hover on content** | 커서가 pointer로 변경 (long-press 가능 표시) |
| **Hover on menu item** | `fills.tertiary` 배경 하이라이트 |
| **Hover on destructive** | `rgba(accents.red, 0.1)` 배경 하이라이트 |
| **Hover on submenu (›)** | 0.3초 후 서브메뉴 자동 펼침 |
| **Hover off submenu** | 0.5초 후 서브메뉴 자동 접힘 |

### Keyboard Shortcuts (Context Menu 표시 중)

| 단축키 | 동작 |
|--------|------|
| `Esc` | Context Menu 닫기 |
| `↑` / `↓` | 메뉴 항목 간 포커스 이동 |
| `Return` | 선택된 항목 실행 |
| `→` | 서브메뉴 펼치기 |
| `←` | 서브메뉴 닫고 상위 메뉴로 복귀 |

### 위치 자동 조정 (iPad 넓은 화면)

```
기본 규칙:
  Preview + Menu는 트리거 요소 근처에 표시
  화면 가장자리에서 최소 16pt 여백 유지

우측 가장자리 근처 트리거:
  Menu가 Preview 왼쪽에 배치 (또는 왼쪽 아래)

하단 가장자리 근처 트리거:
  Menu가 Preview 위에 배치

Sidebar 내 트리거:
  Menu가 Sidebar 오른쪽으로 넘어갈 수 있음 (z-index 상위)
```

---

## Submenu (서브메뉴)

### 서브메뉴 구조

```
┌────────────────────────────┐
│  [📋]  복사                │
│  ────────────────────────  │
│  [📤]  공유           ›   │───────┐
│  ────────────────────────  │       │
│  [⭐]  즐겨찾기             │       ┌──────────────────────────┐
│  ────────────────────────  │       │  SUBMENU (200pt)         │
│  [🗑️]  삭제           🔴   │       │  Liquid Glass BG         │
└────────────────────────────┘       │  ──────────────────────  │
                                      │  [📱]  Messages          │
                                      │  ──────────────────────  │
                                      │  [📧]  Mail              │
                                      │  ──────────────────────  │
                                      │  [🔗]  링크 복사          │
                                      └──────────────────────────┘
```

| 속성 | 값 | 토큰 |
|------|-----|------|
| Submenu Width | `200pt` | 커스텀 (Main보다 좁음) |
| Overlap | `4pt` (Main 메뉴와 겹침) | 시스템 기본 |
| 등장 방향 | Main 메뉴의 반대쪽 | 공간 기반 자동 결정 |
| Hover 지연 | `0.3s` | 시스템 기본 |

---

## Light / Dark Mode 차이

### Light Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| Menu BG | `rgba(#f5f5f5, 0.6)` + frost | `materials.json` > `liquidGlass.regular.medium.light` |
| Dimming | `rgba(#000000, 0.2)` | `colors.json` > `overlays.default.light` |
| Preview Shadow | `rgba(#000000, 0.15)` blur 12pt | 시스템 기본 |
| Item Hover | `rgba(#767680, 0.12)` | `colors.json` > `fills.tertiary.light` |

### Dark Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| Menu BG | `rgba(#000000, 0.6)` + frost + tint | `materials.json` > `liquidGlass.regular.medium.dark` |
| Tint | `rgba(#ffffff, 0.06)` | `materials.json` > `liquidGlass.regular.medium.dark.tint` |
| Dimming | `rgba(#000000, 0.48)` | `colors.json` > `overlays.default.dark` |
| Preview Shadow | `rgba(#000000, 0.4)` blur 12pt | 시스템 기본 |
| Item Hover | `rgba(#767680, 0.24)` | `colors.json` > `fills.tertiary.dark` |

---

## Multitasking Considerations

### Split View

- Context Menu는 **활성 앱 영역 내에서만** Dimming + 표시
- 50/50 Split: 605pt 내에서 Preview + Menu 배치
- Menu가 앱 경계를 넘지 않도록 자동 조정
- Dimming은 해당 앱 영역에만 적용

### Slide Over

- Slide Over 앱 (320pt): 공간 제약으로 Preview 크기 축소
- Menu는 여전히 250pt (앱 너비의 78% 차지)
- Preview를 숨기고 Menu만 표시하는 것도 가능 (시스템 자동)

### Stage Manager

- 각 윈도우 내에서 독립적으로 Context Menu 표시
- 다른 윈도우는 Dimming 없이 정상 표시
- 윈도우 외부 클릭 시 Context Menu 닫힘

---

## Animation Spec

### Context Menu 등장

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.25s` | `animations.json` > `duration.semantic.contextMenuOpen` |
| Easing | spring.snappy | `animations.json` > `easing.spring.snappy` |
| Preview Scale | `0.95 → 1.0` (lift-up) | 커스텀 |
| Menu Scale | `0.85 → 1.0` | `animations.json` > `transitions.scale.in` |
| Menu Opacity | `0 → 1` | `animations.json` > `transitions.scale.in` |
| Dimming | `0 → target opacity` | `animations.json` > `transitions.fade.in` |
| Background | 가우시안 블러 fade-in | 시스템 자동 |

### Context Menu 닫힘

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.15s` | `animations.json` > `duration.semantic.contextMenuClose` |
| Easing | easeIn | `animations.json` > `easing.easeIn` |
| Preview Scale | `1.0 → 1.0` (제자리) | 시스템 자동 |
| Menu Scale | `1.0 → 0.85` | `animations.json` > `transitions.scale.out` |
| Menu Opacity | `1 → 0` | `animations.json` > `transitions.scale.out` |

### Long-press Haptic (iPad)

| 단계 | 시간 | 피드백 |
|------|------|--------|
| Press start | 0ms | — |
| 0.2s | 200ms | 콘텐츠 약간 축소 (scale 0.97) |
| 0.5s | 500ms | 햅틱 피드백 + Context Menu 등장 |

> Right-click 시에는 햅틱/축소 없이 즉시 등장한다.

---

## Accessibility

| 항목 | 구현 |
|------|------|
| **VoiceOver** | Long-press 대신 "Actions" 로터 항목으로 접근 |
| **Esc 키** | Context Menu 닫기 |
| **Tab** | 메뉴 항목 간 포커스 이동 |
| **Reduce Motion** | Scale 애니메이션 → 단순 fade |
| **Reduce Transparency** | Liquid Glass → 불투명 배경 |
| **Touch Target** | 모든 Menu Item 44pt 높이 보장 |
| **Switch Control** | 항목 스캔 모드로 접근 |
