# iPad Control Center — iOS 26 iPad 페이지 예시

> **References**
> - Components: `../../components/specs/system-ui.md`
> - Tokens: `../../tokens/colors.json`, `../../tokens/spacing.json`, `../../tokens/typography.json`, `../../tokens/materials.json`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24688")`

---

## 1. 화면 개요

iPad Control Center는 화면 우상단 모서리에서 스와이프 다운하여 접근하는 시스템 UI다. iOS 26에서는 **Liquid Glass** 소재 타일이 격자 형태로 배치되며, iPad의 넓은 화면을 활용한 더 큰 모듈 그리드를 제공한다. Landscape 모드에서는 수평으로 넓어진 레이아웃으로 더 많은 모듈을 한 화면에 표시한다.

| 항목 | 값 |
|------|-----|
| **디바이스** | iPad Pro 13" (1210 x 834pt landscape) |
| **플랫폼** | iPadOS 26 |
| **접근 방법** | 우상단 모서리 스와이프 다운 |
| **배경** | Dimming overlay + 배경 blur |
| **iOS 26 특징** | Liquid Glass 모듈 타일, 커스터마이즈 가능 |
| **커스터마이징** | WidgetKit (ControlWidget) |

---

## 2. 디바이스 컨텍스트

```
┌──────────────────────────────────────────────────────────────────────────────────┐
│                              iPad Pro 13" Bezel                                  │
│  ┌────────────────────────────────────────────────────────────────────────────┐  │
│  │                          1210 x 834pt (landscape)                         │  │
│  │                                                                           │  │
│  │              Control Center는 전체 화면 위에 overlay로 표시               │  │
│  │              Dimming + Blur 배경 처리                                     │  │
│  │                                                                           │  │
│  └────────────────────────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────────────────────┘
```

---

## 3. 전체 레이아웃

### 3.1 Landscape 모드 와이어프레임

```
┌─────────────────────────────────────────────────────────────────────────┐
│  Dimming Overlay (전체 화면)                                             │
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐    │
│  │  STATUS BAR (24pt) — 시간, 배터리, Wi-Fi 등                      │    │
│  └─────────────────────────────────────────────────────────────────┘    │
│                                                                         │
│  ┌──────────────────────────────────────────────────────────────┐       │
│  │  CONTROL CENTER GRID                                          │       │
│  │  (center-aligned, max-width: 800pt)                           │       │
│  │                                                               │       │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐        │       │
│  │  │ 비행기   │ │ Wi-Fi    │ │ Bluetooth│ │ AirDrop  │        │       │
│  │  │ 모드     │ │          │ │          │ │          │        │       │
│  │  │ (2x2)    │ │ (2x2)    │ │ (2x2)    │ │ (2x2)    │        │       │
│  │  └──────────┘ └──────────┘ └──────────┘ └──────────┘        │       │
│  │                                                               │       │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────────────────┐         │       │
│  │  │ 집중모드 │ │ 화면미러 │ │ 밝기 조절            │         │       │
│  │  │ (2x2)    │ │ (2x2)    │ │ (2x4 — 세로 슬라이더)│         │       │
│  │  └──────────┘ └──────────┘ │                      │         │       │
│  │                             │                      │         │       │
│  │  ┌──────────┐ ┌──────────┐ └──────────────────────┘         │       │
│  │  │ 타이머   │ │ 카메라   │ ┌──────────────────────┐         │       │
│  │  │ (2x2)    │ │ (2x2)    │ │ 볼륨 조절            │         │       │
│  │  └──────────┘ └──────────┘ │ (2x4 — 세로 슬라이더)│         │       │
│  │                             └──────────────────────┘         │       │
│  │                                                               │       │
│  │  ┌──────────────────────────────────────────────────┐        │       │
│  │  │  Now Playing (4x2 — 가로 넓은 타일)               │        │       │
│  │  │  [앨범아트]  제목 — 아티스트   [⏮] [⏯] [⏭]     │        │       │
│  │  └──────────────────────────────────────────────────┘        │       │
│  │                                                               │       │
│  └──────────────────────────────────────────────────────────────┘       │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 3.2 Portrait 모드 비교

```
Portrait (834 x 1210pt):
  - 그리드 최대 너비: 600pt
  - 세로로 더 많은 모듈 표시 가능
  - 밝기/볼륨 슬라이더가 나란히 배치

Landscape (1210 x 834pt):
  - 그리드 최대 너비: 800pt
  - 수평으로 더 많은 타일 배치
  - 높이 제한으로 스크롤 필요할 수 있음
