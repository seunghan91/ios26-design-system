# iPad Action Sheet — iOS 26 iPad 페이지 레시피

> **References**
> - Templates: `../../templates/`
> - Components: `../../components/specs/action-sheets.md`
> - Tokens: `../../tokens/`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24669")`

---

## 화면 개요

iPad에서 Action Sheet는 iPhone과 완전히 다른 프레젠테이션을 사용한다. iPhone에서는 화면 하단에서 슬라이드 업되는 Bottom Card + Cancel Card 형태이지만, **iPad에서는 Popover**로 표시된다. 트리거 버튼 위치에서 Arrow가 가리키는 형태로 나타나며, Cancel 버튼은 **표시되지 않는다** (바깥 영역 탭이 Cancel 역할).

| 항목 | 값 |
|------|-----|
| **적용 디바이스** | iPad Pro 13" (1210x834pt landscape) |
| **프레젠테이션** | Popover (UIPopoverPresentationController) |
| **iPhone 대응** | Bottom Card + Cancel Card (별도 카드) |
| **Popover 너비** | `280~320pt` |
| **Cancel 버튼** | iPad: 없음 (바깥 탭으로 대체), iPhone: 있음 |
| **Dimming** | iPad: 없음, iPhone: 있음 |
| **배경 소재** | Liquid Glass (`materials.json` > `liquidGlass.regular.medium`) |
| **Corner Radius** | `14pt` (`spacing.json` > `radius.semantic.popover`) |

---

## Device Context

```
iPad Pro 13" Landscape
─────────────────────────────
화면 크기      : 1210 x 834pt
Safe Area Top  : 24pt           ← spacing.json > safeArea.ipadLandscape.top
Safe Area Bot  : 20pt           ← spacing.json > safeArea.ipadLandscape.bottom
Content Margin : 20pt           ← spacing.json > contentMargin.ipad.horizontal
```

---

## iPad vs iPhone 프레젠테이션 비교

| 항목 | iPad (Popover) | iPhone (Bottom Sheet) |
|------|----------------|----------------------|
| **외형** | Arrow 있는 플로팅 카드 | 화면 하단 슬라이드 업 2장 카드 |
| **너비** | 280~320pt | 화면 너비 - 32pt |
| **Cancel 버튼** | 없음 | 별도 카드로 하단에 표시 |
| **Dimming** | 없음 | `overlays.default` 적용 |
| **바깥 영역** | 탭 가능 + Cancel 역할 | 탭 시 Cancel |
| **Arrow** | 있음 (트리거 방향 가리킴) | 없음 |
| **Destructive** | 빨간색 텍스트, 동일 | 빨간색 텍스트, 동일 |
| **Title/Message** | Popover 상단에 표시 | 본체 카드 상단에 표시 |

---

## Screen Composition Breakdown

### Popover — Arrow UP (Toolbar 버튼에서 트리거)

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           STATUS BAR (24pt)                                     │
├─────────────────────────────────────────────────────────────────────────────────┤
│  NAVIGATION BAR (Liquid Glass, 44pt)                                            │
│  [< 사진]    [앨범 이름]                                    [선택] [⋯ 더보기]   │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│                                                              ▲ Arrow (12pt)     │
│                                                  ┌───────────┴──────────┐       │
│                                                  │  ACTION SHEET        │       │
│                                                  │  (Popover, 300pt)    │       │
│                                                  │  Liquid Glass BG     │       │
│                                                  │                      │       │
│  CONTENT AREA                                    │  사진 정리             │       │
│  (사진 그리드 등                                  │  선택한 3장의 사진을   │       │
│   메인 콘텐츠)                                   │  어떻게 하시겠습니까?  │       │
│                                                  │                      │       │
│                                                  │  ─────────────────── │       │
│                                                  │  📥 앨범에 추가       │       │
│                                                  │  ─────────────────── │       │
│                                                  │  📤 공유              │       │
│                                                  │  ─────────────────── │       │
│                                                  │  📋 복사              │       │
│                                                  │  ─────────────────── │       │
│                                                  │  🔒 숨기기            │       │
│                                                  │  ─────────────────── │       │
│                                                  │  🗑️ 삭제           🔴│       │
│                                                  └──────────────────────┘       │
│                                                                                 │
│  (배경: dimming 없음, 상호작용 가능)                                             │
│                                                                                 │
├─────────────────────────────────────────────────────────────────────────────────┤
│  TOOLBAR-BOTTOM (44pt, Liquid Glass)                                            │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### Popover — Arrow LEFT (좌측 Sidebar 버튼에서 트리거)

