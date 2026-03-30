# iPad Tab Bars — iOS 26 iPad 페이지 예시

> **References**
> - Components: `../../components/specs/tab-bar.md`
> - Tokens: `../../tokens/colors.json`, `../../tokens/spacing.json`, `../../tokens/typography.json`, `../../tokens/materials.json`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="2524:7957")`

---

## 1. 화면 개요

iPad Tab Bar는 iPhone과 달리 **화면 상단**에 위치하며, 수평 방향으로 탭 아이템을 배치한다. iOS 26에서는 Liquid Glass 소재의 탭 인디케이터가 선택된 탭 주변에 반투명 유리질 배경을 형성한다. 이 페이지에서는 두 가지 variant를 다룬다: **검색 없음(Without Search)**과 **검색 포함(With Search)**.

| 항목 | 값 |
|------|-----|
| **디바이스** | iPad Pro 13" (1210 x 834pt landscape) |
| **플랫폼** | iPadOS 26 |
| **Size Class** | Regular Width x Regular Height |
| **위치** | 화면 상단 (iPhone: 하단) |
| **Figma Node (iPad)** | `2524:7957` — COMPONENT |
| **iOS 26 특징** | Liquid Glass tab indicator, 수평 레이아웃 |

---

## 2. 디바이스 컨텍스트

```
┌──────────────────────────────────────────────────────────────────────────────────┐
│                              iPad Pro 13" Bezel                                  │
│  ┌────────────────────────────────────────────────────────────────────────────┐  │
│  │                          1210 x 834pt (landscape)                         │  │
│  │                                                                           │  │
│  │  ┌──────────────────────────────────────────────────────────────────┐     │  │
│  │  │  Tab Bar (상단, 49pt 높이)                                       │     │  │
│  │  └──────────────────────────────────────────────────────────────────┘     │  │
│  │                                                                           │  │
│  │  ┌──────────────────────────────────────────────────────────────────┐     │  │
│  │  │                                                                  │     │  │
│  │  │                   콘텐츠 영역                                     │     │  │
│  │  │                   (834 - 24 - 49 - 20 = 741pt)                   │     │  │
│  │  │                                                                  │     │  │
│  │  └──────────────────────────────────────────────────────────────────┘     │  │
│  │                                                                           │  │
│  └────────────────────────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────────────────────┘
```

---

## 3. iPad Tab Bar 치수

### 3.1 전체 바 치수

| 속성 | 값 | 토큰 참조 |
|------|-----|----------|
| 너비 | 1210pt (전체 화면) | — |
| 높이 | 49pt | `spacing.components.tabBar.height` |
| Padding Horizontal | 20pt | `spacing.contentMargin.ipad.horizontal` |
| Padding Vertical | 0pt (수직 중앙 정렬) | — |
| 배경 | Liquid Glass Regular Medium | `materials.liquidGlass.regular.medium` |
| Frost Radius | 12px | `materials.liquidGlass.regular.medium.frostRadius` |

### 3.2 탭 버튼 치수

| 속성 | 값 | 비고 |
|------|-----|------|
| 최소 너비 | 64pt | `spacing.components.tabBar.itemMinWidth` |
| 높이 | 36pt (인디케이터 pill) | Liquid Glass pill 높이 |
| 탭 간 간격 | 4pt | 인접 탭 사이 |
| 아이콘 크기 | 22pt | SF Symbol, Regular weight |
| 텍스트-아이콘 간격 | 4pt | 수평 배치에서 아이콘과 레이블 사이 |
| 레이블 폰트 | Footnote (13pt) | `typography.styles.footnote` |

### 3.3 iPhone vs iPad 비교

| 속성 | iPhone | iPad |
|------|--------|------|
| **위치** | 화면 하단 | 화면 상단 |
| **방향** | 수직 (아이콘 위, 텍스트 아래) | 수평 (아이콘 왼쪽, 텍스트 오른쪽) |
| **높이** | 49pt + safeArea(34pt) = 83pt | 49pt |
| **인디케이터** | 하단 pill 형태 | 수평 pill 형태 |
| **Minimized** | 스크롤 시 축소 가능 | 항상 동일 크기 |
| **최대 탭 수** | 5 | 제한 없음 (overflow 시 "더 보기") |

---

## 4. Variant 1: Without Search

### 4.1 와이어프레임

```
┌─────────────────────────────────────────────────────────────────────────┐
│ STATUS BAR (24pt)                                                       │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│    ┌─────────────────────────────────────────────────────────────┐      │
│    │                    iPad Tab Bar (49pt)                       │      │
│    │                                                             │      │
│    │  ┌──────────────┐                                           │      │
│    │  │ ★ Featured   │  🕐 Recents   📥 Downloads   🔍 Search   │      │
│    │  │ (Liquid Glass│                                           │      │
│    │  │  indicator)  │                                           │      │
│    │  └──────────────┘                                           │      │
│    │                                                             │      │
│    └─────────────────────────────────────────────────────────────┘      │
│                                                                         │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│                                                                         │
│                         콘텐츠 영역                                      │
│                                                                         │
│                                                                         │
│                                                                         │
│                                                                         │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 4.2 탭 인디케이터 상세

