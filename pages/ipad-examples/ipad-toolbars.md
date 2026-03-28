# iPad Toolbars — iOS 26 iPad 페이지 예시

> **References**
> - Components: `../../components/specs/toolbar.md`
> - Tokens: `../../tokens/colors.json`, `../../tokens/spacing.json`, `../../tokens/typography.json`, `../../tokens/materials.json`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="5561:41165")`

---

## 1. 화면 개요

iPad Top Toolbar는 화면 상단의 네비게이션 및 액션 컨트롤 영역이다. iOS 26에서는 **Liquid Glass 소재**가 배경에 적용된다. iPad는 iPhone보다 약간 더 큰 50pt 높이를 기본으로 사용하며, 넓은 화면을 활용한 다양한 버튼 배치가 가능하다.

이 페이지에서는 iPad 전용 4가지 Top Toolbar variant를 다룬다.

| 항목 | 값 |
|------|-----|
| **디바이스** | iPad Pro 13" (1210 x 834pt landscape) |
| **플랫폼** | iPadOS 26 |
| **Figma Node (iPad Top)** | `5561:41165` — COMPONENT_SET, 8 variants |
| **iOS 26 특징** | Liquid Glass material, blur(12px) |
| **기본 높이** | 50pt (iPad standard) |
| **Large Title 높이** | 96pt |

---

## 2. 디바이스 컨텍스트

```
┌──────────────────────────────────────────────────────────────────────────────────┐
│                              iPad Pro 13" Bezel                                  │
│  ┌────────────────────────────────────────────────────────────────────────────┐  │
│  │  STATUS BAR (24pt)                                                        │  │
│  │  ┌──────────────────────────────────────────────────────────────────┐     │  │
│  │  │  TOOLBAR (50pt or 96pt)                                          │     │  │
│  │  └──────────────────────────────────────────────────────────────────┘     │  │
│  │  ┌──────────────────────────────────────────────────────────────────┐     │  │
│  │  │                        콘텐츠 영역                                │     │  │
│  │  └──────────────────────────────────────────────────────────────────┘     │  │
│  └────────────────────────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────────────────────┘
```

---

## 3. 공통 치수

| 속성 | 값 | 토큰 참조 |
|------|-----|----------|
| Standard 높이 | 50pt | `toolbar.md` iPad 스펙 |
| Large Title 높이 | 96pt | `spacing.components.navigationBar.largeTitleHeight` |
| Padding Horizontal | 20pt | `spacing.contentMargin.ipad.horizontal` |
| 버튼 최소 크기 | 44pt x 44pt | `spacing.components.touchTarget.minimum` |
| Blur (Liquid Glass) | 12px | `materials.liquidGlass.regular.medium.frostRadius` |
| 배경색 (Light) | `#f5f5f5` (a: 0.6) | `materials.liquidGlass.regular.medium.light.bg` |
| 배경색 (Dark) | `#000000` (a: 0.6) | `materials.liquidGlass.regular.medium.dark.bg` |

---

## 4. Variant 1: 2-Line Left Aligned

타이틀이 왼쪽 정렬되고, 서브타이틀이 아래에 표시되는 2줄 구성.

### 4.1 와이어프레임

```
┌─────────────────────────────────────────────────────────────────────────┐
│ STATUS BAR (24pt)                                                       │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐    │
│  │  TOOLBAR (50pt)                                                  │    │
│  │                                                                  │    │
│  │  [< Back]  제목 텍스트                      [🔍] [↑] [•••]     │    │
│  │            부제 텍스트                                           │    │
│  │                                                                  │    │
│  └─────────────────────────────────────────────────────────────────┘    │
│                                                                         │
│                         콘텐츠 영역                                      │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 4.2 레이아웃 상세

```
├── 20pt ──┤── Back (44pt) ──┤── 8pt ──┤── Title Area ──────────┤── gap ──┤── Buttons ──┤── 20pt ──┤

Title Area 내부:
┌─────────────────────────────┐
│  제목 텍스트 (Headline 17pt) │  ← SF Pro Semibold, labels.primary
│  부제 텍스트 (Footnote 13pt) │  ← SF Pro Regular, labels.secondary
└─────────────────────────────┘
  Line spacing: 2pt between title and subtitle
```

| 요소 | 폰트 | Weight | 색상 (Light) | 토큰 참조 |
|------|------|--------|-------------|----------|
| 제목 | Headline (17pt) | Semibold | `#000000` | `typography.styles.headline`, `colors.labels.primary.light` |
| 부제 | Footnote (13pt) | Regular | `#3c3c43` (a: 0.6) | `typography.styles.footnote`, `colors.labels.secondary.light` |
| Back 버튼 | Body (17pt) | Regular | `#0088ff` | `colors.accents.blue.light` |
| 액션 버튼 | — | — | `#0088ff` | `colors.accents.blue.light` |

---

## 5. Variant 2: 2-Line Center Aligned

타이틀이 중앙 정렬되고, 서브타이틀이 아래에 표시되는 2줄 구성.

### 5.1 와이어프레임