```

---

## 4. 모듈 타일 치수

### 4.1 기본 그리드 단위

| 항목 | 값 | 비고 |
|------|-----|------|
| 기본 타일 (1x1) | 46pt x 46pt | 최소 단위 |
| 표준 타일 (2x2) | 100pt x 100pt | 대부분의 토글 컨트롤 |
| 넓은 타일 (4x2) | 208pt x 100pt | Now Playing, 연결 상태 |
| 세로 타일 (2x4) | 100pt x 208pt | 밝기, 볼륨 슬라이더 |
| 대형 타일 (4x4) | 208pt x 208pt | 음악 플레이어 확장 |
| 타일 간 간격 | 8pt | `spacing.scale.2` |
| 그리드 패딩 | 24pt | `spacing.inset.xl` |

### 4.2 iPad vs iPhone 타일 크기 비교

| 타일 유형 | iPhone (pt) | iPad (pt) | 비율 |
|----------|-------------|---------|------|
| 2x2 토글 | 91 x 91 | 100 x 100 | +10% |
| 2x4 슬라이더 | 91 x 206 | 100 x 208 | 유사 |
| 4x4 플레이어 | 206 x 206 | 208 x 208 | 유사 |

### 4.3 타일 Liquid Glass 소재

| 속성 | Light Mode | Dark Mode | 토큰 참조 |
|------|-----------|-----------|----------|
| 배경색 | `#f7f7f7` (a: 1) | `#000000` (a: 0.6) | `materials.liquidGlass.regular.small.light.default.bg` |
| Border | `#dddddd` | — | `materials.liquidGlass.regular.small.light.default.border` |
| Tint (Dark) | — | `#ffffff` (a: 0.06) | `materials.liquidGlass.regular.small.dark.default.tint` |
| Frost Radius | 7px | 7px | `materials.liquidGlass.regular.small.frostRadius` |
| Corner Radius | 20pt | 20pt | `spacing.radius.xxl` |
| Shadow Blur | 40px | 40px | — |

### 4.4 타일 활성 상태

| 속성 | 비활성 | 활성 | 토큰 참조 |
|------|--------|------|----------|
| 배경색 (Light) | `#f7f7f7` | `#ffffff` | `materials.liquidGlass.regular.small.light.primary.bg` |
| 아이콘 색상 (Light) | `labels.secondary` | `#0091ff` | `materials.liquidGlass.regular.small.light.primary.iconColor` |
| 배경색 (Dark) | `#000000` (a: 0.6) | `#ffffff` | — |
| 아이콘 색상 (Dark) | `labels.secondary` | `#0091ff` | — |

---

## 5. 주요 모듈 상세

### 5.1 연결 모듈 그룹 (4개 타일)

```
┌──────────┬──────────┐
│  비행기   │  Wi-Fi   │
│  모드     │          │
│  ✈️       │  📶      │
├──────────┼──────────┤
│Bluetooth │ AirDrop  │
│          │          │
│  ᛒ       │  📡      │
└──────────┴──────────┘
  각 100x100pt, 간격 8pt
  전체 그룹: 208 x 208pt
```

### 5.2 밝기/볼륨 슬라이더

```
┌──────────┐
│  ☀️       │
│  │ ←── 채움  │  ← 세로 슬라이더
│  │       │  │     높이에 따라 값 결정
│  │       │  │     드래그 또는 탭으로 조작
│  │       │  │
│  │       │  │
│  └───────┘  │
│ (빈 영역)   │
│             │
└──────────┘
  100 x 208pt
```

| 속성 | 값 |
|------|-----|
| 슬라이더 track 너비 | 60pt |
| 슬라이더 track corner | 30pt (pill) |
| Fill 색상 | `#ffffff` (Light), `#ffffff` (Dark) |
| Empty 색상 | Liquid Glass Small default bg |
| 아이콘 위치 | 상단 중앙 |
| 아이콘 크기 | 24pt |

### 5.3 Now Playing 모듈

```
┌──────────────────────────────────────────────────┐
│  [앨범아트    ]  노래 제목                         │
│  [40x40, r:8 ]  아티스트 이름                     │
│               [⏮]  [⏯]  [⏭]    ─── 진행 바 ───  │
└──────────────────────────────────────────────────┘
  208 x 100pt (4x2 타일)
```

| 요소 | 폰트 | 색상 | 토큰 참조 |
|------|------|------|----------|
| 제목 | Subheadline (15pt, Semibold) | `labels.primary` | `typography.styles.subheadline` |
| 아티스트 | Footnote (13pt) | `labels.secondary` | `typography.styles.footnote` |
| 재생 버튼 | SF Symbol 22pt | `labels.primary` | — |
| 진행 바 높이 | 4pt | accent blue | `colors.accents.blue` |

---

## 6. Light / Dark Mode 차이

### 6.1 Dimming Overlay

| 속성 | Light Mode | Dark Mode | 토큰 참조 |
|------|-----------|-----------|----------|
| Overlay 색상 | `#000000` (a: 0.2) | `#000000` (a: 0.48) | `colors.overlays.default` |
| Blur radius | 20px | 20px | `materials.backgroundMaterials.thin.blurRadius` |

