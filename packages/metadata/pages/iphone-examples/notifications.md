# Notifications — iOS 26 페이지 레시피

> **References**
> - Components: `../../components/specs/notifications.md`
> - Tokens: `../../tokens/`
> - Sections: `../../sections/`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24678")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Notifications (2 Variants) |
| **디바이스** | iPhone 17 Pro, 402 × 874pt |
| **용도** | 알림 표시 — Lock Screen, Notification Center |
| **iOS 26 특이사항** | Liquid Glass 카드 배경, 스택 깊이 효과, 인터랙티브 액션 |

2가지 variant: Collapsed Stack (그룹화된 알림 스택)과 Expanded (확장된 단일 알림). 알림 카드는 Liquid Glass 소재를 배경으로 사용한다.

---

## Variant 1: Collapsed Stack

### 화면 구성 분해

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41          ⠿ ▐▌ ■               │  ← Status Bar
├─────────────────────────────────────────────┤
│                                              │
│   (Lock Screen content above)                │
│                                              │
│      ┌─────────────────────────────────┐     │  ← Card 3 (behind, scale: 0.9216)
│     ┌┼─────────────────────────────────┤     │  ← Card 2 (behind, scale: 0.96)
│    ┌┼┼─────────────────────────────────┤     │  ← Card 1 (front, scale: 1.0)
│    │││                                 │     │
│    │││  [📱 40×40]  메시지    ⋯  2분 전 │     │    ← App icon + name + time
│    │││                                 │     │
│    │││  홍길동                           │     │    ← Title (subheadline bold)
│    │││  안녕하세요! 오늘 미팅 시간        │     │    ← Body preview (footnote, 2줄)
│    │││  확인해주세요...                   │     │
│    │││                                 │     │
│    └┴┴─────────────────────────────────┘     │
│             4개 더 보기                       │    ← Stack count
│                                              │
│      ┌─────────────────────────────────┐     │  ← Single notification (다른 앱)
│      │  [📧]  메일           5분 전     │     │
│      │  프로젝트 업데이트                │     │
│      │  이번 주 진행 상황을 공유합니다... │     │
│      └─────────────────────────────────┘     │
│                                              │
└─────────────────────────────────────────────┘
```

### Card Dimensions

| 속성 | 값 | 토큰 |
|------|-----|------|
| Width | `screen_width - 32pt` = 370pt (402 - 16*2) | `spacing.json > contentMargin.iphone.horizontal: 16` |
| cornerRadius | 20pt | `spacing.json > radius.semantic.notification` |
| Padding Horizontal | 16pt | `spacing.json > inset.md` |
| Padding Vertical | 12pt | `spacing.json > inset.sm` |
| Collapsed Height | ~84pt | Figma 측정값 |
| App Icon Size | 40×40pt | — |
| App Icon cornerRadius | 10pt | `spacing.json > radius.md` |

### Stack Depth Effect

| 속성 | 값 |
|------|-----|
| Z-offset per card | 8pt (뒤 카드가 위쪽에) |
| Scale per card behind | 0.96 (96%씩 축소) |
| 최대 visible depth | 3장 (4번째 이상 숨김) |
| Stack indicator | "N개 더" (Caption1 Semibold 12pt) |

```css
/* CSS 구현 */
.notification-stack .card:nth-child(1) {
  transform: translateY(0) scale(1.0);
  z-index: 3;
}
.notification-stack .card:nth-child(2) {
  transform: translateY(-8px) scale(0.96);
  z-index: 2;
}
.notification-stack .card:nth-child(3) {
  transform: translateY(-16px) scale(0.9216);  /* 0.96^2 */
  z-index: 1;
}
```

### Liquid Glass Background

| 역할 | Light | Dark | 토큰 |
|------|-------|------|------|
| 카드 배경 | `rgba(250,250,250,0.7)` | `rgba(0,0,0,0.8)` | `materials.json > liquidGlass.regular.large` |
| Dark tint | — | `rgba(255,255,255,0.06)` | `liquidGlass.regular.large.dark.tint` |
| Frost blur | 14px | 14px | `liquidGlass.regular.large.frostRadius` |
| Shadow | blur: 40 | blur: 40 | `liquidGlass.regular.large.shadow.blur` |

---

## Variant 2: Expanded Notification

### 화면 구성 분해

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41          ⠿ ▐▌ ■               │
├─────────────────────────────────────────────┤
│                                              │
│   (dimmed background)                        │
│                                              │
│  ┌───────────────────────────────────────┐   │  ← Expanded Card
│  │                                       │   │    cornerRadius: 20pt
│  │  [📱 40×40]  메시지         2분 전    │   │    Liquid Glass bg
│  │                                       │   │
│  │  홍길동                                │   │    ← Title (subheadline bold)
│  │                                       │   │
│  │  안녕하세요! 오늘 미팅 시간 확인해     │   │    ← Full body (footnote, max 5줄)
│  │  주세요. 오후 3시에 회의실 B에서       │   │
│  │  진행됩니다. 자료 준비 부탁드립니다.   │   │
│  │                                       │   │
│  │  ┌─────────────────────────────────┐  │   │    ← Thumbnail (선택적)
│  │  │  [첨부 이미지 160×84pt]          │  │   │      cornerRadius: 8pt
│  │  └─────────────────────────────────┘  │   │
│  │                                       │   │
│  │  ───────────────────────────────────  │   │    ← separator (nonOpaque)
│  │                                       │   │
│  │  ╭─────────╮ ╭─────────╮ ╭──────╮   │   │    ← Action Buttons
│  │  │  답장    │ │  좋아요  │ │ 무시  │   │   │      Liquid Glass Small
│  │  ╰─────────╯ ╰─────────╯ ╰──────╯   │   │      pill shape (r: 1000)
│  │                                       │   │      h: 44pt
│  └───────────────────────────────────────┘   │
│                                              │
└─────────────────────────────────────────────┘
```

