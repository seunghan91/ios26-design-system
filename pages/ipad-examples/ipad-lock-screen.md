# iPad Lock Screen — iOS 26 iPad 페이지 예시

> **References**
> - Components: `../../components/specs/system-ui.md`, `../../components/specs/widgets.md`, `../../components/specs/notifications.md`
> - Tokens: `../../tokens/colors.json`, `../../tokens/spacing.json`, `../../tokens/typography.json`, `../../tokens/materials.json`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24688")`

---

## 1. 화면 개요

iPad Lock Screen은 잠금 상태에서 시간, 날짜, 위젯, 알림을 표시하는 시스템 UI다. iOS 26에서는 **Liquid Glass** 소재가 위젯과 시계 영역에 적용되며, 커스터마이즈 가능한 위젯 배치를 지원한다. iPad landscape 모드에서는 시간이 중앙에 위치하고 위젯이 좌우로 배치되는 독특한 레이아웃을 가진다.

| 항목 | 값 |
|------|-----|
| **디바이스** | iPad Pro 13" (1210 x 834pt landscape) |
| **플랫폼** | iPadOS 26 |
| **인증 방법** | Face ID (iPad Pro) / Touch ID (iPad Air/mini) |
| **커스터마이즈** | 배경화면, 시계 스타일, 위젯, 포커스 연동 |
| **iOS 26 특징** | Liquid Glass 위젯, 개선된 Always-On Display |

---

## 2. 디바이스 컨텍스트

```
┌──────────────────────────────────────────────────────────────────────────────────┐
│                              iPad Pro 13" Bezel                                  │
│  ┌────────────────────────────────────────────────────────────────────────────┐  │
│  │                          1210 x 834pt (landscape)                         │  │
│  │                                                                           │  │
│  │  TrueDepth Camera: 상단 중앙 (Face ID)                                   │  │
│  │  Safe Area: top=24pt, bottom=20pt                                         │  │
│  │  Home Indicator: 없음 (iPad)                                               │  │
│  │                                                                           │  │
│  └────────────────────────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────────────────────┘
```

---

## 3. Landscape 레이아웃

### 3.1 전체 와이어프레임

```
┌─────────────────────────────────────────────────────────────────────────┐
│ STATUS BAR (24pt) — 시간(좌상단), 배터리/Wi-Fi(우상단)                    │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│                                                                         │
│  ┌──────────────┐                                ┌──────────────┐      │
│  │ Lock Screen  │                                │ Lock Screen  │      │
│  │ Widget       │                                │ Widget       │      │
│  │ (좌측)       │         9:41                   │ (우측)       │      │
│  │              │      수요일, 3월 28일            │              │      │
│  │ [Circular]   │                                │ [Circular]   │      │
│  │ [Circular]   │                                │ [Circular]   │      │
│  │              │                                │              │      │
│  └──────────────┘                                └──────────────┘      │
│                                                                         │
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐    │
│  │  Notification Area (중앙 하단)                                   │    │
│  │  ┌────────────────────────────────────────────────────┐         │    │
│  │  │  [📱] 메시지  2개의 알림                            │         │    │
│  │  └────────────────────────────────────────────────────┘         │    │
│  └─────────────────────────────────────────────────────────────────┘    │
│                                                                         │
│  ┌───────┐                                              ┌───────┐      │
│  │ 🔦    │            ─── Swipe up to unlock ───       │ 📷    │      │
│  │(Quick │                                              │(Quick │      │
│  │Action)│                                              │Action)│      │
│  └───────┘                                              └───────┘      │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 4. 시계 영역

### 4.1 중앙 시계

| 속성 | 값 | 토큰 참조 |
|------|-----|----------|
| 시간 폰트 | SF Pro Rounded, 96pt | 커스텀 (시스템 전용) |
| 시간 폰트 Weight | Bold | — |
| 시간 Line Height | 96pt | — |
| 시간 Letter Spacing | -2pt | — |
| 날짜 폰트 | Title3 (20pt) | `typography.styles.title3` |
| 날짜 Weight | Semibold | — |
| 시간-날짜 간격 | 4pt | — |
| 위치 | 화면 수평/수직 중앙 | — |

### 4.2 시계 스타일 옵션

| 스타일 | 설명 |
|--------|------|
| 기본 | SF Pro Rounded, Bold, 단색 |
| 커스텀 색상 | accent color 적용 가능 (모든 system accent) |
| Depth Effect | 배경화면 주체가 시계 앞으로 겹침 |
| Duo Tone | 상단/하단 다른 색상 |

### 4.3 시계 색상

| 속성 | Light | Dark | 토큰 참조 |
|------|-------|------|----------|
| 기본 색상 | `#ffffff` | `#ffffff` | — |
| Shadow | blur(4px), `#000` a:0.3 | blur(4px), `#000` a:0.5 | 배경 위 가독성 |
| 날짜 색상 | `#ffffff` (a: 0.8) | `#ffffff` (a: 0.8) | — |

