# Standard Screen Template

> **References**
> - Components: `../components/specs/navigation-bar.md`, `../components/specs/tab-bar.md`, `../components/specs/list-row.md`
> - Tokens: `../tokens/spacing.json`, `../tokens/colors.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md` (Examples page: `0:3329`)
> - Parent: `../PLAN.md`

---

## 1. Overview

Standard Screen은 iOS 앱에서 가장 많이 사용되는 기본 화면 구조다. Navigation Bar + Content Area + Tab Bar의 3단 수직 레이아웃으로 구성된다. 대부분의 1depth 화면(홈, 목록, 설정 등)이 이 템플릿을 따른다.

**적용 대상**
- 앱의 루트 탭 화면 (각 탭의 첫 번째 화면)
- 목록 기반 콘텐츠 화면
- 설정 화면
- 대시보드 / 홈 화면

**이 템플릿이 다루지 않는 것**
- Push된 하위 화면 → `navigation-stack.md` 참조
- 모달/시트 → `sheet-overlay.md` 참조
- 탭 없는 단독 화면 → Navigation Bar + Content만 사용

---

## 2. Layout Diagram

```
┌─────────────────────────────────────┐
│           STATUS BAR                │  54pt (Dynamic Island 모델)
│    [signal] [time] [battery]        │  배경: 투명 (Navigation Bar 색과 연속)
├─────────────────────────────────────┤
│         NAVIGATION BAR              │  44pt (inline) / 96pt (large title)
│  [Back]   [Title]      [Button]     │  Large Title 모드: 아래 Content에 겹침
├─────────────────────────────────────┤
│                                     │
│         CONTENT AREA                │  flex: 1 (남은 공간 전체)
│    (scrollable / static)            │  상단: Nav Bar 하단 기준
│                                     │  하단: Tab Bar 상단 기준
│   ┌─────────────────────────────┐   │
│   │  Large Title (scroll 내부)  │   │  Large Title 모드에서만 존재
│   │  [Large Title Text]         │   │  scroll offset ~40pt에서 inline으로 전환
│   └─────────────────────────────┘   │
│                                     │
│   [List Row / Card / Grid...]       │
│   [List Row]                        │
│   [List Row]                        │
│                                     │
│             ↕ scroll                │
│                                     │
├─────────────────────────────────────┤
│           TAB BAR                   │  49pt (기본) / 83pt (Liquid Glass indicator)
│  [Tab1]  [Tab2]  [Tab3]  [Tab4]    │  + 하단 Safe Area (34pt, Dynamic Island 모델)
│    ●                                │  ● = Liquid Glass 선택 인디케이터
└─────────────────────────────────────┘

총 화면 높이 예시 (iPhone 16 Pro, 874pt logical):
  Status Bar:     54pt
  Navigation Bar: 44pt (inline) 또는 Content 상단에 포함 (large title 시)
  Content Area:   ~693pt (large title inline 기준)
  Tab Bar:        49pt
  Safe Area 하단: 34pt
```

---

## 3. Component Assembly Rules

### 수직 적층 순서 (위→아래)

| 순서 | 영역 | 컴포넌트 | 비고 |
|------|------|----------|------|
| 1 | Status Bar | 시스템 자동 렌더 | 직접 구현 없음 |
| 2 | Navigation Bar | `NavigationBar` | Large Title 시 Content 상단에 병합 |
| 3 | Content Area | `ScrollView` + 내부 컴포넌트들 | 유일한 유연 영역 |
| 4 | Tab Bar | `TabBar` | 항상 화면 하단 고정 |

### Content Area 내부 컴포넌트 규칙

- **목록 콘텐츠**: `ListRow` 컴포넌트를 수직 반복 (`Section` 묶음 가능)
- **카드 그리드**: `Card` 컴포넌트를 2~3열 `LazyVGrid`로 배치
- **스크롤**: 항상 `ScrollView`로 감싸되, 콘텐츠가 화면에 맞으면 스크롤 비활성
- **Sticky Header**: Section header는 스크롤 시 상단 고정 (iOS 기본 동작)

### 금지 규칙

- Navigation Bar와 Tab Bar 사이 영역 외부에 콘텐츠 배치 금지
- Tab Bar 위에 플로팅 버튼 배치 시 Tab Bar 높이 + 16pt 간격 확보 필수
- Status Bar 영역에 interactive element 배치 금지

---

## 4. Spacing Rules

### 영역 간 간격

