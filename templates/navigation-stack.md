# Navigation Stack Template

> **References**
> - Components: `../components/specs/navigation-bar.md`, `../components/specs/back-button.md`
> - Tokens: `../tokens/spacing.json`, `../tokens/colors.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md` (Examples page: `0:3329`)
> - Parent: `../PLAN.md`

---

## 1. Overview

Navigation Stack은 iOS 앱에서 화면 간 이동을 관리하는 가장 기본적인 패턴이다. 사용자가 목록에서 상세로, 설정에서 세부 설정으로 이동할 때 화면이 오른쪽에서 왼쪽으로 밀려 들어오는(push) 방식으로 작동한다. SwiftUI에서는 `NavigationStack`, UIKit에서는 `UINavigationController`가 이를 구현한다.

**적용 대상**
- 목록 → 상세 화면 이동
- 설정 → 세부 설정 항목
- 온보딩 플로우 (단계별 화면 전환)
- 검색 결과 → 상세 보기

**핵심 개념**
- **Stack**: 방문한 화면들이 쌓이는 구조 (LIFO — 마지막에 들어온 화면이 먼저 나감)
- **Push**: 새 화면을 스택에 추가 (오른쪽에서 슬라이드인)
- **Pop**: 현재 화면을 스택에서 제거 (오른쪽으로 슬라이드아웃)
- **Root**: 스택의 첫 번째 화면 (탭의 홈 화면)

---

## 2. Layout Zones

```
┌─────────────────────────────────────┐
│           STATUS BAR                │  54pt — 배경: Navigation Bar와 연속
├─────────────────────────────────────┤
│         NAVIGATION BAR              │
│  ┌──────────────────────────────┐   │
│  │ [← Back]  [Title]  [Button+] │   │  44pt (inline) / 96pt (large title)
│  └──────────────────────────────┘   │
│  ──────────────── (선택: 검색창) ───  │  +50pt (SearchBar 추가 시)
├─────────────────────────────────────┤
│         CONTENT AREA                │
│                                     │
│  ┌─────────────────────────────┐    │
│  │  Large Title (스크롤 내부)   │    │  34pt Bold — 스크롤 시 Nav Bar로 이동
│  └─────────────────────────────┘    │
│                                     │
│  [콘텐츠 영역]                       │
│  — 이전 화면과 완전히 다른 콘텐츠    │
│                                     │
│                                     │
└─────────────────────────────────────┘
        ↕ (Tab Bar는 Navigation Stack 밖)

Navigation Bar 구성 요소:
  Leading:   [← Back Button] (이전 화면 타이틀 또는 "뒤로")
  Center:    [현재 화면 Title] (inline 모드) 또는 없음 (large title 모드)
  Trailing:  [최대 3개 버튼] (sfSymbol or text)
```

---

## 3. Push Transition

새 화면이 스택에 추가될 때의 애니메이션이다.

### 두 화면의 동시 움직임

```
Push 시작:
  새 화면:     [화면 밖 오른쪽]  →  [정위치]      translateX(100% → 0)
  이전 화면:   [정위치]          →  [왼쪽 30%]   translateX(0 → -30%) + opacity(1 → 0.8)

Pop 시작 (역방향):
  현재 화면:   [정위치]  →  [오른쪽 밖]    translateX(0 → 100%)
  이전 화면:   [왼쪽 30%] → [정위치]       translateX(-30% → 0) + opacity(0.8 → 1)
```

### Push 파라미터

| 항목 | 값 | 토큰 |
|------|-----|------|
| Duration | **0.35s** | `duration.semantic.pageTransition` |
| Easing | `appleEaseOut` | `easing.appleEaseOut` |
| 새 화면 시작 위치 | `translateX(100%)` | `transitions.push.enter.from` |
| 새 화면 끝 위치 | `translateX(0)` | `transitions.push.enter.to` |
| 이전 화면 끝 위치 | `translateX(-30%)` | `transitions.push.exit.to` |
| 이전 화면 opacity | `1 → 0.8` | `transitions.push.exit.opacity` |

### Navigation Bar 전환

- Back Button: 이전 타이틀이 왼쪽에서 fade-out, 새 타이틀이 중앙에서 fade-in
- Large Title → Inline: 동시에 타이틀이 위로 이동하며 축소

### CSS 근사값

