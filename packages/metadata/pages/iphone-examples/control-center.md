# Control Center — iOS 26 페이지 레시피

> **References**
> - Components: `../../components/specs/system-ui.md`, `../../components/specs/sliders.md`, `../../components/specs/toggle.md`
> - Tokens: `../../tokens/`
> - Sections: `../../sections/`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24688")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Control Center |
| **디바이스** | iPhone 17 Pro, 402 × 874pt |
| **용도** | 시스템 빠른 설정 — 연결, 밝기, 볼륨, 미디어, 토글 |
| **트리거** | 우측 상단에서 아래로 스와이프 (Dynamic Island 기기) |
| **iOS 26 특이사항** | Liquid Glass 모듈, WidgetKit 기반 커스텀 컨트롤, 다중 페이지 |

Control Center는 iOS 26에서 Liquid Glass 소재 모듈로 재설계되었다. 각 모듈은 독립적인 Liquid Glass 타일로 표현되며, 사용자가 레이아웃을 커스터마이징할 수 있다. WidgetKit의 `ControlWidget` API로 서드파티 컨트롤 추가도 가능하다.

---

## 화면 구성 분해

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41          ⠿ ▐▌ ■               │  ← Status Bar (54pt)
├─────────────────────────────────────────────┤
│                                              │
│  ┌─────────────┬─────────────┐              │  ← Connectivity Module
│  │  ✈️          │  📶          │              │    Liquid Glass Large
│  │  Airplane    │  Cellular    │  2×2 grid   │    frostRadius: 14px
│  │──────────────┼──────────────│              │    bg: liquidGlass.regular.large
│  │  📡          │  📲          │              │    cornerRadius: 24pt
│  │  Wi-Fi       │  Bluetooth   │              │
│  └─────────────┴─────────────┘              │
│                                              │
│  ┌───────────┐  ┌───────────┐               │  ← Quick Toggles Row
│  │  🔇        │  │  🔒        │               │    2×1 tiles each
│  │  Mute      │  │  Lock      │  Liquid Glass │    bg: liquidGlass.regular.small
│  └───────────┘  └───────────┘  Small          │    frostRadius: 7px
│                                              │    pill shape (r: 1000)
│  ┌──────────────────────────────────────┐   │  ← Media Player Module
│  │  🎵  Now Playing                      │   │    Liquid Glass Large
│  │                                        │   │    4×2 tile
│  │  Song Title                            │   │    bg: liquidGlass.regular.large
│  │  Artist Name                           │   │
│  │  ◁◁    ▶    ▷▷                         │   │    Play controls
│  │  ─────────●──────────                  │   │    Progress slider
│  └──────────────────────────────────────┘   │
│                                              │
│  ┌──────────────────────────────────────┐   │  ← Brightness Slider
│  │  ☀                                    │   │    Vertical slider module
│  │  │█│                                  │   │    Liquid Glass Medium
│  │  │█│                                  │   │    frostRadius: 12px
│  │  │█│                                  │   │    1×4 vertical
│  │  │░│                                  │   │
│  │  ☀                                    │   │
│  └──────┘  ┌──────┐                      │   │  ← Volume Slider
│            │  🔈   │                      │   │    Same vertical style
│            │  │█│  │                      │   │
│            │  │█│  │                      │   │
│            │  │░│  │                      │   │
│            │  🔊   │                      │   │
│            └──────┘                       │   │
│                                              │
│  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐          │  ← Bottom Action Buttons
│  │  🔦  │ │  📷  │ │  ⏱  │ │  💡  │          │    1×1 tiles
│  │Flash │ │Cam  │ │Timer│ │Light│          │    Liquid Glass Small
│  └─────┘ └─────┘ └─────┘ └─────┘          │    pill shape
│                                              │
│          ●  ○  ○  ○                         │  ← Page indicator
└─────────────────────────────────────────────┘
```

---

## Liquid Glass Module Sizes

| 모듈 크기 | Grid Slots | 치수 (approx) | frostRadius | 토큰 |
|----------|-----------|--------------|-------------|------|
| 1×1 | Single | 91×91pt | 7px | `materials.json > liquidGlass.regular.small` |
| 2×1 | Half-row | 91×206pt | 7px | `liquidGlass.regular.small` |
| 2×2 | Quarter | 198×198pt | 14px | `liquidGlass.regular.large` |
| 4×2 | Half | 402×198pt | 14px | `liquidGlass.regular.large` |
| 4×4 | Full row | 402×402pt | 14px | `liquidGlass.regular.large` |

### Module Background (Liquid Glass)

**Light Mode:**
| 크기 | 배경 | Border | Shadow |
|------|------|--------|--------|
| Small (default) | `rgba(247,247,247,1.0)` | `#dddddd` | blur: 40 |
| Small (primary) | `#ffffff` | none | blur: 40 |
| Medium | `rgba(245,245,245,0.6)` | none | blur: 40 |
| Large | `rgba(250,250,250,0.7)` | none | blur: 40 |

**Dark Mode:**
| 크기 | 배경 | Tint | Shadow |
|------|------|------|--------|
| Small (default) | `rgba(0,0,0,0.6)` | `rgba(255,255,255,0.06)` | blur: 40 |
| Small (primary) | `#ffffff` (icon: `#0091ff`) | none | blur: 40 |
| Medium | `rgba(0,0,0,0.6)` | `rgba(255,255,255,0.06)` | blur: 40 |
| Large | `rgba(0,0,0,0.8)` | `rgba(255,255,255,0.06)` | blur: 40 |

---

## Connectivity Module (2×2)

