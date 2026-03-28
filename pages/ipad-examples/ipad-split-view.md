# iPad Split View — iOS 26 iPad 페이지 레시피

> **References**
> - Templates: `../../templates/`
> - Components: `../../components/specs/`
> - Tokens: `../../tokens/`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="...")`

---

## 화면 개요

iPad Split View(마스터-디테일)는 iPad의 `regular` size class에서 화면을 두 개의 열로 나누어 동시에 표시하는 레이아웃 패턴이다. 왼쪽 Primary Column에는 목록(master)을, 오른쪽 Detail Column에는 선택된 항목의 상세 내용을 표시한다. iOS 26에서는 Liquid Glass 소재가 sidebar toolbar에도 적용된다.

| 항목 | 값 |
|------|-----|
| **적용 디바이스** | iPad (모든 모델), iPad mini 6+, iPhone Max (landscape) |
| **Size Class 조건** | `horizontal: regular` 일 때 split 활성화 |
| **Primary Column 기본 너비** | 320pt |
| **Detail Column** | 나머지 전체 (`flex: 1`) |
| **Collapse 조건** | `horizontal: compact` (iPhone portrait, iPad compact) |

---

## iPad 레이아웃 규칙 (pt 치수)

### iPad Pro 12.9" (1024pt wide)
```
Primary Column : 320pt
Separator      :   1pt (divider)
Detail Column  : 703pt
```

### iPad Pro 11" / iPad Air (834pt wide)
```
Primary Column : 320pt
Separator      :   1pt
Detail Column  : 513pt
```

### iPad mini (744pt wide)
```
Primary Column : 320pt  (기본, 사용자 조절 불가)
Separator      :   1pt
Detail Column  : 423pt
```

### Split View 비율 (iPadOS Multitasking)
```
1/3 앱 + 2/3 앱:
  좁은 앱 width ≈ 320~375pt  → compact 취급 → sidebar collapse
  넓은 앱 width ≈ 710pt      → regular 유지  → split 활성

