# List — iPhone Full-Screen Example

> **References**
> - Components: `../../components/specs/list-row.md`
> - Tokens: `../../tokens/colors.json`, `../../tokens/spacing.json`, `../../tokens/typography.json`, `../../tokens/animations.json`, `../../tokens/materials.json`
> - Sections: `../../sections/`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24675")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | List (목록 화면) |
| **디바이스** | iPhone 17 Pro — 402 × 874pt (@3x, 1206 × 2622px) |
| **용도** | 구조화된 데이터를 행 단위로 표시하는 스크롤 가능 목록 |
| **프레젠테이션** | 인라인 (Navigation 계층 내 콘텐츠) |
| **iOS 26 특이사항** | Inset Grouped 리스트에 Liquid Glass 소재, 스크롤 시 edge blur 효과 |

List는 iOS에서 가장 빈번하게 사용되는 UI 패턴이다. 3가지 주요 스타일(Inset Grouped, Full Width, Full Width with Section Headers)을 이 문서에서 다룬다.

---

## 디바이스 컨텍스트

```
iPhone 17 Pro
├─ 화면 크기: 402 × 874pt
├─ Safe Area Top: 59pt (Dynamic Island)
├─ Safe Area Bottom: 34pt (Home Indicator)
├─ Nav Bar: 44pt (inline title)
├─ Tab Bar: 49pt + 34pt = 83pt
└─ 콘텐츠 스크롤 영역: 874 - 59 - 44 - 83 = 688pt
```

---

## Variant 1: Inset Grouped List

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │  ← Status Bar (59pt)
├─────────────────────────────────────────────┤
│  ← 뒤로              설정                    │  ← Navigation Bar (44pt, inline)
├─────────────────────────────────────────────┤  ← backgroundsGrouped.primary
│                                              │    Light: #f2f2f7 / Dark: #000000
│  ← 16pt →  일반                              │  ← Section Header (footnote, secondary)
│                                              │    uppercase, 높이 ~32pt
│  ← 16pt → ┌──────────────────────┐ ← 16pt  │  ← Grouped Card
│            │  ✈️  에어플레인 모드   🔘 │         │    배경: backgroundsGrouped.secondary
│            ├──────────────────────┤         │    Light: #ffffff / Dark: #1c1c1e
│            │  📶  Wi-Fi      홈 › │         │    cornerRadius: 10pt
│            ├──────────────────────┤         │    separatorInset: 56pt (아이콘 후)
│            │  📱  Bluetooth  켜짐 › │         │
│            ├──────────────────────┤         │
│            │  📡  셀룰러          › │         │
│            ├──────────────────────┤         │
│            │  🔗  개인용 핫스팟     › │         │
│            └──────────────────────┘         │
│                                              │  ← Section 간격: 35pt
│  ← 16pt →  알림                              │  ← Section Header
│                                              │
│  ← 16pt → ┌──────────────────────┐ ← 16pt  │
│            │  🔔  알림            › │         │  ← 행 높이: 44pt (Regular)
│            ├──────────────────────┤         │
│            │  🔊  사운드 및 햅틱   › │         │
│            ├──────────────────────┤         │
│            │  🌙  집중 모드        › │         │
│            ├──────────────────────┤         │
│            │  ⏱️  스크린 타임      › │         │
│            └──────────────────────┘         │
│                                              │
├─────────────────────────────────────────────┤
│  [🏠홈] [🔍탐색] [＋] [🔔벨] [👤프로필]      │  ← Tab Bar (83pt)
│     ●                                        │
└─────────────────────────────────────────────┘
```

### Inset Grouped 치수

| 항목 | 값 | 토큰 |
|------|-----|------|
| 화면 배경 | `backgroundsGrouped.primary` | Light: `#f2f2f7`, Dark: `#000000` |
| 카드 배경 | `backgroundsGrouped.secondary` | Light: `#ffffff`, Dark: `#1c1c1e` |
| 카드 좌우 여백 | 16pt | `spacing.contentMargin.iphone.horizontal` |
| 카드 cornerRadius | 10pt | `spacing.radius.md` |
| 행 높이 (Regular) | 44pt | `spacing.components.listRow.heightRegular` |
| 행 수평 패딩 | 16pt | `spacing.components.listRow.paddingHorizontal` |
| 구분선 inset | 56pt (아이콘 포함 시) / 16pt (텍스트만) | `spacing.components.listRow.separatorInset` |
| 구분선 두께 | 0.5px | — |
| 구분선 색상 | `separators.opaque` | Light: `#c6c6c8`, Dark: `#38383a` |
| Section 간격 | 35pt | — |
| Section Header 높이 | ~32pt | — |
| Section Header 타이포 | Footnote (13pt) | `typography.styles.footnote` |
| Section Header 색상 | `labels.secondary` | `rgba(60,60,67,0.6)` / `rgba(235,235,245,0.7)` |

