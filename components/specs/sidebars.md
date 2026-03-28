# iOS 26 Sidebar — Component Spec

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:26013")`

---

## 1. 개요

iOS 26 Sidebar는 iPad에서 마스터 내비게이션을 담당하는 영역이다. `UISplitViewController`의 sidebar column에 해당하며, 앱의 최상위 내비게이션 구조를 표시한다.

- **Regular width (iPad)**: 항상 표시, 메인 콘텐츠를 옆으로 밀어냄
- **Compact width (iPhone / iPad Slide Over)**: 기본 숨김, 스와이프 또는 버튼으로 오버레이 표시

---

## 2. 구성 요소

```
┌────────────────────────────────┐
│  [앱 이름 / 툴바 영역]          │  ← Toolbar (44pt)
│  ┌──────────────────────────┐ │
│  │ 🔍 검색창                 │ │  ← Search Field (36pt)
│  └──────────────────────────┘ │
│                                │
│  SECTION HEADER                │  ← Section Header (28pt)
│  ─────────────────────────────│
│  ○ 항목 1                      │  ← Sidebar Row (44pt)
│  ● 항목 2 (선택됨)              │  ← Sidebar Row - Selected
│    ├─ 하위 항목 A   ←들여쓰기→  │  ← Sidebar Row - Child
│    └─ 하위 항목 B              │
│                                │
│  SECTION HEADER 2              │
│  ─────────────────────────────│
│  ○ 항목 3              (3) ●  │  ← Sidebar Row - Badge
│  ○ 항목 4                      │
│                                │
│  [편집 버튼]                    │  ← Edit Button (하단)
└────────────────────────────────┘
```

---

## 3. Variants

### 3.1 Sidebar Row (12 variants)

| Variant | 설명 |
|---|---|
| `Default` | 기본 미선택 상태 |
| `Selected` | 선택됨, Liquid Glass 배경 |
| `Selected + Focus` | 선택 + 키보드 포커스 |
| `Badge` | 우측에 숫자 배지 표시 |
| `Badge + Selected` | 배지 있는 선택 상태 |
| `Disclosure` | 하위 항목 있음, 셰브론 표시 |
| `Disclosure Expanded` | 하위 항목 펼쳐진 상태 |
| `Child Default` | 하위 항목 기본 |
| `Child Selected` | 하위 항목 선택됨 |
| `Editing` | 편집 모드, 순서변경 핸들 |
| `Editing + Delete` | 편집 모드, 삭제 버튼 |
| `Drag Active` | 드래그 중 (elevated shadow) |

### 3.2 Leading / Trailing Decorators

| 타입 | Variants | 설명 |
|---|---|---|
| `_Sidebar - Leading` | 16 | 아이콘, SF Symbol, 색상 원형 |
| `_Sidebar - Trailing` | 24 | 배지, 셰브론, 카운트, 별표 |
| `_Sidebar - Edit Button` | 6 | 편집 진입/완료 버튼 상태들 |

---

## 4. 치수

### 4.1 너비 (iPad 기기별)

| 기기 | Sidebar 너비 |
|---|---|
| iPad Pro 13" | 320pt |
| iPad Pro 11" / iPad Air | 280pt |
| iPad mini | 260pt |
| iPhone (Compact) | 전체 너비 (overlay) |

### 4.2 개별 요소 높이

| 요소 | 높이 |
|---|---|
| Toolbar 영역 | 44pt (+ Safe Area top) |
| Search Field | 36pt |
| Section Header | 28pt |
| Sidebar Row | 44pt |
| Child Row (들여쓰기) | 44pt |
| Edit Button 영역 | 44pt (+ Safe Area bottom) |

### 4.3 들여쓰기 (Hierarchy)

```
[아이콘 16pt] [레이블]                    ← depth 0 (최상위)
              [아이콘 16pt] [레이블]      ← depth 1 (들여쓰기 20pt)
                            [레이블]    ← depth 2 (들여쓰기 40pt)
```

- **들여쓰기**: depth당 20pt
- **최대 depth**: 2 (표준 권장), 3 이상은 비권장

### 4.4 Row 내부 레이아웃

```
┌────────────────────────────────────────┐
│ 16 │ [Leading 24×24] │ 12 │ [Label] [---flex---] │ [Trailing] │ 16 │
└────────────────────────────────────────┘
  ↑ leading padding     ↑ icon  ↑ gap   ↑ 레이블 텍스트           trailing
```

- 좌측 패딩: 16pt
- 아이콘 크기: 24×24pt
- 아이콘↔레이블 gap: 12pt
- 우측 패딩: 16pt
- Trailing 요소 (배지 등) ↔ 우측 패딩: 8pt