```
선택된 탭 (Liquid Glass pill):
┌───────────────────────────┐
│  [★]  Featured            │  ← 36pt 높이, padding-h: 12pt
│  Liquid Glass background  │     cornerRadius: 1000 (pill)
└───────────────────────────┘

비선택 탭:
   [🕐]  Recents               ← 투명 배경, 같은 높이
```

| 상태 | 아이콘 색상 | 텍스트 색상 | 배경 | 토큰 참조 |
|------|-----------|-----------|------|----------|
| Selected (Light) | `#0088ff` | `labels.primary.light` | Liquid Glass Small | `colors.accents.blue.light` |
| Selected (Dark) | `#0091ff` | `labels.primary.dark` | Liquid Glass Small | `colors.accents.blue.dark` |
| Unselected (Light) | `#999999` | `#999999` | 투명 | `colors.miscellaneous.tabUnselected.light` |
| Unselected (Dark) | `#7e7e7e` | `#7e7e7e` | 투명 | `colors.miscellaneous.tabUnselected.dark` |

---

## 5. Variant 2: With Search

검색 탭이 분리되어 별도 위치에 배치된다.

### 5.1 와이어프레임

```
┌─────────────────────────────────────────────────────────────────────────┐
│ STATUS BAR (24pt)                                                       │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│    ┌─────────────────────────────────────────────────────────────┐      │
│    │                    iPad Tab Bar (49pt)                       │      │
│    │                                                             │      │
│    │  ┌──────────────┐                                           │      │
│    │  │ ★ Featured   │  🕐 Recents   📥 Downloads    ┌───────┐  │      │
│    │  │ (selected)   │                                │🔍검색  │  │      │
│    │  └──────────────┘                                └───────┘  │      │
│    │  ├── 일반 탭 그룹 ──┤                     ├─ Search pill ─┤  │      │
│    │                                                             │      │
│    └─────────────────────────────────────────────────────────────┘      │
│                                                                         │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│                         콘텐츠 영역                                      │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 5.2 Search 탭 분리 레이아웃

```
Tab Bar 내부 수평 구조:

├── 20pt ──┤── 탭 그룹 (leading) ────────────────┤── gap ──┤── Search (trailing) ──┤── 20pt ──┤
           │  [★Featured] [🕐Recents] [📥Down]  │         │  [🔍 검색]             │
           │  각 탭 사이: 4pt                     │  flex   │  Liquid Glass pill     │
