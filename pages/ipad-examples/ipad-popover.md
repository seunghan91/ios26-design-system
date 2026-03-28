# iPad Popover — iOS 26 iPad 페이지 예시

> **References**
> - Components: `../../components/specs/popovers.md`
> - Tokens: `../../tokens/colors.json`, `../../tokens/spacing.json`, `../../tokens/typography.json`, `../../tokens/materials.json`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="61:65421")`

---

## 1. 화면 개요

Popover는 iPad 전용 컴포넌트로, 트리거 요소 근처에 화살표(arrow)와 함께 플로팅 패널을 표시한다. iOS 26에서는 **Liquid Glass material**이 배경에 적용되어 반투명 유리질 효과를 제공한다. iPhone에서는 자동으로 Sheet(bottom sheet)로 폴백된다.

이 페이지에서는 4가지 화살표 방향(top, bottom, left, right)에 따른 Popover 배치, preferredContentSize 설정, 그리고 내부 콘텐츠(리스트, 액션 버튼)의 구성을 다룬다.

| 항목 | 값 |
|------|-----|
| **디바이스** | iPad Pro 13" (1210 x 834pt landscape) |
| **플랫폼** | iPadOS 26 |
| **Size Class** | Regular Width x Regular Height |
| **컴포넌트** | `UIPopoverPresentationController` |
| **iOS 26 특징** | Liquid Glass material 배경 |
| **iPhone 폴백** | `UISheetPresentationController` (bottom sheet) |

---

## 2. 디바이스 컨텍스트

```
┌──────────────────────────────────────────────────────────────────────────────────┐
│                              iPad Pro 13" Bezel                                  │
│  ┌────────────────────────────────────────────────────────────────────────────┐  │
│  │                          1210 x 834pt (landscape)                         │  │
│  │  Status Bar: 24pt                                                         │  │
│  │  Safe Area: top=24pt, bottom=20pt, left=0pt, right=0pt                    │  │
│  │  Home Indicator: 없음 (iPad)                                               │  │
│  └────────────────────────────────────────────────────────────────────────────┘  │
│                                                                                  │
└──────────────────────────────────────────────────────────────────────────────────┘
```

| 속성 | 값 | 토큰 참조 |
|------|-----|----------|
| 화면 너비 | 1210pt | — |
| 화면 높이 | 834pt | — |
| Safe Area Top | 24pt | `spacing.safeArea.ipadLandscape.top` |
| Safe Area Bottom | 20pt | `spacing.safeArea.ipadLandscape.bottom` |
| Content Margin | 20pt | `spacing.contentMargin.ipad.horizontal` |

---

## 3. Popover 치수

### 3.1 크기 규격

| 항목 | 값 | 토큰 참조 |
|------|-----|----------|
| 최소 너비 | 200pt | `popovers.md` 스펙 |
| 기본 너비 | 320pt | — |
| 최대 너비 | 460pt | 화면 너비 절반 이하 권장 |
| 최소 높이 | 44pt | `spacing.components.touchTarget.minimum` |
| 최대 높이 | 500pt (834 x 0.6) | 화면 높이 60% |
| 코너 반경 | 13pt | `spacing.radius.semantic.popover: 14` 근접 |
| 내부 패딩 (수평) | 16pt | `spacing.inset.md` |
| 내부 패딩 (수직) | 12pt | `spacing.inset.sm` |

### 3.2 화살표 (Arrow) 치수

| 항목 | 값 |
|------|-----|
| 너비 | 11pt |
| 높이 | 8pt |
| 형태 | 이등변 삼각형 |
| 트리거와의 거리 | 0pt (인접) |
| 화면 경계 최소 여백 | 20pt |

### 3.3 Liquid Glass 배경

| 속성 | Light Mode | Dark Mode | 토큰 참조 |
|------|-----------|-----------|----------|
| 배경색 | `#fafafa` (a: 0.7) | `#000000` (a: 0.8) | `materials.liquidGlass.regular.large.light.bg` |
| Frost Radius | 14px | 14px | `materials.liquidGlass.regular.large.frostRadius` |
| Depth | 16 | 16 | `materials.liquidGlass.regular.large.depth` |
| Shadow Blur | 40px | 40px | `materials.liquidGlass.regular.large.light.shadow.blur` |
| Tint (Dark) | — | `#ffffff` (a: 0.06) | `materials.liquidGlass.regular.large.dark.tint` |

---

## 4. 화살표 방향별 배치 (4 variants)

### 4.1 Arrow Top (화살표가 위를 향함)

트리거가 상단에 있을 때 — Popover가 트리거 아래에 나타남.

