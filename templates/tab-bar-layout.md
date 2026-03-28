# Tab Bar Layout Template

> **References**
> - Components: `../components/specs/tab-bar.md`
> - Tokens: `../tokens/spacing.json`, `../tokens/colors.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md` (Examples page: `0:3329`, Figma node: `3:70967`)
> - Parent: `../PLAN.md`

---

## 1. Overview

Tab Bar Layout은 앱의 최상위 네비게이션 구조를 제공한다. 화면 하단에 고정된 탭 바를 통해 앱의 주요 섹션 간을 빠르게 전환한다. iOS 26에서는 **Liquid Glass 인디케이터**가 선택된 탭 아이콘 위로 흘러다니듯 이동하는 새로운 시각적 언어를 도입했다.

**적용 대상**
- 앱의 최상위 네비게이션 구조 (2~5개 주요 섹션)
- 각 탭은 독립적인 Navigation Stack을 유지

**Tab Bar가 적합하지 않은 경우**
- 2개 이하 섹션 → Toggle/Segmented Control 사용
- 선형 플로우 (단계적 진행) → Navigation Stack만 사용
- 계층적으로 동등하지 않은 화면 → Sidebar 또는 Navigation Stack 사용

---

## 2. Tab Count Guidelines

| 탭 수 | 권장 여부 | 비고 |
|-------|----------|------|
| 2개 | 최소 (비권장) | Segmented Control 고려 |
| 3개 | 권장 (최적) | 균형 잡힌 레이아웃 |
| 4개 | 권장 | 가장 일반적 |
| **5개** | **최대 (권장)** | 아이콘이 좁아짐 |
| 6개 이상 | 금지 | "More" 탭 자동 생성 (섹션 7 참조) |

### 아이콘 크기 및 간격 (탭 수별)

```
3탭: [  Tab1  ] [  Tab2  ] [  Tab3  ]   아이콘 28pt, 간격 여유
4탭: [ Tab1 ] [ Tab2 ] [ Tab3 ] [ Tab4 ]  아이콘 25pt
5탭: [Tab1] [Tab2] [Tab3] [Tab4] [Tab5]   아이콘 25pt, 최소 간격
```

**탭 최소 폭**: `64pt` (`components.tabBar.itemMinWidth`)

---

## 3. Liquid Glass Indicator Animation Assembly

iOS 26의 핵심 시각 요소인 Liquid Glass 탭 인디케이터는 탭 이동 시 물방울처럼 흘러다니는 애니메이션을 제공한다.

### 인디케이터 구조

```
Tab Bar (height: 83pt with indicator):
┌─────────────────────────────────────────┐
│                                         │
│    ┌────────┐                           │
│    │ ~~~~~~ │  ← Liquid Glass Indicator │
│    │  [🏠]  │     backdrop-filter: blur(7pt)
│    │  Home  │     border-radius: 9999pt  │
│    └────────┘                           │
│      [🔍]         [📱]         [👤]     │
│    Search       Library       Profile   │
│                                         │
└─────────────────────────────────────────┘
```

### 인디케이터 치수

| 속성 | 값 | 토큰 |
|------|-----|------|
| 기본 폭 | ~64pt | `components.tabBar.itemMinWidth` |
| 기본 높이 | ~34pt | (Tab Bar height 차이) |
| Corner Radius | **9999pt** (full pill) | `radius.semantic.liquidGlass.small` |
| Frost Blur | **7pt** | `liquidGlass.frost.small` |

### Morphing 애니메이션 — 탭 이동 시

```
이동 방향 기준 인디케이터가 먼저 늘어났다가 스냅:

Tab1 → Tab3으로 이동 시 (오른쪽으로):

  0%:   [●────] Tab1에 위치, 64pt 폭
  40%:  [●──────────] 이동 방향으로 80pt 폭 늘어남 (stretched pill)
  100%: [────●] Tab3에 위치, 64pt 폭 복귀

border-radius: 9999pt 유지 → 항상 pill 형태
```

### 애니메이션 파라미터

| 항목 | 값 | 토큰 |
|------|-----|------|
| Duration | **0.45s** | `duration.semantic.liquidGlassTabIndicator` |
| Spring | `snappy` | `spring.presets.snappy` |
| CSS 근사 | `cubic-bezier(0.34, 1.56, 0.64, 1.0)` | `liquidGlass.tabIndicator.cssApprox` |
| 애니메이션 속성 | width, transform, border-radius, backdrop-filter | `liquidGlass.tabIndicator.properties` |

### CSS @keyframes 구현

