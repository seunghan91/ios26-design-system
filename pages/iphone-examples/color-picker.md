# Color Picker — iPhone Full-Screen Example

> **References**
> - Components: `../../components/specs/color-pickers.md`
> - Tokens: `../../tokens/colors.json`, `../../tokens/spacing.json`, `../../tokens/typography.json`, `../../tokens/animations.json`, `../../tokens/materials.json`
> - Sections: `../../sections/`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:26010")`
> - Figma node 3147:15989 (Color Picker full view)

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Color Picker (색상 선택기) |
| **디바이스** | iPhone 17 Pro — 402 × 874pt (@3x, 1206 × 2622px) |
| **용도** | 사용자가 색상을 선택하는 시스템 UI — 그리기, 메모, 커스터마이징 앱에서 사용 |
| **트리거** | 색상 웰(color well) 탭, 커스텀 색상 버튼 탭 |
| **프레젠테이션** | Sheet (`.large` detent) 또는 Popover |
| **iOS 26 특이사항** | Liquid Glass 배경 패널, 7가지 탭 모드, 시스템 전체 색상 공유 |

Color Picker는 `UIColorPickerViewController`가 제공하는 시스템 UI로, Grid/Spectrum/Sliders/Eyedropper/Favorites/Hex/Opacity 7가지 탭을 통해 색상 선택이 가능하다.

---

## 디바이스 컨텍스트

```
iPhone 17 Pro
├─ 화면 크기: 402 × 874pt
├─ Safe Area Top: 59pt (Dynamic Island)
├─ Safe Area Bottom: 34pt (Home Indicator)
├─ Pixel Density: @3x (1206 × 2622px)
└─ 색상 공간: P3 Wide Color (Display P3 색상 지원)
```

---

## 화면 구성 분해

### Spectrum 모드 기준 레이아웃 (ASCII 와이어프레임)

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │  ← Status Bar (59pt)
├─────────────────────────────────────────────┤
│                                              │
│  ← 이전 화면 (dimming) ──────────────────── │
│                                              │
│  ┌──────── Color Picker Sheet ──────────────┐│  ← Sheet top cornerRadius: 34pt
│  │  ─────── Grabber (36 × 5pt) ──────────  ││  ← grabber top: 8pt
│  │                                          ││
│  │  [Grid] [Spec] [Slid] [Eye] [Fav] [Hex] ││  ← Segmented Tab Bar (44pt)
│  │          ~~~~                            ││    선택 탭 underline: accents.blue
│  │                                          ││
│  │  ┌────────────────────────────────────┐  ││
│  │  │                                    │  ││  ← Spectrum Area (200pt)
│  │  │    ← 2D 색상 채도/명도 그라디언트 → │  ││    가로: Hue (색상)
│  │  │    ↑                               │  ││    세로: Saturation → Brightness
│  │  │    밝기                             │  ││
│  │  │    ↓                               │  ││
│  │  │                ◉                   │  ││  ← 선택 커서 (28pt 원)
│  │  │                                    │  ││    border: 3pt white
│  │  └────────────────────────────────────┘  ││    shadow: blur 4pt
│  │                                          ││
│  │  ┌─ Hue Bar ─────────────────────────┐  ││  ← Hue 슬라이더 (높이 28pt)
│  │  │  🌈 무지개 그라디언트 가로 바        │  ││    cornerRadius: 14pt (full)
│  │  │         ◯                          │  ││  ← thumb (28pt 원)
│  │  └────────────────────────────────────┘  ││
│  │                  ↕ 16pt                  ││
│  │  ┌─ Opacity Bar ─────────────────────┐  ││  ← 불투명도 슬라이더 (28pt)
│  │  │  ░░░▒▒▒▓▓▓████████████████         │  ││    체커보드 배경 + 색상 그라디언트
│  │  │         ◯                          │  ││  ← thumb (28pt 원)
│  │  └────────────────────────────────────┘  ││
│  │                  ↕ 16pt                  ││
│  │  ┌─ Preview + Hex ───────────────────┐  ││  ← 하단 미리보기 영역 (44pt)
│  │  │  ■  #3A86FF  ← Hex 코드            │  ││    색상 사각형: 36×36pt
│  │  │  [이전색][현재색]                    │  ││    radius: 8pt
│  │  └────────────────────────────────────┘  ││
│  │                                          ││
│  └──────────────────────────────────────────┘│
│  ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔│  ← Home Indicator (34pt)
└─────────────────────────────────────────────┘
```

---

## 패널 치수 상세

### 전체 패널

| 항목 | 값 | 토큰 |
|------|-----|------|
| 너비 | 화면 전체 너비 (Sheet) | — |
| cornerRadius (top) | 34pt | `spacing.radius.semantic.sheet.iphoneTop` |
| 배경 | Liquid Glass | `materials.liquidGlass.regular.large` |
| Frost blur | 14px | `materials.liquidGlass.regular.large.frostRadius` |
| Grabber | 36 × 5pt, top 8pt | `spacing.components.sheet.grabber*` |

### Tab Bar (모드 선택)

| 항목 | 값 | 토큰 |
|------|-----|------|
| 높이 | 44pt | — |
| 선택 인디케이터 | 2pt underline, `accents.blue` | Light: `#0088ff`, Dark: `#0091ff` |
| 비선택 탭 색상 | `labels.secondary` | `rgba(60,60,67,0.6)` / `rgba(235,235,245,0.7)` |
| 선택 탭 색상 | `accents.blue` | `#0088ff` / `#0091ff` |
| 탭 아이콘 크기 | 20pt (SF Symbol) | — |

