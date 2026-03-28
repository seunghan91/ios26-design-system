# iPad Window — iOS 26 iPad 페이지 예시

> **References**
> - Components: `../../components/specs/windows.md`
> - Tokens: `../../tokens/colors.json`, `../../tokens/spacing.json`, `../../tokens/typography.json`, `../../tokens/materials.json`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="5413:10149")`

---

## 1. 화면 개요

iPadOS 26 Windowed Mode는 **Stage Manager** 환경에서 사용되는 멀티 윈도우 시스템이다. macOS 스타일의 윈도우 크롬(타이틀 바, 닫기/최소화/전체화면 버튼), 자유로운 크기 조절 핸들, 포커스/비포커스 상태를 포함한다. iOS 26에서는 윈도우 크롬에 **Liquid Glass** 소재가 적용되어 반투명 효과를 제공한다.

| 항목 | 값 |
|------|-----|
| **디바이스** | iPad Pro 13" (1210 x 834pt landscape) |
| **플랫폼** | iPadOS 26 (Stage Manager) |
| **요구 사항** | iPad Pro M1 이상 / iPad Air M1 이상 |
| **Figma Node** | `5413:10149` — Window Container |
| **iOS 26 특징** | Liquid Glass 타이틀 바, 개선된 크기 조절 |
| **외부 디스플레이** | iPadOS 16+에서 지원 (M1 이상) |

---

## 2. 디바이스 컨텍스트

```
┌──────────────────────────────────────────────────────────────────────────────────┐
│                              iPad Pro 13" Bezel                                  │
│  ┌────────────────────────────────────────────────────────────────────────────┐  │
│  │                          1210 x 834pt (landscape)                         │  │
│  │                                                                           │  │
│  │  Stage Manager 활성 시:                                                   │  │
│  │  - 좌측: 최근 앱 스트립 (~80pt)                                           │  │
│  │  - 중앙: 활성 윈도우 (자유 배치)                                           │  │
│  │  - 하단: Dock (~80pt)                                                     │  │
│  │  - 사용 가능 영역: ~1050 x 734pt                                          │  │
│  │                                                                           │  │
│  └────────────────────────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────────────────────┘
```

---

## 3. 윈도우 크기 규격

### 3.1 크기 프리셋

| 크기 | 너비 | 높이 | 비율 | 사용 장면 |
|------|------|------|------|---------|
| **Standard** | 1180pt | 820pt | ~16:11 | 기본 전체화면급 윈도우 |
| **Medium** | 860pt | 640pt | ~4:3 | 두 창 나란히 |
| **Small** | 620pt | 480pt | ~4:3 | 보조 창 |
| **Minimum** | 320pt | 320pt | 1:1 | 허용 최소 크기 |
| **Full Screen** | 전체화면 | 전체화면 | 기기 비율 | 전체화면 모드 |

### 3.2 크기 규칙

| 속성 | 값 | 비고 |
|------|-----|------|
| 최소 너비 | 320pt | 시스템 강제 제한 |
| 최소 높이 | 320pt | 시스템 강제 제한 |
| 최대 크기 | 전체 화면 | 전체화면 모드 |
| 크기 조절 | 자유 (8방향 핸들) | 비율 잠금 없음 (기본) |
| 스냅 포인트 | 화면 가장자리, 다른 윈도우 | 자석 효과 |

---

## 4. 타이틀 바 (Window Chrome)

### 4.1 와이어프레임

```
┌─────────────────────────────────────────────────────────────────┐
│  ●  ●  ●   [  앱 타이틀                        ]   [─]  [□]   │ ← 36pt
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│                                                                 │
│                       앱 콘텐츠 영역                             │
│                                                                 │
│                                                                 │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 4.2 타이틀 바 치수

| 속성 | 값 | 토큰 참조 |
|------|-----|----------|
| 높이 | 36pt | `windows.md` 스펙 |
| 좌측 패딩 | 12pt | — |
| 우측 패딩 | 12pt | — |
| Window Controls 좌측 여백 | 8pt | — |
| 타이틀 정렬 | 중앙 | — |
| 타이틀 폰트 | Subheadline (15pt, Semibold) | `typography.styles.subheadline` |
| 배경 | Liquid Glass Regular Medium | `materials.liquidGlass.regular.medium` |

