# Menus — iPhone Full-Screen Example

> **References**
> - Components: `../../components/specs/menus.md`
> - Tokens: `../../tokens/colors.json`, `../../tokens/spacing.json`, `../../tokens/typography.json`, `../../tokens/animations.json`, `../../tokens/materials.json`
> - Sections: `../../sections/`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24676")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Menus (메뉴 시스템) |
| **디바이스** | iPhone 17 Pro — 402 × 874pt (@3x, 1206 × 2622px) |
| **용도** | 버튼/바 아이템에서 액션 목록 드롭다운, 텍스트 선택 편집 메뉴 |
| **트리거** | 버튼 탭 (즉시 등장), 텍스트 선택 |
| **프레젠테이션** | 드롭다운 오버레이 (dimming 없음 또는 옅음) |
| **iOS 26 특이사항** | Liquid Glass 메뉴 카드 배경, spring scale 등장, 체크마크/서브메뉴 지원 |

이 문서는 두 가지 Menu variant를 다룬다: **Edit Medium** (텍스트 선택 메뉴)과 **Standard Menu** (드롭다운 메뉴).

---

## 디바이스 컨텍스트

```
iPhone 17 Pro
├─ 화면 크기: 402 × 874pt
├─ Safe Area Top: 59pt (Dynamic Island)
├─ Safe Area Bottom: 34pt (Home Indicator)
├─ Pixel Density: @3x (1206 × 2622px)
└─ 색상 공간: P3 Wide Color
```

---

## Variant 1: Edit Medium (텍스트 선택 메뉴)

### 전체 레이아웃

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │  ← Status Bar (59pt)
├─────────────────────────────────────────────┤
│  ← 뒤로              메모             [완료] │  ← Navigation Bar (44pt)
├─────────────────────────────────────────────┤
│                                              │
│  Lorem ipsum dolor sit amet, consectetur     │
│  adipiscing elit. ████████████████████       │  ← 텍스트 선택 (하이라이트)
│  ████████████ do eiusmod tempor incididunt   │    색상: accents.blue (0.2 alpha)
│  ut labore.                                  │
│                                              │
│  ◆───────────── Selection ───────────────◆  │  ← 선택 핸들 (grab dots)
│                                              │    색상: accents.blue
│     ┌─── Edit Menu (Floating Bar) ────┐     │
│     │  잘라내기 │ 복사하기 │ 붙여넣기 │ ⋯  │     │  ← Edit Menu Bar
│     └─────────────────────────────────┘     │    높이: 44pt
│                                              │    cornerRadius: 10pt
│                                              │    Liquid Glass 배경
│  Ut enim ad minim veniam, quis nostrud       │
│  exercitation ullamco laboris nisi ut        │
│  aliquip ex ea commodo consequat.            │
│                                              │
│                                              │
│                                              │
│                                              │
├─────────────────────────────────────────────┤
│  [🏠홈] [🔍탐색] [＋] [🔔벨] [👤프로필]      │  ← Tab Bar (83pt)
└─────────────────────────────────────────────┘
```

### ⋯ 확장 메뉴 (More)

```
     ┌─── Edit Menu (확장) ──────────┐
     │  잘라내기 │ 복사하기 │ 붙여넣기 │ ⋯  │
     └──────────────────────────────┘
              ↓ ⋯ 탭 시 드롭다운
     ┌──────────────────────┐
     │  모두 선택             │  ← 250pt 너비 메뉴 카드
     │  ────────────────── │
     │  찾기 및 대치          │  ← Liquid Glass 배경
     │  ────────────────── │
     │  들여쓰기             │  ← 44pt 높이/항목
     │  ────────────────── │
     │  내어쓰기             │
     │  ────────────────── │
     │  공유               › │  ← 서브메뉴 화살표
     └──────────────────────┘
