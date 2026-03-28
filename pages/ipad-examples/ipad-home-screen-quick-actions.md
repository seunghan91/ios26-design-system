# iPad Home Screen Quick Actions — iOS 26 iPad 페이지 예시

> **References**
> - Components: `../../components/specs/context-menus.md`, `../../components/specs/system-ui.md`
> - Tokens: `../../tokens/colors.json`, `../../tokens/spacing.json`, `../../tokens/typography.json`, `../../tokens/materials.json`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:25994")`

---

## 1. 화면 개요

Home Screen Quick Actions는 홈 화면에서 앱 아이콘을 **길게 누르거나 우클릭**할 때 나타나는 Context Menu다. iPad에서는 iPhone과 달리 **Popover 스타일**로 표시되며, 앱 아이콘의 확대 미리보기와 함께 액션 목록이 나타난다. iOS 26에서는 **Liquid Glass** 소재가 메뉴 카드에 적용된다.

| 항목 | 값 |
|------|-----|
| **디바이스** | iPad Pro 13" (1210 x 834pt landscape) |
| **플랫폼** | iPadOS 26 |
| **트리거** | Long Press (0.5초) 또는 Right-click |
| **구성** | 앱 아이콘 Preview + 액션 메뉴 카드 |
| **iOS 26 특징** | Liquid Glass 메뉴 배경, spring 애니메이션 |
| **최대 액션 수** | 4개 (커스텀) + 시스템 액션 |

---

## 2. 디바이스 컨텍스트

```
┌──────────────────────────────────────────────────────────────────────────────────┐
│                              iPad Pro 13" Bezel                                  │
│  ┌────────────────────────────────────────────────────────────────────────────┐  │
│  │                          1210 x 834pt (landscape)                         │  │
│  │                                                                           │  │
│  │  Context Menu는 앱 아이콘 위치에서 표시                                    │  │
│  │  Dimming Overlay가 전체 화면을 커버                                        │  │
│  │                                                                           │  │
│  └────────────────────────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────────────────────┘
```

---

## 3. 전체 레이아웃

### 3.1 Quick Actions 와이어프레임

```
┌─────────────────────────────────────────────────────────────────────────┐
│  Dimming Overlay (전체 화면, 반투명 블러)                                 │
│                                                                         │
│  STATUS BAR (24pt, dimmed)                                              │
│                                                                         │
│  [App1] [App2]  ┌── Preview + Menu ──────────────────┐  [App5] [App6]  │
│                 │                                     │                 │
│  [App7] [App8]  │  ┌──────────────────────────────┐  │  [App11][App12] │
│                 │  │                              │  │                 │
│                 │  │   앱 아이콘 확대 Preview       │  │                 │
│                 │  │   (120 x 120pt, r:28)        │  │                 │
│                 │  │                              │  │                 │
│                 │  │       [앱 이름]               │  │                 │
│                 │  │                              │  │                 │
│                 │  └──────────────────────────────┘  │                 │
│                 │              ↕ 8pt gap              │                 │
│                 │  ┌──────────────────────────────┐  │                 │
│                 │  │  [📝] 새 메모 작성             │  │                 │
│                 │  │  ──────────────────────────  │  │                 │
│                 │  │  [📷] 사진 찍기               │  │                 │
│                 │  │  ──────────────────────────  │  │                 │
│                 │  │  [📋] 클립보드에서 붙여넣기    │  │                 │
│                 │  │  ──────────────────────────  │  │                 │
│                 │  │  [📂] 폴더 열기               │  │                 │
│                 │  ├──────────────────────────────┤  │                 │
│                 │  │  홈 화면 편집                  │  │                 │
│                 │  │  ──────────────────────────  │  │                 │
│                 │  │  앱 공유                      │  │                 │
│                 │  │  ──────────────────────────  │  │                 │
│                 │  │  🔴 앱 삭제                   │  │                 │
│                 │  └──────────────────────────────┘  │                 │
│                 │                                     │                 │
│                 └─────────────────────────────────────┘                 │
│                                                                         │
│  ────────────────────────── DOCK ───────────────────────────────        │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 4. Preview 영역

### 4.1 앱 아이콘 확대

| 속성 | 값 | 비고 |
|------|-----|------|
| Preview 아이콘 크기 | 120 x 120pt | 홈 화면 아이콘(76pt)의 ~1.6배 |
| Corner Radius | 28pt | iPad 아이콘 비율 유지 |
| Shadow | blur(16px), `#000` a:0.2 | lift 효과 |
| 배경 | 앱 아이콘 자체 (투명 배경 없음) | — |
| Scale 애니메이션 | 76pt → 120pt (spring, 0.3s) | 길게 누르기 시 |