```css
/* Push: 새 화면 진입 */
.screen-enter {
    transform: translateX(100%);
    animation: pushEnter 0.35s cubic-bezier(0.0, 0, 0.6, 1.0) forwards;
    /* animations.json: easing.appleEaseOut */
}

@keyframes pushEnter {
    to { transform: translateX(0); }
}

/* Push: 기존 화면 퇴장 */
.screen-exit {
    animation: pushExit 0.35s cubic-bezier(0.0, 0, 0.6, 1.0) forwards;
}

@keyframes pushExit {
    to { transform: translateX(-30%); opacity: 0.8; }
}
```

---

## 4. Pop Transition

현재 화면이 스택에서 제거될 때의 애니메이션이다.

### Pop 파라미터

| 항목 | 값 | 토큰 |
|------|-----|------|
| Duration | **0.35s** | `duration.semantic.pageTransition` |
| Easing | `appleEaseOut` | `easing.appleEaseOut` |
| 현재 화면 시작 위치 | `translateX(0)` | `transitions.pop.exit.from` |
| 현재 화면 끝 위치 | `translateX(100%)` | `transitions.pop.exit.to` |
| 이전 화면 시작 위치 | `translateX(-30%)` | `transitions.pop.enter.from` |
| 이전 화면 끝 위치 | `translateX(0)` | `transitions.pop.enter.to` |
| 이전 화면 opacity | `0.8 → 1` | `transitions.pop.enter.opacity` |

### 인터랙티브 Pop (Edge Swipe)

iOS에서 화면 왼쪽 가장자리를 오른쪽으로 스와이프하면 pop이 인터랙티브하게 진행된다.

- **제스처 진행률**이 50% 이상이면 pop 완료
- **50% 미만**이면 원래 위치로 복귀 (spring 애니메이션)
- `UINavigationController.interactivePopGestureRecognizer` 기본 활성화

```swift
// UIKit: 인터랙티브 pop 비활성화 (커스텀 gesture 사용 시)
navigationController?.interactivePopGestureRecognizer?.isEnabled = false

// SwiftUI: 자동 처리
```

---

## 5. Large Title Collapse Rules

Large Title이 Inline Title로 전환되는 규칙이다.

### 전환 임계값

```
scroll offset = 0pt       Large Title 완전 표시 (34pt Bold)
scroll offset = 10~40pt   Large Title 점진적 축소 + 위로 이동
scroll offset ≥ ~60pt     Inline Title 완전 표시 (17pt SemiBold, Navigation Bar)
```

### 화면별 Large Title 사용 권장

| 화면 유형 | Large Title | 이유 |
|----------|-------------|------|
| 탭의 Root 화면 | 사용 (`.large`) | 계층 구조 명확화 |
| Push된 2depth 이상 | 사용하지 않음 (`.inline`) | 공간 효율 |
| 설정 세부항목 | 사용하지 않음 (`.inline`) | |
| 검색 포함 화면 | 사용 (`large` + SearchBar) | |

---

## 6. Back Button Label Rules

### 레이블 결정 알고리즘

```
이전 화면 타이틀 길이 ≤ 8자  →  이전 화면 타이틀 표시
                               예: "설정", "홈", "Messages"

이전 화면 타이틀 길이 > 8자  →  "뒤로" (한국어) 또는 "Back" (영어) 표시
                               예: 타이틀 "알림 및 사운드 설정" → "뒤로"

Root 화면 (이전 화면 없음)    →  Back Button 없음
```

### Back Button 스타일

```
[← 설정]        ← 표준: SF Symbol chevron.left + 레이블
[← ]            ← 공간 부족 시: chevron.left만 표시 (아이콘만)
[취소]           ← Modal dismiss용: Back Button 대신 "취소" 버튼
```

**터치 타겟 최소**: `44×44pt` (`components.touchTarget.minimum`)

### 커스텀 Back Button

```swift
// UIKit: Back Button 레이블 변경
navigationItem.backButtonTitle = "뒤로"
// 또는 완전 커스텀
navigationItem.leftBarButtonItem = UIBarButtonItem(...)

// SwiftUI
.navigationBarBackButtonHidden(true)
.toolbar {
    ToolbarItem(placement: .navigationBarLeading) {
        Button("뒤로") { dismiss() }
    }
}
```

---

## 7. Title 정렬 규칙

