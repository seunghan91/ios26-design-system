# Widgets — iOS 26 페이지 레시피

> **References**
> - Components: `../../components/specs/widgets.md`
> - Tokens: `../../tokens/`
> - Sections: `../../sections/`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:26511")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Widgets (3 Sizes) |
| **디바이스** | iPhone 17 Pro, 402 × 874pt |
| **용도** | Home Screen 위젯 — 한눈에 보는 앱 정보 |
| **iOS 26 특이사항** | Liquid Glass 배경, 인터랙티브 위젯 (iOS 17+), ContainerBackground API |

3가지 크기: Small (2×2), Medium (4×2), Large (4×4). 각 크기별로 레이아웃, 타이포그래피, 콘텐츠 밀도가 다르다. iOS 26에서는 위젯 배경이 Liquid Glass 계열 `.systemMaterial`로 통합되었다.

---

## Size 1: Small (2×2)

### 화면 구성

```
┌──────────────────────┐
│                      │  158 × 158pt
│  ☀️                   │  cornerRadius: 22pt
│                      │  padding: 16pt
│                      │
│  22°                 │  ← 주요 수치 (SF Pro Rounded 40pt Bold)
│  맑음                 │  ← 서브타이틀 (13pt Regular, secondary)
│                      │
└──────────────────────┘
```

### Dimensions

| 속성 | 값 | 토큰 |
|------|-----|------|
| Size | 158 × 158pt | `widgets.md > 2. 위젯 크기 > Small` |
| cornerRadius | 22pt | `widgets.md > 4. 코너 반경` |
| Content Padding | 16pt (전체) | `widgets.md > 4. 콘텐츠 패딩` |
| Usable area | 126 × 126pt (158 - 16*2) | — |

### Typography

| 요소 | Font | Size | Weight | 색상 |
|------|------|------|--------|------|
| 주요 수치 (기온 등) | SF Pro Rounded | 32-52pt | Bold | `labels.primary` |
| 서브타이틀 | SF Pro | 13pt | Regular | `labels.secondary` |
| 아이콘 | SF Symbol | 20-24pt | — | `labels.primary` |

### Layout Patterns

**Pattern A: 수치 중심** (날씨, 배터리, 걸음수)
```
┌────────────────┐
│  [icon]         │  top-left icon
│                 │
│  42°            │  large number, bottom-left
│  Sunny          │  description below
└────────────────┘
```

**Pattern B: 링/차트** (Activity Rings, Battery)
```
┌────────────────┐
│                 │
│    ╭──╮         │  circular progress ring
│    │78│         │  center number
│    ╰──╯         │
│  Battery        │  label below
└────────────────┘
```

**Pattern C: 컴팩트 정보** (Calendar, Clock)
```
┌────────────────┐
│  📅 Calendar    │  header
│  ─────────────  │
│  28             │  large date number
│  금요일          │  weekday
└────────────────┘
```

---

## Size 2: Medium (4×2)

### 화면 구성

```
┌──────────────────────────────────────────────────┐
│                                                  │  338 × 158pt
│  ☀️ 날씨                              서울       │  cornerRadius: 22pt
│                                                  │  padding: 16pt
│  22°  맑음                                       │
│                                                  │
│  ☀️ 22°  🌤 24°  ☁️ 21°  🌧 19°  🌧 18°  ☁️ 20°  │  ← 시간별 예보 (가로 배열)
│  지금    1시    2시    3시    4시    5시           │
│                                                  │
└──────────────────────────────────────────────────┘
```

### Dimensions

| 속성 | 값 | 토큰 |
|------|-----|------|
| Size | 338 × 158pt | `widgets.md > 2. 위젯 크기 > Medium` |
| cornerRadius | 22pt | — |
| Content Padding | 16pt | — |
| Usable area | 306 × 126pt | — |

### Layout Patterns

**Pattern A: 좌측 정보 + 우측 차트** (날씨, 주가)
```
┌──────────────────────────────────────┐
│  [icon] Title              Location  │
│                                      │
│  Value + Description                 │
│                                      │
│  item  item  item  item  item  item  │  horizontal scroll/grid
│  label label label label label label │
└──────────────────────────────────────┘
```