```
┌─────────────────────────────────────────────────────────────────────────┐
│ STATUS BAR (24pt)                                                       │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐    │
│  │  TOOLBAR (50pt)                                                  │    │
│  │                                                                  │    │
│  │  [< Back]         제목 텍스트 (center)         [🔍] [↑] [•••]  │    │
│  │                   부제 텍스트 (center)                           │    │
│  │                                                                  │    │
│  └─────────────────────────────────────────────────────────────────┘    │
│                                                                         │
│                         콘텐츠 영역                                      │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 5.2 레이아웃 상세

```
├── 20pt ──┤── Back ──┤── flex ──┤── Title (center) ──┤── flex ──┤── Buttons ──┤── 20pt ──┤

센터 정렬 규칙:
  - Title area의 수평 중심 = Toolbar 전체 너비의 수평 중심
  - 좌우 버튼 영역 너비가 다를 경우, 넓은 쪽에 맞춰 반대쪽 최소 여백 확보
  - Title이 양쪽 버튼을 침범하지 않도록 최대 너비 제한
```

| 속성 | 값 |
|------|-----|
| Title 최대 너비 | Toolbar 너비 - (좌 버튼 영역 + 우 버튼 영역) - 32pt |
| Title overflow | Truncation (middle) |
| 좌우 최소 여백 | 16pt (버튼과 Title 사이) |

---

## 6. Variant 3: 2-Line Large Title Inline

Large Title이 축소되어 Inline으로 표시되는 상태. 스크롤 시 Large Title → Inline 전환 후의 모습.

### 6.1 와이어프레임

```
┌─────────────────────────────────────────────────────────────────────────┐
│ STATUS BAR (24pt)                                                       │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐    │
│  │  TOOLBAR (50pt) — Large Title collapsed to Inline                │    │
│  │                                                                  │    │
│  │  [< Back]  제목 (Title3, 20pt)              [🔍] [↑] [•••]     │    │
│  │            부제 텍스트 (Footnote)                                 │    │
│  │                                                                  │    │
│  └─────────────────────────────────────────────────────────────────┘    │
│                                                                         │
│                         콘텐츠 (스크롤됨)                                 │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 6.2 Inline Title 상세

| 요소 | 폰트 | Weight | 크기 |
|------|------|--------|------|
| 제목 (Inline) | Title3 | Semibold | 20pt |
| 부제 | Footnote | Regular | 13pt |

**전환 애니메이션**:
- Large Title (34pt) → Inline Title (20pt) 으로 크기 축소
- Toolbar 높이: 96pt → 50pt
- 애니메이션: 스크롤 연동 interactive transition
- Blur 강도: 스크롤에 따라 점진적 증가

---

## 7. Variant 4: 2-Line Large Title

Large Title이 완전히 펼쳐진 상태. 콘텐츠가 최상단에 있을 때의 모습.

### 7.1 와이어프레임

```
┌─────────────────────────────────────────────────────────────────────────┐
│ STATUS BAR (24pt)                                                       │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐    │
│  │  TOOLBAR (96pt) — Large Title expanded                           │    │
│  │                                                                  │    │
│  │  [< Back]                                   [🔍] [↑] [•••]     │    │
│  │                                                                  │    │
│  │  제목 (Large Title, 34pt, Bold)                                  │    │
│  │  부제 텍스트 (Footnote, 13pt)                                    │    │
│  │                                                                  │    │
│  └─────────────────────────────────────────────────────────────────┘    │
│                                                                         │
│                         콘텐츠 (최상단)                                   │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 7.2 레이아웃 상세

```
TOOLBAR 96pt 내부 구조:

Row 1 (상단 44pt):
├── 20pt ──┤── [< Back] ──┤── flex ──┤── [🔍] [↑] [•••] ──┤── 20pt ──┤

Row 2 (하단 52pt):
├── 20pt ──┤── Large Title (34pt) ─────────────────────────┤── 20pt ──┤
│           │  부제 (13pt)                                  │
```

| 요소 | 폰트 | Weight | 크기 | 줄 높이 | 토큰 참조 |
|------|------|--------|------|--------|----------|
| Large Title | Large Title | Bold | 34pt | 41pt | `typography.styles.largeTitle` |
| 부제 | Footnote | Regular | 13pt | 18pt | `typography.styles.footnote` |
| Back 레이블 | Body | Regular | 17pt | 22pt | `typography.styles.body` |

---

## 8. Search 통합

### 8.1 Search Bar in Toolbar

```
┌─────────────────────────────────────────────────────────────────────────┐
│ STATUS BAR (24pt)                                                       │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐    │
│  │  TOOLBAR (96pt) — Large Title + Search                           │    │
│  │                                                                  │    │
│  │  [< Back]                                   [🔍] [↑] [•••]     │    │
│  │                                                                  │    │
│  │  제목 (Large Title, 34pt)                                        │    │
│  │  ┌──────────────────────────────────────────────────────┐       │    │
│  │  │  🔍 검색                                              │       │    │
│  │  └──────────────────────────────────────────────────────┘       │    │
│  │                                                                  │    │
│  └─────────────────────────────────────────────────────────────────┘    │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 8.2 Search Bar 치수

