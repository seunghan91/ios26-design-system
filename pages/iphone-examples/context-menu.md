# Context Menu — iPhone Full-Screen Example

> **References**
> - Components: `../../components/specs/context-menus.md`
> - Tokens: `../../tokens/colors.json`, `../../tokens/spacing.json`, `../../tokens/typography.json`, `../../tokens/animations.json`, `../../tokens/materials.json`
> - Sections: `../../sections/`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:25994")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Context Menu (Long-Press 컨텍스트 메뉴) |
| **디바이스** | iPhone 17 Pro — 402 × 874pt (@3x, 1206 × 2622px) |
| **용도** | 콘텐츠 요소에 관련된 액션을 미리보기와 함께 제공 |
| **트리거** | Long Press (0.5초), Haptic Touch |
| **프레젠테이션** | 오버레이 (전체 화면 블러 dimming + 미리보기 + 메뉴 카드) |
| **iOS 26 특이사항** | Liquid Glass 메뉴 카드 배경, 블러-only dimming (색상 오버레이 없음), spring scale 등장 |

Context Menu는 사용자가 요소를 길게 누르면 나타나는 인터랙티브 오버레이다. 탭한 요소의 확대 미리보기(Preview)와 관련 액션을 나열하는 메뉴 카드 두 부분으로 구성된다.

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

## 화면 구성 분해

### Variant A: Preview + Menu Below (트리거가 화면 상단)

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │  ← Status Bar (59pt)
│                                              │
│  ┌──── Blur Dimming Overlay ────────────────┐│  ← 전체 화면 블러
│  │  backdrop-filter: blur(20px)             ││    iOS 26: 블러만 (색상 오버레이 없음)
│  │                                          ││
│  │         ┌──── Preview ────────┐          ││  ← 미리보기 영역
│  │         │                     │          ││    최대 높이: 화면 40%
│  │         │  [콘텐츠 확대 미리보기] │          ││    최대 너비: 화면 - 32pt
│  │         │                     │          ││    cornerRadius: 12pt
│  │         │  (원본 요소가 scale-up │          ││    shadow: blur 20pt, offset (0,8)
│  │         │   되어 표시됨)       │          ││           opacity 0.3
│  │         │                     │          ││
│  │         └─────────────────────┘          ││
│  │                   ↕ 8pt gap              ││
│  │         ┌──── Menu Card ──────┐          ││  ← 메뉴 카드 (250pt 고정)
│  │         │                     │          ││    cornerRadius: 13pt
│  │         │  ⬆  공유             │          ││    Liquid Glass 배경
│  │         │  ───────────────── │          ││    높이: 44pt × 항목 수
│  │         │  📋  복사             │          ││
│  │         │  ───────────────── │          ││  ← separator: opaque 1px
│  │         │  ⭐  즐겨찾기         │          ││
│  │         │  ───────────────── │          ││
│  │         │  🗑  삭제        ⛔  │          ││  ← Destructive (red)
│  │         │                     │          ││
│  │         └─────────────────────┘          ││
│  │                                          ││
│  └──────────────────────────────────────────┘│
│  ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔│  ← Home Indicator (34pt)
└─────────────────────────────────────────────┘
```

### Variant B: No Preview + Menu Above (트리거가 화면 하단)

```
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │
│                                              │
│  ┌──── Blur Dimming ────────────────────────┐│
│  │                                          ││
│  │                                          ││
│  │         ┌──── Menu Card ──────┐          ││  ← 메뉴가 트리거 위에 배치
│  │         │  ⬆  공유             │          ││
│  │         │  ───────────────── │          ││
│  │         │  📋  복사             │          ││
│  │         │  ───────────────── │          ││
│  │         │  🗑  삭제        ⛔  │          ││
│  │         └─────────────────────┘          ││
│  │                   ↕ 8pt                  ││
│  │         [원본 요소 위치 (하이라이트)]        ││  ← 트리거 요소
│  │                                          ││
│  └──────────────────────────────────────────┘│
│  ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔│
└─────────────────────────────────────────────┘
```

---

## 컴포넌트별 토큰 참조

### Dimming Overlay

| 역할 | 값 | 비고 |
|------|-----|------|
| 크기 | 전체 화면 (Safe Area 포함) | — |
| 배경 색상 | 투명 (iOS 26 기준) | iOS 15-17: `rgba(0,0,0,0.4)` 이었으나 iOS 26에서 변경 |
| 블러 반경 | 20pt | `backdrop-filter: blur(20px)` |
| 탭 동작 | 메뉴 닫기 | — |

### Preview 영역

| 역할 | 값 | 토큰 |
|------|-----|------|
| 최대 높이 | 화면 높이 × 0.4 (= ~350pt) | — |
| 최대 너비 | 화면 너비 - 32pt (= ~370pt) | `spacing.contentMargin.iphone.horizontal` × 2 |
| cornerRadius | 12pt | `spacing.radius.lg` |
| Shadow blur | 20pt | — |
| Shadow offset | (0, 8) | — |
| Shadow opacity | 0.3 | — |

### Menu Card

| 역할 | 값 | 토큰 |
|------|-----|------|
| 너비 | 250pt (고정) | — |
| 항목 높이 | 44pt | `spacing.components.touchTarget.minimum` |
| 코너 반경 | 13pt | `spacing.radius.semantic.menu` = 14pt (근사) |
| 내부 수평 패딩 | 16pt (좌우) | `spacing.inset.md` |
| 배경 (Light) | Liquid Glass: `rgba(255,255,255,0.72)` + blur 20px + saturate 180% | `materials.liquidGlass` |
| 배경 (Dark) | Liquid Glass: `rgba(28,28,30,0.72)` + blur 20px + saturate 150% | `materials.liquidGlass` |
| Preview ↔ Menu 간격 | 8pt | — |

### Menu Item

| 역할 | 토큰 | Light | Dark |
|------|------|-------|------|
| 레이블 색상 | `colors.labels.primary` | `#000000` | `#ffffff` |
| Destructive 색상 | `colors.accents.red` | `#ff383c` | `#ff4245` |
| 아이콘 크기 | — | 20pt (SF Symbol) | 20pt |
| 아이콘 ↔ 레이블 간격 | — | 12pt | 12pt |
| 섹션 구분선 | `colors.separators.opaque` | `#c6c6c8` | `#38383a` |
| Hover/Highlighted | `colors.fills.tertiary` | `rgba(118,118,128,0.12)` | `rgba(118,118,128,0.24)` |
| Submenu chevron | SF Symbol `chevron.right`, 17pt | `labels.secondary` | `labels.secondary` |

