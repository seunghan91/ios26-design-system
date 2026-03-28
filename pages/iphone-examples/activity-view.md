# Activity View (Share Sheet) — iPhone Full-Screen Example

> **References**
> - Components: `../../components/specs/activity-views.md`
> - Tokens: `../../tokens/colors.json`, `../../tokens/spacing.json`, `../../tokens/typography.json`, `../../tokens/animations.json`, `../../tokens/materials.json`
> - Sections: `../../sections/`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24670")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Activity View (Share Sheet) |
| **디바이스** | iPhone 17 Pro — 402 × 874pt (@3x, 1206 × 2622px) |
| **용도** | 콘텐츠 공유 또는 시스템/서드파티 앱 액션 수행 |
| **트리거** | Share 버튼 탭 (`UIActivityViewController` / `ShareLink`) |
| **프레젠테이션** | Bottom Sheet (`.medium` detent → `.large` detent 확장 가능) |
| **iOS 26 특이사항** | Liquid Glass 배경 소재, 블러 오버레이, spring 등장 애니메이션 |

Activity View는 앱 내 콘텐츠(URL, 이미지, 텍스트)를 시스템 공유 시스템을 통해 다른 앱이나 사용자에게 전달하는 모달 바텀 시트다. AirDrop 근접 공유 대상, 앱 아이콘 그리드, 시스템 액션 행으로 구성된다.

---

## 디바이스 컨텍스트

```
iPhone 17 Pro
├─ 화면 크기: 402 × 874pt
├─ Safe Area Top: 59pt (Dynamic Island)
├─ Safe Area Bottom: 34pt (Home Indicator)
├─ Pixel Density: @3x (1206 × 2622px)
└─ 색상 공간: P3 Wide Color
```

---

## 화면 구성 분해 (Status Bar → Content → Bottom)