```css
/* Liquid Glass Tab Indicator */
.tab-indicator {
    position: absolute;
    height: 34px;
    border-radius: 9999px;
    background: rgba(255, 255, 255, 0.25);
    backdrop-filter: blur(7px);
    -webkit-backdrop-filter: blur(7px);
    transition:
        width 0.45s cubic-bezier(0.34, 1.56, 0.64, 1.0),
        transform 0.45s cubic-bezier(0.34, 1.56, 0.64, 1.0),
        border-radius 0.45s cubic-bezier(0.34, 1.56, 0.64, 1.0);
    /* animations.json: css.tabIndicatorTransition */
}

/* 오른쪽으로 이동 시 stretch keyframe */
@keyframes liquid-tab-move-right {
    0%   { width: 64px; }
    40%  { width: 80px; border-radius: 9999px; }  /* 늘어남 */
    100% { width: 64px; }                           /* 복귀 */
}
```

### SwiftUI 구현 (iOS 26)

```swift
TabView(selection: $selectedTab) {
    // ...tabs...
}
.tabViewStyle(.sidebarAdaptable) // iOS 26: iPad에서 자동 Sidebar 전환
// Liquid Glass 인디케이터는 iOS 26 TabView에서 자동 적용
```

---

## 4. Badge 포지셔닝

Badge는 알림 수나 상태를 표시하는 작은 레이블이다.

### Badge 레이아웃

```
탭 아이콘 기준:
    ┌──────────────────┐
    │         ┌──────┐ │
    │    [🔔] │ 12   │ │  ← 숫자 뱃지: 빨간 원형
    │         └──────┘ │
    │    알림            │
    └──────────────────┘

아이콘 top-right 기준:
  x-offset: +8pt (아이콘 우측 밖)
  y-offset: -6pt (아이콘 위)
```

### Badge 크기 규칙

| 유형 | 크기 | 내용 |
|------|------|------|
| Dot Badge | 8×8pt | 빈 원 — 새 콘텐츠 있음을 표시 |
| Number Badge (1-9) | 18×18pt (원형) | 숫자 표시 |
| Number Badge (10-99) | 18×24pt (pill) | 두 자리 숫자 |
| Number Badge (100+) | 18×28pt | "99+" 표시 |

### Badge 색상

| 상태 | 색상 | 토큰 |
|------|------|------|
| 기본 (알림) | `#ff383c` | `accents.red.light` |
| 어두운 모드 | `#ff4245` | `accents.red.dark` |
| Badge 텍스트 | `#ffffff` | `grays.white` |

### UIKit Badge 설정

```swift
// UIKit
tabBarItem.badgeValue = "12"         // 숫자 뱃지
tabBarItem.badgeValue = ""           // Dot 뱃지 (빈 문자열)
tabBarItem.badgeValue = nil          // 뱃지 제거
tabBarItem.badgeColor = .systemRed   // 커스텀 색상

// SwiftUI
.badge(12)          // 숫자
.badge("신규")       // 텍스트
```

---

## 5. More Tab (5개 초과 시)

탭이 6개 이상일 때 iOS는 자동으로 마지막 탭을 "더 보기"(More)로 대체한다.

### 동작 방식

```
6개 탭 설정 시:
  Tab Bar에 표시: [Tab1] [Tab2] [Tab3] [Tab4] [더 보기 ···]
  "더 보기" 탭 탭하면 → UIMoreNavigationController (목록 화면)
    ├── Tab5
    └── Tab6

더 보기 화면:
  Navigation Bar + Table List
  각 항목: 탭 아이콘 + 탭 이름 + > 아이콘
  편집 버튼: 탭 순서 재배치 가능
```

### 설계 권장사항

- **6개 이상 탭이 필요하면 정보 구조 재검토** — 탭 통합 or Sidebar 전환 고려
- iOS 26에서는 Liquid Glass 인디케이터가 "더 보기" 탭에는 적용 불가
- 중요도 높은 탭을 앞 4개에 배치 (5번째는 "더 보기"로 숨겨지기 때문)

---

## 6. iPad Sidebar Transition

iPad에서는 Tab Bar가 Sidebar로 전환된다.

### 레이아웃 변화

```
iPhone (Portrait):
  ┌─────────────────┐
  │     Content     │
  │                 │
  ├─────────────────┤
  │[T1][T2][T3][T4] │  ← Tab Bar (하단)
  └─────────────────┘

iPad (Landscape):
  ┌──────┬──────────────────┐
  │ Tab1 │                  │
  │ Tab2 │    Content       │  ← Sidebar (왼쪽)
  │ Tab3 │                  │
  │ Tab4 │                  │
  └──────┴──────────────────┘
```