**Pattern B: 그리드** (Shortcuts, Photos)
```
┌──────────────────────────────────────┐
│  Title                               │
│  ┌────┐ ┌────┐ ┌────┐ ┌────┐       │  2×4 icon grid
│  │ 🏠 │ │ 📱 │ │ 🎵 │ │ 💡 │       │
│  └────┘ └────┘ └────┘ └────┘       │
│  ┌────┐ ┌────┐ ┌────┐ ┌────┐       │
│  │ 🔔 │ │ ⚙️ │ │ 📷 │ │ 📝 │       │
│  └────┘ └────┘ └────┘ └────┘       │
└──────────────────────────────────────┘
```

**Pattern C: 리스트** (Calendar, Reminders)
```
┌──────────────────────────────────────┐
│  📅 Calendar                Today    │
│  ────────────────────────────────    │
│  • 09:00  팀 미팅                     │
│  • 14:00  디자인 리뷰                 │
│  • 17:00  1:1 미팅                    │
└──────────────────────────────────────┘
```

---

## Size 3: Large (4×4)

### 화면 구성

```
┌──────────────────────────────────────────────────┐
│                                                  │  338 × 354pt
│  ☀️ 날씨                              서울       │  cornerRadius: 22pt
│                                                  │  padding: 16pt
│  22°  맑음                                       │
│  H:26° L:18°                                     │
│                                                  │
│  ─────────────────────────────────────────────   │
│                                                  │
│  금   22°/18°  ☀️    ██████████░░░░             │  ← 주간 예보
│  토   24°/17°  🌤   █████████░░░░░             │    (7-day forecast)
│  일   21°/16°  ☁️   ████████░░░░░░             │
│  월   19°/15°  🌧   ██████░░░░░░░░             │
│  화   20°/14°  🌧   ███████░░░░░░░             │
│  수   22°/16°  ☁️   ████████░░░░░░             │
│  목   25°/18°  ☀️   ██████████░░░░             │
│                                                  │
└──────────────────────────────────────────────────┘
```

### Dimensions

| 속성 | 값 | 토큰 |
|------|-----|------|
| Size | 338 × 354pt | `widgets.md > 2. 위젯 크기 > Large` |
| cornerRadius | 22pt | — |
| Content Padding | 16pt | — |
| Usable area | 306 × 322pt | — |

### Layout Patterns

**Pattern A: 헤더 + 리스트** (날씨 주간, Calendar)
```
┌──────────────────────────────────────┐
│  Header section (same as Medium)     │
│  ─────────────────────────────────   │
│  Row 1                               │
│  Row 2                               │
│  Row 3                               │
│  Row 4                               │  7+ rows available
│  Row 5                               │
│  Row 6                               │
│  Row 7                               │
└──────────────────────────────────────┘
```

**Pattern B: 사진 그리드** (Photos)
```
┌──────────────────────────────────────┐
│  📸 Photos          Memories         │
│  ┌──────────────────────────────┐   │
│  │                              │   │  featured image
│  │        Full-width photo      │   │
│  │                              │   │
│  ├──────────┬──────────┬────────┤   │
│  │  small   │  small   │ small  │   │  3-column grid
│  └──────────┴──────────┴────────┘   │
└──────────────────────────────────────┘
```

---

## Widget Background (공통)

### Background Material

| 모드 | 소재 | 불투명도 | CSS 근사 |
|------|------|---------|---------|
| Light | `.systemMaterial` | ~72% | `rgba(255,255,255,0.72)` + `backdrop-filter: blur(40px)` |
| Dark | `.systemMaterialDark` | ~64% | `rgba(0,0,0,0.64)` + `backdrop-filter: blur(40px)` |

### iOS 26 Liquid Glass 적용

```swift
// SwiftUI WidgetKit
.containerBackground(.widgetBackground, for: .widget)
// 시스템이 자동으로 Liquid Glass 스타일 적용
```

```css
/* CSS/Svelte 근사 구현 */
.widget {
  background: rgba(255, 255, 255, 0.72);
  backdrop-filter: blur(40px);
  -webkit-backdrop-filter: blur(40px);
  border-radius: 22px;
  padding: 16px;
}

@media (prefers-color-scheme: dark) {
  .widget {
    background: rgba(0, 0, 0, 0.64);
  }
}
```

---

## Color Tokens

| 요소 | Light | Dark | 토큰 |
|------|-------|------|------|
| 기본 레이블 | `#000000` | `#ffffff` | `colors.json > labels.primary` |
| 보조 레이블 | `rgba(0,0,0,0.6)` | `rgba(255,255,255,0.6)` | `colors.json > labels.secondary` |
| 강조 (tint) | `#0088ff` | `#0091ff` | `colors.json > accents.blue` |
| 배경 | `#f2f2f7` (~72%) | `#1c1c1e` (~64%) | `colors.json > backgrounds.secondary` |