### 전체 레이아웃 (ASCII 와이어프레임)

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │  ← Status Bar (59pt, Dynamic Island)
│                                              │
│  ┌──────────────────── Dimmed ─────────────┐│
│  │  (이전 화면 콘텐츠가 dimming 오버레이    ││  ← overlays.activityView
│  │   뒤로 비쳐 보임)                        ││    Light: rgba(0,0,0,0.2)
│  │                                          ││    Dark:  rgba(0,0,0,0.29)
│  └──────────────────────────────────────────┘│
│                                              │
│  ┌──────── Activity View Sheet ─────────────┐│  ← cornerRadius top: 20pt
│  │                                      [X] ││  ← Close Button (30×30pt)
│  │  ┌────────────────────────────────────┐  ││     top: 14pt, right: 16pt
│  │  │  📄 example.com/article/title     │  ││  ← Header (_Header) ~88pt
│  │  │  "기사 제목이 여기에 표시됩니다"      │  ││    콘텐츠 미리보기 영역
│  │  └────────────────────────────────────┘  ││
│  ├──────────────────────────────────────────┤│  ← separator (nonOpaque)
│  │  [👤]  [👤]  [👤]  [👤]  [👤]   →     ││  ← Contact Row (~88pt)
│  │  AirDrop 홍길동 김철수 이영희 박민수      ││    가로 스크롤 가능
│  ├──────────────────────────────────────────┤│  ← separator
│  │  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐         ││  ← App Grid Row 1 (~81pt)
│  │  │메모│ │카톡│ │메일│ │인스│ │트위│         ││    앱 아이콘 60pt + 레이블
│  │  └──┘  └──┘  └──┘  └──┘  └──┘         ││    cornerRadius: 13pt (아이콘)
│  │  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐         ││  ← App Grid Row 2 (~81pt)
│  │  │라인│ │텔레│ │디코│ │슬랙│ │더보│         ││
│  │  └──┘  └──┘  └──┘  └──┘  └──┘         ││
│  ├──────────────────────────────────────────┤│  ← separator
│  │  📋  복사                                ││  ← Action Row (57pt)
│  ├──────────────────────────────────────────┤│    Liquid Glass Button
│  │  🔖  나중에 읽기                          ││  ← Action Row (57pt)
│  ├──────────────────────────────────────────┤│
│  │  ➕  홈 화면에 추가                       ││  ← Action Row (57pt)
│  ├──────────────────────────────────────────┤│
│  │  🖨️  프린트                              ││  ← Action Row (57pt)
│  └──────────────────────────────────────────┘│
│  ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔│  ← Home Indicator (34pt safe area)
└─────────────────────────────────────────────┘
```

### 영역별 상세

#### 1. Status Bar (0–59pt)

| 항목 | 값 | 토큰 |
|------|-----|------|
| 높이 | 59pt | `spacing.safeArea.iphone16Pro.top` |
| 배경 | 투명 (아래 dimming 오버레이가 비침) | — |
| 시계/아이콘 | 시스템 제어 (앱에서 변경 불가) | — |

#### 2. Dimming Overlay (전체 화면)

| 항목 | 값 | 토큰 |
|------|-----|------|
| 범위 | 전체 화면 (Safe Area 포함) | — |
| Light 배경 | `rgba(0, 0, 0, 0.2)` | `colors.overlays.activityView.light` |
| Dark 배경 | `rgba(0, 0, 0, 0.29)` | `colors.overlays.activityView.dark` |
| 탭 동작 | 외부 탭 → Sheet dismiss | — |

#### 3. Activity View Sheet

| 항목 | 값 | 토큰 |
|------|-----|------|
| 너비 | 화면 전체 너비 (402pt) | — |
| 기본 detent | `.medium` (~50% 화면 높이) | `spacing.components.sheet.mediumDetent` |
| 확장 detent | `.large` (전체 높이) | `spacing.components.sheet.largeDetent` |
| cornerRadius (top) | 20pt | `spacing.radius.semantic.activitySheet.iphoneTop` |
| 배경 소재 | Liquid Glass (frosted) | `materials.liquidGlass.regular.large` |
| Frost blur | 14px | `materials.liquidGlass.regular.large.frostRadius` |

##### 3a. Header (_Header) — ~88pt

| 항목 | 값 | 토큰 |
|------|-----|------|
| 높이 | ~88pt | `spacing.components.activityView.headerHeight` |
| 내부 패딩 | 16pt (수평) | `spacing.contentMargin.iphone.horizontal` |
| 제목 타이포 | Headline (17pt, Semibold) | `typography.styles.headline` |
| URL 타이포 | Footnote (13pt, Regular) | `typography.styles.footnote` |
| 제목 색상 | `labels.primary` | Light: `#000000`, Dark: `#ffffff` |
| URL 색상 | `labels.secondary` | Light: `rgba(60,60,67,0.6)`, Dark: `rgba(235,235,245,0.7)` |

##### 3b. Close Button

| 항목 | 값 |
|------|-----|
| 크기 | 30 × 30pt |
| 위치 | top: 14pt, right: 16pt |
| 아이콘 | SF Symbol `xmark.circle.fill` |
| 색상 | `labels.tertiary` — Light: `rgba(60,60,67,0.3)`, Dark: `rgba(235,235,245,0.3)` |
| 터치 타겟 | 44 × 44pt (Apple HIG 최소) |

##### 3c. Contact Row — ~88pt

| 항목 | 값 | 토큰 |
|------|-----|------|
| 높이 | ~88pt | `spacing.components.activityView.contactRowHeight` |
| 아바타 크기 | 60 × 60pt (원형) | — |
| 아바타 간격 | 16pt | `spacing.inset.md` |
| 레이블 타이포 | Caption1 (12pt, Regular) | `typography.styles.caption1` |
| 레이블 색상 | `labels.primary` | — |
| 스크롤 | 수평 스크롤 (오버플로우 시) | — |
| AirDrop 아이콘 | SF Symbol `airdrop`, `accents.blue` | — |

##### 3d. App Icon Grid — ~81pt/행

| 항목 | 값 | 토큰 |
|------|-----|------|
| 행 높이 | ~81pt | `spacing.components.activityView.appGridRowHeight` |
| 아이콘 크기 | 60 × 60pt | — |
| 아이콘 cornerRadius | 13pt (iOS 앱 아이콘 표준) | `spacing.radius.semantic.appIcon.iphone` = 26pt (큰 아이콘 기준) |
| 아이콘 간격 | 화면 너비에 맞춰 균등 배분 (5열) | — |
| 레이블 타이포 | Caption2 (11pt, Regular) | `typography.styles.caption2` |
| 레이블 색상 | `labels.primary` | — |