---

## Variant 2: Full Width (Plain List)

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │  ← Status Bar (59pt)
├─────────────────────────────────────────────┤
│  메시지                           [편집]     │  ← Navigation Bar (44pt)
├─────────────────────────────────────────────┤  ← backgrounds.primary
│                                              │    Light: #ffffff / Dark: #000000
│  ┌──────────────────────────────────────┐   │
│  │ 👤  홍길동                    오전 10:32 │   │  ← 행 높이: 68pt (Tall)
│  │     안녕하세요! 오늘 회의...         ›   │   │    _Images/Tall: Circular 60pt
│  ├──────────────────────────────────────┤   │    separator: 전체 너비 - 76pt inset
│  │ 👤  김철수                    오전 9:15  │   │
│  │     프로젝트 진행 상황 공유...       ›   │   │
│  ├──────────────────────────────────────┤   │
│  │ 👤  이영희                    어제       │   │
│  │     내일 점심 어때요?             ›   │   │
│  ├──────────────────────────────────────┤   │
│  │ 👤  박민수                    어제       │   │
│  │     사진 보내드립니다.            ›   │   │
│  ├──────────────────────────────────────┤   │
│  │ 👤  최지현                    화요일     │   │
│  │     감사합니다!                  ›   │   │
│  ├──────────────────────────────────────┤   │
│  │ 👤  정수아                    월요일     │   │
│  │     주말에 만나요!               ›   │   │
│  └──────────────────────────────────────┘   │
│                                              │
│  (스크롤 계속...)                              │
│                                              │
├─────────────────────────────────────────────┤
│  [🏠홈] [🔍탐색] [＋] [🔔벨] [👤프로필]      │
└─────────────────────────────────────────────┘
```

### Full Width 치수

| 항목 | 값 | 토큰 |
|------|-----|------|
| 화면 배경 | `backgrounds.primary` | Light: `#ffffff`, Dark: `#000000` |
| 행 배경 | `backgrounds.primary` (동일) | — |
| 좌우 여백 | 0pt (전체 너비) | — |
| 행 높이 (Tall) | 68pt | — |
| 아바타 크기 | 60 × 60pt (Circular) | — |
| 아바타 ↔ 텍스트 간격 | 16pt | `spacing.inset.md` |
| 구분선 inset | 76pt (아바타 + 간격) | — |
| Trailing accessory | chevron.right | `labels.tertiary` |
| 타이틀 타이포 | Headline (17pt, Semibold) | `typography.styles.headline` |
| 서브타이틀 타이포 | Subheadline (15pt, Regular) | `typography.styles.subheadline` |
| 타임스탬프 타이포 | Subheadline (15pt, Regular) | `labels.secondary` |

---

## Variant 3: Full Width with Section Headers

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41           ⠿ ▐▌ ■              │  ← Status Bar (59pt)
├─────────────────────────────────────────────┤
│  연락처                [+]     [그룹]       │  ← Navigation Bar (44pt)
├─────────────────────────────────────────────┤
│  🔍 검색                                    │  ← Search Bar (36pt)
├─────────────────────────────────────────────┤  ← A
│  A ─────────────────────────────────────── │  ← Section Header    │ ▲
│  │ 안성현                                › │  ← 44pt Regular      │ │
│  ├──────────────────────────────────────── │                      │ │
│  │ 안지영                                › │                      │ B
│  ├──────────────────────────────────────── │                      │ │
│  B ─────────────────────────────────────── │  ← Section Header    │ C
│  │ 박민수                                › │                      │ │
│  ├──────────────────────────────────────── │                      │ D
│  │ 박서연                                › │                      │ │
│  ├──────────────────────────────────────── │                      │ ⋮
│  C ─────────────────────────────────────── │  ← Section Header    │ │
│  │ 최지현                                › │                      │ ㄱ
│  ├──────────────────────────────────────── │                      │ │
│  │ 최하늘                                › │                      │ ㄴ
│  ├──────────────────────────────────────── │                      │ │
│  ...                                        │                      │ ⋮
│                                              │                      │ ▼
├─────────────────────────────────────────────┤  ← Index Bar (우측)
│  [🏠홈] [🔍탐색] [＋] [🔔벨] [👤프로필]      │
└─────────────────────────────────────────────┘
```

### Section Header + Index Bar 치수

| 항목 | 값 | 토큰 |
|------|-----|------|
| Section Header 높이 | 28pt | — |
| Section Header 배경 | `backgroundsGrouped.tertiary` | Light: `#f2f2f7`, Dark: `#2c2c2e` |
| Section Header 타이포 | Footnote (13pt, Semibold) | `typography.styles.footnote` (emphasized) |
| Section Header 색상 | `labels.primary` | — |
| Section Header 패딩 | 좌 16pt | `spacing.inset.md` |
| Index Bar 너비 | ~16pt | — |
| Index Bar 위치 | 우측 가장자리, 수직 중앙 | — |
| Index Bar 글자 크기 | 10pt | — |
| Index Bar 글자 색상 | `accents.blue` | Light: `#0088ff`, Dark: `#0091ff` |
| Index Bar 터치 영역 | 44pt 너비 (히트 영역 확장) | — |

