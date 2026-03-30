> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/animations.json`, `../tokens/materials.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24678")`

# Notifications — Component Spec

## 1. Overview

iOS 26 Notification은 Lock Screen 및 Notification Center에 표시되는 알림 카드 컴포넌트다. Liquid Glass 소재를 배경으로 사용하며, 여러 알림이 쌓일 때 Stack 형태로 표시된다. Collapsed/Expanded/Single 3가지 주요 타입이 존재한다.

| 항목 | 값 |
|------|-----|
| Figma Node | `507:24678` (Notifications page) |
| Section | `544:199441` (5 children) |
| 내부 컴포넌트 | `Notification - Collapsed/List`, `Notification - Expanded`, thumbnail variants, Action button, Time |

---

## 2. Dimensions

### 기본 카드 치수

| 속성 | 값 | 출처 |
|------|-----|------|
| Width | `screen width - 32pt` (양쪽 16pt margin) = **343pt** on iPhone 16 (390pt) | `spacing.json` > `contentMargin.iphone.horizontal: 16` |
| cornerRadius | `20pt` | `spacing.json` > `radius.semantic.notification` |
| Collapsed Height | `~84pt` | Figma 측정값 |
| Expanded Height | 콘텐츠에 따라 가변 (최대 화면 50%) | |
| Padding Horizontal | `16pt` | `spacing.json` > `inset.md` |
| Padding Vertical | `12pt` | `spacing.json` > `inset.sm` |
| App Icon Size | `40pt × 40pt` | |
| App Icon cornerRadius | `10pt` | `spacing.json` > `radius.md` |
| Action Button Height | `44pt` (Liquid Glass Small) | `spacing.json` > `components.touchTarget.minimum` |

### Stack 치수 (Collapsed Stack)

| 속성 | 값 |
|------|-----|
| Z-offset per card (depth) | `8pt` (하단 카드가 위쪽에 더 가까이) |
| Scale per card behind | `0.96` (뒤로 갈수록 96%씩 축소) |
| Visible stack depth | 최대 3장 (4번째 이상은 숨김) |
| Stack indicator 텍스트 | "x개 더" (3번째 카드 위에 표시) |

### 내부 레이아웃 구조

#### Single / Collapsed (펼쳐진 단일)
```
┌────────────────────────────────────────────────────┐ ← w:343, r:20, h:~84
│ [앱 아이콘 40×40]  앱 이름         ⋯  [시간]  │ ← paddingV: 12, paddingH: 16
├────────────────────────────────────────────────────┤
│  제목 텍스트 (Subheadline, Bold)                    │
│  본문 미리보기 텍스트 (Footnote, Regular, 2줄)       │
└────────────────────────────────────────────────────┘
```

#### Expanded (확장됨)
```
┌────────────────────────────────────────────────────┐ ← r:20, h: variable
│ [앱 아이콘 40×40]  앱 이름         ⋯  [시간]  │
├────────────────────────────────────────────────────┤
│  제목 텍스트                                        │
│  본문 전체 텍스트 (최대 5줄)                         │
│  [썸네일 이미지 - 있는 경우]                         │
├────────────────────────────────────────────────────┤
│  [액션 버튼 1]  [액션 버튼 2]  [액션 버튼 3]        │
└────────────────────────────────────────────────────┘
```

#### Collapsed Stack (쌓인 알림)
```
      ┌──────────────────────────────────────────────┐ ← 맨 앞 카드 (scale: 1.0)
     ┌┼──────────────────────────────────────────────┤ ← 두번째 카드 (scale: 0.96, offset: -8pt)
    ┌┼┼──────────────────────────────────────────────┤ ← 세번째 카드 (scale: 0.92, offset: -16pt)
    │││  앱 이름                       [N개 더]       │
    │││  가장 최근 알림 제목                           │
    └┴┴──────────────────────────────────────────────┘
```

---

## 3. Variants