##### 3e. Action Rows — 57pt/행

| 항목 | 값 | 토큰 |
|------|-----|------|
| 행 높이 | 57pt | `spacing.components.activityView.actionRowHeight` |
| 아이콘 크기 | 20pt (SF Symbol) | — |
| 아이콘 색상 | `labels.primary` | — |
| 텍스트 타이포 | Body (17pt, Regular) | `typography.styles.body` |
| 텍스트 색상 | `labels.primary` | — |
| 구분선 | `separators.nonOpaque` — Light: `rgba(0,0,0,0.12)`, Dark: `rgba(255,255,255,0.17)` | — |
| Highlighted 배경 | `fills.tertiary` | Light: `rgba(118,118,128,0.12)`, Dark: `rgba(118,118,128,0.24)` |

#### 4. Home Indicator Area (하단 34pt)

| 항목 | 값 | 토큰 |
|------|-----|------|
| 높이 | 34pt | `spacing.safeArea.iphone16Pro.bottom` |
| 표시 | Home Indicator 바 (시스템) | — |

---

## 컴포넌트 사용 목록

| 컴포넌트 | 스펙 파일 | 사용 위치 | Variant/참고 |
|---------|----------|---------|-------------|
| Status Bar | `../../sections/status-bar.md` | 최상단 | Dynamic Island |
| Sheet | `../../components/specs/sheet.md` | 시트 컨테이너 | Medium/Large detent |
| Activity View | `../../components/specs/activity-views.md` | 시트 내부 전체 | iPhone variant |
| List Row (Action) | `../../components/specs/list-row.md` | 하단 액션 행 | Button variant |

---

## Light/Dark 모드 차이

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| Dimming 오버레이 | `rgba(0,0,0,0.2)` | `rgba(0,0,0,0.29)` |
| Sheet 배경 | `rgba(250,250,250,0.7)` + blur 14px | `rgba(0,0,0,0.8)` + blur 14px + tint `rgba(255,255,255,0.06)` |
| 텍스트 (Primary) | `#000000` | `#ffffff` |
| 텍스트 (Secondary) | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.7)` |
| 구분선 | `rgba(0,0,0,0.12)` | `rgba(255,255,255,0.17)` |
| Close 버튼 배경 | `rgba(60,60,67,0.3)` | `rgba(235,235,245,0.3)` |
| Highlighted row | `rgba(118,118,128,0.12)` | `rgba(118,118,128,0.24)` |
| Status Bar 스타일 | `.darkContent` | `.lightContent` |

### Liquid Glass 소재 차이

```css
/* Light Mode */
.activity-sheet {
  background: rgba(250, 250, 250, 0.7);
  backdrop-filter: blur(14px) saturate(180%);
  -webkit-backdrop-filter: blur(14px) saturate(180%);
}

/* Dark Mode */
.activity-sheet {
  background: rgba(0, 0, 0, 0.8);
  backdrop-filter: blur(14px) saturate(150%);
  -webkit-backdrop-filter: blur(14px) saturate(150%);
  /* tint overlay */
  box-shadow: inset 0 0 0 0.5px rgba(255, 255, 255, 0.06);
}
```

---

## 애니메이션

### Sheet Present (등장)

```yaml
trigger: Share 버튼 탭
duration: 0.5s
spring: gentle (response: 0.55, dampingRatio: 0.825)
css_approx: cubic-bezier(0.25, 0.46, 0.45, 0.94)
properties:
  translateY: 100% → 0%
  backdrop_blur: 0 → 14px (점진적 frosting)
overlay:
  opacity: 0 → 1
  duration: 0.35s
  easing: easeOut — cubic-bezier(0, 0, 0.58, 1.0)
```

> 토큰: `animations.duration.semantic.sheetPresent` = 0.5s, `animations.spring.presets.gentle`

### Sheet Dismiss (퇴장)

```yaml
trigger: Close 버튼 탭 / 아래로 스와이프 / 외부 탭
duration: 0.3s
easing: easeIn — cubic-bezier(0.42, 0, 1.0, 1.0)
properties:
  translateY: 0% → 100%
overlay:
  opacity: 1 → 0
  duration: 0.25s