---

## 5. 색상 토큰

```json
// ../tokens/colors.json 참조
{
  "sidebar": {
    "background": "Colors/Background/Secondary",
    "row": {
      "default": "transparent",
      "selected": "Colors/Liquid Glass/Regular",
      "selectedFallback": "Colors/Fill/Quaternary",
      "hovered": "Colors/Fill/Tertiary",
      "pressed": "Colors/Fill/Secondary"
    },
    "label": {
      "default": "Colors/Label/Primary",
      "selected": "Colors/Label/Primary",
      "secondary": "Colors/Label/Secondary",
      "disabled": "Colors/Label/Quaternary"
    },
    "icon": {
      "default": "Colors/Label/Secondary",
      "selected": "Colors/Tint/Blue"
    },
    "badge": {
      "background": "Colors/Fill/Tertiary",
      "label": "Colors/Label/Secondary"
    },
    "sectionHeader": "Colors/Label/Secondary",
    "separator": "Colors/Separator/Opaque"
  }
}
```

---

## 6. 타이포그래피

```json
// ../tokens/typography.json 참조
{
  "sidebar": {
    "rowLabel": {
      "fontStyle": "Body",
      "weight": "Regular",
      "size": "17pt"
    },
    "rowLabelSelected": {
      "fontStyle": "Body",
      "weight": "Semibold",
      "size": "17pt"
    },
    "sectionHeader": {
      "fontStyle": "Footnote",
      "weight": "Semibold",
      "size": "13pt",
      "letterSpacing": "0.06em",
      "textTransform": "uppercase"
    },
    "badge": {
      "fontStyle": "Caption1",
      "weight": "Semibold",
      "size": "12pt"
    },
    "childLabel": {
      "fontStyle": "Subheadline",
      "weight": "Regular",
      "size": "15pt"
    }
  }
}
```

---

## 7. 간격 토큰

```json
// ../tokens/spacing.json 참조
{
  "sidebar": {
    "rowHeight": 44,
    "sectionHeaderHeight": 28,
    "toolbarHeight": 44,
    "searchFieldHeight": 36,
    "rowPaddingH": 16,
    "iconSize": 24,
    "iconLabelGap": 12,
    "indentPerLevel": 20,
    "badgePaddingH": 8,
    "badgePaddingV": 2,
    "badgeMinWidth": 20,
    "badgeCornerRadius": 10,
    "sectionTopSpacing": 24,
    "sectionHeaderPaddingH": 16,
    "sectionHeaderPaddingBottom": 4
  }
}
```

---

## 8. 애니메이션

```json
// ../tokens/animations.json 참조
{
  "sidebar": {
    "slideIn": {
      "type": "spring",
      "stiffness": 300,
      "damping": 38,
      "direction": "leading-edge",
      "duration": "~0.35s"
    },
    "slideOut": {
      "type": "spring",
      "stiffness": 300,
      "damping": 38,
      "direction": "leading-edge-reverse",
      "duration": "~0.3s"
    },
    "rowSelection": {
      "type": "spring",
      "stiffness": 500,
      "damping": 40,
      "property": "background-color"
    },
    "disclosureExpand": {
      "type": "spring",
      "stiffness": 380,
      "damping": 36,
      "property": "height + chevron-rotation"
    },
    "editModeEnter": {
      "type": "easeInOut",
      "duration": 0.25,
      "property": "layout-shift + handle-appear"
    }
  }
}
```

### 8.1 Sidebar Show/Hide (Regular → Compact)

1. **Regular (iPad landscape)**: 사이드바 항상 표시, 메인 뷰가 오른쪽에 배치
2. **Compact (iPhone / 세로 iPad)**: 사이드바 숨김
   - 버튼 탭 → leading edge에서 spring slide-in (stiffness: 300, damping: 38)
   - 외부 탭 또는 dismiss → spring slide-out
3. **Overlay dimming**: 사이드바 뒤 콘텐츠에 `rgba(0,0,0,0.3)` dim 오버레이 (fade-in 0.25s)

### 8.2 행 선택 전환

- 이전 선택 행: Liquid Glass 배경 fade-out (0.15s)
- 신규 선택 행: Liquid Glass 배경 spring-in (stiffness: 500, damping: 40)
- 아이콘 색상: secondary → tinted (0.15s crossfade)
- 레이블 굵기: Regular → Semibold (0.15s)

### 8.3 Disclosure 펼치기/접기

- 셰브론 아이콘 회전: 0° → 90° (spring)
- 하위 항목들: height 0 → (n × 44pt) (spring, staggered delay 0.05s/항목)

