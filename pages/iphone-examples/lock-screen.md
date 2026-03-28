# Lock Screen — iOS 26 페이지 레시피

> **References**
> - Components: `../../components/specs/system-ui.md`, `../../components/specs/widgets.md`
> - Tokens: `../../tokens/`
> - Sections: `../../sections/status-bar.md`, `../../sections/system-region.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24688")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Lock Screen |
| **디바이스** | iPhone 17 Pro, 402 × 874pt |
| **용도** | 잠금 상태 — 시간, 날짜, 위젯, 알림, 빠른 액션 |
| **iOS 26 특이사항** | Dynamic Island 통합, Liquid Glass 위젯 배경, Always-On Display 최적화, 커스텀 폰트/색상 |

Lock Screen은 iPhone의 가장 자주 보는 화면이다. iOS 26에서는 잠금 화면 위젯이 Liquid Glass 소재를 사용하며, Dynamic Island과 Live Activity가 통합되어 실시간 정보를 표시한다. 사용자는 시계 폰트, 위젯 배치, 배경화면을 커스터마이징할 수 있다.

---

## 화면 구성 분해

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│                                              │
│        ╔══════════════╗                      │  ← Dynamic Island
│        ║   ████████   ║                      │    idle: 126×37pt
│        ╚══════════════╝                      │    위치: 상단 중앙, top 11pt
│                                              │
│   9:41    ⠿ ▐▌ ■                             │  ← Status Bar elements
│                                              │    시간: 좌상단 (body 17pt Semibold)
│                                              │
│   ┌──────────────────────────────┐           │  ← Accessory Inline Widget
│   │  ☀️ 22°C 맑음                 │           │    가변 너비, 최대 ~280pt
│   └──────────────────────────────┘           │    font: 14pt Regular
│                                              │
│                                              │
│              9:41                             │  ← Time Display (주 시계)
│                                              │    font: 가변 (86pt 기본)
│                                              │    weight: Bold
│                                              │    커스텀 폰트/색상 가능
│                                              │
│           3월 28일 금요일                      │  ← Date Display
│                                              │    font: Title3 (20pt)
│                                              │    위치: 시계 바로 아래
│                                              │
│   ┌────────────────────────────────────┐     │  ← Accessory Rectangular Widget
│   │  📅  다음 일정: 팀 미팅 오후 2시     │     │    338×58pt
│   │      회의실 B — 30분 후              │     │    bg: vibrant material
│   └────────────────────────────────────┘     │    font: caption bold + caption2
│                                              │
│   ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐   │  ← Accessory Circular Widgets
│   │  🔋  │  │  🏃  │  │  🌡  │  │  ⏰  │   │    4 slots, each 44×44pt
│   │  78% │  │ ring │  │ 22°  │  │ 3:00 │   │    bg: AccessoryWidgetBackground
│   └──────┘  └──────┘  └──────┘  └──────┘   │    circular clip
│                                              │
│                                              │
│   ┌─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┐   │  ← Notification Area
│   │  (알림이 있으면 여기에 스택 표시)       │   │    Notification cards
│   │   See: notifications.md               │   │    Liquid Glass bg
│   └─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┘   │
│                                              │
│                                              │
│  ┌──────┐                        ┌──────┐   │  ← Bottom Shortcuts
│  │  🔦  │                        │  📷  │   │    Flashlight / Camera
│  │      │                        │      │   │    각 44×44pt
│  └──────┘                        └──────┘   │    Liquid Glass Small pill
│                                              │
│              ─────                            │  ← Home Indicator (134×5pt)
└─────────────────────────────────────────────┘
```

---

## Dynamic Island Integration

### 5 States

| 상태 | 크기 | 설명 |
|------|------|------|
| Idle | 126×37pt | 기본 캡슐 형태 |
| Compact Leading | 250×37pt | 좌측 확장 (예: 타이머) |
| Compact Trailing | 250×37pt | 우측 확장 (예: 음악) |
| Minimal | 8pt 원형 | 우측 분리 점 |
| Expanded | (화면너비-24pt)×84~160pt | 전체 확장 (Live Activity) |