```
┌────────────────────┬────────────────────────────────────────────────────────────┐
│  SIDEBAR           │  CONTENT AREA                                              │
│  (320pt)           │                                                            │
│  ○ 라이브러리      │                                                            │
│  ● 앨범  ← 길게 탭│                                                            │
│  ○ 사람들         ┌┴─────────────────────────┐                                 │
│  ○ 최근 항목      │  ACTION SHEET (Popover)   │                                 │
│                    │  ← Arrow LEFT            │                                 │
│                    │                          │                                 │
│                    │  ──────────────────────  │                                 │
│                    │  앨범 이름 변경           │                                 │
│                    │  ──────────────────────  │                                 │
│                    │  앨범 정렬               │                                 │
│                    │  ──────────────────────  │                                 │
│                    │  🗑️ 앨범 삭제          🔴│                                 │
│                    └──────────────────────────┘                                 │
│                    │                                                            │
└────────────────────┴────────────────────────────────────────────────────────────┘
```

---

## Popover 상세 치수

### Action Sheet Popover 크기

```
기본 너비        : 300pt (HIG 권장)
최소 너비        : 280pt
최대 너비        : 400pt
높이             : 콘텐츠에 맞게 자동 (auto)
최대 높이        : 600pt (내부 ScrollView 권장)
코너 반경        : 14pt     ← spacing.json > radius.semantic.popover
Arrow            : 12pt
```

### Popover 내부 레이아웃

```
┌──────────────────────────────────────┐  ← cornerRadius: 14pt
│  Title (선택)                         │  ← paddingTop: 16pt
│  footnote/Regular (13pt)              │    paddingH: 16pt
│  color: labels.secondary              │    textAlign: center
│                                       │
│  Message (선택)                       │  ← footnote/Regular (13pt)
│  color: labels.secondary              │
│                                       │  ← paddingBottom: 8pt
├───────────────────────────────────────┤  ← separator 0.5pt
│  [Icon]  Action Label 1              │  ← height: 57pt
│                                       │    paddingH: 16pt
├───────────────────────────────────────┤    labels.primary
│  [Icon]  Action Label 2              │    body/Regular (17pt)
├───────────────────────────────────────┤
│  [Icon]  Destructive Action     🔴   │  ← accents.red
│                                       │    body/Regular (17pt)
└───────────────────────────────────────┘

※ Cancel 버튼 없음 (iPad Popover에서는 바깥 탭으로 닫기)
```

---

## Component Usage (토큰 참조)

### Popover Container

| 속성 | 값 | 토큰 |
|------|-----|------|
| Width | `300pt` (기본) | HIG 권장값 |
| Corner Radius | `14pt` | `spacing.json` > `radius.semantic.popover` |
| Background | Liquid Glass medium | `materials.json` > `liquidGlass.regular.medium` |
| Frost Radius | `12pt` | `materials.json` > `liquidGlass.regular.medium.frostRadius` |
| Shadow Blur | `40pt` | `materials.json` > `liquidGlass.regular.medium.*.shadow.blur` |

### Title / Message 영역

| 속성 | 값 | 토큰 |
|------|-----|------|
| Title Font | footnote/Semibold (13pt) | `typography.json` > `styles.footnote.emphasized` |
| Title Color | labels.secondary | `colors.json` > `labels.secondary` |
| Message Font | footnote/Regular (13pt) | `typography.json` > `styles.footnote` |
| Message Color | labels.secondary | `colors.json` > `labels.secondary` |
| Text Align | center | HIG 기본 |
| Padding Top | `16pt` | `spacing.json` > `inset.md` |
| Padding Horizontal | `16pt` | `spacing.json` > `inset.md` |
| Padding Bottom | `8pt` | `spacing.json` > `inset.xs` |

### Action Button Row

| 속성 | 값 | 토큰 |
|------|-----|------|
| Height | `57pt` | `spacing.json` > `components.actionSheet.actionHeight` |
| Padding Horizontal | `16pt` | `spacing.json` > `inset.md` |
| Label Font | body/Regular (17pt) | `typography.json` > `styles.body` |
| Label Color (Normal) | labels.primary | `colors.json` > `labels.primary` |
| Label Color (Destructive) | accents.red | `colors.json` > `accents.red` |
| Icon Size | `22x22pt` | SF Symbol 기본 |
| Icon Color (Normal) | accents.blue | `colors.json` > `accents.blue` |
| Icon Color (Destructive) | accents.red | `colors.json` > `accents.red` |
| Separator | `0.5pt` | `colors.json` > `separators.nonOpaque` |

---

## iPad-Specific Adaptations

### Arrow 방향 자동 결정

| 트리거 위치 | Arrow 방향 | Popover 위치 |
|------------|-----------|-------------|
| Toolbar 상단 | UP (↑) | 버튼 아래에 표시 |
| Toolbar 하단 | DOWN (↓) | 버튼 위에 표시 |
| Sidebar 항목 | LEFT (←) | 항목 오른쪽에 표시 |
| 콘텐츠 우측 버튼 | RIGHT (→) | 버튼 왼쪽에 표시 |

### Pointer Support

| 상호작용 | 동작 |
|---------|------|
| **Hover** | Action Row 위 포인터 → `fills.tertiary` 하이라이트 |
| **Click** | 탭과 동일 — 해당 액션 실행 |
| **Right-Click** | Context Menu 표시 (별도 시스템, Action Sheet가 아님) |
| **Scroll** | 트랙패드 스크롤로 긴 목록 내비게이션 |