---

## Scroll Indicators

| 항목 | 값 |
|------|-----|
| 스크롤 인디케이터 너비 | 2.5pt |
| 색상 | `labels.quaternary` |
| 표시 조건 | 스크롤 중에만 표시 (idle 시 자동 숨김) |
| 페이드 아웃 | 스크롤 멈춤 후 1.5s, 0.3s fade |

---

## Swipe Actions

```
← 왼쪽 스와이프 (Trailing Actions) ────────────────
┌──────────────────────┬──────┬──────┬───────┐
│  홍길동                │  🔕  │  📌  │  🗑️  │  ← 트레일링 스와이프 액션
│  안녕하세요!           │ 알림끔│  고정 │  삭제 │    각 액션 너비: ~74pt
└──────────────────────┴──────┴──────┴───────┘
                                         ↑ Destructive (빨간 배경)

→ 오른쪽 스와이프 (Leading Actions) ───────────────
┌───────┬──────────────────────────────────────┐
│  ✉️  │  김철수                                │  ← 리딩 스와이프 액션
│ 읽지않음│  프로젝트 진행...                      │    accents.blue 배경
└───────┴──────────────────────────────────────┘
```

### Swipe Action 치수

| 항목 | 값 | 토큰 |
|------|-----|------|
| 액션 버튼 너비 | ~74pt (기본), 전체 스와이프 시 확장 | — |
| 아이콘 크기 | 22pt (SF Symbol) | — |
| 레이블 타이포 | Caption2 (11pt) | `typography.styles.caption2` |
| 삭제 배경 | `accents.red` | Light: `#ff383c`, Dark: `#ff4245` |
| 고정 배경 | `accents.orange` | Light: `#ff8d28`, Dark: `#ff9230` |
| 알림끔 배경 | `accents.purple` | Light: `#cb30e0`, Dark: `#db34f2` |
| 읽지않음 배경 | `accents.blue` | Light: `#0088ff`, Dark: `#0091ff` |
| 스와이프 duration | 0.2s | `animations.duration.semantic.listRowSwipe` |

---

## Light/Dark 모드 차이

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| 화면 배경 (Grouped) | `#f2f2f7` | `#000000` |
| 카드 배경 (Grouped) | `#ffffff` | `#1c1c1e` |
| 화면 배경 (Plain) | `#ffffff` | `#000000` |
| 행 텍스트 (Primary) | `#000000` | `#ffffff` |
| 행 텍스트 (Secondary) | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.7)` |
| 구분선 | `#c6c6c8` | `#38383a` |
| Section Header 배경 | `#f2f2f7` | `#2c2c2e` |
| Index Bar | `#0088ff` | `#0091ff` |
| Highlighted row | `rgba(209,209,214,1)` (gray4) | `rgba(58,58,60,1)` (gray4) |

---

## 애니메이션

### Swipe Action

```yaml
trigger: 행 좌/우 스와이프 제스처
duration: 0.2s (gesture-driven 이후 snap)
easing: appleEaseOut
properties:
  row_translateX: 0 → -(action_width)
  action_buttons: scale 0.8 → 1.0 (등장 시)
full_swipe:
  threshold: 행 너비 × 0.6
  action: 첫 번째 액션 자동 실행
  spring: snappy (response 0.3, dampingRatio 0.8)
```