### 4.3 Liquid Glass 타이틀 바

| 속성 | Light Mode | Dark Mode | 토큰 참조 |
|------|-----------|-----------|----------|
| 배경색 | `#f5f5f5` (a: 0.6) | `#000000` (a: 0.6) | `materials.liquidGlass.regular.medium` |
| Frost | blur(12px) | blur(12px) | — |
| 타이틀 색상 | `#000000` | `#ffffff` | `colors.labels.primary` |
| Tint (Dark) | — | `#ffffff` (a: 0.06) | — |

---

## 5. Window Controls

### 5.1 닫기 / 최소화 / 전체화면 버튼

```
Window Controls (좌상단):

  ● ● ●
  닫  최  전
  기  소  체
      화  화
          면

  각 12pt 원형, 간격 8pt
  좌측 패딩 8pt
```

| 버튼 | 색상 | 크기 | 토큰 참조 |
|------|------|------|----------|
| 닫기 (Close) | `#ff5f57` | 12pt 원형 | `colors.miscellaneous.windowControls.close` |
| 최소화 (Minimize) | `#febc2f` | 12pt 원형 | `colors.miscellaneous.windowControls.minimize` |
| 전체화면 (Maximize) | `#27c840` | 12pt 원형 | `colors.miscellaneous.windowControls.maximize` |
| 비활성 (Inactive) | `#000000` (a: 0.05) | 12pt 원형 | `colors.miscellaneous.windowControls.bgInactive.light` |

### 5.2 버튼 상태

| 상태 | 외관 | 동작 |
|------|------|------|
| **기본** | 색상 원형, 아이콘 없음 | — |
| **Hover** | 색상 원형 + 내부 아이콘 (✕, −, ↗) | 마우스/트랙패드 Hover 시 |
| **Pressed** | 색상 약간 어둡게 | 클릭/탭 중 |
| **Inactive** (비포커스) | 회색 원형 (`bgInactive`) | 다른 윈도우가 포커스 |

### 5.3 Focus vs Unfocus 비교

```
포커스된 윈도우:                    비포커스 윈도우:
┌─────────────────────────┐       ┌─────────────────────────┐
│ 🔴 🟡 🟢  앱 타이틀     │       │ ⚪ ⚪ ⚪  앱 타이틀      │
├─────────────────────────┤       ├─────────────────────────┤
│                         │       │                         │
│  콘텐츠 (선명)           │       │  콘텐츠 (약간 desaturate)│
│                         │       │                         │
└─────────────────────────┘       └─────────────────────────┘
  Shadow: blur(24), a:0.25          Shadow: blur(24), a:0.10
```

| 속성 | 포커스 | 비포커스 |
|------|--------|---------|
| Window Controls | 컬러 (red/yellow/green) | 회색 (`bgInactive`) |
| Shadow opacity | 0.25 | 0.10 |
| Shadow blur | 24pt | 24pt |
| Shadow offset | (0, 8pt) | (0, 8pt) |
| 타이틀 색상 | `labels.primary` | `labels.secondary` |

---

## 6. 크기 조절 핸들

### 6.1 8방향 핸들

```
┌──── ★ ─────────────────────── ★ ────────────────────── ★ ────┐
│                                                               │
★                                                               ★
│                                                               │
│                       앱 콘텐츠                                │
│                                                               │
★                                                               ★
│                                                               │
└──── ★ ─────────────────────── ★ ────────────────────── ★ ────┘

★ = Resize handle
  모서리: 12 x 12pt hit area
  변: 8pt (한 축 방향만 조절)
```

| 속성 | 값 |
|------|-----|
| 모서리 핸들 크기 | 12 x 12pt (hit area) |
| 변 핸들 크기 | 8pt (한 축 방향) |
| 시각적 표시 | 없음 (투명, 커서 변경으로 인지) |
| 커서 | 방향에 따라 ↔ ↕ ↗ ↘ 등 |
| 최소 드래그 | 2pt (의도치 않은 리사이즈 방지) |