### Keyboard Shortcuts

| 단축키 | 동작 |
|--------|------|
| `Esc` | Popover 닫기 (Cancel) |
| `↑` / `↓` | 액션 항목 간 포커스 이동 |
| `Return` | 선택된 액션 실행 |

### Source Button 연결 (필수)

```swift
// UIKit: iPad에서 popoverPresentationController 설정 필수
let actionSheet = UIAlertController(
    title: "사진 정리",
    message: "선택한 3장의 사진을 어떻게 하시겠습니까?",
    preferredStyle: .actionSheet
)

// iPad: 이 설정 없으면 런타임 크래시!
actionSheet.popoverPresentationController?.barButtonItem = moreButton
// 또는
actionSheet.popoverPresentationController?.sourceView = view
actionSheet.popoverPresentationController?.sourceRect = button.frame
actionSheet.popoverPresentationController?.permittedArrowDirections = [.up, .down]
```

---

## Light / Dark Mode 차이

### Light Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| Popover BG | `rgba(#f5f5f5, 0.6)` + frost | `materials.json` > `liquidGlass.regular.medium.light.bg` |
| Shadow | blur 40pt | `materials.json` > `liquidGlass.regular.medium.light.shadow` |
| Title/Message | `rgba(#3c3c43, 0.6)` | `colors.json` > `labels.secondary.light` |
| Action Label | `#000000` | `colors.json` > `labels.primary.light` |
| Destructive | `#ff383c` | `colors.json` > `accents.red.light` |
| Separator | `rgba(#000000, 0.12)` | `colors.json` > `separators.nonOpaque.light` |

### Dark Mode

| 요소 | 값 | 토큰 |
|------|-----|------|
| Popover BG | `rgba(#000000, 0.6)` + frost + tint | `materials.json` > `liquidGlass.regular.medium.dark` |
| Tint | `rgba(#ffffff, 0.06)` | `materials.json` > `liquidGlass.regular.medium.dark.tint` |
| Shadow | blur 40pt | `materials.json` > `liquidGlass.regular.medium.dark.shadow` |
| Title/Message | `rgba(#ebebf5, 0.7)` | `colors.json` > `labels.secondary.dark` |
| Action Label | `#ffffff` | `colors.json` > `labels.primary.dark` |
| Destructive | `#ff4245` | `colors.json` > `accents.red.dark` |
| Separator | `rgba(#ffffff, 0.17)` | `colors.json` > `separators.nonOpaque.dark` |

---

## Multitasking Considerations

### Split View

- Popover는 **활성 앱 영역 내에서만** 표시
- 50/50 Split (605pt): Popover 300pt 표시 가능, Arrow 방향 자동 조정
- 33/66 Split 좁은 쪽 (403pt): 여전히 Popover 표시 가능
- Compact width로 전환 시: **Bottom Sheet로 자동 폴백** (Cancel 버튼 포함)

```
Compact Width 감지 시:
  iPad Popover → iPhone-style Bottom Sheet
  Cancel 버튼 표시됨
  Dimming 적용됨
  하단에서 슬라이드 업
```

### Slide Over

- Slide Over 앱 (320pt): Compact size class → Bottom Sheet로 폴백
- Bottom Sheet 시: 너비 320 - 32 = 288pt, Cancel 카드 별도 표시

### Stage Manager

- 윈도우 크기에 따라 size class 자동 전환
- Regular → Popover, Compact → Bottom Sheet
- Popover가 윈도우 밖으로 나가지 않도록 Arrow 방향 + 위치 자동 조정

---

## Animation Spec

### Popover 등장

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.25s` | `animations.json` > `transitions.scale.in.duration` |
| Easing | spring.snappy | `animations.json` > `easing.spring.snappy` |
| Transform Origin | Arrow tip | 시스템 자동 |
| Scale | `0.85 → 1.0` | `animations.json` > `transitions.scale.in` |
| Opacity | `0 → 1` | `animations.json` > `transitions.scale.in` |

### Popover 닫힘

| 속성 | 값 | 토큰 |
|------|-----|------|
| Duration | `0.15s` | `animations.json` > `transitions.scale.out.duration` |
| Easing | easeIn | `animations.json` > `easing.easeIn` |
| Scale | `1.0 → 0.85` | `animations.json` > `transitions.scale.out` |
| Opacity | `1 → 0` | `animations.json` > `transitions.scale.out` |

---

## Accessibility

| 항목 | 구현 |
|------|------|
| **VoiceOver** | Title → Message → Actions 순서로 읽기 |
| **Esc 키** | Cancel (Popover 닫기) |
| **Tab** | Action 간 포커스 이동 |
| **Touch Target** | Action 높이 57pt (44pt 최소 초과) |
| **Reduce Transparency** | Liquid Glass → 불투명 배경 |
| **Reduce Motion** | Spring → 단순 fade |
| **Dynamic Type** | Action 텍스트 크기 증가 시 Row 높이 자동 확장 |