### 4.2 앱 이름

| 속성 | 값 | 토큰 참조 |
|------|-----|----------|
| 폰트 | Subheadline (15pt, Semibold) | `typography.styles.subheadline` |
| 색상 (Light) | `#ffffff` + shadow | 배경 위 가독성 |
| 위치 | 아이콘 아래 중앙 정렬, 4pt gap | — |
| 최대 줄 수 | 1 (truncation) | — |

### 4.3 Preview + Menu 전체 컨테이너

```
┌──────────────────────────────────────┐
│                                      │
│         [앱 아이콘 120x120]           │
│            앱 이름                    │
│                                      │  ← Preview 영역
│                                      │
├── 8pt gap ──────────────────────────┤
│                                      │
│  ┌──────────────────────────────┐   │
│  │  메뉴 카드 (250pt 너비)       │   │  ← Action Menu
│  │  ...                         │   │
│  └──────────────────────────────┘   │
│                                      │
└──────────────────────────────────────┘
```

---

## 5. 액션 메뉴 카드

### 5.1 메뉴 치수

| 속성 | 값 | 토큰 참조 |
|------|-----|----------|
| 너비 | 250pt | Context Menu 기본 너비 |
| Corner Radius | 14pt | `spacing.radius.semantic.contextMenu` |
| 내부 패딩 (수직) | 8pt (상하) | — |
| 내부 패딩 (수평) | 0pt (행은 full-width) | — |
| Preview-Menu 간격 | 8pt | — |

### 5.2 Liquid Glass 배경

| 속성 | Light Mode | Dark Mode | 토큰 참조 |
|------|-----------|-----------|----------|
| 배경색 | `#f5f5f5` (a: 0.6) | `#000000` (a: 0.6) | `materials.liquidGlass.regular.medium` |
| Frost Radius | 12px | 12px | `materials.liquidGlass.regular.medium.frostRadius` |
| Depth | 16 | 16 | — |
| Shadow Blur | 40px | 40px | — |
| Tint (Dark) | — | `#ffffff` (a: 0.06) | — |

### 5.3 메뉴 항목 (Action Row)

```
┌────────────────────────────────────┐
│  [아이콘 22pt]  레이블 텍스트       │  ← 44pt 높이, 16pt 좌우 패딩
├── separator (0.33pt) ──────────────┤
│  [아이콘 22pt]  레이블 텍스트       │
├── separator ───────────────────────┤
│  ...                               │
├── 섹션 구분 (8pt gap + separator) ──┤  ← 커스텀 액션과 시스템 액션 사이
│  홈 화면 편집                       │
├── separator ───────────────────────┤
│  앱 공유                            │
├── separator ───────────────────────┤
│  🔴 앱 삭제                        │  ← destructive 색상
└────────────────────────────────────┘
```

| 요소 | 값 | 토큰 참조 |
|------|-----|----------|
| 행 높이 | 44pt | `spacing.components.listRow.heightRegular` |
| 아이콘 크기 | 22pt | — |
| 아이콘-텍스트 간격 | 12pt | `spacing.inset.sm` |
| 레이블 폰트 | Body (17pt, Regular) | `typography.styles.body` |
| Separator 높이 | 0.33pt | — |
| Separator inset | 44pt (아이콘 포함 시) | — |
| Destructive 텍스트 | `#ff383c` (Light) / `#ff4245` (Dark) | `colors.accents.red` |

---

## 6. 액션 유형

### 6.1 커스텀 Quick Actions (개발자 정의)

| 항목 | 설명 |
|------|------|
| 최대 수 | 4개 |
| 아이콘 | SF Symbol 또는 커스텀 이미지 |
| 순서 | 개발자가 정의한 순서 |
| 위치 | 메뉴 상단 (시스템 액션 위) |
| API | `UIApplicationShortcutItem` 또는 Info.plist |

### 6.2 시스템 Quick Actions