### Action Buttons (Liquid Glass Small)

| 속성 | Light | Dark | 토큰 |
|------|-------|------|------|
| 배경 | `rgba(247,247,247,1.0)` | `rgba(0,0,0,0.6)` | `materials.json > liquidGlass.regular.small` |
| Border | `#dddddd` | none | — |
| blur | 7px | 7px | `frostRadius: 7` |
| cornerRadius | 1000px (pill) | 1000px | `spacing.json > radius.semantic.liquidGlass.small` |
| 높이 | 44pt | 44pt | `spacing.json > components.touchTarget.minimum` |
| 텍스트 | Footnote Regular 13pt | 13pt | `typography.json > styles.footnote` |
| 텍스트 색상 | `labels.primary` | `labels.primary` | `colors.json > labels.primary` |

---

## Typography

| 요소 | Style | Size | Weight | Line Height | 토큰 |
|------|-------|------|--------|-------------|------|
| 앱 이름 | Subheadline | 15pt | Regular | 20pt | `typography.json > styles.subheadline` |
| 알림 제목 | Subheadline | 15pt | Semibold | 20pt | — |
| 본문 (collapsed) | Footnote | 13pt | Regular | 18pt (2줄 max) | `typography.json > styles.footnote` |
| 본문 (expanded) | Footnote | 13pt | Regular | 18pt (5줄 max) | — |
| 시간 | Caption1 | 12pt | Regular | 16pt | `typography.json > styles.caption1` |
| Action 버튼 | Footnote | 13pt | Regular | 18pt | — |
| Stack count | Caption1 | 12pt | Semibold | 16pt | — |

### Text Colors

| 역할 | Light | Dark | 토큰 |
|------|-------|------|------|
| 앱 이름 | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.7)` | `labels.secondary` |
| 시간 | `rgba(60,60,67,0.3)` | `rgba(235,235,245,0.3)` | `labels.tertiary` |
| 제목 | `#000000` | `#ffffff` | `labels.primary` |
| 본문 | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.7)` | `labels.secondary` |
| List item separator | `rgba(0,0,0,0.12)` | `rgba(255,255,255,0.17)` | `separators.nonOpaque` |

---

## 애니메이션

### 알림 등장 (상단 슬라이드인)

```yaml
trigger: 새 알림 수신
duration: 0.4s                    # animations.json > duration.semantic.notificationSlide
easing: spring.bouncy             # cubic-bezier(0.68, -0.55, 0.265, 1.55)
spring: response 0.5, dampingRatio 0.65
properties:
  translateY: -100px → 0
  opacity: 0 → 1
  scale: 0.9 → 1.0
  liquid_glass_blur: 0 → 14px