```
┌─────────────────────────────────────────────────────────────────────────┐
│ STATUS BAR (24pt)                                                       │
├─────────────────────────────────────────────────────────────────────────┤
│ TOOLBAR (50pt)                                                          │
│  [< Back]  화면 제목              [검색]  [공유]  [더보기•••]           │
├─────────────────────────────────────────────────────────────────────────┤
│                                            △ arrow (11x8pt)            │
│                                   ┌────────────────────────┐           │
│                                   │   Popover 콘텐츠        │ 320pt    │
│                                   │                        │           │
│                                   │   [리스트 항목 1]       │           │
│                                   │   ──────────────       │           │
│                                   │   [리스트 항목 2]       │           │
│                                   │   ──────────────       │           │
│                                   │   [리스트 항목 3]       │           │
│                                   │                        │           │
│         콘텐츠 영역               │   [삭제 (destructive)] │           │
│         (dimming overlay)         └────────────────────────┘           │
│                                                                         │
│                                                                         │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

**배치 규칙**:
- Popover top = Toolbar bottom + arrow height (8pt)
- Arrow 수평 중심 = 트리거 버튼 수평 중심에 정렬
- 화면 경계 최소 여백 20pt 유지

### 4.2 Arrow Bottom (화살표가 아래를 향함)

트리거가 하단에 있을 때 — Popover가 트리거 위에 나타남.

```
┌─────────────────────────────────────────────────────────────────────────┐
│ STATUS BAR (24pt)                                                       │
├─────────────────────────────────────────────────────────────────────────┤
│ TOOLBAR (50pt)                                                          │
│  [< Back]  화면 제목                                                    │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│                                                                         │
│                                                                         │
│                                   ┌────────────────────────┐           │
│                                   │   Popover 콘텐츠        │ 320pt    │
│                                   │                        │           │
│                                   │   [첨부 파일]           │           │
│                                   │   ──────────────       │           │
│                                   │   [카메라]              │           │
│                                   │   ──────────────       │           │
│                                   │   [사진 라이브러리]      │           │
│                                   └────────────────────────┘           │
│                                            ▽ arrow (11x8pt)            │
├─────────────────────────────────────────────────────────────────────────┤
│ BOTTOM TOOLBAR (44pt + safeArea 20pt)                                   │
│               [Bold] [Italic] [Underline]  [첨부📎]                    │
└─────────────────────────────────────────────────────────────────────────┘
```

### 4.3 Arrow Left (화살표가 왼쪽을 향함)

트리거가 왼쪽에 있을 때 — Popover가 트리거 오른쪽에 나타남.

```
┌─────────────────────────────────────────────────────────────────────────┐
│ STATUS BAR (24pt)                                                       │
├─────────────────────────────────────────────────────────────────────────┤
│ TOOLBAR (50pt)                                                          │
├──────────┬──────────────────────────────────────────────────────────────┤
│ SIDEBAR  │                                                              │
│ (320pt)  │                                                              │
│          │                                                              │
│ [설정] ◁─────┌────────────────────────┐                                │
│          │   │   Popover 콘텐츠        │                                │
│          │   │   [일반 설정]            │                                │
│          │   │   ──────────────       │                                │
│          │   │   [알림 설정]            │                                │
│          │   │   ──────────────       │                                │
│          │   │   [개인정보]             │                                │
│          │   └────────────────────────┘                                │
│          │                                                              │
│          │         Detail Content                                       │
│          │                                                              │
└──────────┴──────────────────────────────────────────────────────────────┘
```

### 4.4 Arrow Right (화살표가 오른쪽을 향함)

트리거가 오른쪽에 있을 때 — Popover가 트리거 왼쪽에 나타남.

```
┌─────────────────────────────────────────────────────────────────────────┐
│ STATUS BAR (24pt)                                                       │
├─────────────────────────────────────────────────────────────────────────┤
│ TOOLBAR (50pt)                                                          │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│                                                                         │
│                     ┌────────────────────────┐─────▷  [Trigger]        │
│                     │   Popover 콘텐츠        │                         │
│                     │                        │                         │
│                     │   [복사]        ⌘C     │                         │
│                     │   ──────────────       │                         │
│                     │   [붙여넣기]     ⌘V     │                         │
│                     │   ──────────────       │                         │
│                     │   [공유...]      ⇧⌘S   │                         │
│                     └────────────────────────┘                         │
│                                                                         │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 5. preferredContentSize 설정

Popover의 크기는 `preferredContentSize`로 제어한다.

