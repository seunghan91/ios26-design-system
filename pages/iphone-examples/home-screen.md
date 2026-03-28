# Home Screen — iOS 26 페이지 레시피

> **References**
> - Components: `../../components/specs/app-icons.md`, `../../components/specs/system-ui.md`, `../../components/specs/widgets.md`
> - Tokens: `../../tokens/`
> - Sections: `../../sections/`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="2402:17543")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Home Screen |
| **디바이스** | iPhone 17 Pro, 402 × 874pt |
| **용도** | 앱 런처, 위젯 표시, 시스템 최상위 화면 |
| **iOS 26 특이사항** | Light/Dark/Tint 아이콘 모드, Liquid Glass 위젯 배경, 인터랙티브 위젯 |

Home Screen은 iOS의 가장 기본적인 시스템 화면이다. 앱 아이콘 그리드, Dock, 위젯, 페이지 인디케이터로 구성된다. iOS 26에서는 앱 아이콘이 3가지 어피어런스 모드(Light/Dark/Tint)를 지원하며, 위젯 배경이 Liquid Glass 소재로 통합되었다.

---

## 화면 구성 분해

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41          ⠿ ▐▌ ■               │  ← Status Bar (54pt)
├─────────────────────────────────────────────┤
│                                              │
│   safe area top: 59pt                        │
│                                              │
│  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐   │  ← Row 1: App Icons
│  │  📱  │  │  💬  │  │  📧  │  │  🎵  │   │    4 columns
│  │ Phone │  │ Msgs │  │ Mail │  │Music │   │    icon: 60×60pt
│  └──────┘  └──────┘  └──────┘  └──────┘   │    label below
│                                              │
│  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐   │  ← Row 2
│  │  📷  │  │  ⚙️  │  │  🗺  │  │  📝  │   │
│  │Camera│  │ Set  │  │ Maps │  │Notes │   │
│  └──────┘  └──────┘  └──────┘  └──────┘   │
│                                              │
│  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐   │  ← Row 3
│  │  📅  │  │  🏪  │  │  💰  │  │  ❤️  │   │
│  │ Cal  │  │Store │  │Wallet│  │Health│   │
│  └──────┘  └──────┘  └──────┘  └──────┘   │
│                                              │
│  ┌──────────────────────────────────────┐   │  ← Widget (Medium: 338×158pt)
│  │  🌤                                   │   │    cornerRadius: 22pt
│  │  22°  맑음                             │   │    bg: systemMaterial ~72%
│  │  H:26° L:18°                          │   │    Liquid Glass style
│  │  ☀️ 22° → 🌤 24° → ☁️ 21° → 🌧 19°   │   │    padding: 16pt
│  └──────────────────────────────────────┘   │
│                                              │
│  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐   │  ← Row 4
│  │  📸  │  │  🎮  │  │  📖  │  │  🔍  │   │
│  │Photos│  │Games │  │Books │  │Safari│   │
│  └──────┘  └──────┘  └──────┘  └──────┘   │
│                                              │
│                ● ○ ○ ○                      │  ← Page Indicator
│                                              │
├─────────────────────────────────────────────┤  ← Dock separator (없음, 배경 구분)
│  ┌──────────────────────────────────────┐   │  ← Dock
│  │  📱     💬      🧭      🎵         │   │    height: 83pt
│  │  Phone  Msgs   Safari   Music      │   │    Liquid Glass bg
│  └──────────────────────────────────────┘   │    blur(12px)
│                                              │    safe area bottom: 34pt
└─────────────────────────────────────────────┘
              ─────                               ← Home Indicator (134×5pt)
```

---

## App Icon Grid

### Icon Dimensions

| 속성 | 값 | 토큰 |
|------|-----|------|
| 아이콘 크기 | 60×60pt | `system-ui.md > App Icon (홈 화면)` |
| 아이콘 cornerRadius | Squircle (시스템 자동 클리핑) | `spacing.json > radius.semantic.appIcon.iphone: 26` |
| 그리드 columns | 4 | — |
| 그리드 rows | 최대 6 (아이콘만), 위젯 포함 시 가변 | — |
| 아이콘 간 수평 간격 | ~26pt (계산: (402 - 16*2 - 60*4) / 3) | — |
| 아이콘 간 수직 간격 | ~28pt (레이블 포함) | — |
| 레이블 상단 마진 | 4pt (아이콘 하단 → 레이블) | — |
| content margin | 16pt 좌우 | `spacing.json > contentMargin.iphone.horizontal` |

### Icon Label Typography

| 요소 | Style | Size | Weight | 색상 |
|------|-------|------|--------|------|
| 아이콘 레이블 | Caption2 | 11pt | Regular | `labels.primary` (white on dark wallpaper, black on light) |
| 뱃지 숫자 | Caption2 Emphasized | 11pt | Semibold | `#ffffff` on red bg |

### iOS 26 Icon Appearance Modes

| 모드 | 배경 | 아이콘 그래픽 | 적용 조건 |
|------|------|-------------|----------|
| Light | 밝은 배경 | 채도 높은 색상 | 시스템 Light Mode |
| Dark | `#1C1C1E` ~ `#2C2C2E` 계열 | 밝게 조정된 색상 | 시스템 Dark Mode |
| Tint | 시스템 틴트 컬러 배경 | 흰색/모노 그래픽 | 사용자 커스텀 틴트 |

---

## Dock