### 6.2 크기 조절 동작

| 동작 | 효과 |
|------|------|
| 모서리 드래그 | 자유 크기 조절 (너비 + 높이 동시) |
| 변 드래그 | 한 방향만 조절 |
| Option + 드래그 | 중심 기준 양방향 조절 |
| 더블 클릭 (변) | 해당 방향으로 콘텐츠에 맞게 자동 조절 |

---

## 7. Window Grabber (이동)

### 7.1 타이틀 바 드래그

| 속성 | 값 | 토큰 참조 |
|------|-----|----------|
| 드래그 영역 | 타이틀 바 전체 (36pt 높이) | — |
| Grabber 표시 | 없음 (타이틀 바가 드래그 affordance) | — |
| Grabber 색상 | — | `colors.miscellaneous.windowGrabber` |
| 스냅 | 화면 가장자리, 다른 윈도우, 좌측 스트립 | — |
| 드래그 시 | 윈도우 약간 투명화 (a: 0.9) | — |

### 7.2 윈도우 이동 규칙

| 규칙 | 설명 |
|------|------|
| 화면 경계 | 윈도우가 화면 밖으로 나가지 않음 (타이틀 바 최소 20pt 노출) |
| 다른 윈도우 위 | 자유롭게 겹칠 수 있음 |
| Dock 영역 | Dock 위로 드래그 시 Dock이 숨겨짐 |
| Stage Manager 스트립 | 좌측 스트립 위로 드래그 시 해당 앱 그룹에 추가 |

---

## 8. Light / Dark Mode 차이

| 요소 | Light Mode | Dark Mode | 토큰 참조 |
|------|-----------|-----------|----------|
| 타이틀 바 배경 | `#f5f5f5` (a: 0.6) | `#000000` (a: 0.6) | `materials.liquidGlass.regular.medium` |
| Window Controls | 컬러 (빨/노/초) | 컬러 (빨/노/초) | `colors.miscellaneous.windowControls` |
| Controls (비활성) | `#000` (a: 0.05) | `#fff` (a: 0.05) | `colors.miscellaneous.windowControls.bgInactive` |
| 타이틀 텍스트 | `#000000` | `#ffffff` | `colors.labels.primary` |
| 윈도우 그림자 | `#000` a:0.25 | `#000` a:0.35 | — |
| 콘텐츠 배경 | `#ffffff` | `#000000` | `colors.backgrounds.primary` |
| 코너 반경 | 12pt | 12pt | — |

---

## 9. iPad 전용 적응사항

### 9.1 Stage Manager 통합

```
Stage Manager 레이아웃:

┌────────┬────────────────────────────────────────────────────────┐
│ Recent │                                                        │
│ Apps   │  ┌─────────────────────────────┐                      │
│ Strip  │  │ ● ● ●  Notes               │                      │
│ (80pt) │  │                             │  ┌──────────────────┐│
│        │  │                             │  │ ● ● ●  Safari    ││
│ [앱A]  │  │     Primary Window          │  │                  ││
│ [앱B]  │  │     (Standard: 860x640)     │  │  Secondary       ││
│ [앱C]  │  │                             │  │  (Small: 620x480)││
│ [앱D]  │  │                             │  │                  ││
│        │  └─────────────────────────────┘  │                  ││
│        │                                    └──────────────────┘│
│        │                                                        │
├────────┴────────────────────────────────────────────────────────┤
│                           DOCK                                   │
└──────────────────────────────────────────────────────────────────┘
```

### 9.2 최대 동시 윈도우

| 환경 | 최대 윈도우 |
|------|-----------|
| iPad 화면 | 4개 |
| 외부 디스플레이 | 4개 (별도) |
| 합계 | 8개 |

### 9.3 Pointer 지원