| 영역 경계 | 간격 | 토큰 값 |
|-----------|------|---------|
| Status Bar ↔ Navigation Bar | 0pt (연속) | — |
| Navigation Bar ↔ Content 첫 항목 | 0pt (ScrollView가 처리) | — |
| Content 마지막 항목 ↔ Tab Bar | 0pt (SafeArea가 처리) | — |

### Content Area 내부 간격

| 항목 | 값 | 토큰 |
|------|-----|------|
| 좌우 Content Margin (iPhone) | **16pt** | `contentMargin.iphone.horizontal` |
| 좌우 Content Margin (iPad) | **20pt** | `contentMargin.ipad.horizontal` |
| Section 간 간격 | **24pt** | `scale.3` (12pt top) + `scale.3` (12pt bottom) |
| List Row 높이 (기본) | **44pt** | `components.listRow.heightRegular` |
| List Row 높이 (대형) | **58pt** | `components.listRow.heightLarge` |
| List Row 내부 상하 패딩 | **11pt** | `components.listRow.paddingVertical` |
| Separator inset | **16pt** | `components.listRow.separatorInset` |
| Card Grid 간격 | **8pt** | `scale.1` (4pt) ~ `scale.2` (8pt) |

### Safe Area 처리

```
iPhone 16 Pro:
  상단 Safe Area: 59pt (Dynamic Island 포함)
  하단 Safe Area: 34pt (홈 인디케이터)

Status Bar (54pt)는 Safe Area top(59pt) 내에 포함됨.
Navigation Bar는 Safe Area 아래에서 시작.
Tab Bar는 하단 Safe Area를 자동으로 포함.
```

---

## 5. Scroll Behavior — Large Title 전환

### 전환 조건

```
scroll offset = 0pt     → Large Title 표시 (Content 상단)
scroll offset ~40pt     → Large Title → Inline Title 전환 시작
scroll offset ≥ ~60pt   → Inline Title 완전 표시 (Navigation Bar에 고정)
```

### 전환 애니메이션

- **Duration**: 암시적 (시스템 처리), 약 `0.2s`
- **Easing**: `appleEaseOut` (`cubic-bezier(0.0, 0, 0.6, 1.0)`)
- **Large Title 글자 크기**: `34pt Bold`
- **Inline Title 글자 크기**: `17pt SemiBold`
- **동작**: Large Title이 스크롤과 함께 위로 이동 → Navigation Bar 타이틀로 fade-in

### Scroll Indicator

- 기본: Right edge 표시
- Tab Bar 위에서 자동 종료 (bottom content inset 자동 처리)

---

## 6. Status Bar Style

| 배경 밝기 | Status Bar 스타일 | 설정값 |
|----------|------------------|--------|
| 밝은 배경 (`#ffffff`, `#f2f2f7`) | Dark content | `.darkContent` |
| 어두운 배경 (`#000000`, `#1c1c1e`) | Light content | `.lightContent` |
| 투명/반투명 (Liquid Glass) | 자동 감지 | `.default` |

**iOS 26 특이사항**: Liquid Glass 배경 위 Status Bar는 배경 평균 밝기를 실시간 감지하여 자동 전환된다. 수동 지정이 필요한 경우만 명시적으로 설정.

---

## 7. Common Variations

### (a) Plain List

```
Navigation Bar (Large Title)
└── ScrollView
    └── List (plain style)
        ├── ListRow
        ├── ListRow  ← separator 전폭 (inset 없음)
        └── ListRow

배경: backgrounds.primary (흰색/검정)
Separator: separators.opaque (#c6c6c8 / #38383a)
```

**토큰**
- Background Light: `#ffffff` (`backgrounds.primary.light`)
- Background Dark: `#000000` (`backgrounds.primary.dark`)
- Separator: `#c6c6c8` / `#38383a` (`separators.opaque`)

### (b) Inset Grouped List

```
Navigation Bar (Large Title)
└── ScrollView
    └── List (insetGrouped style)
        ├── Section Header (optional)
        │   ├── ListRow (corner-radius: 12pt top)  ← 첫 row
        │   ├── ListRow (separator: inset 16pt)
        │   └── ListRow (corner-radius: 12pt bottom) ← 마지막 row
        └── Section 2...

배경: backgroundsGrouped.primary (#f2f2f7 / #000000)
카드 배경: backgroundsGrouped.secondary (#ffffff / #1c1c1e)
```