| 속성 | 값 | 토큰 |
|------|-----|------|
| 높이 | 83pt (아이콘 + padding + safe area) | `system-ui.md > Dock (iPhone)` |
| 너비 | 화면 전체 (402pt) | — |
| 아이콘 수 | 최대 4개 | — |
| 아이콘 크기 | 60×60pt | 홈 화면과 동일 |
| 배경 | Liquid Glass Medium | `materials.json > liquidGlass.regular.medium` |
| 배경 blur | 12px | `liquidGlass.regular.medium.frostRadius` |
| 배경 색상 (light) | `rgba(245,245,245,0.6)` | — |
| 배경 색상 (dark) | `rgba(0,0,0,0.6)` + tint | — |
| cornerRadius | 40pt (pill 형태) | — |
| 아이콘 레이블 | 숨김 (Dock 내에서는 표시 안 함) | — |

---

## Page Indicator

| 속성 | 값 |
|------|-----|
| 점 크기 | 7pt 직경 |
| 활성 점 색상 | `labels.primary` (투명도 조정) |
| 비활성 점 색상 | `labels.tertiary` |
| 간격 | 8pt |
| 위치 | 아이콘 그리드와 Dock 사이, 수평 중앙 |

---

## Widget Integration

위젯은 아이콘 그리드 사이에 배치되며, 아이콘 2×2 / 4×2 / 4×4 슬롯을 차지한다.

### Widget Sizes on Home Screen

| 크기 | pt (iPhone) | Grid Slots | cornerRadius |
|------|------------|-----------|-------------|
| Small | 158×158pt | 2×2 | 22pt |
| Medium | 338×158pt | 4×2 | 22pt |
| Large | 338×354pt | 4×4 | 22pt |

### Widget Background

| 모드 | 소재 | 불투명도 | 토큰 |
|------|------|---------|------|
| Light | `.systemMaterial` | ~72% | `colors.json > backgrounds.secondary` |
| Dark | `.systemMaterialDark` | ~64% | `colors.json > backgrounds.elevated` |

### Widget Content Padding

모든 크기에서 16pt 전체 패딩. `widgets.md > 4. 시각적 스펙 > 콘텐츠 패딩`

---

## 애니메이션

### 앱 아이콘 런치

```yaml
trigger: 아이콘 탭
properties:
  scale: 1.0 → 0.85 (bounce down)
  then: 확대 전환 (앱 화면으로)
duration: 0.3s
easing: spring.snappy
haptic: .impact(.light)
```

### 흔들기 모드 (편집)

```yaml
trigger: 아이콘 롱프레스 (0.75s)
properties:
  rotation: ±6° oscillation
  frequency: 1.5Hz
haptic: .impact(.medium) on entry
```

### 위젯 추가

```yaml
trigger: 위젯 드래그앤드롭
properties:
  scale: spring bounce (0.9 → 1.05 → 1.0)
duration: 0.35s
easing: spring.bouncy
```

### 페이지 전환

```yaml
trigger: 좌우 스와이프
properties:
  translateX: page width
  parallax: 아이콘 30% 오프셋, 배경 10% 오프셋
duration: 0.35s
easing: appleEaseOut
```

---

## Light / Dark 모드 차이

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| 앱 아이콘 | Light appearance | Dark appearance (자동 전환) |
| 아이콘 레이블 | 흰색 (dark wallpaper) 또는 검정 | 흰색 |
| 위젯 배경 | `systemMaterial` ~72% | `systemMaterialDark` ~64% |
| Dock 배경 | `rgba(245,245,245,0.6)` + blur | `rgba(0,0,0,0.6)` + blur + tint |
| 페이지 인디케이터 | `labels.primary` | `labels.primary` (흰색) |
| 전체 배경 | 사용자 배경화면 | 사용자 배경화면 (어둡게 조정) |
| Tint 아이콘 | 사용자 선택 틴트 | 사용자 선택 틴트 |

---

## 인터랙션 노트

- **아이콘 탭**: 앱 실행 (scale bounce → launch animation)
- **아이콘 롱프레스**: Context Menu → Quick Actions 또는 편집 모드
- **위젯 탭**: deeplink 또는 앱 실행 (`widgetURL`)
- **위젯 인터랙티브 (iOS 17+)**: Button/Toggle 직접 탭 가능
- **페이지 스와이프**: 좌우로 홈 화면 페이지 전환
- **아래로 당기기**: Spotlight 검색 활성화
- **편집 모드**: 아이콘 재배치, 위젯 추가/제거, 페이지 관리
- **Smart Stack**: 위젯 위에서 위아래 스와이프로 위젯 간 전환

---

## 접근성 고려사항

| 항목 | 요구사항 |
|------|---------|
| 아이콘 터치 타겟 | 시스템이 60×60pt 이상 보장 |
| VoiceOver | 앱 이름이 자동 레이블, "앱 이름, 뱃지 N개" |
| 색맹 접근성 | 아이콘은 색상에만 의존하지 않도록 형태로 구분 |
| Dark 모드 아이콘 | 미제출 시 시스템이 자동 탈채색 → 브랜드 일관성 저하 |
| 고대비 | "Increase Contrast" 설정 시 아이콘 대비 강조되지 않음 |
| 위젯 접근성 | 위젯 내용 VoiceOver로 읽기, 인터랙티브 위젯 탭 가능 |
| Reduce Motion | 앱 런치 scale 애니메이션 축소, 페이지 전환 단순화 |
| Dynamic Type | 아이콘 레이블은 시스템 제어 (제한적 크기 조정) |
| 뱃지 | VoiceOver가 뱃지 수 자동 읽기 |
