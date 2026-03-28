# Empty States — iPhone Full-Screen Example

> **References**
> - Components: `../../components/specs/empty-states.md`
> - Tokens: `../../tokens/colors.json`, `../../tokens/spacing.json`, `../../tokens/typography.json`, `../../tokens/animations.json`, `../../tokens/materials.json`
> - Sections: `../../sections/`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="5518:18111")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Empty States (빈 상태 화면) |
| **디바이스** | iPhone 17 Pro — 402 × 874pt (@3x, 1206 × 2622px) |
| **용도** | 콘텐츠가 없을 때 사용자에게 상황 안내 및 다음 행동 유도 |
| **프레젠테이션** | 인라인 (기존 화면 콘텐츠 영역에 삽입) |
| **iOS 26 특이사항** | SF Symbol 시스템 아이콘, Dynamic Type 지원, 수직 중앙 정렬 |

Empty States는 목록이 비어있거나, 검색 결과가 없거나, 첫 실행 온보딩 시 사용하는 안내 UI다. 3가지 복잡도 단계의 variant를 제공한다.

---

## 디바이스 컨텍스트

```
iPhone 17 Pro
├─ 화면 크기: 402 × 874pt
├─ Safe Area Top: 59pt (Dynamic Island)
├─ Safe Area Bottom: 34pt (Home Indicator)
├─ 콘텐츠 영역: 874 - 59 - 44(NavBar) - 83(TabBar) - 34 = 654pt
└─ 수직 중앙 정렬 기준: 콘텐츠 영역의 정중앙
```

---

## 화면 구성 분해

### Variant 1: Icon Only (아이콘만)

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │  ← Status Bar (59pt)
├─────────────────────────────────────────────┤
│             검색 결과            [취소]       │  ← Navigation Bar (44pt)
├─────────────────────────────────────────────┤
│                                              │
│                                              │
│                                              │
│                                              │
│                ↕ flex (수직 중앙)             │
│                                              │
│                  ┌─────┐                     │
│                  │     │                     │  ← SF Symbol 아이콘
│                  │ 🔍  │                     │    60 × 60pt
│                  │     │                     │    색상: labels.tertiary
│                  └─────┘                     │
│                                              │
│                ↕ flex (수직 중앙)             │
│                                              │
│                                              │
│                                              │
│                                              │
├─────────────────────────────────────────────┤
│  [🏠홈] [🔍탐색] [＋] [🔔벨] [👤프로필]      │  ← Tab Bar (49pt + 34pt)
│                   ●                          │    Liquid Glass indicator
└─────────────────────────────────────────────┘
```

**사용 시점**: 보조 화면, 공간 제약 있는 곳, 추가 설명이 불필요한 상황

### Variant 2: Icon + Text (아이콘 + 타이틀 + 설명)

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │  ← Status Bar (59pt)
├─────────────────────────────────────────────┤
│  즐겨찾기                                    │  ← Navigation Bar (44pt)
├─────────────────────────────────────────────┤
│                                              │
│                                              │
│                ↕ flex                        │
│                                              │
│                  ┌─────┐                     │
│                  │     │                     │  ← SF Symbol: star.slash
│                  │ ⭐  │                     │    60 × 60pt
│                  │     │                     │    색상: labels.tertiary
│                  └─────┘                     │
│                    ↕ 16pt                    │
│           ┌─────────────────┐                │
│           │  즐겨찾기 없음    │                │  ← Title: Title2 (22pt, Bold)
│           └─────────────────┘                │    색상: labels.primary
│                    ↕ 8pt                     │
│        ┌──────────────────────┐              │
│        │  항목을 즐겨찾기에 추가  │              │  ← Description: Body (17pt, Regular)
│        │  하면 여기에 표시됩니다. │              │    색상: labels.secondary
│        └──────────────────────┘              │    최대 너비: 280pt, 중앙 정렬
│                                              │
│                ↕ flex                        │
│                                              │
├─────────────────────────────────────────────┤
│  [🏠홈] [🔍탐색] [＋] [🔔벨] [👤프로필]      │  ← Tab Bar
└─────────────────────────────────────────────┘
```

**사용 시점**: 일반적인 빈 상태, 검색 결과 없음, 필터 결과 없음