| 콘텐츠 유형 | 권장 너비 | 권장 높이 | 비고 |
|------------|----------|----------|------|
| 짧은 액션 목록 (3-5개) | 280pt | 200-250pt | 스크롤 불필요 |
| 긴 액션 목록 (6-10개) | 320pt | 400pt | 내부 스크롤 활성화 |
| 설정 패널 | 400pt | 500pt | 최대 높이 제한 적용 |
| 컬러 피커 / 복합 UI | 460pt | 500pt | 최대 너비 한계 |

**preferredContentSize 규칙**:
```
최소: CGSize(width: 200, height: 44)
최대: CGSize(width: 460, height: screenHeight * 0.6)
기본: CGSize(width: 320, height: auto)  ← 콘텐츠에 맞게 자동 조절
```

---

## 6. 내부 콘텐츠 구성

### 6.1 리스트 형태 Popover

```
┌────────────────────────────┐
│  12pt 상단 패딩             │
│  ┌──────────────────────┐  │
│  │ [아이콘] 항목 레이블   │  │  ← 44pt 높이, 16pt 좌우 패딩
│  ├──────────────────────┤  │  ← separator 0.33pt
│  │ [아이콘] 항목 레이블   │  │
│  ├──────────────────────┤  │
│  │ [아이콘] 항목 레이블   │  │
│  ├──── 섹션 구분 ────────┤  │  ← 섹션 구분: 8pt 여백 + separator
│  │ [아이콘] Destructive  │  │  ← 텍스트 색: accents.red
│  └──────────────────────┘  │
│  8pt 하단 패딩              │
└────────────────────────────┘
```

| 항목 | 값 | 토큰 참조 |
|------|-----|----------|
| 행 높이 (단일) | 44pt | `spacing.components.listRow.heightRegular` |
| 행 높이 (부제 포함) | 58pt | `spacing.components.listRow.heightLarge` |
| 아이콘 크기 | 22pt | — |
| 아이콘-텍스트 간격 | 12pt | `spacing.inset.sm` |
| Separator 높이 | 0.33pt | — |
| Separator inset (좌) | 44pt | 아이콘 포함 시 |
| 레이블 폰트 | Body (17pt) | `typography.styles.body` |
| 부제 폰트 | Subheadline (15pt) | `typography.styles.subheadline` |
| Destructive 색상 (Light) | `#ff383c` | `colors.accents.red.light` |
| Destructive 색상 (Dark) | `#ff4245` | `colors.accents.red.dark` |

### 6.2 액션 버튼 Popover

```
┌────────────────────────────┐
│  16pt 상단 패딩             │
│  [메시지 입력 텍스트필드]   │  ← 44pt 높이
│  12pt 간격                  │
│  ┌──────────────────────┐  │
│  │  [취소]    [전송]     │  │  ← Liquid Glass small 버튼
│  └──────────────────────┘  │
│  16pt 하단 패딩             │
└────────────────────────────┘
```

---

## 7. Light / Dark Mode 차이

### 7.1 배경 소재

| 속성 | Light Mode | Dark Mode |
|------|-----------|-----------|
| Popover 배경 | `#fafafa` (a: 0.7) | `#000000` (a: 0.8) |
| Frost 효과 | blur(14px) | blur(14px) |
| Tint overlay | 없음 | `#ffffff` (a: 0.06) |
| Shadow color | `#000000` (a: 0.15) | `#000000` (a: 0.3) |
| Shadow blur | 40px | 40px |

### 7.2 콘텐츠 색상

| 요소 | Light Mode | Dark Mode | 토큰 참조 |
|------|-----------|-----------|----------|
| 기본 텍스트 | `#000000` | `#ffffff` | `colors.labels.primary` |
| 보조 텍스트 | `#3c3c43` (a: 0.6) | `#ebebf5` (a: 0.7) | `colors.labels.secondary` |
| Separator | `#c6c6c8` | `#38383a` | `colors.separators.opaque` |
| Arrow 색상 | Popover 배경과 동일 | Popover 배경과 동일 | — |

### 7.3 Dimming Overlay

| 속성 | Light Mode | Dark Mode | 토큰 참조 |
|------|-----------|-----------|----------|
| Overlay 색상 | `#000000` (a: 0.2) | `#000000` (a: 0.48) | `colors.overlays.default` |

---

## 8. iPad 전용 적응사항

### 8.1 Wide Layout 대응

- iPad landscape (1210pt)에서 Popover 최대 너비는 460pt로 제한하여 좌우 콘텐츠 가시성 유지
- Sidebar + Detail 레이아웃에서 Popover는 Detail 영역 내에서만 표시 (Sidebar를 가리지 않음)
- Split View에서 각 앱 영역의 경계를 넘지 않음