| 속성 | 값 | 토큰 참조 |
|------|-----|----------|
| 높이 | 36pt | — |
| 좌우 여백 | 20pt | `spacing.contentMargin.ipad.horizontal` |
| Corner Radius | 10pt | `spacing.radius.md` |
| 배경색 (Light) | `#ffffff` | `colors.miscellaneous.textField.bg.light` |
| 배경색 (Dark) | `#000000` | `colors.miscellaneous.textField.bg.dark` |
| Outline (Light) | `#3c3c43` (a: 0.29) | `colors.miscellaneous.textField.outline.light` |
| Outline (Dark) | `#ebebf5` (a: 0.3) | `colors.miscellaneous.textField.outline.dark` |
| 아이콘 크기 | 16pt | — |
| Placeholder 색상 | `labels.tertiary` | `colors.labels.tertiary` |

### 8.3 Search 활성화 시 전환

```
비활성 → 활성:
  1. Search bar에 포커스
  2. Large Title이 숨겨짐 (0.3s fade out)
  3. Toolbar 높이: 96pt → 50pt + Search bar 유지
  4. [취소] 버튼이 trailing edge에 나타남 (slide in)
  5. 검색 결과 영역이 콘텐츠를 대체
```

---

## 9. Light / Dark Mode 차이

| 요소 | Light Mode | Dark Mode | 토큰 참조 |
|------|-----------|-----------|----------|
| Toolbar 배경 | `#f5f5f5` (a: 0.6) | `#000000` (a: 0.6) | `materials.liquidGlass.regular.medium` |
| Title 텍스트 | `#000000` | `#ffffff` | `colors.labels.primary` |
| Subtitle 텍스트 | `#3c3c43` (a: 0.6) | `#ebebf5` (a: 0.7) | `colors.labels.secondary` |
| 버튼 tint | `#0088ff` | `#0091ff` | `colors.accents.blue` |
| Shadow | blur(40px), `#000` a:0.1 | blur(40px), `#000` a:0.2 | — |
| Separator | `#c6c6c8` | `#38383a` | `colors.separators.opaque` |

---

## 10. iPad 전용 적응사항

### 10.1 Wide Layout 활용

iPad의 1210pt 너비에서는:
- 좌우 버튼 영역에 더 많은 액션 버튼 배치 가능
- iPhone: 최대 2-3개 버튼 → iPad: 5-6개 버튼 가능
- 버튼 사이 간격: 8pt (iPhone: 4pt)

### 10.2 Pointer 지원

| 인터랙션 | 동작 |
|---------|------|
| Hover (버튼) | lift 효과 + 미묘한 scale(1.05) |
| Hover (Search) | 커서 → text cursor 변환 |
| Click | 탭과 동일 |
| Esc | Search 비활성화 / 이전 화면 |

### 10.3 키보드 단축키

| 단축키 | 동작 |
|--------|------|
| `⌘F` | Search bar 포커스 |
| `Esc` | Search 취소 / 뒤로가기 |
| `⌘[` | 뒤로가기 (Back) |
| `⌘]` | 앞으로가기 (Forward) |

---

## 11. 멀티태스킹 고려사항

### 11.1 Split View 적응

| 화면 비율 | 너비 | Toolbar 변화 |
|----------|------|-------------|
| 1/3 | 403pt | Compact Width → iPhone 스타일, 버튼 축소 |
| 1/2 | 605pt | Regular Width 유지, 일부 버튼 아이콘만 표시 |
| 2/3 | 807pt | 전체 크기, 모든 버튼 텍스트 + 아이콘 |
| Full | 1210pt | 전체 크기, 여유 공간 활용 |

### 11.2 Stage Manager

- 윈도우 크기에 따라 Toolbar 레이아웃 자동 조절
- 최소 윈도우 (320pt) → Compact Width → iPhone 스타일 폴백
- Title truncation: 윈도우가 좁아지면 자동 truncation

---

## 12. 접근성

| 항목 | 설명 |
|------|------|
| VoiceOver | "네비게이션 바, 제목: [title], [button count]개 버튼" |
| Dynamic Type | Large Title 최대 44pt, Inline 최대 24pt 확장 |
| Reduce Transparency | Liquid Glass 비활성화 → 불투명 배경 |
| Button Shapes | 버튼에 눈에 띄는 배경/윤곽선 추가 |
| Large Content Viewer | 길게 누르면 확대 뷰 표시 |

---

## 13. 관련 컴포넌트

| 컴포넌트 | 관계 | 참조 |
|---------|------|------|
| Tab Bar | 상단 탭과 함께 배치 | `../../components/specs/tab-bar.md` |
| Search | Toolbar 내장 검색 | `../../components/specs/text-field.md` |
| Sidebar | iPad 내비게이션 대안 | `../../components/specs/sidebars.md` |
| Segmented Control | Toolbar 내 필터 | `../../components/specs/segmented-control.md` |