### 3-1. Single (단일 알림)
- 1개 앱에서 1개 알림
- 기본 collapsed 형태
- Expanded로 확장 가능

### 3-2. List (목록형 알림 — Collapsed/List)
- 같은 앱에서 여러 알림을 목록으로 표시
- 카드 내부에 알림 항목이 리스트 형태로 나열
- 항목당 높이: ~44pt

### 3-3. Expanded
- 탭하거나 길게 눌러 확장
- 전체 메시지 내용 표시
- Action button 표시
- 썸네일 이미지 표시 (첨부파일 있는 경우)

### 3-4. Thumbnail 포함 variant
- 우측에 작은 썸네일 이미지 (`48×48pt` 또는 `160×84pt` wide 이미지)
- 이미지 cornerRadius: `8pt`

### 3-5. Stacked (앱 그룹)
- 동일 앱의 여러 알림을 카드 스택으로 표시
- 상단 카드 탭 → 목록 확장
- "N개 알림" 표시

---

## 4. Color Tokens (Liquid Glass)

Notification 배경은 `materials.json`의 `liquidGlass.regular.large`를 사용한다.

| 역할 | 토큰 경로 | Light | Dark |
|------|----------|-------|------|
| 카드 배경 (base) | `liquidGlass.regular.large.light.bg` | `#fafafa / a:0.7` | `#000000 / a:0.8` |
| Dark tint | `liquidGlass.regular.large.dark.tint` | — | `#ffffff / a:0.06` |
| Frost Blur | `liquidGlass.regular.large.frostRadius` | `14px blur` | `14px blur` |
| Shadow | `liquidGlass.regular.large.shadow.blur` | `blur: 40` | `blur: 40` |
| 앱 이름 텍스트 | `labels.secondary` | `#3c3c43 / a:0.6` | `#ebebf5 / a:0.7` |
| 시간 텍스트 | `labels.tertiary` | `#3c3c43 / a:0.3` | `#ebebf5 / a:0.3` |
| 제목 텍스트 | `labels.primary` | `#000000 / a:1` | `#ffffff / a:1` |
| 본문 텍스트 | `labels.secondary` | `#3c3c43 / a:0.6` | `#ebebf5 / a:0.7` |
| 구분선 (list item) | `separators.nonOpaque` | `#000000 / a:0.12` | `#ffffff / a:0.17` |
| Action 버튼 | Liquid Glass Small style | 별도 정의 |

### Action 버튼 (Liquid Glass Small)
```css
/* materials.json > liquidGlass.regular.small.light.default */
background: rgba(247, 247, 247, 1.0); /* light default */
border: 1px solid #dddddd;
backdrop-filter: blur(7px);  /* frostRadius: 7 */
border-radius: 1000px;       /* pill shape, radius.semantic.liquidGlass.small */

/* Dark mode */
background: rgba(0, 0, 0, 0.6);
border: none;
```

---

## 5. Typography

| 요소 | Style | Font | Weight | Size | Line Height |
|------|-------|------|--------|------|-------------|
| 앱 이름 | Subheadline | SF Pro Text | Regular | 15pt | 20pt |
| 알림 제목 | Subheadline | SF Pro Text | Semibold | 15pt | 20pt |
| 본문 미리보기 | Footnote | SF Pro Text | Regular | 13pt | 18pt |
| 시간 | Caption 1 | SF Pro Text | Regular | 12pt | 16pt |
| Action 버튼 텍스트 | Footnote | SF Pro Text | Regular | 13pt | 18pt |
| Stack 카운트 ("N개 더") | Caption 1 | SF Pro Text | Semibold | 12pt | 16pt |

텍스트 최대 줄 수:
- 제목: 1줄 (truncated)
- 본문 (collapsed): 2줄
- 본문 (expanded): 최대 5줄
- 앱 이름: 1줄

---

## 6. State Transitions