---

## 9. 상태 정의

| 상태 | 시각적 변화 |
|---|---|
| `default` | 투명 배경, secondary 아이콘 |
| `hovered` | Fill/Tertiary 배경 (iPadOS pointer) |
| `pressed` | Fill/Secondary 배경, scale 0.98 |
| `selected` | Liquid Glass 배경, tinted 아이콘, semibold 텍스트 |
| `selected + focused` | selected + 포커스 링 (2pt, Tint/Blue) |
| `editing` | 순서변경 핸들 표시 (trailing), 삭제 버튼 (leading) |
| `drag-active` | elevated shadow, 약간 scale-up (1.02) |
| `disabled` | opacity 0.4, 탭 불가 |

---

## 10. 플랫폼별 구현

### 10.1 UIKit

```swift
import UIKit

class AppSplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        preferredDisplayMode = .oneBesideSecondary
        preferredSplitBehavior = .tile
        primaryBackgroundStyle = .sidebar

        // Sidebar column 너비 설정
        minimumPrimaryColumnWidth = 260
        maximumPrimaryColumnWidth = 320
        preferredPrimaryColumnWidth = 280
    }
}

// Sidebar TableView 설정
class SidebarViewController: UITableViewController {

    enum Section: CaseIterable {
        case main, settings
    }

    var dataSource: UITableViewDiffableDataSource<Section, SidebarItem>!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "앱 이름"

        // Sidebar cell 스타일
        var config = UIListContentConfiguration.sidebarCell()

        dataSource = UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "SidebarCell", for: indexPath
            ) as! UITableViewCell

            var content = UIListContentConfiguration.sidebarCell()
            content.text = item.title
            content.image = UIImage(systemName: item.systemImageName)
            cell.contentConfiguration = content

            // 배지
            if let count = item.badgeCount {
                var badge = UICellAccessory.label(text: "\(count)")
                cell.accessories = [.label(text: "\(count)"), .disclosureIndicator()]
            }

            return cell
        }

        // Search Controller
        let searchController = UISearchController()
        navigationItem.searchController = searchController
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택 시 메인 뷰 업데이트
        if let splitVC = splitViewController {
            splitVC.show(.secondary)
        }
    }
}
```

### 10.2 SwiftUI

```swift
import SwiftUI

struct ContentView: View {
    @State private var selectedItem: SidebarItem? = .inbox
    @State private var columnVisibility = NavigationSplitViewVisibility.automatic

    var body: some View {
        NavigationSplitView(
            columnVisibility: $columnVisibility
        ) {
            // Sidebar
            List(SidebarItem.allCases, selection: $selectedItem) { item in
                Label(item.title, systemImage: item.icon)
                    .badge(item.badgeCount)
            }
            .navigationTitle("Mail")
            .navigationSplitViewColumnWidth(
                min: 260, ideal: 280, max: 320
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        } detail: {
            // Detail View
            if let item = selectedItem {
                DetailView(item: item)
            } else {
                ContentUnavailableView(
                    "항목을 선택하세요",
                    systemImage: "sidebar.left"
                )
            }
        }
    }
}

enum SidebarItem: String, CaseIterable, Identifiable {
    case inbox, sent, drafts, trash

    var id: String { rawValue }
    var title: String {
        switch self {
        case .inbox: "받은 편지함"
        case .sent: "보낸 편지함"
        case .drafts: "임시 보관함"
        case .trash: "휴지통"
        }
    }
    var icon: String {
        switch self {
        case .inbox: "tray"
        case .sent: "paperplane"
        case .drafts: "doc"
        case .trash: "trash"
        }
    }
    var badgeCount: Int? {
        switch self {
        case .inbox: 3
        default: nil
        }
    }
}
```

### 10.3 Flutter

```dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _selectedIndex = 0;
  bool _showSidebar = true;

  static const double _sidebarWidth = 280.0;

  final List<SidebarItem> _items = [
    SidebarItem(title: '받은 편지함', icon: CupertinoIcons.tray, badgeCount: 3),
    SidebarItem(title: '보낸 편지함', icon: CupertinoIcons.paperplane),
    SidebarItem(title: '임시 보관함', icon: CupertinoIcons.doc),
    SidebarItem(title: '휴지통', icon: CupertinoIcons.trash),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 768;

    return Scaffold(
      body: Row(
        children: [
          // Sidebar (iPad wide)
          if (isWide)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: _showSidebar ? _sidebarWidth : 0,
              child: _showSidebar ? _buildSidebar() : null,
            ),

          // Divider
          if (isWide && _showSidebar)
            Container(width: 0.5, color: CupertinoColors.separator),

          // Main Content
          Expanded(child: _buildContent()),
        ],
      ),

      // Drawer (iPhone / compact)
      drawer: isWide ? null : Drawer(
        width: _sidebarWidth,
        child: _buildSidebar(),
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      color: CupertinoColors.secondarySystemBackground,
      child: Column(
        children: [
          // Safe Area + Search
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: CupertinoSearchTextField(
                placeholder: '검색',
              ),
            ),
          ),

          // Navigation Items
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                final isSelected = _selectedIndex == index;

                return _SidebarRow(
                  item: item,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() => _selectedIndex = index);
                    if (MediaQuery.of(context).size.width < 768) {
                      Navigator.pop(context); // Drawer 닫기
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      child: Text(_items[_selectedIndex].title),
    );
  }
}

class _SidebarRow extends StatelessWidget {
  const _SidebarRow({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final SidebarItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: isSelected
              ? CupertinoColors.quaternarySystemFill
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              size: 20,
              color: isSelected
                  ? CupertinoColors.activeBlue
                  : CupertinoColors.secondaryLabel,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: CupertinoColors.label,
                ),
              ),
            ),
            if (item.badgeCount != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: CupertinoColors.tertiarySystemFill,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${item.badgeCount}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: CupertinoColors.secondaryLabel,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SidebarItem {
  final String title;
  final IconData icon;
  final int? badgeCount;

  SidebarItem({required this.title, required this.icon, this.badgeCount});
}
```

### 10.4 웹 / Svelte

```svelte
<script lang="ts">
  import { MediaQuery } from 'svelte/reactivity';

  interface SidebarItem {
    id: string;
    title: string;
    icon: string;
    badgeCount?: number;
    children?: SidebarItem[];
  }

  let { items = [] }: { items: SidebarItem[] } = $props();

  let selectedId = $state('inbox');
  let isOpen = $state(false);
  let expandedIds = $state<Set<string>>(new Set());

  const isWide = new MediaQuery('(min-width: 768px)');

  function toggleExpand(id: string) {
    if (expandedIds.has(id)) {
      expandedIds.delete(id);
    } else {
      expandedIds.add(id);
    }
    expandedIds = new Set(expandedIds);
  }
</script>

<!-- iPad wide: 항상 표시 -->
<!-- iPhone: drawer 오버레이 -->
<nav
  class="sidebar"
  class:sidebar--open={isOpen || isWide.current}
  style="
    position: {isWide.current ? 'relative' : 'fixed'};
    left: 0; top: 0; bottom: 0;
    width: 280px;
    background: var(--color-background-secondary);
    transform: translateX({isWide.current || isOpen ? '0' : '-100%'});
    transition: transform 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    z-index: {isWide.current ? 'auto' : '200'};
    display: flex;
    flex-direction: column;
  "
>
  <!-- Search -->
  <div style="padding: 8px 16px;">
    <input
      type="search"
      placeholder="검색"
      style="
        width: 100%;
        height: 36px;
        padding: 0 12px;
        border-radius: 10px;
        border: none;
        background: var(--color-fill-tertiary);
        font-size: 15px;
      "
    />
  </div>

  <!-- 구분선 -->
  <div style="height: 1px; background: var(--color-separator-opaque); margin: 4px 0;"></div>

  <!-- Navigation List -->
  <ul style="list-style: none; padding: 0; margin: 0; flex: 1; overflow-y: auto;">
    {#each items as item}
      <!-- Section Header -->
      {#if item.isSection}
        <li style="
          height: 28px;
          padding: 0 16px;
          display: flex;
          align-items: flex-end;
          font-size: 13px;
          font-weight: 600;
          letter-spacing: 0.06em;
          text-transform: uppercase;
          color: var(--color-label-secondary);
          padding-bottom: 4px;
          margin-top: 24px;
        ">
          {item.title}
        </li>
      {:else}
        <!-- Sidebar Row -->
        <li>
          <button
            onclick={() => {
              selectedId = item.id;
              if (item.children) toggleExpand(item.id);
            }}
            style="
              width: 100%;
              height: 44px;
              padding: 0 16px;
              display: flex;
              align-items: center;
              gap: 12px;
              border: none;
              border-radius: 10px;
              margin: 2px 8px;
              width: calc(100% - 16px);
              background: {selectedId === item.id ? 'var(--color-fill-quaternary)' : 'transparent'};
              cursor: pointer;
              text-align: left;
              transition: background 0.15s ease;
            "
          >
            <!-- Leading Icon -->
            <span style="
              width: 24px;
              height: 24px;
              color: {selectedId === item.id
                ? 'var(--color-tint-blue)'
                : 'var(--color-label-secondary)'};
              flex-shrink: 0;
            ">
              {item.icon}
            </span>

            <!-- Label -->
            <span style="
              flex: 1;
              font-size: 17px;
              font-weight: {selectedId === item.id ? 600 : 400};
              color: var(--color-label-primary);
              white-space: nowrap;
              overflow: hidden;
              text-overflow: ellipsis;
            ">
              {item.title}
            </span>

            <!-- Badge -->
            {#if item.badgeCount}
              <span style="
                padding: 2px 8px;
                background: var(--color-fill-tertiary);
                border-radius: 10px;
                font-size: 12px;
                font-weight: 600;
                color: var(--color-label-secondary);
                min-width: 20px;
                text-align: center;
              ">
                {item.badgeCount}
              </span>
            {/if}

            <!-- Disclosure chevron -->
            {#if item.children}
              <span style="
                transform: rotate({expandedIds.has(item.id) ? '90deg' : '0deg'});
                transition: transform 0.2s ease;
                color: var(--color-label-tertiary);
                font-size: 12px;
              ">
                ›
              </span>
            {/if}
          </button>

          <!-- Child items -->
          {#if item.children && expandedIds.has(item.id)}
            <ul style="list-style: none; padding: 0; margin: 0;">
              {#each item.children as child}
                <li>
                  <button
                    onclick={() => selectedId = child.id}
                    style="
                      width: calc(100% - 16px);
                      height: 44px;
                      padding: 0 16px 0 {16 + 20}px;
                      display: flex;
                      align-items: center;
                      gap: 12px;
                      border: none;
                      border-radius: 10px;
                      margin: 2px 8px;
                      background: {selectedId === child.id ? 'var(--color-fill-quaternary)' : 'transparent'};
                      cursor: pointer;
                      text-align: left;
                    "
                  >
                    <span style="
                      font-size: 15px;
                      font-weight: {selectedId === child.id ? 600 : 400};
                      color: var(--color-label-primary);
                    ">{child.title}</span>
                  </button>
                </li>
              {/each}
            </ul>
          {/if}
        </li>
      {/if}
    {/each}
  </ul>
</nav>

<!-- Overlay backdrop (모바일) -->
{#if !isWide.current && isOpen}
  <div
    role="button"
    tabindex="-1"
    onclick={() => isOpen = false}
    onkeydown={(e) => e.key === 'Escape' && (isOpen = false)}
    style="
      position: fixed;
      inset: 0;
      background: rgba(0,0,0,0.3);
      z-index: 199;
    "
  ></div>
{/if}
```