### Dynamic Island 스펙

| 속성 | 값 | 토큰 |
|------|-----|------|
| 위치 | 상단 중앙, top: 11pt | `system-ui.md > 3. Dynamic Island` |
| Idle cornerRadius | pill (9999px) | — |
| Expanded cornerRadius | 38pt | — |
| 배경 | `#000000` (항상) | — |
| 확장 spring | stiffness: 300, damping: 35 | `status-bar.md > Dynamic Island 확장 애니메이션` |

### Live Activity 예시 (확장)

```
╔═══════════════════════════════════════════╗
║  🚕  배차 완료                    2분 후   ║
║                                           ║
║  김기사님  |  서울 12가 3456              ║
║  ● ● ● ─ ─ ─ ─ ─ ─ ●                   ║
║  현재 위치          목적지                 ║
╚═══════════════════════════════════════════╝
```

---

## Time Display

| 속성 | 값 |
|------|-----|
| 기본 폰트 | SF Pro Rounded |
| 기본 크기 | 86pt |
| 기본 weight | Bold |
| 커스텀 폰트 | 사용자가 12개+ 시스템 폰트 중 선택 가능 |
| 색상 | 기본: `#ffffff` / 커스텀 색상 가능 |
| 위치 | 화면 상단 1/3, 수평 중앙 |
| Dynamic Island 피하기 | 시계가 DI 아래에 위치 |

### Date Display

| 속성 | 값 |
|------|-----|
| 폰트 | Title3 Regular (20pt) |
| 색상 | 시계 색상과 동일 (약간 투명) |
| 위치 | 시계 바로 위 또는 아래 (커스터마이즈 가능) |
| 형식 | 로케일에 따라 자동 (예: "3월 28일 금요일") |

---

## Lock Screen Widgets

### Accessory Inline (상단)

| 속성 | 값 | 토큰 |
|------|-----|------|
| 크기 | 가변 (최대 ~280pt) | `widgets.md > Accessory Inline` |
| 위치 | 시계 위 또는 날짜 옆 | — |
| 형식 | 아이콘 + 한 줄 텍스트 | — |
| 렌더링 | Vibrant mode | `WidgetRenderingMode.vibrant` |

### Accessory Rectangular (중단)

| 속성 | 값 | 토큰 |
|------|-----|------|
| 크기 | 338×58pt | `widgets.md > Accessory Rectangular` |
| cornerRadius | 8pt | — |
| 패딩 | 수직 8pt, 수평 11pt | `widgets.md > 콘텐츠 패딩` |
| 렌더링 | Vibrant mode | — |

### Accessory Circular (하단 4슬롯)

| 속성 | 값 | 토큰 |
|------|-----|------|
| 크기 | 44×44pt | `widgets.md > Accessory Circular` |
| 형태 | 원형 클리핑 | cornerRadius: 22pt |
| 패딩 | 4pt (여백 최소화) | — |
| 배경 | `AccessoryWidgetBackground()` | 시스템 원형 배경 |
| 렌더링 | Vibrant mode | — |
| 슬롯 수 | 최대 4개 | — |

---

## Bottom Shortcuts

| 속성 | 값 |
|------|-----|
| 좌측 | 손전등 (Flashlight) |
| 우측 | 카메라 (Camera) |
| 크기 | 44×44pt |
| 배경 | Liquid Glass Small (pill shape) |
| frostRadius | 7px |
| 활성화 | 롱프레스 → 기능 토글 (손전등) / 앱 실행 (카메라) |
| Haptic | `.impact(.medium)` on press |
| cornerRadius | 1000 (pill) |

### Bottom Shortcut Colors

| 상태 | Light Wallpaper | Dark Wallpaper |
|------|----------------|----------------|
| Default | `rgba(0,0,0,0.3)` + blur(7px) | `rgba(255,255,255,0.15)` + blur(7px) |
| Active (on) | `accents.blue` bg, white icon | `accents.blue` bg, white icon |
| 아이콘 색상 | `#ffffff` | `#ffffff` |

---

## 애니메이션

### Lock Screen 깨어남 (Wake)