---

## 5. 위젯 영역

### 5.1 Lock Screen 위젯 슬롯

iPad landscape에서 Lock Screen 위젯은 시계 좌우에 배치된다.

```
좌측 위젯 영역 (시계 왼쪽):
  위치: x=40pt, y=200pt (대략)
  사용 가능 위젯:
    - Accessory Circular (44 x 44pt) x 2~3개
    - Accessory Rectangular (338 x 58pt) x 1개

우측 위젯 영역 (시계 오른쪽):
  위치: x=830pt, y=200pt (대략)
  사용 가능 위젯:
    - Accessory Circular (44 x 44pt) x 2~3개
    - Accessory Rectangular (338 x 58pt) x 1개
```

### 5.2 위젯 타입 (Lock Screen)

| 위젯 | 크기 | 설명 | WidgetFamily |
|------|------|------|--------------|
| Accessory Circular | 44 x 44pt | 원형, 시계 하단 좌우 | `.accessoryCircular` |
| Accessory Rectangular | 338 x 58pt | 직사각형, 시계 하단 중앙 | `.accessoryRectangular` |
| Accessory Inline | 최대 ~280pt 너비 | 한 줄 텍스트+아이콘, 날짜 위 | `.accessoryInline` |

### 5.3 위젯 렌더링

| 속성 | 값 |
|------|-----|
| 배경 | Vibrant (배경화면에 따라 자동 tint) |
| 렌더링 모드 | `.accented` (단색 tint) 또는 `.fullColor` |
| Shadow | blur(2px), `#000` a:0.3 |
| Always-On Display | 밝기 감소, 색상 desaturate |

---

## 6. 알림 영역

### 6.1 iPad Lock Screen 알림 배치

```
알림은 시계 아래, Quick Action 위에 배치:

┌────────────────────────────────────────────────────────────┐
│  [앱 아이콘 40x40]  앱 이름                    2분 전      │
│                                                            │
│  알림 제목 (Subheadline, Bold)                             │
│  알림 본문 미리보기 (Footnote, 2줄 truncation)              │
└────────────────────────────────────────────────────────────┘
  너비: 600pt (iPad landscape, 화면 중앙 정렬)
  높이: ~84pt
  cornerRadius: 20pt
  배경: Liquid Glass Regular Medium
```

| 속성 | 값 | 토큰 참조 |
|------|-----|----------|
| 알림 카드 너비 | 600pt | iPad landscape 전용 |
| Corner Radius | 20pt | `spacing.radius.semantic.notification` |
| 내부 패딩 | 16pt (수평), 12pt (수직) | `spacing.inset.md`, `spacing.inset.sm` |
| 앱 아이콘 | 40 x 40pt, r:10pt | — |
| 배경 (Light) | `#f5f5f5` (a: 0.6) | `materials.liquidGlass.regular.medium` |
| 배경 (Dark) | `#000000` (a: 0.6) | `materials.liquidGlass.regular.medium` |

### 6.2 알림 스택

```
여러 알림 시 (collapsed stack):
  ┌────────────────────────────────┐
  │ 최상단 알림                     │
  ├────────────────────────────────┤  ← z-offset 8pt
  │ 2번째 알림 (축소)               │
  ├────────────────────────────────┤  ← z-offset 8pt
  │ 3번째+ (숨김, "x개 더" 표시)    │
  └────────────────────────────────┘

  Scale per depth: 0.96
  최대 보이는 카드: 3장
```

---

## 7. Quick Actions

### 7.1 하단 좌우 버튼

```
좌하단 Quick Action:              우하단 Quick Action:
┌──────────┐                      ┌──────────┐
│  🔦      │                      │  📷      │
│  44x44pt │                      │  44x44pt │
│  r:1000  │                      │  r:1000  │
└──────────┘                      └──────────┘
```

| 속성 | 값 | 토큰 참조 |
|------|-----|----------|
| 크기 | 44pt x 44pt | `spacing.components.touchTarget.minimum` |
| Corner Radius | 1000 (원형) | `spacing.radius.semantic.liquidGlass.small` |
| 배경 | Liquid Glass Small | `materials.liquidGlass.regular.small` |
| 아이콘 크기 | 22pt | — |
| 좌측 여백 | 40pt | — |
| 우측 여백 | 40pt | — |
| 하단 여백 | 40pt (+ safe area 20pt) | — |

### 7.2 기본 Quick Actions

| 위치 | 기본 앱 | 커스터마이즈 |
|------|---------|-----------|
| 좌하단 | 손전등 (Flashlight) | 사용자 변경 가능 |
| 우하단 | 카메라 (Camera) | 사용자 변경 가능 |