### Variant 3: Icon + Text + Button (아이콘 + 타이틀 + 설명 + CTA)

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │  ← Status Bar (59pt)
├─────────────────────────────────────────────┤
│  내 메모                            [⋯]     │  ← Navigation Bar (44pt)
├─────────────────────────────────────────────┤
│                                              │
│                ↕ flex                        │
│                                              │
│                  ┌─────┐                     │
│                  │     │                     │  ← SF Symbol: note.text
│                  │ 📝  │                     │    60 × 60pt
│                  │     │                     │    색상: labels.tertiary
│                  └─────┘                     │
│                    ↕ 16pt                    │
│           ┌─────────────────┐                │
│           │   메모 없음       │                │  ← Title: Title2 (22pt, Bold)
│           └─────────────────┘                │
│                    ↕ 8pt                     │
│        ┌──────────────────────┐              │
│        │  첫 번째 메모를 작성하여 │              │  ← Description: Body (17pt)
│        │  아이디어를 기록하세요. │              │    labels.secondary
│        └──────────────────────┘              │
│                    ↕ 24pt                    │
│           ┌─────────────────┐                │
│           │   메모 작성하기    │                │  ← CTA Button
│           └─────────────────┘                │    높이: 50pt, 최소 너비: 140pt
│                                              │    cornerRadius: 14pt
│                ↕ flex                        │    배경: accents.blue
│                                              │    텍스트: white, Headline
├─────────────────────────────────────────────┤
│  [🏠홈] [🔍탐색] [＋] [🔔벨] [👤프로필]      │
└─────────────────────────────────────────────┘
```

**사용 시점**: 첫 실행 온보딩, 사용자 행동 유도가 필요한 곳, 빈 컬렉션

---

## 요소별 토큰 참조

### 아이콘

| 역할 | 토큰 | Light | Dark |
|------|------|-------|------|
| 크기 | — | 60 × 60pt | 60 × 60pt |
| 타입 | SF Symbol | font-size: 60pt | font-size: 60pt |
| 색상 | `colors.labels.tertiary` | `rgba(60,60,67,0.3)` | `rgba(235,235,245,0.3)` |
| 렌더링 | `.hierarchical` 또는 `.monochrome` | — | — |

### Title

| 역할 | 토큰 | Light | Dark |
|------|------|-------|------|
| 타이포 | `typography.styles.title2` | 22pt, Bold | 22pt, Bold |
| letterSpacing | — | -0.26 | -0.26 |
| 색상 | `colors.labels.primary` | `#000000` | `#ffffff` |
| 정렬 | center | — | — |

### Description

| 역할 | 토큰 | Light | Dark |
|------|------|-------|------|
| 타이포 | `typography.styles.body` | 17pt, Regular | 17pt, Regular |
| letterSpacing | — | -0.43 | -0.43 |
| lineHeight | — | 22pt | 22pt |
| 색상 | `colors.labels.secondary` | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.7)` |
| 최대 너비 | — | 280pt | 280pt |
| 줄 수 | 최대 2줄 권장 | — | — |
| 정렬 | center | — | — |

### CTA Button

| 역할 | 토큰 | Light | Dark |
|------|------|-------|------|
| 높이 | — | 50pt | 50pt |
| 최소 너비 | — | 140pt | 140pt |
| cornerRadius | `spacing.radius.semantic.alert` | 14pt | 14pt |
| 배경 | `colors.accents.blue` | `#0088ff` | `#0091ff` |
| 텍스트 색상 | — | `#ffffff` | `#ffffff` |
| 타이포 | `typography.styles.headline` | 17pt, Semibold | 17pt, Semibold |
| Pressed 배경 | — | `#0077dd` (약 10% 어두움) | `#0080ee` |

### Spacing

| 간격 | 값 | 토큰 |
|------|-----|------|
| 아이콘 → 타이틀 | 16pt | `spacing.inset.md` |
| 타이틀 → 설명 | 8pt | `spacing.inset.xs` |
| 설명 → 버튼 | 24pt | `spacing.inset.xl` |
| 수평 패딩 | 40pt (양쪽) | — |
| 최대 콘텐츠 너비 | 280pt | — |
| 수직 배치 | Safe Area 내 중앙 정렬 | flexbox center |

---

## Light/Dark 모드 차이

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| 화면 배경 | `#f2f2f7` (backgroundsGrouped.primary) | `#000000` |
| 아이콘 | `rgba(60,60,67,0.3)` | `rgba(235,235,245,0.3)` |
| Title | `#000000` | `#ffffff` |
| Description | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.7)` |
| CTA 버튼 배경 | `#0088ff` | `#0091ff` |
| CTA 버튼 텍스트 | `#ffffff` | `#ffffff` |
| Status Bar | `.darkContent` | `.lightContent` |

---

## 애니메이션

### 초기 등장

```yaml
trigger: 빈 상태 감지 (데이터 로드 완료 후 결과 0건)
sequence:
  1. 아이콘:
    opacity: 0 → 1
    scale: 0.8 → 1.0
    duration: 0.3s
    spring: gentle (response 0.55, dampingRatio 0.825)
  2. 타이틀 (delay 0.05s):
    opacity: 0 → 1
    translateY: 8pt → 0
    duration: 0.25s
    easing: easeOut
  3. 설명 (delay 0.1s):
    opacity: 0 → 1
    translateY: 8pt → 0
    duration: 0.25s
  4. 버튼 (delay 0.15s):
    opacity: 0 → 1
    scale: 0.9 → 1.0
    duration: 0.3s
    spring: snappy (response 0.3, dampingRatio 0.8)
```