1/2 앱 + 1/2 앱 (iPad Pro 12.9"):
  각 앱 width = 512pt        → regular 유지  → split 활성

1/2 앱 + 1/2 앱 (iPad Air 11"):
  각 앱 width = 417pt        → compact 취급 → sidebar collapse
```

### Safe Area (iPad)
```
Status Bar 높이  : 24pt (iPad, Non-Dynamic Island)
Home Indicator   : 0pt  (iPad — 없음, 홈 버튼/제스처 영역 별도)
Sidebar Top Inset: 24pt (Status Bar)
```

---

## 컴포넌트 계층 (ASCII 와이어프레임)

### Regular Width — Split 활성 상태
```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          STATUS BAR  (24pt)                                 │
│  [Wi-Fi] [Battery]                              [Time]  [Control Center]    │
├──────────────────────────┬──────────────────────────────────────────────────┤
│  PRIMARY COLUMN (320pt)  │              DETAIL COLUMN (나머지)               │
│ ┌──────────────────────┐ │ ┌──────────────────────────────────────────────┐ │
│ │  TOOLBAR-TOP         │ │ │  TOOLBAR-TOP (detail)                        │ │
│ │  (primary)           │ │ │  [< Back] [Detail Title]    [Edit] [Share]   │ │
│ │  [≡] [Title]  [+]   │ │ │  Liquid Glass background                     │ │
│ │  Liquid Glass bg     │ │ └──────────────────────────────────────────────┘ │
│ └──────────────────────┘ │                                                  │
│                          │  ┌────────────────────────────────────────────┐  │
│  ┌────────────────────┐  │  │  CONTENT AREA (detail)                     │  │
│  │  SEARCH BAR        │  │  │                                            │  │
│  │  [🔍 검색...]      │  │  │  ┌──────────────────────────────────────┐  │  │
│  └────────────────────┘  │  │  │  Hero Image / Media                  │  │  │
│                          │  │  │  (full width of detail column)        │  │  │
│  ┌────────────────────┐  │  │  └──────────────────────────────────────┘  │  │
│  │  LIST-ROW          │  │  │                                            │  │
│  │  [Icon] Title      │  │  │  Section Header                           │  │
│  │         Subtitle ▶ │  │  │  ─────────────────────────────────────── │  │
│  ├────────────────────┤  │  │  [List Row] Detail Item 1                 │  │
│  │  LIST-ROW          │  │  │  [List Row] Detail Item 2                 │  │
│  │  [Icon] Title      │  │  │  [List Row] Detail Item 3                 │  │
│  │         Subtitle ▶ │  │  │                                            │  │
│  ├────────────────────┤  │  │  (스크롤 가능)                              │  │
│  │  LIST-ROW          │  │  │                                            │  │
│  │  [Icon] Title ●    │  │  └────────────────────────────────────────────┘  │
│  │  (selected/active) │  │                                                  │
│  ├────────────────────┤  │                                                  │
│  │  LIST-ROW          │  │                                                  │
│  │  [Icon] Title      │  │                                                  │
│  │         Subtitle ▶ │  │                                                  │
│  └────────────────────┘  │                                                  │
│                          │                                                  │
│  (스크롤 가능)            │                                                  │
└──────────────────────────┴──────────────────────────────────────────────────┘
```

### Compact Width — Sidebar Collapsed (Sheet로 전환)
```
┌──────────────────────────────────────┐
│           STATUS BAR  (54pt)         │
│  [signal] [time] [battery]           │
├──────────────────────────────────────┤
│  TOOLBAR-TOP                         │
│  [≡] [Detail Title]    [Edit]        │  ← Back 버튼 없음, 메뉴 버튼으로 대체
├──────────────────────────────────────┤
│                                      │
│  CONTENT AREA (full width)           │
│  ─ Detail 화면만 표시 ─              │
│  선택 항목 상세 내용                  │
│                                      │
└──────────────────────────────────────┘
         ↑ 메뉴 버튼([≡]) 탭 시
┌──────────────────────────────────────┐
│  ████████████████ SIDEBAR SHEET ████ │  ← Bottom Sheet로 슬라이드업
│  [Title]                    [Done]   │
│  ─────────────────────────────────── │
│  [List Row] Item 1              ▶    │
│  [List Row] Item 2              ▶    │
│  [List Row] Item 3 (selected)  ✓    │
│  [List Row] Item 4              ▶    │
└──────────────────────────────────────┘
```

### Sidebar Collapse 애니메이션
```
Regular → Compact 전환:
  Primary Column: width 320pt → 0pt (duration 0.35s, easeInOut)
  Detail Column : left-edge 321pt → 0pt (동시)
  Separator     : opacity 1 → 0

Sidebar Sheet 등장 (compact):
  Sheet: translateY(100%) → translateY(0), duration 0.4s, spring(damping: 0.85)
  Backdrop: opacity 0 → 0.4
```

---

## iPhone vs iPad 분기 처리

| 조건 | iPhone (compact) | iPad (regular) |
|------|-----------------|---------------|
| 레이아웃 | 단일 column stack | Split View (Primary + Detail) |
| Sidebar | Full-screen push | 고정 표시 (Always Visible / Auto) |
| Toolbar 구성 | Back 버튼 있음 | Primary toolbar 독립 |
| 초기 화면 | Master list만 표시 | Master + Detail 동시 |
| 항목 선택 | Push navigation | Detail column 갱신 |
| 빈 화면(미선택) | 해당 없음 | "항목을 선택하세요" placeholder |

### SwiftUI Size Class 감지 예시
```swift
// iOS 26 / SwiftUI
struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        if sizeClass == .regular {
            // iPad — Split View
            NavigationSplitView {
                SidebarListView()
            } detail: {
                DetailPlaceholderView()
            }
        } else {
            // iPhone — Stack Navigation
            NavigationStack {
                MasterListView()
            }
        }
    }
}
```

---

## 애니메이션 시나리오

### 1. 항목 선택 → Detail 갱신
```
Trigger  : List Row 탭
Duration : 0.25s
Curve    : easeOut

Detail Column:
  이전 내용 → opacity 0 (0.1s)
  새 내용   → opacity 1 (0.15s, delay 0.1s)
  + translateX(20pt → 0pt) 미세 슬라이드

List Row:
  배경색 → selectedBackground (즉시)
  이전 선택 Row → selectedBackground 해제 (0.2s)
```

### 2. Sidebar Collapse / Expand
```
Collapse (버튼 탭):
  Primary Column width: 320 → 0 (0.35s, spring damping 0.9)
  Detail Column left: 321 → 0 (동시)

Expand:
  Primary Column width: 0 → 320 (0.35s, spring damping 0.85)
  Separator opacity: 0 → 1 (0.2s, delay 0.15s)
```

### 3. Swipe Gesture (Primary Column 드래그)
```
Drag Right (compact에서):
  Sidebar Sheet: pan gesture 연동
  velocity > 500pt/s → snap to open
  velocity < 500pt/s AND offset > 50% → snap to open
  else → snap to closed