### Typography

| 요소 | 스타일 | 크기 | 굵기 | 토큰 |
|------|--------|------|------|------|
| 항목 레이블 | Body | 17pt | Regular | `typography.styles.body` |
| Destructive 레이블 | Body | 17pt | Regular | (색상만 red) |
| 섹션 헤더 (있을 때) | Caption2 | 11pt | Regular | `typography.styles.caption2` |
| Keyboard shortcut | Subheadline | 15pt | Regular | `typography.styles.subheadline` |

---

## Light/Dark 모드 차이

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| Dimming overlay | blur 20px (색상 없음) | blur 20px (색상 없음) |
| Menu card 배경 | `rgba(255,255,255,0.72)` + blur + saturate 180% | `rgba(28,28,30,0.72)` + blur + saturate 150% |
| 레이블 (Primary) | `#000000` | `#ffffff` |
| Destructive | `#ff383c` | `#ff4245` |
| 구분선 (Opaque) | `#c6c6c8` | `#38383a` |
| Highlighted | `rgba(118,118,128,0.12)` | `rgba(118,118,128,0.24)` |
| Preview shadow | `rgba(0,0,0,0.3)` | `rgba(0,0,0,0.5)` |
| Status Bar | `.darkContent` | `.lightContent` |

---

## 애니메이션

### 등장 (Presentation)

```yaml
trigger: Long press 인식 (0.5초)
haptic: UIImpactFeedbackGenerator(.medium) — 즉시

timeline:
  0ms:
    - scale: 0.8, opacity: 0 (시작 상태)
    - dimming blur: 0
  0–300ms:
    - preview: scale 0.8 → 1.0, opacity 0 → 1 (spring)
    - spring: stiffness 400, damping 38
    - css_approx: cubic-bezier(0.34, 1.56, 0.64, 1.0)
  30ms delay:
    - menu_card: scale 0.8 → 1.0, opacity 0 → 1 (같은 spring, 30ms 지연)
  0–200ms:
    - dimming: blur 0 → 20px, opacity 0 → 1
    - easing: easeOut
```

> 토큰: `animations.transitions.scale.in` (scale 0.85→1, 0.25s, spring.snappy), 여기서는 context menu 전용 파라미터 사용

### 닫힘 (Dismissal)

```yaml
trigger: 외부 탭 / 액션 선택 / 스와이프 다운
duration: 200ms
easing: easeIn — cubic-bezier(0.42, 0, 1.0, 1.0)
properties:
  scale: 1.0 → 0.8
  opacity: 1 → 0
dimming:
  blur: 20px → 0
  duration: 150ms
```