```

> 토큰: `animations.duration.semantic.sheetDismiss` = 0.3s

### Detent 전환

```yaml
trigger: 시트를 위/아래로 드래그
duration: 0.35s
spring: gentle
properties:
  height: medium(50%) ↔ large(100%)
  scale: 뒤 화면 0.92 ↔ 1.0 (large detent 시 뒤 화면 축소)
```

### Reduce Motion

```yaml
prefers-reduced-motion:
  translateY: 비활성화
  opacity: 0 → 1 (fade only, 0.2s)
  spring: 일반 easeOut로 대체
```

---

## 인터랙션 노트

| 인터랙션 | 동작 |
|---------|------|
| **Share 버튼 탭** | Activity View가 `.medium` detent로 등장 |
| **위로 드래그** | `.large` detent로 확장 (더 많은 앱/액션 표시) |
| **아래로 드래그** | `.medium` 이하로 내리면 dismiss |
| **Close 버튼 탭** | Sheet dismiss |
| **외부 dimming 탭** | Sheet dismiss |
| **Contact 아바타 탭** | AirDrop 전송 시작 / 메시지 앱으로 공유 |
| **앱 아이콘 탭** | 해당 앱의 공유 Extension 실행 |
| **액션 행 탭** | 해당 액션 실행 후 Sheet 자동 dismiss |
| **수평 스와이프 (Contact Row)** | 더 많은 연락처 스크롤 |
| **수평 스와이프 (App Grid)** | 더 많은 앱 스크롤 (2페이지 이상) |
| **하단 "편집 액션"** | 액션 순서 커스터마이즈 화면으로 전환 |

---

## 접근성 (Accessibility)

| 항목 | 요구사항 |
|------|---------|
| **VoiceOver** | Sheet 등장 시 "Share sheet, [콘텐츠 제목]" 안내. 포커스가 Header로 이동 |
| **항목 순서** | Header → Contact Row (각 아바타) → App Grid (각 아이콘) → Action Rows (순서대로) → Close 버튼 |
| **Close 버튼** | `accessibilityLabel: "닫기"`, `accessibilityHint: "공유 시트를 닫습니다"` |
| **앱 아이콘** | `accessibilityLabel: "[앱 이름]으로 공유"` |
| **액션 행** | `accessibilityLabel: "[액션명]"`, `accessibilityTraits: .button` |
| **터치 타겟** | Close: 44×44pt, 앱 아이콘: 60×60pt (44pt 초과), 액션 행: 57pt 높이 (44pt 초과) |
| **Dynamic Type** | 앱 이름 레이블, 액션 행 텍스트가 Dynamic Type에 따라 크기 조정 |
| **Reduce Motion** | 슬라이드 애니메이션 → fade only (0.2s) |
| **색상 대비** | Primary 텍스트 vs 배경: WCAG AA 충족 (4.5:1 이상) |
| **색상 반전** | Smart Invert 시 앱 아이콘은 반전 제외 (`accessibilityIgnoresInvertColors = true`) |
| **키보드 탐색** | Tab: 항목 간 이동, Space/Enter: 선택, Escape: Sheet dismiss |
| **스위치 제어** | 모든 인터랙티브 요소에 순차 접근 가능 |

---

## 구현 체크리스트

- [ ] `UIActivityViewController` 또는 `ShareLink` 사용
- [ ] 콘텐츠 미리보기(Header)에 적절한 메타데이터 표시
- [ ] AirDrop Contact Row 수평 스크롤 동작
- [ ] App Grid 2행 이상 시 수평 페이징
- [ ] 액션 행 커스터마이즈 지원 (`UIActivity` 서브클래스)
- [ ] Close 버튼 동작 및 접근성 레이블
- [ ] Light/Dark 모드 Liquid Glass 소재 적용
- [ ] Reduce Motion 대응
- [ ] iPad에서 Popover로 자동 전환 (`popoverPresentationController` 설정)
- [ ] VoiceOver 포커스 순서 검증

---

## 관련 화면

| 화면 | 관계 |
|------|------|
| `detail-view.md` | 콘텐츠 상세에서 Share 버튼 탭 → Activity View 표시 |
| `sheet-form.md` | Sheet 프레젠테이션 패턴 공유 |
| `action-sheet.md` | 유사 바텀 시트 컴포넌트 (선택지 제공) |