| 상태 | 시각 변화 |
|------|----------|
| Default (collapsed) | 단일 카드 또는 스택 표시 |
| Highlighted (pressed) | Liquid Glass opacity 살짝 증가, scale 0.97 |
| Expanding | 카드 높이 증가, action button 등장, 애니메이션 |
| Expanded | 전체 내용 표시, action button 활성 |
| Collapsing | 높이 감소, action button 퇴장 |
| Stack Expanding | 스택 카드들이 아래로 펼쳐지며 목록 표시 |
| Swiping Right | 시스템 액션 노출 (설정, 전달 등) |
| Swiping Left | 삭제/닫기 액션 노출 |
| Dismissed | 슬라이드 아웃 + fade out |

---

## 7. Animation

### Notification 등장 (상단 슬라이드인)
```yaml
trigger: 새 알림 수신
duration: 0.4s  # animations.json > duration.semantic.notificationSlide
easing: spring.bouncy  # cubic-bezier(0.68, -0.55, 0.265, 1.55)
spring_preset: bouncy
  response: 0.5
  dampingRatio: 0.65
properties:
  translateY: -100px → 0   # 상단에서 슬라이드 다운
  opacity: 0 → 1
  scale: 0.9 → 1.0
liquid_glass:
  blur: 0 → 14px  # frosting 점진적 활성화
```

### Stack 표시 (여러 알림)
```yaml
trigger: 스택에 카드 추가 시
properties:
  cards_behind:
    scale: 각 카드 1.0에서 0.96씩 감소
    translateY: 각 카드 -8pt씩 위로 이동 (depth z-offset)
  duration: 0.3s
  easing: spring.snappy  # cubic-bezier(0.34, 1.56, 0.64, 1.0)
```

### Expand (확장)
```yaml
trigger: 알림 카드 탭 또는 길게 누르기
duration: 0.35s
easing: spring.gentle  # cubic-bezier(0.25, 0.46, 0.45, 0.94)
properties:
  height: ~84pt → content height (variable)
  action_buttons: opacity 0 → 1, translateY 10pt → 0 (딜레이 0.1s)
  thumbnail: opacity 0 → 1 (딜레이 0.05s)
```

### Dismiss (스와이프 또는 탭)
```yaml
trigger: 알림 좌측 스와이프 → 삭제 또는 외부 탭
duration: 0.3s
easing: easeIn  # cubic-bezier(0.42, 0, 1.0, 1.0)
properties:
  translateX: 0 → screen_width  # 오른쪽으로 날아감
  opacity: 1 → 0
  scale: 1.0 → 0.95
```

### Stack Expand (그룹 펼치기)
```yaml
trigger: 스택 카드 탭
duration: 0.4s
easing: spring.gentle
properties:
  각 카드: scale 0.96^n → 1.0, translateY 축소 → 각자 높이
  연속 딜레이: 카드당 0.05s 간격
```

### iOS Native (UserNotifications)
```swift
// Push notification 수신 — 시스템이 자동으로 Lock Screen/Banner 표시
// 커스텀 Notification Content Extension:
class NotificationViewController: UIViewController, UNNotificationContentExtension {
    func didReceive(_ notification: UNNotification) {
        // 커스텀 UI 구성
        // preferredContentSize로 높이 설정
    }
}
```

### Flutter 구현 (OverlayEntry 방식)
```dart
// 앱 내 커스텀 알림 배너 (in-app notification)
OverlayEntry(
  builder: (_) => Positioned(
    top: MediaQuery.of(context).padding.top + 8,
    left: 16,
    right: 16,
    child: AnimatedNotificationCard(
      // Spring bouncy animation
      // translateY: -100px → 0
      // opacity: 0 → 1
    ),
  ),
)
```