```

---

## 프레임워크별 구현

### UIKit — UISplitViewController
```swift
// iOS 26, UIKit
class AppSplitViewController: UISplitViewController {

    init() {
        super.init(style: .doubleColumn)
        preferredDisplayMode = .oneBesideSecondary
        preferredPrimaryColumnWidth = 320
        minimumPrimaryColumnWidth = 280
        maximumPrimaryColumnWidth = 380
        presentsWithGesture = true
        showsSecondaryOnlyButton = false
    }

    required init?(coder: NSCoder) { fatalError() }
}

// Primary (master) controller
class SidebarViewController: UITableViewController {

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        let detail = DetailViewController(item: items[indexPath.row])

        // split이 collapse 상태면 push, regular면 show detail
        showDetailViewController(detail, sender: self)
    }
}
```

### SwiftUI — NavigationSplitView
```swift
// iOS 26 / SwiftUI
struct RootSplitView: View {
    @State private var selectedItem: Item?
    @State private var columnVisibility: NavigationSplitViewVisibility = .automatic

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // Primary Column (sidebar)
            List(items, selection: $selectedItem) { item in
                Label(item.title, systemImage: item.icon)
                    .tag(item)
            }
            .navigationTitle("목록")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: addItem) {
                        Image(systemName: "plus")
                    }
                }
            }
        } detail: {
            // Detail Column
            if let item = selectedItem {
                DetailView(item: item)
            } else {
                ContentUnavailableView(
                    "항목을 선택하세요",
                    systemImage: "sidebar.left",
                    description: Text("왼쪽 목록에서 항목을 선택하면 여기에 표시됩니다.")
                )
            }
        }
        // iPad에서 sidebar 기본 표시
        .navigationSplitViewStyle(.balanced)
    }
}
```

### Flutter — AdaptiveLayout (two_pane)
```dart
// flutter_adaptive_scaffold 패키지 활용
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

class SplitViewScreen extends StatefulWidget {
  @override
  State<SplitViewScreen> createState() => _SplitViewScreenState();
}

class _SplitViewScreenState extends State<SplitViewScreen> {
  Item? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      primaryNavigation: SlotLayout(
        config: {
          // compact: 없음 (drawer로 대체)
          Breakpoints.medium: SlotLayout.from(
            key: const Key('primary-nav'),
            builder: (_) => AdaptiveScaffold.standardNavigationRail(
              destinations: navDestinations,
            ),
          ),
          // large: sidebar 표시
          Breakpoints.large: SlotLayout.from(
            key: const Key('primary-nav-large'),
            builder: (_) => SidebarPanel(
              width: 320,
              selectedItem: _selectedItem,
              onItemSelected: (item) => setState(() => _selectedItem = item),
            ),
          ),
        },
      ),
      body: SlotLayout(
        config: {
          Breakpoints.standard: SlotLayout.from(
            key: const Key('body'),
            builder: (_) => _selectedItem != null
                ? DetailPanel(item: _selectedItem!)
                : const EmptyDetailPlaceholder(),
          ),
        },
      ),
    );
  }
}
```

---

## Sidebar Collapse 구현 상세

### SwiftUI Programmatic Collapse
```swift
// columnVisibility 상태로 제어
Button("사이드바 토글") {
    withAnimation(.spring(duration: 0.35, bounce: 0.1)) {
        if columnVisibility == .all {
            columnVisibility = .detailOnly
        } else {
            columnVisibility = .all
        }
    }
}
```

### Empty Detail State (항목 미선택)
```swift
// iOS 16+ ContentUnavailableView 활용
ContentUnavailableView {
    Label("선택된 항목 없음", systemImage: "list.bullet.rectangle")
} description: {
    Text("목록에서 항목을 선택하면 여기에 상세 내용이 표시됩니다.")
} actions: {
    Button("첫 번째 항목 보기") {
        selectedItem = items.first
    }
    .buttonStyle(.borderedProminent)
}
```

---

## 토큰 참조

| 토큰 | 값 | 용도 |
|------|-----|------|
| `sidebar.width` | 320pt | Primary Column 기본 너비 |
| `sidebar.minWidth` | 280pt | 드래그 최소 너비 |
| `sidebar.maxWidth` | 380pt | 드래그 최대 너비 |
| `separator.color` | `colors.separator` | Column 구분선 |
| `toolbar.height` | 52pt (iPad inline) | iPad Toolbar 높이 |
| `animation.splitCollapse` | 0.35s spring | Sidebar 접기/펼치기 |
| `animation.detailTransition` | 0.25s easeOut | Detail 콘텐츠 전환 |