| 액션 | 아이콘 | 항상 표시 | 설명 |
|------|--------|---------|------|
| 홈 화면 편집 | — | Yes | 아이콘 재배치 모드 진입 |
| 앱 공유 | ↑ | Yes | App Store 링크 공유 |
| 앱 삭제 | 🗑️ (red) | Yes | 앱 삭제 확인 |
| 위젯 추가 | + | 조건부 | 위젯 지원 앱만 |
| 일시 정지 | ⏸ | 조건부 | 다운로드 중 앱 |

### 6.3 섹션 구분

```
┌──────────────────────────────┐
│  커스텀 Quick Actions         │  ← 개발자 정의 (0-4개)
│  (새 메모, 사진 찍기 등)       │
├── 섹션 구분 (8pt + sep) ──────┤
│  시스템 Quick Actions         │  ← 항상 표시
│  (편집, 공유, 삭제)            │
└──────────────────────────────┘
```

---

## 7. Dimming Overlay

### 7.1 전체 화면 Overlay

| 속성 | Light Mode | Dark Mode | 토큰 참조 |
|------|-----------|-----------|----------|
| 색상 | `#000000` (a: 0.2) | `#000000` (a: 0.48) | `colors.overlays.default` |
| Blur | 배경 콘텐츠 blur(20px) | 배경 콘텐츠 blur(20px) | — |
| 탭 동작 | 메뉴 닫기 | 메뉴 닫기 | — |

### 7.2 배경 앱 아이콘 상태

```
Quick Actions 활성 시:
  - 선택된 앱: Preview로 확대 표시
  - 주변 앱 아이콘: dimming + blur 처리, 약간 축소 (scale: 0.95)
  - Dock: dimming 처리
```

---

## 8. 위치 결정 로직

### 8.1 메뉴 위치 자동 결정

```
앱 아이콘 위치에 따른 메뉴 배치:

화면 좌상단 아이콘:          화면 우상단 아이콘:
  [📱] → Preview              Preview ← [📱]
         ┌────────┐         ┌────────┐
         │ Menu   │         │ Menu   │
         └────────┘         └────────┘
  (아이콘 오른쪽 아래)      (아이콘 왼쪽 아래)

화면 좌하단 아이콘:          화면 우하단 아이콘:
         ┌────────┐         ┌────────┐
         │ Menu   │         │ Menu   │
         └────────┘         └────────┘
  [📱] → Preview              Preview ← [📱]
  (아이콘 오른쪽 위)        (아이콘 왼쪽 위)
```

| 규칙 | 설명 |
|------|------|
| 가장 많은 공간 방향 | 아이콘에서 화면 가장자리까지 거리 기준 |
| 화면 경계 여백 | 최소 20pt |
| 기본 배치 | Preview 위 + Menu 아래 (공간 충분할 때) |
| 좁은 경우 | Preview 좌/우 + Menu 아래 |

### 8.2 Dock 아이콘에서 트리거

```
Dock 아이콘 길게 누르기:
                     ┌────────────────────┐
                     │  메뉴 카드 (위쪽)   │
                     └────────────────────┘
                              ↕ 8pt
                     ┌──────────────────┐
                     │  앱 아이콘 Preview │
                     └──────────────────┘
  ─────────────────── DOCK ───────────────────
```

- Dock 아이콘은 항상 메뉴가 **위쪽**에 표시
- Preview는 Dock과 메뉴 사이에 위치

---

## 9. Light / Dark Mode 차이

| 요소 | Light Mode | Dark Mode | 토큰 참조 |
|------|-----------|-----------|----------|
| 메뉴 배경 | `#f5f5f5` (a: 0.6) | `#000000` (a: 0.6) | `materials.liquidGlass.regular.medium` |
| 메뉴 텍스트 | `#000000` | `#ffffff` | `colors.labels.primary` |
| Destructive | `#ff383c` | `#ff4245` | `colors.accents.red` |
| Separator | `#c6c6c8` | `#38383a` | `colors.separators.opaque` |
| Dimming | `#000` a:0.2 | `#000` a:0.48 | `colors.overlays.default` |
| 아이콘 tint | `#0088ff` | `#0091ff` | `colors.accents.blue` |
| Preview shadow | `#000` a:0.2 | `#000` a:0.35 | — |

---

## 10. iPad 전용 적응사항

### 10.1 Popover 스타일 메뉴