### 6.2 타일 외관 비교

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| 비활성 타일 배경 | `#f7f7f7` | `#000000` (a: 0.6) |
| 활성 타일 배경 | `#ffffff` (밝은 강조) | `#ffffff` (밝은 강조) |
| 아이콘 비활성 | `#3c3c43` (a: 0.6) | `#ebebf5` (a: 0.7) |
| 아이콘 활성 | `#0088ff` | `#0091ff` |
| 텍스트 | `#000000` | `#ffffff` |
| 전체 분위기 | 밝은 유리질 느낌 | 어두운 유리질 + 미세 tint |

---

## 7. iPad 전용 적응사항

### 7.1 Landscape 최적화

- iPad landscape에서 그리드 최대 너비 800pt (화면 중앙 정렬)
- 수평 공간 활용: 연결 모듈(208pt) + 슬라이더 2개(100pt x 2) + Now Playing(208pt) = 한 행에 배치 가능
- 높이가 제한적(834pt)이므로 모듈 수에 따라 세로 스크롤 필요

### 7.2 Portrait vs Landscape 레이아웃

```
Portrait (834 x 1210pt):           Landscape (1210 x 834pt):
┌────────────────┐                 ┌──────────────────────────┐
│ [연결] [밝기]  │                 │ [연결] [밝기] [볼륨] [NP] │
│ [NP  ] [볼륨]  │                 │ [타이머][카메라][집중][미러]│
│ [타이머][카메라]│                 └──────────────────────────┘
│ [집중] [미러]  │                   더 넓고 얕은 배치
└────────────────┘
  더 좁고 긴 배치
```

### 7.3 Pointer 지원

| 인터랙션 | 동작 |
|---------|------|
| Hover (타일) | 미묘한 scale(1.02) + 밝기 증가 |
| Click | 토글 on/off |
| Long press / Force click | 확장 옵션 표시 (예: Wi-Fi 네트워크 선택) |
| Scroll wheel | 슬라이더 값 조정 (밝기/볼륨) |
| Drag | 슬라이더 직접 조작 |

### 7.4 키보드 단축키

| 단축키 | 동작 |
|--------|------|
| `Fn + C` | Control Center 열기/닫기 |
| `Esc` | Control Center 닫기 |
| `←` `→` `↑` `↓` | 타일 간 포커스 이동 |
| `Return` / `Space` | 포커스된 타일 활성화 |

---

## 8. 멀티태스킹 고려사항

### 8.1 Control Center와 앱 상태

- Control Center는 **모든 앱 위에** overlay로 표시
- Split View / Slide Over 상태 관계없이 전체 화면 overlay
- Control Center 활성 시 하단 앱은 dimming + blur 처리

### 8.2 Stage Manager 환경

- Stage Manager에서도 Control Center는 전체 화면 overlay
- 모든 윈도우 위에 표시
- Control Center 닫으면 이전 윈도우 배치 복원

### 8.3 외부 디스플레이

- 외부 디스플레이 연결 시 Control Center는 iPad 화면에서만 표시
- 외부 디스플레이용 미러링/확장 토글이 연결 모듈 그룹에 추가

---

## 9. 커스터마이징 가능 영역

### 9.1 사용자 커스터마이징

| 항목 | 방법 |
|------|------|
| 모듈 추가/제거 | 설정 > Control Center |
| 모듈 순서 변경 | 길게 눌러 드래그 |
| 타일 크기 변경 | 모서리 드래그 (2x2 → 4x2 등) |
| 페이지 추가 | 좌우 스와이프로 추가 페이지 |

### 9.2 개발자 커스터마이징 (ControlWidget)

| 항목 | API |
|------|-----|
| 토글 컨트롤 | `ControlWidget` + `ControlWidgetToggle` |
| 버튼 컨트롤 | `ControlWidget` + `ControlWidgetButton` |
| 타일 크기 | 시스템 자동 결정 (2x2 기본) |
| 커스텀 tint | `.tint(.blue)` 등 accent color 지정 가능 |

---

## 10. 접근성

| 항목 | 설명 |
|------|------|
| VoiceOver | 각 타일은 "버튼, [이름], [상태: 켜짐/꺼짐]" 형태 |
| Dynamic Type | 타일 내 텍스트 크기 조절 (최소 크기 유지) |
| Reduce Transparency | Liquid Glass → 불투명 배경 |
| Reduce Motion | 열기/닫기 애니메이션 비활성화 |
| Switch Control | 그리드 순서대로 포커스 이동 |
| AssistiveTouch | Control Center 접근 버튼 사용 가능 |

---

## 11. 관련 컴포넌트

| 컴포넌트 | 관계 | 참조 |
|---------|------|------|
| System UI | 상위 시스템 컴포넌트 | `../../components/specs/system-ui.md` |
| Widgets | ControlWidget 기반 | `../../components/specs/widgets.md` |
| Toggle | 토글 상태 UI | `../../components/specs/toggle.md` |
| Sliders | 밝기/볼륨 슬라이더 | `../../components/specs/sliders.md` |