---

## 애니메이션

위젯은 런타임 애니메이션을 지원하지 않는다. 전환 애니메이션만 가능.

| 이벤트 | 동작 | Duration |
|--------|------|---------|
| Timeline entry 전환 | `.contentTransition(.identity)` | 시스템 기본 |
| Smart Stack 스와이프 | 시스템 수직 슬라이드 | ~0.3s |
| 인터랙티브 버튼 탭 | 즉각 반응 → 0.5s 내 업데이트 | `animations.json > duration.fast: 0.2` |
| 위젯 추가 (홈 화면) | spring scale (0.9→1.05→1.0) | system spring |
| 위젯 삭제 | scale 1.0→0.8, opacity 1→0 | 0.3s |

---

## Interactive Widgets (iOS 17+)

| 속성 | 값 |
|------|-----|
| 지원 컨트롤 | `Button`, `Toggle` only |
| Gesture Recognizer | 불가 |
| 응답 시간 | < 500ms 권장 |
| 구현 | `AppIntent` 프로토콜 |
| 피드백 | 탭 즉시 UI 반응, 백그라운드 처리 |

### Interactive Button Example

```swift
Button(intent: ToggleFavoriteIntent()) {
    Image(systemName: "star.fill")
        .foregroundStyle(.yellow)
}
.buttonStyle(.plain)
```

---

## Light / Dark 모드 차이

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| 배경 | `rgba(255,255,255,0.72)` | `rgba(0,0,0,0.64)` |
| 레이블 | `#000000` | `#ffffff` |
| 보조 텍스트 | `rgba(0,0,0,0.6)` | `rgba(255,255,255,0.6)` |
| 강조색 | `#0088ff` | `#0091ff` |
| 구분선 | `rgba(0,0,0,0.12)` | `rgba(255,255,255,0.17)` |
| 그래프/차트 | 밝은 배경에 최적화 | 어두운 배경에 최적화 |

---

## Smart Stack

| 속성 | 값 |
|------|-----|
| 크기 | Small / Medium / Large 와 동일 |
| 스와이프 | 위아래로 위젯 간 전환 |
| 자동 로테이션 | Siri Intelligence 기반 시간대별 |
| 최대 위젯 수 | ~10개 |
| 인디케이터 | 우측 상단에 점 표시 (현재/전체) |

---

## 인터랙션 노트

- **위젯 탭**: deeplink로 앱 실행 (`widgetURL` 또는 `Link`)
- **Interactive 버튼/토글 탭**: AppIntent 실행, 위젯 내에서 처리
- **Smart Stack 스와이프**: 위아래로 위젯 전환
- **롱프레스**: 위젯 편집 / 제거 옵션
- **갱신 주기**: 시스템이 배터리/사용 패턴에 따라 조절
- **네트워크**: Timeline 생성 시에만 가능 (렌더링 중 불가)

---

## 접근성 고려사항

| 항목 | 요구사항 |
|------|---------|
| VoiceOver | 위젯 전체 내용 읽기 ("날씨 위젯, 22도, 맑음") |
| Dynamic Type | 위젯은 고정 레이아웃 → `.minimumScaleFactor`로 대응 |
| 색상 대비 | `labels.primary` vs 위젯 배경 — WCAG AA 4.5:1 |
| Interactive 접근성 | Button/Toggle에 `accessibilityLabel` 필수 |
| Reduce Motion | Timeline 전환 시 fade 사용 |
| Smart Stack | VoiceOver: "스와이프하여 다른 위젯으로 이동" |
| 렌더링 시간 | ~5초 이내 완료 필수 (느리면 캐시된 스냅샷) |
| 메모리 | Small/Medium/Large 모두 30MB 제한 |

---

## 제약사항 요약

| 제약 | 내용 |
|------|------|
| 네트워크 | Timeline 생성 시에만 |
| 렌더링 시간 | ~5초 이내 |
| 메모리 | 30MB per widget |
| 갱신 빈도 | 시스템 제어 (배터리 최적화) |
| 애니메이션 | 전환만 (런타임 불가) |
| 인터랙션 | Button/Toggle만 (iOS 17+) |
| Deeplink | `widgetURL()` 또는 `Link()` |
| Background | iOS 17+: `containerBackground` API |