```yaml
trigger: 탭 또는 들어올리기 (Raise to Wake)
duration: 0.3s
easing: appleEaseOut
properties:
  opacity: 0 → 1 (전체 화면)
  brightness: 0 → 사용자 설정값
  widgets: stagger fade-in (0.05s 간격)
```

### 잠금 해제 (Unlock)

```yaml
trigger: Face ID 성공 또는 패스코드 입력
duration: 0.4s
easing: spring.gentle
properties:
  scale: 1.0 → 1.1 (약간 확대)
  opacity: 1 → 0
  then: Home Screen 표시
```

### Dynamic Island 확장

```yaml
trigger: Live Activity 업데이트 또는 알림
spring:
  stiffness: 300
  damping: 35
properties:
  width: 126pt → (screen_width - 24pt)
  height: 37pt → 84~160pt
  cornerRadius: pill → 38pt
duration: system spring (~0.5s)
```

### 알림 등장

```yaml
# See notifications.md for full spec
trigger: 새 알림 수신
duration: 0.4s
easing: spring.bouncy
properties:
  translateY: -100px → 0
  opacity: 0 → 1
  scale: 0.9 → 1.0
```

---

## Light / Dark 모드 차이

Lock Screen의 light/dark는 주로 배경화면에 의해 결정된다.

| 요소 | Light Wallpaper | Dark Wallpaper |
|------|----------------|----------------|
| 시계 색상 | `#000000` (기본) | `#ffffff` (기본) |
| Status Bar 스타일 | `.darkContent` | `.lightContent` |
| 위젯 렌더링 | Vibrant (자동 색상 조정) | Vibrant (자동) |
| Bottom shortcuts bg | `rgba(0,0,0,0.3)` | `rgba(255,255,255,0.15)` |
| 날짜 색상 | 시계 색상 따라감 | 시계 색상 따라감 |
| Always-On Display | 밝기 극저, 색상 유지 | 밝기 극저, OLED 절전 |

---

## Always-On Display (AOD)

| 속성 | 값 |
|------|-----|
| 지원 기기 | iPhone 14 Pro 이상 (LTPO OLED) |
| 새로고침 | 1Hz (최저 주사율) |
| 밝기 | 극저 (~1 nit) |
| 위젯 | 계속 표시 (색상 탈채색/dimmed) |
| 시계 | 계속 표시 (밝기 감소) |
| 민감 정보 | 알림 미리보기 숨김 (설정에 따라) |
| 배경화면 | 어둡게 dimmed (OLED 전력 절약) |

---

## 인터랙션 노트

- **탭**: 화면 깨우기 (Raise to Wake와 동일 효과)
- **스와이프 위**: 알림 센터 확장
- **스와이프 우측 상단 아래**: Control Center
- **좌측 롱프레스**: 손전등 토글
- **우측 롱프레스**: 카메라 앱 실행
- **시계 영역 롱프레스**: 잠금 화면 커스터마이징 모드
- **알림 탭**: 해당 앱으로 이동 (Face ID 인증 후)
- **위젯 탭**: 해당 앱 deeplink

---

## 접근성 고려사항

| 항목 | 요구사항 |
|------|---------|
| VoiceOver | 시간, 날짜, 위젯 내용 순서대로 읽기 |
| 시계 VoiceOver | "오전 9시 41분" (시간 읽기) |
| 위젯 VoiceOver | 위젯 내용 + 앱 이름 읽기 |
| Dynamic Island | Live Activity 내용 VoiceOver로 접근 가능 |
| Reduce Motion | 잠금 해제 spring 제거, 단순 fade |
| Bold Text | 시계/날짜/위젯 텍스트에 반영 |
| 시계 크기 | 커스텀 폰트에서도 충분한 가독성 확보 |
| 색상 대비 | 시계/위젯 텍스트 vs 배경화면 — 시스템이 자동 shadow/outline 처리 |
| 손전등/카메라 | VoiceOver: "손전등, 길게 눌러 켜기" |
| Passcode 대체 | Face ID 실패 시 패스코드 입력 폴백 |