```

| 속성 | 값 | 비고 |
|------|-----|------|
| Search pill 너비 | 자동 (텍스트+아이콘+패딩) | ~80pt |
| Search pill 위치 | trailing edge (오른쪽 정렬) | 일반 탭과 분리 |
| 일반 탭과의 간격 | flex (남은 공간 전체) | 양쪽 끝 정렬 |

### 5.3 Search 활성화 시

```
┌─────────────────────────────────────────────────────────────────────────┐
│                                                                         │
│    ┌─────────────────────────────────────────────────────────────┐      │
│    │                    iPad Tab Bar (49pt)                       │      │
│    │                                                             │      │
│    │  ★ Featured   🕐 Recents   📥 Downloads    ┌─────────────┐  │      │
│    │                                             │ 🔍 |검색어   │  │      │
│    │                                             │  (active)    │  │      │
│    │                                             └─────────────┘  │      │
│    │                                                             │      │
│    └─────────────────────────────────────────────────────────────┘      │
│                                                                         │
│    ┌─────────────────────────────────────────────────────────────┐      │
│    │  검색 결과 드롭다운 / 콘텐츠 전환                             │      │
│    │  ...                                                        │      │
│    └─────────────────────────────────────────────────────────────┘      │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 6. Liquid Glass Tab Indicator 상세

### 6.1 Indicator 소재

| 속성 | Light Mode | Dark Mode | 토큰 참조 |
|------|-----------|-----------|----------|
| 배경색 | `#f7f7f7` (a: 1) | `#000000` (a: 0.6) | `materials.liquidGlass.regular.small.light.default.bg` |
| Border | `#dddddd` | — | `materials.liquidGlass.regular.small.light.default.border` |
| Tint (Dark) | — | `#ffffff` (a: 0.06) | `materials.liquidGlass.regular.small.dark.default.tint` |
| Frost Radius | 7px | 7px | `materials.liquidGlass.regular.small.frostRadius` |
| Shadow Blur | 40px | 40px | `materials.liquidGlass.regular.small.light.default.shadow.blur` |
| Corner Radius | 1000 (pill) | 1000 (pill) | `spacing.radius.semantic.liquidGlass.small` |

### 6.2 Indicator 전환 애니메이션

| 속성 | 값 |
|------|-----|
| 애니메이션 유형 | Spring (iOS 26 default) |
| Duration | ~0.35s |
| Damping | 0.8 |
| 전환 동작 | Indicator가 현재 탭에서 새 탭 위치로 morph하며 이동 |
| 크기 변경 | 새 탭의 콘텐츠 너비에 맞게 pill 너비 자동 조절 |

---

## 7. Light / Dark Mode 차이

### 7.1 Tab Bar 배경

| 속성 | Light Mode | Dark Mode | 토큰 참조 |
|------|-----------|-----------|----------|
| Bar 배경 | `#f5f5f5` (a: 0.6) | `#000000` (a: 0.6) | `materials.liquidGlass.regular.medium` |
| Frost | blur(12px) | blur(12px) | — |
| Scroll Edge | 스크롤 시 blur 강화 | 스크롤 시 blur 강화 | `materials.scrollEdgeEffect` |

### 7.2 콘텐츠 색상 비교

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| 선택 아이콘 | `#0088ff` | `#0091ff` |
| 비선택 아이콘 | `#999999` | `#7e7e7e` |
| 선택 텍스트 | `#000000` | `#ffffff` |
| 비선택 텍스트 | `#999999` | `#7e7e7e` |
| Indicator pill | `#f7f7f7` | `#000000` (a: 0.6) |
| Selection fill (Dark) | — | `#ffffff` |

---

## 8. iPad 전용 적응사항

### 8.1 수평 레이아웃

iPhone Tab Bar는 아이콘(위) + 텍스트(아래) 수직 배치이지만, iPad는:
- 아이콘(왼쪽) + 텍스트(오른쪽) **수평** 배치
- 화면 상단에 위치 (iPhone은 하단)
- Minimized 상태 없음 (항상 동일 크기 유지)

### 8.2 Pointer (마우스/트랙패드) 지원