---

## 11. 다크모드 대응

| 토큰 | 라이트 | 다크 |
|---|---|---|
| `Colors/Background/Secondary` | #F2F2F7 | #1C1C1E |
| `Colors/Fill/Quaternary` | rgba(116,116,128,0.08) | rgba(118,118,128,0.24) |
| `Colors/Tint/Blue` | #007AFF | #0A84FF |
| `Colors/Label/Primary` | rgba(0,0,0,1) | rgba(255,255,255,1) |
| `Colors/Label/Secondary` | rgba(60,60,67,0.6) | rgba(235,235,245,0.6) |

---

## 12. 접근성

- **VoiceOver 역할**: `UIAccessibilityTraitButton` + 선택 상태 `UIAccessibilityTraitSelected`
- **배지 접근성**: "받은 편지함, 3개의 읽지 않은 메시지" 형식으로 accessibilityLabel 설정
- **키보드 탐색**: `Tab`으로 항목 이동, `Enter`/`Space`로 선택, `Arrow` 키로 disclosure 토글
- **터치 타겟**: 최소 44×44pt (행 높이 44pt 준수)
- **포커스 인디케이터**: 2pt 포커스 링, `Colors/Tint/Blue` 색상

---

## 13. 체크리스트

- [ ] Regular/Compact 너비 분기 처리
- [ ] Liquid Glass 선택 배경 (또는 Fill/Quaternary 폴백)
- [ ] Spring 애니메이션 (stiffness: 300, damping: 38)
- [ ] 들여쓰기 depth당 20pt
- [ ] 배지 최소 너비 20pt, 코너 반경 10pt
- [ ] Section Header uppercase + letter-spacing
- [ ] 다크모드 토큰 대응
- [ ] VoiceOver 선택 상태 전달
- [ ] 키보드 포커스 링
- [ ] Disclosure 셰브론 회전 애니메이션