### 서브메뉴 전환

```yaml
trigger: 서브메뉴 항목 탭
duration: 200ms
easing: easeInOut
properties:
  current_menu: translateX 0 → -30pt, opacity 1 → 0
  submenu: translateX 30pt → 0, opacity 0 → 1
back_navigation:
  trigger: 헤더 chevron.left 탭 또는 스와이프
  direction: 역방향
```

### Reduce Motion

```yaml
prefers-reduced-motion:
  scale: 비활성화
  opacity: 0 → 1 (fade only, 0.2s)
  blur: 즉시 적용
  서브메뉴: 즉시 전환 (슬라이드 없음)
```

---

## 인터랙션 노트

| 인터랙션 | 동작 |
|---------|------|
| **Long press (0.5초)** | 햅틱 + Context Menu 등장 |
| **메뉴 항목 탭** | 액션 실행 → 메뉴 닫힘 |
| **Destructive 항목 탭** | 위험 액션 실행 → 닫힘 |
| **서브메뉴 항목 탭** | 서브메뉴 슬라이드 전환 |
| **서브메뉴 뒤로가기** | 헤더 `chevron.left` 탭 또는 스와이프 right |
| **외부 (dimming) 탭** | 메뉴 닫힘 |
| **스와이프 다운** | 메뉴 닫힘 |
| **Preview 탭** | 해당 콘텐츠로 네비게이션 (push) + 메뉴 닫힘 |
| **Preview에서 위로 스와이프** | 메뉴 항목으로 포커스 이동 |
| **3D Touch (레거시)** | Peek → Pop으로 동작 (Context Menu와 통합됨) |

### 위치 결정 로직

```
if (트리거 Y좌표 > 화면 높이 × 0.5) {
  메뉴 위치 = 트리거 위 (Menu Above)
} else {
  메뉴 위치 = 트리거 아래 (Menu Below)
}

if (메뉴 + 프리뷰 높이 > 사용 가능 공간) {
  스크롤 가능 모드 활성화
}
```

---

## 접근성 (Accessibility)

| 항목 | 요구사항 |
|------|---------|
| **VoiceOver** | 메뉴 열릴 때 "Context menu, [N] options" 안내 |
| **항목 탐색** | 각 항목 `accessibilityLabel` 명시적 설정 |
| **Destructive** | "Destructive action" 접미사 자동 추가 (UIAccessibility) |
| **서브메뉴** | "Submenu, double-tap to open" 힌트 |
| **닫기** | 두 손가락 Z스크럽 제스처로 닫기 |
| **UIMenu 시맨틱** | 자동으로 `UIMenu` 의미론적 역할 부여 |
| **터치 타겟** | 항목 높이 44pt — Apple HIG 최소 충족 |
| **Dynamic Type** | 레이블 크기 변경 시 항목 높이 자동 조정 (44pt 최소 유지) |
| **색상 대비** | Primary 텍스트 vs Liquid Glass 배경: WCAG AA (4.5:1) |
| **색상 대비 (Destructive)** | `#ff383c` vs Liquid Glass: ~4.0:1 (AA Large 충족) |
| **Reduce Motion** | scale 비활성화 → fade only |
| **키보드** | 화살표 키로 항목 이동, Enter로 선택, Escape로 닫기 |
| **Switch Control** | 모든 메뉴 항목에 순차 접근 |

---

## 구현 체크리스트

- [ ] UIKit: `UIContextMenuInteraction` + delegate 설정
- [ ] SwiftUI: `.contextMenu { } preview: { }` 사용
- [ ] Preview 필요 여부 결정 (`previewProvider: nil` vs 커스텀 뷰)
- [ ] Destructive 항목에 `attributes: .destructive` / `role: .destructive`
- [ ] 서브메뉴 깊이 2단계 이내
- [ ] 메뉴 카드 너비 250pt, 항목 높이 44pt
- [ ] Liquid Glass 배경 + blur 20px
- [ ] 등장 spring (stiffness 400, damping 38)
- [ ] 햅틱 피드백 (long press 인식 시)
- [ ] Reduce Motion → fade only
- [ ] VoiceOver 포커스 순서 검증
- [ ] Dynamic Type 대응

---

## 관련 화면

| 화면 | 관계 |
|------|------|
| `menus.md` | Menu (탭으로 즉시 등장) vs Context Menu (long press) 비교 |
| `action-sheet.md` | 액션 선택 대안 (하단 시트 방식) |
| `list.md` | 리스트 항목에 Context Menu 적용 예시 |