| 항목 | 값 |
|------|-----|
| 각 셀 크기 | ~91×91pt |
| 아이콘 크기 | 24pt (SF Symbol) |
| 레이블 | Caption2 (11pt, Regular) |
| 활성 상태 배경 | `accents.blue` (#0088ff) |
| 비활성 상태 배경 | `fills.tertiary` |
| 활성 아이콘 색상 | `#ffffff` |
| 비활성 아이콘 색상 | `labels.primary` |
| cornerRadius | `spacing.json > radius.semantic.liquidGlass.large: 24` |

---

## Media Player Module (4×2)

| 요소 | Typography | 색상 |
|------|-----------|------|
| 제목 | Headline Semibold 17pt | `labels.primary` |
| 아티스트 | Subheadline Regular 15pt | `labels.secondary` |
| 컨트롤 아이콘 | 24pt SF Symbol | `labels.primary` |
| 프로그레스 바 | Slider variant (track 4pt) | fill: `accents.blue`, track: `fills.tertiary` |
| 앨범 아트 | 48×48pt, cornerRadius 8pt | — |

---

## Brightness / Volume Sliders

| 속성 | 값 | 토큰 |
|------|-----|------|
| 방향 | Vertical | `sliders.md > Variant: Vertical` |
| 트랙 너비 | 4pt | — |
| Knob | 28pt 직경, white | — |
| Fill 색상 | `accents.blue` | `colors.json > accents.blue` |
| Track 색상 | `fills.tertiary` | `colors.json > fills.tertiary` |
| 터치 타겟 | 44pt 너비 확보 | — |
| Min/Max 아이콘 | SF Symbol (sun.min / sun.max, speaker.fill / speaker.wave.3.fill) | — |
| 아이콘 크기 | 20pt | — |
| 아이콘 색상 | `labels.secondary` | — |

---

## Toggle Grid

| 상태 | 배경 | 아이콘 색상 | 토큰 |
|------|------|-----------|------|
| OFF | `liquidGlass.regular.small.light.default.bg` | `labels.primary` | `materials.json` |
| ON (default) | `accents.blue` | `#ffffff` | `colors.json > accents.blue` |
| ON (primary) | `liquidGlass.regular.small.light.primary.bg` | `#0091ff` | `materials.json` |
| Haptic | `.impact(.light)` on toggle | — | — |

---

## 애니메이션

### Control Center 등장

```yaml
trigger: 우측 상단 스와이프 다운
duration: 0.4s
easing: spring.bouncy             # cubic-bezier(0.68, -0.55, 0.265, 1.55)
spring: response 0.5, dampingRatio 0.65
properties:
  scale: 0.85 → 1.0
  opacity: 0 → 1
  blur: 0 → 14px (Liquid Glass frost)
modules:
  stagger_delay: 0.03s per module  # 모듈별 순차 등장
```

### Control Center 퇴장

```yaml
trigger: 위로 스와이프 또는 배경 탭
duration: 0.3s
easing: easeIn                    # cubic-bezier(0.42, 0, 1.0, 1.0)
properties:
  scale: 1.0 → 0.85
  opacity: 1 → 0
```

### Module Long Press (편집 모드)

```yaml
trigger: 모듈 롱프레스 (0.5s)
properties:
  scale: 1.0 → 0.95 (프레스 피드백)
  haptic: .impact(.medium)
  then: 편집 모드 진입 (흔들기 + 재배치 가능)
```

---

## Light / Dark 모드 차이

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| 전체 배경 | 블러된 홈 화면 + dimming | 블러된 홈 화면 + 강한 dimming |
| Module bg (small) | `rgba(247,247,247,1.0)` | `rgba(0,0,0,0.6)` |
| Module bg (large) | `rgba(250,250,250,0.7)` | `rgba(0,0,0,0.8)` |
| Module border (small) | `#dddddd` | none |
| Module tint (dark) | — | `rgba(255,255,255,0.06)` |
| 아이콘 색상 | `#000000` | `#ffffff` |
| 활성 토글 | `#0088ff` bg | `#0091ff` bg |
| 텍스트 | `labels.primary/secondary` | `labels.primary/secondary` |

---

## 인터랙션 노트

- **스와이프 진입**: 우측 상단 가장자리에서 아래로 스와이프
- **모듈 탭**: 토글 ON/OFF 또는 앱으로 이동
- **모듈 롱프레스**: 세부 컨트롤 표시 (예: Wi-Fi 네트워크 목록)
- **슬라이더 드래그**: 밝기/볼륨 실시간 조절
- **미디어 컨트롤**: 재생/일시정지, 이전/다음 트랙
- **페이지 스와이프**: 좌우 스와이프로 추가 Control Center 페이지
- **편집 모드**: 하단 "+" 버튼 또는 롱프레스로 모듈 추가/제거/재배치
- **3D Touch / Haptic Touch**: 모듈 확장 (밝기 → True Tone/Night Shift 옵션)

---

## 접근성 고려사항

| 항목 | 요구사항 |
|------|---------|
| VoiceOver | 각 모듈에 레이블 + 상태 값 읽기 ("Wi-Fi, 켜짐, 네트워크: Home") |
| 최소 탭 타겟 | 모든 컨트롤 44×44pt |
| Reduce Motion | 등장 애니메이션 → 단순 fade (spring bounce 제거) |
| 색상 대비 | 활성 토글 (`accents.blue` on white) — 대비 충족 |
| Switch Control | 모든 모듈 순차 접근 가능 |
| VoiceOver 슬라이더 | `.adjustable` trait, swipe up/down으로 값 조절 |
| Bold Text | 시스템 설정 반영 |
| 고대비 모드 | 모듈 border 강화 |
| Dynamic Type | Control Center는 시스템 UI이므로 제한적 지원 (caption2 고정) |