```

### Stack 추가

```yaml
trigger: 같은 앱 알림 추가
duration: 0.3s
easing: spring.snappy             # cubic-bezier(0.34, 1.56, 0.64, 1.0)
properties:
  new_card: 위에서 슬라이드 인
  existing_cards: scale 0.96씩 감소, translateY -8pt씩
```

### 확장 (Expand)

```yaml
trigger: 카드 탭 또는 롱프레스
duration: 0.35s
easing: spring.gentle             # cubic-bezier(0.25, 0.46, 0.45, 0.94)
properties:
  height: ~84pt → content height
  action_buttons: opacity 0→1, translateY 10→0 (delay 0.1s)
  thumbnail: opacity 0→1 (delay 0.05s)
```

### Dismiss (스와이프)

```yaml
trigger: 좌측 스와이프 → 삭제
duration: 0.3s
easing: easeIn                    # cubic-bezier(0.42, 0, 1.0, 1.0)
properties:
  translateX: 0 → screen_width
  opacity: 1 → 0
  scale: 1.0 → 0.95
```

### Stack 펼치기

```yaml
trigger: 스택 카드 탭
duration: 0.4s
easing: spring.gentle
properties:
  each_card: scale 0.96^n → 1.0, translateY → 각자 높이
  stagger: 카드당 0.05s 간격
```

---

## Grouping & Actions

### 그룹핑 규칙

| 규칙 | 설명 |
|------|------|
| `threadIdentifier` | 동일 identifier → 하나의 스택 |
| 앱 기본 | 같은 앱의 알림 자동 그룹 |
| 시간순 | 최신 알림이 스택 맨 위 |

### 스와이프 액션

| 방향 | 액션 |
|------|------|
| 좌측 스와이프 | 삭제 (빨간색 배경) / 관리 |
| 우측 스와이프 | 열기 (파란색 배경) |
| 길게 누르기 | 확장 (액션 버튼 표시) |

---

## Light / Dark 모드 차이

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| 카드 배경 | `rgba(250,250,250,0.7)` + blur(14px) | `rgba(0,0,0,0.8)` + tint + blur(14px) |
| Shadow | blur 40, light | blur 40, dark |
| 제목 | `#000000` | `#ffffff` |
| 본문/앱이름 | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.7)` |
| 시간 | `rgba(60,60,67,0.3)` | `rgba(235,235,245,0.3)` |
| Action 버튼 bg | `rgba(247,247,247,1.0)`, border `#ddd` | `rgba(0,0,0,0.6)`, no border |
| Separator | `rgba(0,0,0,0.12)` | `rgba(255,255,255,0.17)` |

---

## 인터랙션 노트

- **탭**: 확장 (expanded) 또는 앱으로 이동
- **롱프레스**: 확장 + 액션 버튼 표시
- **좌측 스와이프**: 삭제 또는 관리 옵션
- **우측 스와이프**: 빠른 열기
- **스택 탭**: 그룹 내 알림 목록 펼치기
- **Highlighted 상태**: Liquid Glass opacity 증가, scale 0.97
- **Action 버튼 탭**: 해당 액션 실행 (답장, 좋아요 등)

---

## 접근성 고려사항

| 항목 | 요구사항 |
|------|---------|
| VoiceOver 읽기 | "앱 이름. 제목. 본문 미리보기. 시간 전" |
| accessibilityCustomActions | Expand, Dismiss, 각 Action 버튼 |
| 최소 탭 타겟 | Action 버튼 44×44pt |
| Dynamic Type | 모든 텍스트 Dynamic Type 지원, 크기 증가 시 카드 높이 자동 조절 |
| Reduce Motion | spring bounce 제거 → fade + minimal translateY (30px) |
| 색상 대비 | 제목 vs Liquid Glass 배경: 4.5:1 이상 (WCAG AA) |
| 그룹 VoiceOver | "앱이름에서 N개 알림, 탭하여 펼치기" |
| 키보드 (iPadOS) | Tab으로 알림 간 이동, Enter 확장, Delete 삭제 |
| 알림 권한 | `UNUserNotificationCenter.requestAuthorization()` 명시적 요청 |