### Spectrum Area

| 항목 | 값 |
|------|-----|
| 높이 | 200pt |
| 너비 | 화면 너비 - 32pt (좌우 16pt 패딩) |
| cornerRadius | 12pt (`spacing.radius.lg`) |
| 커서 크기 | 28pt 원 |
| 커서 border | 3pt white |
| 커서 shadow | blur 4pt, `rgba(0,0,0,0.25)` |

### Hue & Opacity Sliders

| 항목 | 값 |
|------|-----|
| 높이 | 28pt |
| cornerRadius | 14pt (full pill) |
| thumb 크기 | 28pt 원 |
| thumb border | 2pt white |
| thumb shadow | blur 3pt, `rgba(0,0,0,0.2)` |
| 간격 (slider 간) | 16pt |

### Preview + Hex 영역

| 항목 | 값 |
|------|-----|
| 높이 | 44pt |
| 색상 사각형 | 36 × 36pt, cornerRadius 8pt |
| Hex 텍스트 | Callout (16pt, Regular) |
| Hex 텍스트 색상 | `labels.primary` |

---

## 모드별 콘텐츠

### Grid 모드

```
┌──────────────────────────────────────────┐
│ ●  ●  ●  ●  ●  ●  ●  ●  ●  ●  ●  ●   │  ← 12열, 스와치 24×24pt
│ ●  ●  ●  ●  ●  ●  ●  ●  ●  ●  ●  ●   │    간격 4pt, 행간 4pt
│ ...                                      │    선택: 2pt accents.blue 링
│ ●  ●  ●  ●  ●  ●  ●  ●  ●  ●  ●  ●   │    + 체크마크 오버레이
└──────────────────────────────────────────┘
  콘텐츠 높이: ~280pt → 총 패널 높이 ~384pt
```

### Sliders 모드

```
┌──────────────────────────────────────────┐
│  R ─────────◯───────── 58                │  ← Red slider + 값 텍스트
│  G ─────────────◯───── 134               │  ← Green slider
│  B ──────────────────◯ 255               │  ← Blue slider
│  A ──────────────────◯ 100%              │  ← Alpha slider
└──────────────────────────────────────────┘
  슬라이더 높이: 각 28pt, 간격 16pt
  콘텐츠 높이: ~176pt → 총 패널 높이 ~280pt
```

### Hex Input 모드

```
┌──────────────────────────────────────────┐
│  # ┌─────────────────────────────┐       │
│    │  3A86FF                     │       │  ← TextField, 44pt 높이
│    └─────────────────────────────┘       │    monospace font
└──────────────────────────────────────────┘
  콘텐츠 높이: ~80pt → 총 패널 높이 ~184pt
```

---

## Light/Dark 모드 차이

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| Sheet 배경 | `rgba(250,250,250,0.7)` + blur 14px | `rgba(0,0,0,0.8)` + blur 14px |
| Tab bar 배경 | 투명 (Sheet 위 렌더링) | 투명 |
| 선택 탭 | `#0088ff` | `#0091ff` |
| Spectrum 배경 | 색상 그라디언트 (모드 무관) | 동일 |
| Slider track | 색상 그라디언트 + 밝은 배경 | 색상 그라디언트 + 어두운 배경 |
| Slider thumb | white, shadow 0.2 | white, shadow 0.3 |
| Hex 텍스트 | `#000000` | `#ffffff` |
| 커서 border | white (3pt) | white (3pt) |
| Grid 스와치 | 동일 색상값 | 동일 색상값 |
| Preview 배경 | `fills.quaternary` light | `fills.quaternary` dark |

---

## 애니메이션

### Sheet Present