| 인터랙션 | 동작 |
|---------|------|
| Hover | 탭 항목에 hover 시 미묘한 하이라이트 (fills.quaternary) |
| Click | 탭 전환 |
| Right-click | 기본 동작 없음 |
| Scroll wheel | 탭이 overflow 시 수평 스크롤 |

### 8.3 키보드 단축키

| 단축키 | 동작 |
|--------|------|
| `⌘1` ~ `⌘9` | 1번~9번 탭으로 직접 이동 |
| `⌘F` | 검색 탭 활성화 (With Search variant) |
| `⌘⇧[` / `⌘⇧]` | 이전/다음 탭 이동 |

---

## 9. 멀티태스킹 고려사항

### 9.1 Split View

```
┌──────────────────────────┬──────────────────────────────┐
│   앱 A (1/3 = 403pt)     │   앱 B (2/3 = 807pt)         │
│                          │                              │
│  Tab Bar (상단, 49pt)    │  Tab Bar (상단, 49pt)        │
│  ┌──────────────────┐    │  ┌────────────────────────┐  │
│  │ ★  🕐  📥  🔍    │    │  │ ★ Featured  🕐  📥  🔍 │  │
│  │ (아이콘만 표시)    │    │  │ (아이콘 + 텍스트)      │  │
│  └──────────────────┘    │  └────────────────────────┘  │
│                          │                              │
│   콘텐츠                  │   콘텐츠                      │
└──────────────────────────┴──────────────────────────────┘
```

**Split View 적응 규칙**:
- **1/3 화면 (403pt)**: Compact Width → iPhone 스타일 하단 탭바로 전환, 또는 아이콘만 표시
- **1/2 화면 (605pt)**: Regular Width 유지 → 상단 수평 탭바, 텍스트 레이블 축소 가능
- **2/3 이상 (807pt)**: 전체 크기 상단 탭바

### 9.2 Slide Over

- Slide Over (320pt) → Compact Width → iPhone 스타일 하단 탭바로 자동 전환
- 탭바 높이: 49pt + Safe Area bottom

### 9.3 Stage Manager

- 윈도우 크기 변경에 따라 상단 ↔ 하단 탭바 자동 전환
- Regular Width: 상단 수평 탭바
- Compact Width: 하단 수직 탭바 (iPhone 스타일)
- 전환 시 Spring 애니메이션 (0.35s)

---

## 10. Overflow 처리

iPad Tab Bar에서 탭 수가 많을 때:

| 탭 수 | 처리 방법 |
|--------|----------|
| 1-6개 | 모든 탭 표시, 균등 배분 |
| 7-8개 | 탭 너비 축소, 텍스트 truncation |
| 9개+ | 마지막 항목을 "더 보기(•••)" 탭으로 대체 → Popover에서 나머지 표시 |

```
더 보기 탭 탭 시:
   [...] ← "더 보기" 탭
          △
    ┌──────────────┐
    │  📊 Analytics │
    │  ⚙️ Settings  │
    │  👤 Profile   │
    └──────────────┘
```

---

## 11. 접근성

| 항목 | 설명 |
|------|------|
| VoiceOver | 각 탭은 "탭, N개 중 M" 형태로 읽힘 |
| Dynamic Type | 탭 레이블 크기 조절, 필요 시 아이콘만 표시 |
| Reduce Transparency | Liquid Glass 비활성화, 불투명 배경 |
| Bold Text | 탭 레이블에 Bold weight 적용 |
| Button Shapes | 선택된 탭 주위에 눈에 띄는 윤곽선 추가 |

---

## 12. 관련 컴포넌트

| 컴포넌트 | 관계 | 참조 |
|---------|------|------|
| Toolbar | 상단 내비게이션 (Tab Bar와 함께 배치) | `../../components/specs/toolbar.md` |
| Sidebar | iPad 대체 내비게이션 패턴 | `../../components/specs/sidebars.md` |
| Segmented Control | 탭 내부 서브 내비게이션 | `../../components/specs/segmented-control.md` |