- iPad에서 Context Menu는 **Popover 스타일**로 표시 (iPhone: 전체 화면 오버레이)
- 넓은 화면에서 Preview + Menu가 나란히 또는 수직으로 배치
- 메뉴 너비 250pt로 고정 (iPhone과 동일)

### 10.2 Pointer 지원

| 인터랙션 | 동작 |
|---------|------|
| Long press | Context Menu 표시 (0.5초) |
| Right-click | Context Menu 즉시 표시 |
| Hover (메뉴 항목) | `fills.tertiary` 하이라이트 |
| Click (메뉴 항목) | 해당 액션 실행 + 메뉴 닫기 |
| Esc | 메뉴 닫기 |

### 10.3 키보드 단축키

| 단축키 | 동작 |
|--------|------|
| `↑` / `↓` | 메뉴 항목 포커스 이동 |
| `Return` | 포커스된 항목 실행 |
| `Esc` | 메뉴 닫기 |
| `⌘.` | 메뉴 닫기 (대체) |

### 10.4 3D Touch / Haptic Touch

| iPad 모델 | 방식 |
|-----------|------|
| iPad Pro | Haptic Touch (시간 기반, 0.5초 길게 누르기) |
| iPad Air/mini | Haptic Touch |
| 모든 iPad | 3D Touch 미지원 (iPad은 3D Touch 하드웨어 없음) |

---

## 11. 멀티태스킹 고려사항

### 11.1 Stage Manager 환경

- 홈 화면 Quick Actions는 Stage Manager 배경 홈 화면에서도 동작
- 윈도우 위에서 Quick Actions 표시 시 해당 윈도우 내부에서만 dimming
- 다른 윈도우/앱은 영향 없음

### 11.2 Split View

- Split View 상태에서 홈 화면은 보이지 않으므로 Quick Actions 불가
- 앱 내부 Context Menu는 해당 앱 영역 내에서 표시

---

## 12. 애니메이션

### 12.1 표시 애니메이션

| 단계 | 시간 | 효과 |
|------|------|------|
| 1. 아이콘 lift | 0-0.15s | scale(1.0 → 1.05), shadow 증가 |
| 2. Dimming | 0-0.2s | 배경 blur + dimming fade in |
| 3. Preview 확대 | 0.1-0.3s | scale(76pt → 120pt), spring |
| 4. Menu 슬라이드 | 0.15-0.35s | opacity(0 → 1) + translateY(-10 → 0), spring |

### 12.2 닫기 애니메이션

| 단계 | 시간 | 효과 |
|------|------|------|
| 1. Menu 사라짐 | 0-0.15s | opacity fade out |
| 2. Preview 축소 | 0-0.25s | scale(120pt → 76pt), spring |
| 3. Dimming 제거 | 0.1-0.3s | 배경 blur + dimming fade out |
| 4. 아이콘 복귀 | 0.2-0.35s | 원래 위치/크기로 |

### 12.3 Reduce Motion

- Reduce Motion 활성 시: 모든 spring 애니메이션 → cross dissolve (0.2s)
- Preview 크기 전환 없음, 즉시 표시/숨김

---

## 13. 접근성

| 항목 | 설명 |
|------|------|
| VoiceOver | "컨텍스트 메뉴, [앱이름], [액션 수]개 항목" |
| VoiceOver 탐색 | 메뉴 항목 순차 탐색 |
| Dynamic Type | 메뉴 항목 텍스트 크기 조절, 행 높이 자동 확장 |
| Reduce Transparency | Liquid Glass → 불투명 배경 |
| Reduce Motion | spring → cross dissolve |
| Bold Text | 메뉴 항목 레이블 bold weight |
| Button Shapes | 메뉴 항목에 구분선 강화 |

---

## 14. 관련 컴포넌트

| 컴포넌트 | 관계 | 참조 |
|---------|------|------|
| Context Menus | 기반 컴포넌트 | `../../components/specs/context-menus.md` |
| Menus | 메뉴 항목 구조 공유 | `../../components/specs/menus.md` |
| Popovers | iPad 메뉴 표시 스타일 | `../../components/specs/popovers.md` |
| App Icons | 아이콘 스펙 | `../../components/specs/app-icons.md` |
| Home Screen | 배치 컨텍스트 | `./ipad-home-screen.md` |