```yaml
trigger: Color well 탭
duration: 0.5s
spring: gentle (response: 0.55, dampingRatio: 0.825)
css_approx: cubic-bezier(0.25, 0.46, 0.45, 0.94)
properties:
  translateY: 100% → 0%
```

### Tab 전환

```yaml
trigger: 탭 선택 변경
duration: 0.25s
easing: easeInOut — cubic-bezier(0.42, 0, 0.58, 1.0)
properties:
  content_opacity: 1 → 0 → 1 (crossfade)
  underline_translateX: 이전 탭 X → 선택 탭 X
```

### Spectrum 커서 이동

```yaml
trigger: 드래그 (pan gesture)
duration: 실시간 (gesture-driven)
easing: none (1:1 추적)
haptic: UISelectionFeedbackGenerator (경계 도달 시)
```

### Slider Thumb 이동

```yaml
trigger: 드래그 / 탭
duration: 실시간 (gesture-driven)
spring: snappy (response: 0.3, dampingRatio: 0.8) — 탭으로 점프 시
haptic: UIImpactFeedbackGenerator(.light) — 정수 경계값 통과 시
```

### Reduce Motion

```yaml
prefers-reduced-motion:
  sheet: fade only (0.2s)
  tab_transition: 즉시 전환 (crossfade 제거)
  커서/thumb: 동일 (gesture-driven은 항상 유지)
```

---

## 인터랙션 노트

| 인터랙션 | 동작 |
|---------|------|
| **Color well 탭** | Picker Sheet `.large` detent로 등장 |
| **탭 바 탭 변경** | 해당 모드로 crossfade 전환 |
| **Spectrum 드래그** | 실시간 색상 변경 + 미리보기 업데이트 |
| **Hue bar 드래그** | 색상(Hue) 변경 → Spectrum 그라디언트 갱신 |
| **Opacity bar 드래그** | 불투명도 변경 |
| **Grid 스와치 탭** | 즉시 색상 선택 + 체크마크 표시 |
| **Hex 입력** | 텍스트 필드에 직접 입력, 유효한 Hex면 즉시 반영 |
| **Eyedropper 활성화** | 전체 화면 루페 모드 진입, 탭으로 픽셀 색상 추출 |
| **Favorites 저장** | 현재 색상을 즐겨찾기 슬롯에 저장 (+버튼) |
| **Sheet 닫기** | 아래 스와이프 또는 Done 버튼 |

---

## 접근성 (Accessibility)

| 항목 | 요구사항 |
|------|---------|
| **VoiceOver** | Sheet 등장 시 "Color Picker" 안내 |
| **탭 바** | 각 탭: `accessibilityLabel: "[모드명]"`, `accessibilityTraits: .selected` (선택 시) |
| **Spectrum** | `accessibilityLabel: "Color spectrum"`, 드래그 시 "Red [value], Green [value], Blue [value]" 읽기 |
| **Sliders** | `accessibilityTraits: .adjustable`, 증감 시 값 읽기 |
| **Grid 스와치** | `accessibilityLabel: "[색상명]"` (e.g., "Red", "Sky Blue") |
| **Hex 입력** | `accessibilityLabel: "Hex color code"`, 키보드 입력 지원 |
| **터치 타겟** | 스와치 24pt → 44pt 히트 영역 확장 필요 |
| **Dynamic Type** | Hex 텍스트, 슬라이더 값 레이블 크기 조정 |
| **색상 대비** | 탭 텍스트, Hex 값: WCAG AA 충족 |
| **Reduce Motion** | Sheet fade, 탭 전환 즉시 |
| **Switch Control** | 모든 탭, 스와치, 슬라이더에 순차 접근 |

---

## 구현 체크리스트

- [ ] `UIColorPickerViewController` / `.colorPicker()` 사용
- [ ] `supportsAlpha` 설정 (불투명도 필요 여부)
- [ ] `selectedColor` 바인딩 (실시간 색상 업데이트)
- [ ] P3 Wide Color 지원 확인
- [ ] 7가지 탭 모드 모두 동작 검증
- [ ] Sheet detent 올바르게 설정 (`.large`)
- [ ] Light/Dark Liquid Glass 소재 적용
- [ ] Reduce Motion 대응
- [ ] VoiceOver로 모든 탭/스와치/슬라이더 탐색 검증
- [ ] Eyedropper 모드 전체 화면 동작 검증

---

## 관련 화면

| 화면 | 관계 |
|------|------|
| `sheet-form.md` | Sheet 프레젠테이션 패턴 공유 |
| `picker.md` | Picker 인터랙션 패턴 비교 (날짜/시간 선택) |
| `menus.md` | 메뉴 내 색상 선택 옵션 (한정된 색상 팔레트 시) |
