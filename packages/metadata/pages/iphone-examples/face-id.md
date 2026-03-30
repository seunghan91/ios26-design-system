# Face ID — iPhone Full-Screen Example

> **References**
> - Components: `../../components/specs/face-id.md`
> - Tokens: `../../tokens/colors.json`, `../../tokens/spacing.json`, `../../tokens/typography.json`, `../../tokens/animations.json`, `../../tokens/materials.json`
> - Sections: `../../sections/`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:26011")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Face ID (생체 인증 화면) |
| **디바이스** | iPhone 17 Pro — 402 × 874pt (@3x, 1206 × 2622px) |
| **용도** | 생체 인증(Face ID)으로 앱/기능 접근 인증 |
| **트리거** | 앱 잠금 해제, 결제 인증, 민감한 데이터 접근 |
| **프레젠테이션** | 시스템 UI 오버레이 (전체 화면 dimming + 중앙 카드) |
| **iOS 26 특이사항** | Liquid Glass 카드 배경, 초록/빨강 테두리 링 애니메이션, 시스템 제어 UI |

Face ID UI는 `LocalAuthentication` 프레임워크가 시스템 레벨에서 표시하는 인증 화면이다. 앱에서 직접 커스터마이즈할 수 없으며, 2가지 상태(인증 중 / 실패)를 갖는다.

---

## 디바이스 컨텍스트

```
iPhone 17 Pro
├─ 화면 크기: 402 × 874pt
├─ Safe Area Top: 59pt (Dynamic Island)
├─ Safe Area Bottom: 34pt (Home Indicator)
├─ Face ID 센서: TrueDepth 카메라 (Dynamic Island 내장)
├─ Pixel Density: @3x (1206 × 2622px)
└─ 지원 기기: Face ID 탑재 모든 iPhone/iPad
```

---

## 화면 구성 분해