### Row Insert/Delete

```yaml
insert:
  duration: 0.3s
  properties:
    height: 0 → 44pt
    opacity: 0 → 1
  easing: easeOut
delete:
  duration: 0.3s
  properties:
    height: 44pt → 0
    opacity: 1 → 0
    translateX: 0 → -100% (왼쪽으로 밀림)
  easing: easeIn
```

### Scroll Edge Effect (iOS 26)

```yaml
description: 스크롤 경계에서 Liquid Glass 블러 페이드
top_edge:
  gradient: 투명 → blur 10px (상단 ~20pt)
  condition: contentOffset.y > 0
bottom_edge:
  gradient: blur 10px → 투명 (하단 ~20pt)
  condition: contentOffset.y < maxOffset
token: materials.scrollEdgeEffect.soft
```

### Reduce Motion

```yaml
prefers-reduced-motion:
  swipe: 즉시 스냅 (gesture-driven은 유지)
  insert/delete: opacity만 (높이 애니메이션 제거)
  scroll_edge: 유지 (시각 효과)
```

---

## 인터랙션 노트

| 인터랙션 | 동작 |
|---------|------|
| **행 탭** | 상세 화면으로 push 네비게이션 |
| **행 길게 누르기** | Context Menu 표시 (설정에 따라) |
| **좌로 스와이프** | Trailing 액션 노출 (삭제, 더보기 등) |
| **우로 스와이프** | Leading 액션 노출 (읽지않음, 핀 등) |
| **전체 스와이프 (좌)** | 삭제 등 기본 액션 자동 실행 |
| **Pull-to-Refresh** | 상단 당기기 → RefreshControl 활성화 |
| **Index Bar 탭/드래그** | 해당 섹션으로 즉시 스크롤 |
| **검색 바 탭** | 키보드 활성화 + 검색 모드 진입 |
| **편집 모드** | 행 재정렬 (Grabber 핸들), 삭제 버튼 표시 |

---

## 접근성 (Accessibility)

| 항목 | 요구사항 |
|------|---------|
| **VoiceOver** | 각 행: `accessibilityLabel` (제목 + 부제목 + 상태), `accessibilityTraits: .button` |
| **Swipe Actions** | VoiceOver: "Actions available" 힌트, 위아래 스와이프로 액션 순환 |
| **Section Header** | `accessibilityTraits: .header` |
| **Index Bar** | `accessibilityLabel: "[문자] 섹션으로 이동"` |
| **터치 타겟** | 행 높이 44pt+ (Apple HIG 충족) |
| **Dynamic Type** | 행 높이 자동 확장, 텍스트 잘림 없음 (multiline 허용) |
| **색상 대비** | Primary 텍스트: WCAG AA (4.5:1+), Secondary: 3.0:1+ (AA Large) |
| **Reduce Motion** | 행 삽입/삭제 시 opacity만, 스와이프 snap은 유지 |
| **Bold Text** | 행 텍스트 굵기 자동 조정 |
| **키보드 탐색** | 화살표 키로 행 이동, Enter로 선택, Space로 체크박스 토글 |

---

## 구현 체크리스트

- [ ] List 스타일 선택 (`.insetGrouped` / `.plain` / `.grouped`)
- [ ] 행 높이 올바르게 설정 (Regular 44pt / Tall 68pt)
- [ ] 구분선 inset 올바르게 계산 (아이콘 유무에 따라)
- [ ] Swipe Actions 설정 (leading/trailing)
- [ ] Full swipe 임계값 설정
- [ ] Pull-to-Refresh 구현
- [ ] Section Header 스타일 적용
- [ ] Index Bar 활성화 (`sectionIndexTitles`)
- [ ] Light/Dark 모드 배경색 올바르게 적용
- [ ] Context Menu 연동 (필요 시)
- [ ] 편집 모드 지원 (재정렬/삭제)
- [ ] VoiceOver 포커스 순서 및 액션 접근성 검증
- [ ] Dynamic Type 대응
- [ ] Scroll Edge Effect (iOS 26)

---

## 관련 화면

| 화면 | 관계 |
|------|------|
| `home-feed.md` | 피드 목록 (Full Width + Tall 행) |
| `settings-screen.md` | 설정 화면 (Inset Grouped) |
| `empty-states.md` | 리스트 빈 상태 |
| `context-menu.md` | 행 Long Press 시 Context Menu |