### CSS/Svelte 구현
```css
/* Stack 카드 CSS */
.notification-stack .card:nth-child(2) {
  transform: translateY(-8px) scale(0.96);
  z-index: -1;
}
.notification-stack .card:nth-child(3) {
  transform: translateY(-16px) scale(0.9216); /* 0.96 * 0.96 */
  z-index: -2;
}

/* 등장 애니메이션 */
@keyframes notification-in {
  from {
    transform: translateY(-100px) scale(0.9);
    opacity: 0;
  }
  to {
    transform: translateY(0) scale(1.0);
    opacity: 1;
  }
}
.notification-enter {
  animation: notification-in 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55) forwards;
}
```

---

## 8. Accessibility

| 항목 | 요구사항 |
|------|---------|
| VoiceOver role | `UIAccessibilityTraitStaticText` (알림 내용), `UIAccessibilityTraitButton` (action buttons) |
| accessibilityLabel | "앱 이름. 제목. 본문 미리보기. 시간 전" 순으로 읽음 |
| accessibilityCustomActions | Expand, Dismiss, 각 Action 버튼들 |
| 최소 탭 타겟 | Action 버튼 `44×44pt` |
| Dynamic Type | 모든 텍스트 Dynamic Type 지원. 크기 증가 시 카드 높이 자동 조절. |
| Reduce Motion | spring bounce 제거, 단순 fade + minimal translateY (30px) |
| 색상 대비 | 제목 텍스트 vs Liquid Glass 배경: 최소 4.5:1 (WCAG AA) |
| 알림 그룹화 | VoiceOver: "XX에서 N개 알림, 탭하여 펼치기" 읽음 |
| 키보드 탐색 (iPadOS) | Tab으로 알림 간 이동, Enter로 확장, Delete로 삭제 |
| 시스템 알림 권한 | `UNUserNotificationCenter.requestAuthorization()` 명시적 요청 필수 |

---

## 9. Framework Notes

### UserNotifications 프레임워크 (iOS Native)
```swift
import UserNotifications

// 알림 권한 요청
UNUserNotificationCenter.current().requestAuthorization(
    options: [.alert, .badge, .sound]
) { granted, _ in
    guard granted else { return }
}

// Local notification 발송
let content = UNMutableNotificationContent()
content.title = "제목"
content.body = "본문 내용"
content.sound = .default

// 커스텀 UI (Notification Content Extension)
// Info.plist에 NSExtension 설정 필요
// UNNotificationContentExtensionPrincipalClass 지정
```

### Notification Content Extension
- 커스텀 알림 UI는 `UNNotificationContentExtension` 프로토콜 구현
- `preferredContentSize`로 expanded 높이 지정
- `didReceive(_:completionHandler:)` 으로 action 버튼 처리
- Widget Extension과 같은 `com.apple.notification-content` extension point 사용

### Action 버튼 구성
```swift
let replyAction = UNTextInputNotificationAction(
    identifier: "REPLY_ACTION",
    title: "답장",
    options: [],
    textInputButtonTitle: "보내기",
    textInputPlaceholder: "메시지 입력..."
)
let category = UNNotificationCategory(
    identifier: "MESSAGE_CATEGORY",
    actions: [replyAction],
    intentIdentifiers: [],
    options: .customDismissAction
)
```

### Flutter에서의 시스템 알림
- `flutter_local_notifications` 패키지 사용
- iOS에서 큰 이미지/커스텀 UI는 `flutter_local_notifications` + iOS Extension 조합 필요
- Android는 `BigPictureStyle`, `MessagingStyle` NotificationCompat 사용

### 주의사항
- Notification UI (Lock Screen/NC)는 Notification Content Extension으로만 커스텀 가능. 기본 알림 카드 UI는 시스템이 렌더링.
- iOS 26 Liquid Glass 효과는 시스템 알림에만 자동 적용됨. 앱 내 커스텀 배너는 직접 구현 필요.
- Stack 표시 로직은 iOS 시스템이 제어. 앱은 `threadIdentifier`로 그룹핑만 지정 가능.
- Lock Screen 알림과 Banner 알림은 동일 내용이지만 크기/위치가 다름. `UNNotificationPresentationOptions`로 foreground 시 동작 설정.