### 8.2 Pointer (마우스/트랙패드) 지원

| 인터랙션 | 동작 |
|---------|------|
| Hover | 리스트 항목에 hover 시 `fills.tertiary` 배경 하이라이트 |
| Click | 탭과 동일하게 항목 선택 |
| Right-click | Context Menu 대신 Popover 표시 가능 |
| Scroll wheel | Popover 내부 스크롤 가능 (콘텐츠가 최대 높이 초과 시) |
| Esc 키 | Popover 닫기 |

### 8.3 키보드 단축키

| 단축키 | 동작 |
|--------|------|
| `Esc` | Popover 닫기 |
| `↑` / `↓` | 리스트 항목 간 포커스 이동 |
| `Return` | 포커스된 항목 선택 |
| `⌘.` (Command+Period) | Popover 닫기 (대체 단축키) |

---

## 9. 멀티태스킹 고려사항

### 9.1 Split View

```
┌──────────────────────────┬──────────────────────────────┐
│   앱 A (1/3 = 403pt)     │   앱 B (2/3 = 807pt)         │
│                          │                              │
│                          │       △ arrow                │
│   Popover가 이 앱        │  ┌──────────────┐            │
│   영역 안에서만 표시      │  │  Popover      │            │
│                          │  │  (max 320pt)  │            │
│                          │  └──────────────┘            │
│                          │                              │
└──────────────────────────┴──────────────────────────────┘
```

**Split View 규칙**:
- Popover는 자신이 속한 앱의 영역(windowScene bounds) 내에서만 표시
- 1/3 화면(403pt)에서는 Popover 최대 너비를 280pt로 축소
- 1/2 화면(605pt)에서는 기본 320pt 유지 가능
- 2/3 이상에서는 full-width Popover 사용 가능 (최대 460pt)

### 9.2 Slide Over

```
┌─────────────────────────────────────────────────────┬────────────┐
│                                                     │ Slide Over │
│   메인 앱 (Full Screen)                              │ (320pt)    │
│                                                     │            │
│                                                     │  Popover는 │
│                                                     │  이 영역    │
│                                                     │  내에서 표시│
│                                                     │            │
└─────────────────────────────────────────────────────┴────────────┘
```

- Slide Over 앱 (320pt 너비)에서 Popover는 iPhone처럼 Sheet로 폴백
- Size Class가 Compact Width가 되므로 자동 전환

### 9.3 Stage Manager

- Stage Manager에서 윈도우 크기가 자유롭게 변경 가능
- 윈도우가 Compact Width로 줄어들면 Popover → Sheet 자동 폴백
- 윈도우 이동 중 열린 Popover는 자동으로 닫힘 (dismiss)
- 다른 윈도우 클릭 시 현재 Popover 자동 닫힘

---

## 10. 구현 참고 (SwiftUI)

```swift
// Popover 기본 사용
.popover(isPresented: $showPopover,
         attachmentAnchor: .point(.bottom),
         arrowEdge: .top) {
    PopoverContentView()
        .frame(width: 320)
}

// preferredContentSize 제어
PopoverContentView()
    .presentationCompactAdaptation(.sheet)  // Compact에서 Sheet 폴백
    .presentationDetents([.medium])          // Sheet 폴백 시 detent

// iPad에서 arrow 방향 제어
.popover(isPresented: $show,
         arrowEdge: .leading) {  // .top, .bottom, .leading, .trailing
    ContentList()
}
```

---

## 11. 접근성

| 항목 | 설명 |
|------|------|
| VoiceOver | Popover 표시 시 포커스가 Popover 내부로 이동, 닫기 시 트리거로 복귀 |
| Dynamic Type | Popover 높이가 Dynamic Type에 따라 자동 확장 (최대 높이 제한 유지) |
| Reduce Transparency | Liquid Glass 효과 비활성화, 불투명 배경으로 폴백 |
| Reduce Motion | Spring 애니메이션 비활성화, 즉시 표시/숨김 |
| Switch Control | ESC 제스처로 Popover 닫기 |

---

## 12. 관련 컴포넌트

| 컴포넌트 | 관계 | 참조 |
|---------|------|------|
| Sheet | iPhone 폴백 | `../../components/specs/sheet.md` |
| Context Menu | 유사 오버레이 패턴 | `../../components/specs/context-menus.md` |
| Menus | 리스트 항목 구조 공유 | `../../components/specs/menus.md` |
| Alert | 다른 모달 패턴 | `../../components/specs/alert.md` |