### 전환 조건

| 디바이스/방향 | 레이아웃 |
|-------------|---------|
| iPhone (모든 방향) | Tab Bar |
| iPad Portrait | Tab Bar |
| iPad Landscape | Sidebar |
| iPad Slide Over | Tab Bar |

### SwiftUI 구현 (iOS 18+)

```swift
TabView {
    Tab("홈", systemImage: "house") { HomeView() }
    Tab("검색", systemImage: "magnifyingglass") { SearchView() }
    Tab("라이브러리", systemImage: "square.stack") { LibraryView() }
    Tab("프로필", systemImage: "person") { ProfileView() }
}
.tabViewStyle(.sidebarAdaptable) // iPad에서 자동으로 Sidebar로 전환
```

---

## 7. SwiftUI TabView / UIKit UITabBarController

### SwiftUI TabView

```swift
struct AppTabView: View {
    @State private var selectedTab: Tab = .home

    enum Tab: Hashable {
        case home, search, library, profile
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            // 각 탭은 독립적인 NavigationStack 유지
            Tab("홈", systemImage: "house.fill", value: .home) {
                NavigationStack {
                    HomeView()
                        .navigationTitle("홈")
                }
            }
            .badge(3) // 뱃지

            Tab("검색", systemImage: "magnifyingglass", value: .search) {
                NavigationStack {
                    SearchView()
                        .navigationTitle("검색")
                }
            }

            Tab("라이브러리", systemImage: "square.stack.fill", value: .library) {
                NavigationStack {
                    LibraryView()
                        .navigationTitle("라이브러리")
                }
            }

            Tab("프로필", systemImage: "person.fill", value: .profile) {
                NavigationStack {
                    ProfileView()
                        .navigationTitle("프로필")
                }
            }
        }
        // iOS 26: iPad 자동 Sidebar 전환
        .tabViewStyle(.sidebarAdaptable)

        // Liquid Glass 인디케이터는 iOS 26에서 자동 적용
        // tabViewStyle 미지정 시 기본 .automatic
    }
}
```

### UIKit UITabBarController

```swift
class AppTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    private func setupTabs() {
        // 각 탭 NavigationController 생성
        let homeNav = makeNavController(
            root: HomeViewController(),
            title: "홈",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        let searchNav = makeNavController(
            root: SearchViewController(),
            title: "검색",
            image: UIImage(systemName: "magnifyingglass")
        )

        let libraryNav = makeNavController(
            root: LibraryViewController(),
            title: "라이브러리",
            image: UIImage(systemName: "square.stack"),
            selectedImage: UIImage(systemName: "square.stack.fill")
        )

        let profileNav = makeNavController(
            root: ProfileViewController(),
            title: "프로필",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )

        viewControllers = [homeNav, searchNav, libraryNav, profileNav]

        // 첫 번째 탭 뱃지
        homeNav.tabBarItem.badgeValue = "3"
        homeNav.tabBarItem.badgeColor = .systemRed // accents.red

        // iOS 26: Liquid Glass는 자동 적용
        // tabBar.scrollEdgeAppearance 설정 불필요 (시스템 처리)
    }

    private func makeNavController(
        root: UIViewController,
        title: String,
        image: UIImage?,
        selectedImage: UIImage? = nil
    ) -> UINavigationController {
        let nav = UINavigationController(rootViewController: root)
        nav.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        return nav
    }
}
```

### 핵심 토큰 요약

| 항목 | 값 | 토큰 경로 |
|------|-----|----------|
| Tab Bar 기본 높이 | **49pt** | `components.tabBar.height` |
| Tab Bar + Indicator 높이 | **83pt** | `components.tabBar.heightWithIndicator` |
| 탭 최소 폭 | **64pt** | `components.tabBar.itemMinWidth` |
| Indicator frost blur | **7pt** | `liquidGlass.frost.small` |
| Indicator corner radius | **9999pt** | `radius.semantic.liquidGlass.small` |
| Indicator 애니메이션 | **0.45s snappy** | `duration.semantic.liquidGlassTabIndicator` |
| 선택 탭 색 (Dark) | `#ffffff` | `miscellaneous.tabBarSelection.dark` |
| 미선택 탭 색 (Light) | `#999999` | `miscellaneous.tabUnselected.light` |
| 미선택 탭 색 (Dark) | `#7e7e7e` | `miscellaneous.tabUnselected.dark` |
| Safe Area 하단 (iPhone 16) | **34pt** | `safeArea.iphone16Pro.bottom` |