```

### Edit Menu Bar 치수

| 항목 | 값 | 토큰 |
|------|-----|------|
| 높이 | 44pt | — |
| cornerRadius | 10pt | — |
| 배경 | Liquid Glass | `materials.liquidGlass.regular.small` |
| Light 배경 | `rgba(247,247,247,1)` + blur 7px | `materials.liquidGlass.regular.small.light.default.bg` |
| Dark 배경 | `rgba(0,0,0,0.6)` + blur 7px | `materials.liquidGlass.regular.small.dark.default.bg` |
| 버튼 구분 | `separators.nonOpaque` 세로선 | Light: `rgba(0,0,0,0.12)`, Dark: `rgba(255,255,255,0.17)` |
| 버튼 패딩 | 16pt (좌우) | — |
| 텍스트 타이포 | Callout (16pt, Regular) | `typography.styles.callout` |
| 텍스트 색상 | `labels.primary` | Light: `#000000`, Dark: `#ffffff` |
| ⋯ 아이콘 | SF Symbol `ellipsis`, 20pt | — |
| 위치 | 선택 영역 바로 위 (공간 부족 시 아래) | — |
| Shadow | blur 8pt, `rgba(0,0,0,0.12)` | — |

### 텍스트 선택 핸들

| 항목 | 값 |
|------|-----|
| 형태 | 원형 + 세로 줄 (lollipop) |
| 색상 | `accents.blue` — Light: `#0088ff`, Dark: `#0091ff` |
| 크기 | 원: 12pt, 줄: 2pt 너비 |
| 선택 하이라이트 | `accents.blue` alpha 0.2 |

---

## Variant 2: Standard Menu (드롭다운)

### 전체 레이아웃

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │  ← Status Bar (59pt)
├─────────────────────────────────────────────┤
│  파일                 [정렬 ▾]        [⋯]   │  ← Navigation Bar (44pt)
├─────────────────────────────────────────────┤     [정렬 ▾] = 메뉴 트리거 버튼
│                         │                    │
│  ← 콘텐츠 영역 ──────── │ ← 메뉴 드롭다운 ─── │
│                         │                    │
│                   ┌─── Standard Menu ────┐  │
│                   │  정렬                 │  │  ← Section Header (Caption2)
│                   │  ────────────────── │  │    11pt, labels.tertiary, 대문자
│                   │  📅  이름순      ✓   │  │  ← 체크마크 (선택됨)
│                   │  ────────────────── │  │    accents.blue
│                   │  📏  크기순          │  │  ← 44pt 높이/항목
│                   │  ────────────────── │  │
│                   │  🕐  날짜순          │  │
│                   │  ────────────────── │  │
│                   │  ════════════════ │  │  ← Inline 섹션 구분 (굵은 선)
│                   │  보기 옵션          › │  │  ← 서브메뉴 chevron
│                   │  ────────────────── │  │
│                   │  🗑  삭제        ⛔  │  │  ← Destructive (red)
│                   └──────────────────────┘  │
│                                              │    250pt 너비, cornerRadius 13pt
│                                              │    Liquid Glass 배경
│                                              │
│                                              │
│                                              │
├─────────────────────────────────────────────┤
│  [🏠홈] [🔍탐색] [＋] [🔔벨] [👤프로필]      │  ← Tab Bar (83pt)
└─────────────────────────────────────────────┘
```

### Standard Menu 치수

| 항목 | 값 | 토큰 |
|------|-----|------|
| 너비 | 250pt (고정) | — |
| 항목 높이 | 44pt | `spacing.components.touchTarget.minimum` |
| 코너 반경 | 13pt | `spacing.radius.semantic.menu` |
| 내부 수평 패딩 | 16pt (좌우) | `spacing.inset.md` |
| 배경 (Light) | Liquid Glass: `rgba(255,255,255,0.72)` + blur 20px + saturate 180% | `materials.liquidGlass` |
| 배경 (Dark) | Liquid Glass: `rgba(28,28,30,0.72)` + blur 20px + saturate 150% | — |
| 최대 높이 | 화면 높이 × 0.6 (초과 시 내부 스크롤) | — |
| Shadow | blur 20pt, `rgba(0,0,0,0.15)` | — |

### Menu Item 구조

```
┌──────────────────────────────────────────────┐
│  [아이콘 20pt]  레이블 (17pt)   [오른쪽 요소]  │  ← 높이: 44pt
│  ← 16pt →  ← 12pt →           ← 16pt →     │
└──────────────────────────────────────────────┘