### State 1: Authenticating (인증 중)

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │  ← Status Bar (59pt)
│                                              │
│  ┌──── Dimming Overlay ─────────────────────┐│  ← 전체 화면
│  │  background: rgba(0,0,0,0.45)            ││    backdrop-filter: blur(8px)
│  │                                          ││
│  │                                          ││
│  │         ┌──── Auth Card ──────┐          ││  ← 중앙 카드
│  │         │                     │          ││    너비: 270pt
│  │         │     padding: 24pt   │          ││    cornerRadius: 20pt
│  │         │                     │          ││    Liquid Glass 배경
│  │         │    ┌───────────┐    │          ││
│  │         │    │           │    │          ││  ← Face ID 아이콘 (81×81pt)
│  │         │    │   ◉ ◉     │    │          ││    SF Symbol: faceid
│  │         │    │   ─ ─     │    │          ││    색상: accents.green (#34C759)
│  │         │    │   ___     │    │          ││
│  │         │    └───────────┘    │          ││  ← 테두리 링: 3pt green
│  │         │     ↑ pulse 애니메이션│          ││    반경: 아이콘 + 6pt
│  │         │         ↕ 20pt      │          ││
│  │         │      Face ID        │          ││  ← Title: 17pt, Semibold
│  │         │         ↕ 6pt       │          ││    labels.primary
│  │         │  iPhone의 잠금을     │          ││  ← Subtitle: 13pt, Regular
│  │         │  해제하려면 바라보십시오│         ││    labels.secondary
│  │         │                     │          ││
│  │         ├─────────────────────┤          ││  ← separator (1px)
│  │         │  [취소]      [암호 입력]│          ││  ← 버튼 영역 (44pt)
│  │         └─────────────────────┘          ││    accents.blue (#0088ff)
│  │                                          ││
│  │                                          ││
│  └──────────────────────────────────────────┘│
│  ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔│  ← Home Indicator (34pt)
└─────────────────────────────────────────────┘
```

### State 2: Failed (인증 실패)

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │
│                                              │
│  ┌──── Dimming Overlay ─────────────────────┐│
│  │                                          ││
│  │                                          ││
│  │         ┌──── Auth Card ──────┐          ││
│  │         │                     │          ││
│  │         │    ┌───────────┐    │          ││
│  │         │    │           │    │          ││  ← Face ID 아이콘 (81×81pt)
│  │         │    │   ✕ ✕     │    │          ││    색상: accents.red (#FF3B30)
│  │         │    │   ─ ─     │    │          ││
│  │         │    │   ___     │    │          ││
│  │         │    └───────────┘    │          ││  ← 테두리 링: 3pt red
│  │         │     ↑ shake 애니메이션│          ││    + shake (좌우 진동)
│  │         │         ↕ 20pt      │          ││
│  │         │      Face ID        │          ││
│  │         │         ↕ 6pt       │          ││
│  │         │  Face ID를 인식하지  │          ││  ← Subtitle 변경
│  │         │  못했습니다.         │          ││    labels.secondary
│  │         │                     │          ││
│  │         ├─────────────────────┤          ││
│  │         │  [취소]      [암호 입력]│          ││
│  │         └─────────────────────┘          ││
│  │                                          ││
│  └──────────────────────────────────────────┘│
│  ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔│
└─────────────────────────────────────────────┘
```

---

## 컴포넌트별 토큰 참조

### Dimming Overlay

| 역할 | 값 | 토큰 |
|------|-----|------|
| 배경색 | `rgba(0,0,0,0.45)` | — |
| 블러 | `backdrop-filter: blur(8px)` | — |
| 크기 | 전체 화면 | — |

### Auth Card (중앙 카드)

| 역할 | 값 | 토큰 |
|------|-----|------|
| 너비 | 270pt | — |
| 내부 패딩 | 24pt | `spacing.scale.6` = 24pt |
| cornerRadius | 20pt | `spacing.radius.xxl` |
| 배경 (Light) | Liquid Glass: `colors.backgrounds.primary` | `#ffffff` |
| 배경 (Dark) | Liquid Glass: `colors.backgrounds.primary` | `#000000` |
| Shadow | blur 40pt, `rgba(0,0,0,0.15)` | `materials.liquidGlass.regular.large.light.shadow` |

### Face ID 아이콘

| 역할 | 값 | 토큰 |
|------|-----|------|
| 크기 | 81 × 81pt | — |
| SF Symbol | `faceid` | — |
| 색상 (기본) | `labels.primary` | Light: `#000000`, Dark: `#ffffff` |
| 색상 (인증 중) | `accents.green` | Light: `#34c759`, Dark: `#30d158` |
| 색상 (실패) | `accents.red` | Light: `#ff383c`, Dark: `#ff4245` |

### Border Ring (테두리)

| 상태 | 색상 | 두께 | 반경 | 토큰 |
|------|------|------|------|------|
| 인증 중 | `#34c759` (green) | 3pt | 아이콘 + 6pt = ~46.5pt | `colors.accents.green` |
| 실패 | `#ff383c` (red) | 3pt | 아이콘 + 6pt = ~46.5pt | `colors.accents.red` |

### Typography

| 요소 | 스타일 | 크기 | 굵기 | 색상 토큰 |
|------|--------|------|------|----------|
| Title | Headline | 17pt | Semibold | `colors.labels.primary` |
| Subtitle | Footnote | 13pt | Regular | `colors.labels.secondary` |
| 간격 (아이콘→Title) | — | 20pt | — | — |
| 간격 (Title→Subtitle) | — | 6pt | — | — |

### Buttons

| 버튼 | 텍스트 | 스타일 | 높이 | 색상 |
|------|--------|--------|------|------|
| 취소 (Cancel) | "취소" | Plain | 44pt | `accents.blue` Light: `#0088ff`, Dark: `#0091ff` |
| 암호 입력 (Try Password) | "암호 입력" | Plain | 44pt | `accents.blue` |
| 구분선 | — | — | 1px | `colors.separators.opaque` Light: `#c6c6c8`, Dark: `#38383a` |

---

## Light/Dark 모드 차이

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| Dimming | `rgba(0,0,0,0.45)` + blur 8px | `rgba(0,0,0,0.45)` + blur 8px |
| Card 배경 | `#ffffff` (Liquid Glass) | `#000000` (Liquid Glass) |
| Card shadow | `rgba(0,0,0,0.15)`, blur 40pt | `rgba(0,0,0,0.4)`, blur 40pt |
| Title | `#000000` | `#ffffff` |
| Subtitle | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.7)` |
| Green ring | `#34c759` | `#30d158` |
| Red ring | `#ff383c` | `#ff4245` |
| Button 텍스트 | `#0088ff` | `#0091ff` |
| 구분선 | `#c6c6c8` | `#38383a` |

---

## 애니메이션

### 카드 등장

```yaml
trigger: LAContext.evaluatePolicy() 호출
duration: 0.25s
easing: easeOut — cubic-bezier(0, 0, 0.58, 1.0)
properties:
  card_opacity: 0 → 1
  card_scale: 0.9 → 1.0
dimming:
  opacity: 0 → 1
  duration: 0.2s
  blur: 0 → 8px
```

### Authenticating — Pulse 애니메이션

```yaml
trigger: Face ID 스캔 시작
animation: 무한 반복 pulse
properties:
  border_opacity: 0.6 → 1.0 → 0.6
  border_scale: 1.0 → 1.05 → 1.0
duration: 1.5s (1 cycle)
easing: easeInOut — cubic-bezier(0.42, 0, 0.58, 1.0)
repeat: infinite (인증 완료까지)
color: accents.green (#34c759 / #30d158)
```

### Success (성공)

```yaml
trigger: Face ID 인증 성공
sequence:
  1. 아이콘 → checkmark 변환:
    duration: 0.3s
    spring: snappy (response 0.3, dampingRatio 0.8)
    scale: 1.0 → 1.2 → 1.0
    haptic: UINotificationFeedbackGenerator(.success)
  2. 카드 dismiss:
    delay: 0.5s
    duration: 0.3s
    opacity: 1 → 0
    scale: 1.0 → 0.9
  3. Dimming fadeout:
    duration: 0.25s
    opacity: 1 → 0
```

### Failed — Shake 애니메이션

```yaml
trigger: Face ID 인증 실패
sequence:
  1. 색상 전환: green → red (즉시)
  2. shake:
    keyframes: [0, -12, 10, -8, 6, -4, 2, 0] (translateX, pt)
    duration: 0.5s
    easing: easeOut
    haptic: UINotificationFeedbackGenerator(.error)
  3. 텍스트 변경: 인증 중 → 실패 메시지 (crossfade 0.2s)
```

### Reduce Motion

```yaml
prefers-reduced-motion:
  pulse: border_opacity만 변경 (scale 제거)
  shake: 비활성화 → 색상 변경만
  카드 등장/퇴장: opacity만 (scale 제거)
  성공 checkmark: opacity만 (scale bounce 제거)
```

---

## 인터랙션 노트

| 인터랙션 | 동작 |
|---------|------|
| **Face ID 시작** | 시스템이 자동으로 TrueDepth 카메라 활성화 |
| **얼굴 인식 성공** | checkmark 표시 → 0.5s 후 자동 dismiss |
| **얼굴 인식 실패** | shake → 실패 메시지 → 재시도 대기 |
| **2번 연속 실패** | "암호 입력" 버튼 강조 |
| **취소 탭** | 인증 취소 → LAError.userCancel 반환 |
| **암호 입력 탭** | 시스템 암호 입력 화면으로 전환 |
| **앱 백그라운드** | 인증 세션 자동 취소 |
| **Lockout (5번 실패)** | Face ID 비활성화 → 반드시 암호 입력 필요 |

### 인증 흐름

```
LAContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics)
  → 성공: callback(true) + UI dismiss
  → 실패: shake + 재시도 대기
    → 2회 실패: "암호 입력" 강조
    → 5회 실패: Face ID lockout → 암호 전용
  → 취소: callback(false, LAError.userCancel)
```

---

## 접근성 (Accessibility)

| 항목 | 요구사항 |
|------|---------|
| **VoiceOver** | "Face ID, iPhone의 잠금을 해제하려면 바라보십시오" 전체 안내 |
| **VoiceOver (실패)** | "Face ID를 인식하지 못했습니다" 즉시 안내 |
| **버튼 접근** | "취소, 버튼" / "암호 입력, 버튼" |
| **자동 포커스** | 카드 등장 시 Title에 포커스 |
| **키보드** | 외부 키보드 사용 시 Tab으로 버튼 이동, Enter로 선택 |
| **Escape** | 외부 키보드 Escape → 취소 |
| **Touch ID 대체** | Face ID 미탑재 기기에서는 Touch ID UI로 자동 전환 |
| **Reduce Motion** | pulse scale 제거, shake 제거, 색상/opacity 변경만 유지 |
| **색상 대비** | Title vs Card: WCAG AA (4.5:1+), Green/Red ring: 보조 표시 (색상 외 형태로도 구분) |
| **성공/실패 구분** | 색상(green/red) + 형태(pulse/shake) + 텍스트 + 햅틱 으로 다중 채널 안내 |

---

## 구현 체크리스트

- [ ] `LAContext.evaluatePolicy()` 사용 (시스템 UI 자동 표시)
- [ ] `LAPolicy` 선택: `.deviceOwnerAuthenticationWithBiometrics` (Face ID만) vs `.deviceOwnerAuthentication` (Face ID + 암호 폴백)
- [ ] `localizedReason` 문자열 명확하게 설정
- [ ] 에러 처리: `.userCancel`, `.biometryLockout`, `.biometryNotAvailable`
- [ ] Lockout 시 암호 입력 폴백 제공
- [ ] Face ID 미탑재 기기 대응 (Touch ID / 암호)
- [ ] 시뮬레이터: Features > Face ID > Enrolled + Matching Face/Non-matching Face
- [ ] 앱 포그라운드 복귀 시 재인증 필요 여부 결정
- [ ] VoiceOver 동작 검증 (시스템 UI)
- [ ] Reduce Motion에서 햅틱은 유지

---

## 관련 화면

| 화면 | 관계 |
|------|------|
| `alert-flow.md` | 인증 실패 후 Alert 표시 가능 |
| `settings-screen.md` | Face ID 설정 (활성화/비활성화) |
| `keyboard.md` | 암호 입력 폴백 시 키보드 표시 |