---

## 8. Light / Dark Mode 차이

| 요소 | Light Mode | Dark Mode | 토큰 참조 |
|------|-----------|-----------|----------|
| 시계 색상 | `#ffffff` (shadow 있음) | `#ffffff` (shadow 강화) | — |
| 위젯 tint | 배경화면 대비 자동 | 배경화면 대비 자동 | — |
| 알림 카드 배경 | `#f5f5f5` (a: 0.6) | `#000000` (a: 0.6) | `materials.liquidGlass.regular.medium` |
| Quick Action 배경 | `#f7f7f7` | `#000000` (a: 0.6) | `materials.liquidGlass.regular.small` |
| "Swipe up" 텍스트 | `#ffffff` (a: 0.6) | `#ffffff` (a: 0.6) | — |
| Status Bar | Light content | Light content | — (항상 밝은 텍스트) |

### Always-On Display (iPad Pro OLED)

| 속성 | 값 |
|------|-----|
| 화면 밝기 | 일반의 ~20% |
| 시계 | 풀 컬러 유지 (밝기 감소) |
| 배경화면 | desaturate + 어둡게 |
| 위젯 | 색상 유지, 밝기 감소 |
| 알림 | 표시되지 않음 (프라이버시) |
| 새로고침 | 1분 간격 |

---

## 9. iPad 전용 적응사항

### 9.1 Landscape vs Portrait

```
Landscape (1210 x 834pt):
  - 시계: 중앙
  - 위젯: 시계 좌우에 배치
  - 알림: 시계 아래, 600pt 너비
  - Quick Actions: 좌하단, 우하단

Portrait (834 x 1210pt):
  - 시계: 상단 1/3 영역 중앙
  - 위젯: 시계 바로 아래 (iPhone과 유사)
  - 알림: 위젯 아래, 화면 하단 방향으로 스택
  - Quick Actions: 좌하단, 우하단
```

### 9.2 Pointer 지원

| 인터랙션 | 동작 |
|---------|------|
| Tap / Click | 알림 확장 / 앱으로 이동 |
| Swipe up | 잠금 해제 |
| Long press (시계) | Lock Screen 커스터마이즈 모드 진입 |
| Long press (Quick Action) | 즉시 실행 (길게 누르기 불필요, 탭으로 충분) |

### 9.3 키보드 지원

| 동작 | 방법 |
|------|------|
| 잠금 해제 | 아무 키 입력 → 암호 입력 화면 |
| Face ID | 자동 (카메라 감지) |
| Touch ID | Home 버튼 (iPad Air/mini) |

---

## 10. 멀티태스킹 고려사항

Lock Screen은 멀티태스킹과 직접 관련 없으나:

- Stage Manager 활성 상태에서 잠금 시 → 잠금 해제 후 이전 윈도우 배치 복원
- 외부 디스플레이 연결 시 → iPad Lock Screen + 외부 디스플레이는 별도 잠금 (미러링 시 동일)
- Guided Access 활성 시 → 단일 앱 잠금 (Lock Screen 미표시)

---

## 11. Depth Effect (심도 효과)

### 11.1 배경화면 + 시계 겹침

```
레이어 순서 (뒤→앞):
  1. 배경화면 (뒷부분)
  2. 시계 텍스트
  3. 배경화면 (앞부분 — 주체 인물/사물)
  4. 위젯 (시계와 같은 레이어)
  5. 알림 (최상단)
```

| 속성 | 값 |
|------|-----|
| 지원 조건 | 인물/사물이 분리 가능한 배경화면 |
| ML 모델 | on-device saliency detection |
| 시계 가림 최대 | 시계 높이의 1/3까지 |
| 비활성화 | 위젯이 시계 영역과 겹칠 때 자동 비활성 |

---

## 12. 접근성

| 항목 | 설명 |
|------|------|
| VoiceOver | "잠금 화면, [시간], [날짜], [알림 수]개 알림" |
| Dynamic Type | 시계 크기는 고정, 위젯/알림 텍스트 조절 가능 |
| Reduce Transparency | Liquid Glass → 불투명 배경 |
| Reduce Motion | 잠금 해제 애니메이션 비활성화 |
| Assistive Access | 단순화된 Lock Screen (큰 시계, 큰 버튼) |

---

## 13. 관련 컴포넌트

| 컴포넌트 | 관계 | 참조 |
|---------|------|------|
| Notifications | Lock Screen 알림 카드 | `../../components/specs/notifications.md` |
| Widgets | Lock Screen 위젯 | `../../components/specs/widgets.md` |
| System UI | 시스템 레벨 UI | `../../components/specs/system-ui.md` |