오른쪽 요소 종류:
- 체크마크 (✓): 단일 선택 시, accents.blue
- 숏컷 레이블: "⌘C" 등, labels.secondary, 15pt
- Submenu chevron (›): 서브메뉴 트리거
- (없음): 기본 항목
```

### 오른쪽 요소 상세

| 요소 | 크기 | 색상 | 용도 |
|------|------|------|------|
| 체크마크 | SF Symbol `checkmark`, 17pt | `accents.blue` | 선택 상태 표시 |
| 키보드 숏컷 | Subheadline (15pt, Regular) | `labels.secondary` | iPad/Mac 외부 키보드 |
| Submenu chevron | SF Symbol `chevron.right`, 12pt | `labels.tertiary` | 서브메뉴 진입 |
| Mixed state | SF Symbol `minus`, 17pt | `accents.blue` | 부분 선택 |

---

## 공통 토큰 참조

### 색상

| 역할 | 토큰 | Light | Dark |
|------|------|-------|------|
| 레이블 기본 | `colors.labels.primary` | `#000000` | `#ffffff` |
| 레이블 보조 | `colors.labels.secondary` | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.7)` |
| 레이블 3차 | `colors.labels.tertiary` | `rgba(60,60,67,0.3)` | `rgba(235,235,245,0.3)` |
| Destructive | `colors.accents.red` | `#ff383c` | `#ff4245` |
| 체크마크/선택 | `colors.accents.blue` | `#0088ff` | `#0091ff` |
| 구분선 (Opaque) | `colors.separators.opaque` | `#c6c6c8` | `#38383a` |
| Highlighted | `colors.fills.tertiary` | `rgba(118,118,128,0.12)` | `rgba(118,118,128,0.24)` |
| Disabled | `colors.labels.quaternary` | `rgba(60,60,67,0.18)` | `rgba(235,235,245,0.16)` |

### Typography

| 요소 | 스타일 | 크기 | 굵기 | 토큰 |
|------|--------|------|------|------|
| 항목 레이블 | Body | 17pt | Regular | `typography.styles.body` |
| Destructive | Body | 17pt | Regular | (색상만 red) |
| Section Header | Caption2 | 11pt | Regular | `typography.styles.caption2` |
| Edit Menu 버튼 | Callout | 16pt | Regular | `typography.styles.callout` |
| 키보드 숏컷 | Subheadline | 15pt | Regular | `typography.styles.subheadline` |

---

## Light/Dark 모드 차이

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| Menu 배경 | `rgba(255,255,255,0.72)` + blur 20px | `rgba(28,28,30,0.72)` + blur 20px |
| Edit Bar 배경 | `rgba(247,247,247,1)` + blur 7px | `rgba(0,0,0,0.6)` + blur 7px |
| 레이블 | `#000000` | `#ffffff` |
| Destructive | `#ff383c` | `#ff4245` |
| 체크마크 | `#0088ff` | `#0091ff` |
| 구분선 | `#c6c6c8` | `#38383a` |
| 선택 하이라이트 | `#0088ff` alpha 0.2 | `#0091ff` alpha 0.2 |
| Highlighted item | `rgba(118,118,128,0.12)` | `rgba(118,118,128,0.24)` |
| Shadow | `rgba(0,0,0,0.15)` | `rgba(0,0,0,0.3)` |

---

## 애니메이션

### Standard Menu 등장

```yaml
trigger: 트리거 버튼 탭
duration: 0.25s
spring: snappy (response 0.3, dampingRatio 0.8)
css_approx: cubic-bezier(0.34, 1.56, 0.64, 1.0)
properties:
  scale: 0.85 → 1.0
  opacity: 0 → 1
origin: 트리거 버튼 위치 (anchor point)
```

> 토큰: `animations.transitions.scale.in` — scale 0.85, duration 0.25s, spring.snappy

### Standard Menu 닫힘

```yaml
trigger: 항목 선택 / 외부 탭
duration: 0.15s
easing: easeIn — cubic-bezier(0.42, 0, 1.0, 1.0)
properties:
  scale: 1.0 → 0.85
  opacity: 1 → 0
```

> 토큰: `animations.transitions.scale.out` — scale 0.85, duration 0.15s, easeIn

### Edit Menu 등장

```yaml
trigger: 텍스트 선택 완료
duration: 0.2s
easing: easeOut
properties:
  opacity: 0 → 1
  translateY: 4pt → 0 (위에서 살짝 내려오며 등장)
```

### 서브메뉴 전환

```yaml
trigger: 서브메뉴 항목 hover/탭
duration: 0.2s
easing: easeInOut
properties:
  current_menu: translateX 0 → -30pt, opacity 1 → 0
  submenu: translateX 30pt → 0, opacity 0 → 1
```

### Reduce Motion

```yaml
prefers-reduced-motion:
  scale: 비활성화
  opacity: 0 → 1 (0.15s fade)
  서브메뉴: 즉시 전환
```