| 모드 | 정렬 | 크기 | 폰트 |
|------|------|------|------|
| Large Title | Leading (좌측 정렬) | **34pt** | Bold |
| Inline Title | Center (중앙 정렬) | **17pt** | SemiBold |
| Subtitle 포함 | Center | 15pt + 12pt | SemiBold + Regular |

### 좌우 버튼과의 간격

```
Navigation Bar (44pt 높이):
  ┌────────────────────────────────────────┐
  │ [Back 16pt] [←][텍스트]  [Title]  [btn][btn] [16pt] │
  └────────────────────────────────────────┘
                             ↑ Center
  좌우 버튼 좌우 패딩: 16pt (components.navigationBar.paddingHorizontal)
  버튼 터치 타겟: 최소 44×44pt (components.touchTarget.minimum)
```

---

## 8. Search Integration in Toolbar

Navigation Bar에 검색창을 통합하는 패턴이다.

### 레이아웃

```
[Large Title 모드 + Search Bar]

┌──────────────────────────────────────┐
│  [← Back]      [Title]    [버튼]     │  44pt Navigation Bar
├──────────────────────────────────────┤
│  🔍 검색...                     [취소] │  50pt Search Bar (내장)
├──────────────────────────────────────┤
│  [Large Title Text - 34pt]           │  스크롤 영역 상단
├──────────────────────────────────────┤
│  콘텐츠...                           │
```

### 검색 활성화 시

```
사용자가 검색창 탭 →
  1. 키보드 올라옴 (0.25s, appleEaseOut)
  2. Large Title 사라짐
  3. 뒤 화면 dimming (overlay 20%)
  4. "취소" 버튼 나타남 (오른쪽에서 슬라이드인)
  5. 검색 결과 오버레이 표시
```

```swift
// SwiftUI
.searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))

// UIKit
let searchController = UISearchController(searchResultsController: nil)
navigationItem.searchController = searchController
navigationItem.hidesSearchBarWhenScrolling = false // 항상 표시
```

---

## 9. SwiftUI NavigationStack

```swift
// 기본 Navigation Stack 구조
struct AppRoot: View {
    var body: some View {
        NavigationStack {
            // Root 화면
            RootListView()
                .navigationTitle("목록")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct RootListView: View {
    var body: some View {
        List(items) { item in
            // NavigationLink로 Push
            NavigationLink(destination: DetailView(item: item)) {
                ListRowView(item: item)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { /* 액션 */ }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct DetailView: View {
    let item: Item

    var body: some View {
        ScrollView {
            // 상세 콘텐츠
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline) // 2depth는 inline
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button("편집") { /* */ }
                    Button("공유") { /* */ }
                    Divider()
                    Button("삭제", role: .destructive) { /* */ }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
    }
}

// 프로그래밍 방식 네비게이션 (iOS 16+)
struct ProgrammaticNav: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            RootView()
                .navigationDestination(for: Item.self) { item in
                    DetailView(item: item)
                }
        }
    }
}
```

---

## 10. UIKit UINavigationController

```swift
// AppDelegate / SceneDelegate 설정
let rootVC = RootListViewController()
let navController = UINavigationController(rootViewController: rootVC)
navController.navigationBar.prefersLargeTitles = true // 전체 Large Title 활성화
window?.rootViewController = navController

// Push
class RootListViewController: UITableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.item = items[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
        // animated: true → Push 전환 애니메이션 (0.35s, appleEaseOut)
    }
}

// Pop
class DetailViewController: UIViewController {
    @IBAction func backAction() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}

// Navigation Bar 스타일 (iOS 26 Liquid Glass)
class DetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "상세 보기"
        navigationItem.largeTitleDisplayMode = .never // inline 강제

        // Trailing 버튼
        let editButton = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editTapped)
        )
        navigationItem.rightBarButtonItem = editButton

        // Back Button 레이블 커스텀
        navigationItem.backButtonTitle = "목록"
    }
}
```

### Navigation Bar 스타일 토큰

| 항목 | 값 | 색상 토큰 |
|------|-----|---------|
| 타이틀 색상 (Light) | `#000000` | `labels.primary.light` |
| 타이틀 색상 (Dark) | `#ffffff` | `labels.primary.dark` |
| 버튼 색상 (Accent) | `#0088ff` | `accents.blue.light` |
| 배경 (Liquid Glass) | 반투명 blur | `liquidGlass.frost.medium = 12pt` |
| Separator | `#c6c6c8` / `#38383a` | `separators.opaque` |