**토큰**
- Outer Background Light: `#f2f2f7` (`backgroundsGrouped.primary.light`)
- Outer Background Dark: `#000000` (`backgroundsGrouped.primary.dark`)
- Card Background Light: `#ffffff` (`backgroundsGrouped.secondary.light`)
- Card Background Dark: `#1c1c1e` (`backgroundsGrouped.secondary.dark`)
- Card Corner Radius: `12pt` (`radius.semantic.card`)

### (c) Grid Layout

```
Navigation Bar (Large Title)
└── ScrollView
    └── LazyVGrid (columns: 2 or 3)
        ├── [Card]  [Card]
        ├── [Card]  [Card]
        └── [Card]  [Card]

좌우 마진: 16pt (iPhone)
카드 간격: 8pt (scale.2)
카드 radius: 12pt (radius.semantic.card)
```

---

## 8. Token References

| 항목 | 토큰 경로 | 값 |
|------|-----------|-----|
| Status Bar 높이 | `components.statusBar.heightRegular` | **54pt** |
| Navigation Bar 높이 (inline) | `components.navigationBar.height` | **44pt** |
| Navigation Bar 높이 (large) | `components.navigationBar.largeTitleHeight` | **96pt** |
| Navigation Bar 좌우 패딩 | `components.navigationBar.paddingHorizontal` | **16pt** |
| Tab Bar 높이 | `components.tabBar.height` | **49pt** |
| Tab Bar 높이 (Liquid Glass indicator) | `components.tabBar.heightWithIndicator` | **83pt** |
| Content 좌우 마진 (iPhone) | `contentMargin.iphone.horizontal` | **16pt** |
| List Row 기본 높이 | `components.listRow.heightRegular` | **44pt** |
| 터치 타겟 최소 | `components.touchTarget.minimum` | **44pt** |
| Safe Area 상단 (iPhone 16 Pro) | `safeArea.iphone16Pro.top` | **59pt** |
| Safe Area 하단 (iPhone 16 Pro) | `safeArea.iphone16Pro.bottom` | **34pt** |
| Card Corner Radius | `radius.semantic.card` | **12pt** |
| Alert Corner Radius | `radius.semantic.alert` | **14pt** |

---

## 9. SwiftUI Implementation

```swift
struct StandardScreenTemplate: View {
    var body: some View {
        // TabView는 tab-bar-layout.md 참조
        // 여기서는 단일 탭 내부 구조만 구현

        NavigationStack {
            // (a) Plain List 예시
            List {
                ForEach(items) { item in
                    ListRowView(item: item)
                }
            }
            // (b) Inset Grouped
            // .listStyle(.insetGrouped)

            // Large Title
            .navigationTitle("화면 제목")
            .navigationBarTitleDisplayMode(.large) // 또는 .inline

            // Status Bar 스타일 (어두운 배경 시)
            // .preferredColorScheme(.dark)
        }
    }
}

// Grid Layout 예시
struct GridScreenTemplate: View {
    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(items) { item in
                        CardView(item: item)
                            .cornerRadius(12) // radius.semantic.card
                    }
                }
                .padding(.horizontal, 16) // contentMargin.iphone.horizontal
            }
            .navigationTitle("그리드 화면")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
```

**Large Title 스크롤 전환은 SwiftUI NavigationStack이 자동 처리**한다. `.navigationBarTitleDisplayMode(.large)` 지정 시 scroll offset ~40pt에서 inline으로 자동 전환.

---

## 10. UIKit Implementation

```swift
class StandardViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Large Title 설정
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        title = "화면 제목"

        // (a) Plain 스타일 (기본값)
        // tableView.style = .plain

        // (b) Inset Grouped
        // tableView = UITableView(frame: .zero, style: .insetGrouped)

        // Status Bar 스타일
        // navigationController?.navigationBar.barStyle = .default // 밝은 배경
        // navigationController?.navigationBar.barStyle = .black   // 어두운 배경
    }

    // Content Inset — Tab Bar 자동 처리
    // UITabBarController가 bottomContentInset을 자동으로 설정 (Tab Bar 높이 + Safe Area)

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent  // 밝은 배경: .darkContent / 어두운 배경: .lightContent
    }
}

// Navigation Bar iOS 26 Liquid Glass 스타일 적용
extension UINavigationController {
    func applyiOS26Style() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground() // Liquid Glass 자동 적용 (iOS 26+)
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
```

**UITableView contentInset**: UITabBarController 사용 시 자동으로 bottom inset이 Tab Bar 높이(49pt) + Safe Area(34pt) = 83pt로 설정된다. 수동 조정 불필요.