### 퇴장 (콘텐츠 로드 시)

```yaml
trigger: 콘텐츠 데이터 도착
duration: 0.2s
easing: easeIn
properties:
  opacity: 1 → 0
  scale: 1.0 → 0.95
  # 이후 콘텐츠 목록 fade-in
```

### Reduce Motion

```yaml
prefers-reduced-motion:
  모든 요소: 즉시 표시 (opacity만 0→1, 0.15s)
  scale/translateY: 비활성화
```

---

## 인터랙션 노트

| 인터랙션 | 동작 |
|---------|------|
| **CTA 버튼 탭** | 관련 액션 실행 (생성 화면 이동, 설정 변경 등) |
| **Pull-to-Refresh** | 빈 상태에서도 새로고침 가능 (데이터 재시도) |
| **검색 바 입력** | 검색어 변경 시 빈 상태 ↔ 결과 목록 전환 |
| **필터 변경** | 필터 조건 변경 시 빈 상태 ↔ 목록 전환 |
| **다크 모드 전환** | 아이콘/텍스트 색상 즉시 전환 (시스템 연동) |

---

## 접근성 (Accessibility)

| 항목 | 요구사항 |
|------|---------|
| **VoiceOver** | 아이콘: `accessibilityLabel` 설정 불필요 (장식용이면 hidden), 의미가 있으면 설정 |
| **VoiceOver 순서** | 아이콘(선택) → 타이틀 → 설명 → CTA 버튼 |
| **VoiceOver 그룹** | 아이콘 + 타이틀 + 설명을 하나의 `accessibilityElement`로 그룹화 가능 |
| **CTA 버튼** | `accessibilityTraits: .button`, `accessibilityHint: "[액션 설명]"` |
| **Dynamic Type** | Title: `.title2`, Description: `.body` — 큰 텍스트 시 최대 너비 280pt 내에서 줄바꿈 |
| **터치 타겟** | CTA 버튼: 50pt 높이, 최소 너비 140pt — Apple HIG 44pt 초과 |
| **색상 대비** | Title vs 배경: 4.5:1+ (WCAG AA), Description vs 배경: 3.0:1+ (AA Large) |
| **색상 대비 (아이콘)** | Tertiary vs 배경: 약 1.5:1 — 순수 장식용이므로 AA 대비 미요구 |
| **Reduce Motion** | 등장/퇴장 시 scale 제거, opacity 전환만 유지 |
| **Bold Text** | `.headline` / `.body` 스타일이 자동 대응 |

---

## 사용 가이드라인

| 규칙 | 내용 |
|------|------|
| **Variant 선택** | 행동 유도 필요 → Icon+Text+Button, 안내만 → Icon+Text, 최소 공간 → Icon Only |
| **아이콘 선택** | 빈 상태의 맥락을 직관적으로 표현하는 SF Symbol 사용 |
| **타이틀 작성** | 짧고 명확하게 (2-4단어). "~없음" 패턴 권장 (e.g., "즐겨찾기 없음") |
| **설명 작성** | 왜 비어있는지 + 어떻게 채울 수 있는지. 최대 2줄 |
| **CTA 문구** | 동사형으로 구체적 행동 유도 (e.g., "메모 작성하기", "사진 추가하기") |
| **Pull-to-Refresh** | 네트워크 의존 콘텐츠는 빈 상태에서도 반드시 지원 |

---

## 구현 체크리스트

- [ ] 3가지 variant 중 적절한 것 선택
- [ ] SF Symbol 아이콘 `.hierarchical` 렌더링 모드 적용
- [ ] 수직 중앙 정렬 (Safe Area 내, NavBar/TabBar 제외 영역)
- [ ] 수평 패딩 40pt, 최대 콘텐츠 너비 280pt
- [ ] Light/Dark 모드 색상 토큰 올바르게 적용
- [ ] Dynamic Type 지원 (텍스트 크기 변경 시 레이아웃 유지)
- [ ] CTA 버튼 터치 타겟 44pt 이상
- [ ] Reduce Motion 대응
- [ ] VoiceOver 포커스 순서 검증
- [ ] Pull-to-Refresh 빈 상태에서도 동작 확인

---

## 관련 화면

| 화면 | 관계 |
|------|------|
| `home-feed.md` | 피드 빈 상태 → Empty State Variant 2 사용 |
| `settings-screen.md` | 설정 내 빈 목록 |
| `list.md` | 리스트 빈 상태 표현 |