---

## 인터랙션 노트

### Standard Menu

| 인터랙션 | 동작 |
|---------|------|
| **트리거 버튼 탭** | 메뉴 즉시 등장 (long press 불필요) |
| **항목 탭** | 액션 실행 → 메뉴 닫힘 |
| **체크마크 항목 탭** | 선택 토글 → 메뉴 닫힘 (단일 선택) |
| **서브메뉴 항목 hover** | 서브메뉴 슬라이드 전환 |
| **외부 탭** | 메뉴 닫힘 |
| **Destructive 탭** | 위험 액션 실행 → 닫힘 |
| **Disabled 항목** | 탭 무시, `labels.quaternary` 색상 |

### Edit Menu

| 인터랙션 | 동작 |
|---------|------|
| **텍스트 선택** | Edit Menu Bar 자동 표시 |
| **잘라내기/복사하기/붙여넣기** | 클립보드 동작 → 메뉴 닫힘 |
| **⋯ (More) 탭** | 추가 메뉴 드롭다운 표시 |
| **선택 핸들 드래그** | 선택 범위 조정, 메뉴 임시 숨김 → 드래그 종료 시 재표시 |
| **다른 곳 탭** | 선택 해제 + 메뉴 닫힘 |

---

## 접근성 (Accessibility)

| 항목 | 요구사항 |
|------|---------|
| **VoiceOver (Standard)** | 트리거 버튼: "Menu, double-tap to open" 힌트 |
| **VoiceOver (Edit)** | 선택 시 "Edit menu available" 자동 안내 |
| **항목 탐색** | 각 항목: `accessibilityLabel + accessibilityTraits` |
| **체크마크** | 선택 항목: `accessibilityValue: "selected"` |
| **Destructive** | "Destructive action" 자동 접미사 |
| **서브메뉴** | "Submenu" 힌트 |
| **Disabled** | `accessibilityTraits: .notEnabled` |
| **터치 타겟** | 항목 44pt (Apple HIG 충족) |
| **키보드 숏컷** | iPadOS/macOS에서 키보드 숏컷 자동 표시 |
| **Dynamic Type** | 레이블 크기 조정 시 항목 높이 자동 확장 (44pt 최소) |
| **색상 대비** | Primary vs Liquid Glass: WCAG AA (4.5:1+) |
| **Reduce Motion** | scale 제거, opacity 전환만 |

---

## Context Menu와 비교

| 항목 | Standard Menu | Context Menu |
|------|-------------|-------------|
| 트리거 | 버튼 탭 (즉시) | Long Press (0.5초) |
| Preview | 없음 | 있음 (선택적) |
| Dimming | 없음/옅음 | 전체 화면 블러 |
| 주 용도 | 버튼 액션 목록, 정렬/필터 선택 | 콘텐츠 아이템 액션 |
| UIKit | `UIButton.menu` | `UIContextMenuInteraction` |
| SwiftUI | `Menu { } label: { }` | `.contextMenu { }` |

---

## 구현 체크리스트

- [ ] UIKit: `UIButton.menu` 또는 `UIBarButtonItem.menu` 사용
- [ ] SwiftUI: `Menu { } label: { }` 사용
- [ ] 체크마크 항목: `UIAction.state = .on` / `.off` / `.mixed`
- [ ] 서브메뉴: `UIMenu(children: [...])` 중첩
- [ ] Destructive: `UIAction.attributes = .destructive`
- [ ] Disabled: `UIAction.attributes = .disabled`
- [ ] Section Header: `UIMenu(title: "섹션명", options: .displayInline)`
- [ ] Edit Menu: `UIMenuController` (legacy) → `UIEditMenuInteraction` (iOS 16+)
- [ ] Liquid Glass 배경 (시스템 자동 적용)
- [ ] Light/Dark 모드 색상 토큰
- [ ] VoiceOver 접근성 검증
- [ ] Dynamic Type 대응

---

## 관련 화면

| 화면 | 관계 |
|------|------|
| `context-menu.md` | Context Menu (long press) vs Menu (즉시 등장) 비교 |
| `action-sheet.md` | 3개 이상 선택지 → Action Sheet 대안 |
| `keyboard.md` | Find Bar의 텍스트 선택과 Edit Menu 연동 |
| `list.md` | 리스트 정렬 메뉴 적용 예시 |