| 인터랙션 | 동작 |
|---------|------|
| Hover (타이틀 바) | 커서 → 이동 아이콘 |
| Hover (Window Controls) | 아이콘 표시 (✕, −, ↗) |
| Hover (리사이즈 핸들) | 커서 → 리사이즈 화살표 |
| Click (타이틀 바) | 윈도우 포커스 |
| Double-click (타이틀 바) | 전체화면 전환 |
| Drag (타이틀 바) | 윈도우 이동 |
| Drag (핸들) | 크기 조절 |
| Right-click (타이틀 바) | 윈도우 관리 메뉴 |

### 9.4 키보드 단축키

| 단축키 | 동작 |
|--------|------|
| `⌘W` | 윈도우 닫기 |
| `⌘M` | 윈도우 최소화 |
| `⌃⌘F` | 전체화면 전환 |
| `⌘`` ` | 같은 앱의 다른 윈도우 전환 |
| `⌘Tab` | 앱 간 전환 |
| `Globe + ↑` | 전체화면 |
| `Globe + ↓` | 최소화 |
| `Globe + ←` | 왼쪽 절반 |
| `Globe + →` | 오른쪽 절반 |

---

## 10. 멀티태스킹 고려사항

### 10.1 윈도우 그룹

- Stage Manager에서 앱들을 그룹으로 묶을 수 있음
- 그룹 전환: 좌측 스트립에서 다른 그룹 클릭
- 한 그룹에 최대 4개 윈도우

### 10.2 전체화면 전환

```
일반 윈도우 → 전체화면:
  1. 🟢 버튼 클릭 또는 ⌃⌘F
  2. 윈도우가 전체 화면으로 확장
  3. 타이틀 바 자동 숨김 (hover 시 표시)
  4. Stage Manager 스트립 숨김
  5. Dock 자동 숨김

전체화면 → 일반 윈도우:
  1. 화면 상단 hover → 타이틀 바 표시
  2. 🟢 버튼 클릭 또는 ⌃⌘F
  3. 이전 크기/위치로 복원
```

### 10.3 외부 디스플레이

| 속성 | 값 |
|------|-----|
| 지원 | iPadOS 16+, M1 이상 |
| 해상도 | 최대 6K (디스플레이에 따라) |
| 독립 윈도우 | iPad와 별개로 4개까지 |
| 미러링 | 미러링 모드에서는 동일 콘텐츠 |

---

## 11. 윈도우 애니메이션

| 동작 | 애니메이션 |
|------|----------|
| 열기 | Scale(0.8) → Scale(1.0) + fade in, 0.35s spring |
| 닫기 | Scale(1.0) → Scale(0.8) + fade out, 0.3s ease-out |
| 최소화 | Scale(1.0) → Scale(0.3) → Dock으로 이동 |
| 전체화면 진입 | Bounds expand + corners 0pt, 0.4s spring |
| 전체화면 탈출 | Bounds contract + corners 12pt, 0.4s spring |
| 포커스 전환 | Shadow/brightness 전환, 0.2s ease |

---

## 12. 접근성

| 항목 | 설명 |
|------|------|
| VoiceOver | "윈도우, [앱이름], [크기], 닫기/최소화/전체화면 버튼" |
| Dynamic Type | 타이틀 바 텍스트 크기 조절 (최소 36pt 높이 유지) |
| Reduce Transparency | Liquid Glass → 불투명 타이틀 바 |
| Reduce Motion | 윈도우 열기/닫기 애니메이션 비활성화 |
| Switch Control | 순차적 윈도우 포커스 이동 |
| Keyboard Navigation | 모든 윈도우 컨트롤 키보드 접근 가능 |

---

## 13. 관련 컴포넌트

| 컴포넌트 | 관계 | 참조 |
|---------|------|------|
| Toolbar | 윈도우 내부 상단 | `../../components/specs/toolbar.md` |
| Tab Bar | 윈도우 내부 탭 | `../../components/specs/tab-bar.md` |
| Sidebar | 윈도우 내부 내비게이션 | `../../components/specs/sidebars.md` |
| System UI | Stage Manager 시스템 | `../../components/specs/system-ui.md` |
