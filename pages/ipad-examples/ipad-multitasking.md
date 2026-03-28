# iPad Multitasking — iOS 26 iPad 페이지 레시피

> **References**
> - Templates: `../../templates/`
> - Components: `../../components/specs/`
> - Tokens: `../../tokens/`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="...")`

---

## 화면 개요

iPad Multitasking은 iPadOS에서 여러 앱 또는 동일 앱의 여러 인스턴스를 동시에 화면에 표시하는 기능이다. Split View(두 앱 나란히)와 Slide Over(플로팅 패널)로 구성된다. 앱이 받는 실제 `UIWindow` 너비가 줄어들기 때문에, 각 너비에서 올바른 레이아웃을 제공해야 한다.

| 기능 | 설명 |
|------|------|
| **Split View** | 두 앱을 1/3–2/3 또는 1/2–1/2 비율로 나란히 표시 |
| **Slide Over** | 다른 앱 위에 320pt 폭 플로팅 패널로 표시 |
| **Stage Manager** | 앱 윈도우를 자유 크기로 배치 (iPadOS 16+) |
| **최소 지원 너비** | 320pt (Slide Over 최솟값) |

---

## iPad 레이아웃 규칙 (pt 치수)

### 기기별 전체 화면 너비
```
iPad Pro 12.9" (M4)  : 1024pt (landscape) / 768pt (portrait)
iPad Pro 11"  (M4)   :  834pt (landscape) / 834pt (portrait — 정사각형에 가까움)
iPad Air 11"          :  820pt (landscape) / 820pt (portrait)
iPad mini 6           :  744pt (landscape) / 744pt (portrait)
iPad (10세대)          :  820pt (landscape) / 820pt (portrait)
```

### Split View 분할 비율별 앱 너비

#### iPad Pro 12.9" (landscape 1024pt)
```
레이아웃       앱 A 너비   앱 B 너비   Size Class (A/B)
─────────────────────────────────────────────────────
Full Width     1024pt       —           regular / —
2/3 + 1/3      683pt      341pt        regular / compact
1/2 + 1/2      512pt      512pt        regular / regular
1/3 + 2/3      341pt      683pt        compact / regular
Slide Over     704pt      320pt (float) regular / compact
```

#### iPad Air / iPad (11", 820pt landscape)
```
레이아웃       앱 A 너비   앱 B 너비   Size Class (A/B)
─────────────────────────────────────────────────────
Full Width      820pt       —           regular / —
2/3 + 1/3       547pt      273pt        regular / compact
1/2 + 1/2       410pt      410pt        compact / compact  ← 둘 다 compact!
1/3 + 2/3       273pt      547pt        compact / regular
Slide Over      500pt      320pt (float) compact / compact
```

#### iPad mini (744pt landscape)
```
레이아웃       앱 A 너비   앱 B 너비   Size Class (A/B)
─────────────────────────────────────────────────────
Full Width      744pt       —           regular / —
2/3 + 1/3       496pt      248pt        regular / compact
1/2 + 1/2       372pt      372pt        compact / compact
Slide Over      424pt      320pt (float) compact / compact
```

### Compact 전환 임계값 (HIG 기준)
```
앱 너비 > 438pt → horizontal: regular
앱 너비 ≤ 438pt → horizontal: compact
```

### Safe Area 변화 (Multitasking 상태)
```
Full Width (landscape):
  top    : 24pt
  left   : 0pt (Home 버튼 없는 모델) / 20pt (Home 버튼 모델)
  right  : 0pt
  bottom : 20pt (제스처 바)

Split View (구분선 인접 앱):
  구분선 방향 safe area : 0pt (구분선 자체가 separator 역할)
  반대쪽                : 0pt 또는 기기 곡면 inset

Slide Over (플로팅 앱):
  top    : 8pt  (핸들 영역)
  left   : 8pt
  right  : 8pt
  bottom : 8pt  + gesture area
  cornerRadius: 20pt (앱 컨테이너)
```

---

## 컴포넌트 계층 (ASCII 와이어프레임)

### Full Width — 기본 상태
```
┌──────────────────────────────────────────────────────────────────────────┐
│                        STATUS BAR (24pt)                                  │
├──────────────────────────────────────────────────────────────────────────┤
│  TOOLBAR-TOP                                              ••• (멀티태스킹) │
│  [< Back]   [화면 제목]                      [검색] [편집] │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  CONTENT AREA (1024pt 전체 너비)                                          │
│  ┌─────────────────────────────────────────────────────────────────────┐ │
│  │  [카드] [카드] [카드] [카드]  ← 4열 그리드 (regular)                │ │
│  │  [카드] [카드] [카드] [카드]                                        │ │
│  └─────────────────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────────────────┘
```

### Split View 2/3 + 1/3 (iPad Pro 12.9" landscape)
```
┌─────────────────────────────────────────────┬───────────────────────────┐
│  앱 A (683pt — regular)                      │  앱 B (341pt — compact)   │
├─────────────────────────────────────────────┼───────────────────────────┤
│  TOOLBAR-TOP (앱 A)                          │  TOOLBAR-TOP (앱 B)       │
│  [< Back]  [Title]           [+] [•••]      │  [Title]           [+]    │
├─────────────────────────────────────────────┼───────────────────────────┤
│                                             │ │                         │
│  CONTENT AREA (regular 레이아웃)             │ │  CONTENT AREA           │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐    │ │  (compact 레이아웃)      │
│  │  카드 1  │ │  카드 2  │ │  카드 3  │    │ │  ┌────────────────────┐ │
│  └──────────┘ └──────────┘ └──────────┘    │ │  │  List Row 1        │ │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐    │ │  │  List Row 2        │ │
│  │  카드 4  │ │  카드 5  │ │  카드 6  │    │ │  │  List Row 3        │ │
│  └──────────┘ └──────────┘ └──────────┘    │ │  │  List Row 4        │ │
│                                             │ │  └────────────────────┘ │
│  ← 3열 그리드 유지 (regular)                 │ │  ← 1열 리스트 (compact) │
│                                             │ │                         │
└─────────────────────────────────────────────┴───────────────────────────┘
                                               ↑ 드래그 핸들 (divider)
```

### Split View 1/2 + 1/2 (iPad Air 11" — 둘 다 compact)
```
┌─────────────────────────────────┬─────────────────────────────────┐
│  앱 A (410pt — compact)          │  앱 B (410pt — compact)          │
├─────────────────────────────────┼─────────────────────────────────┤
│  TOOLBAR-TOP (compact 스타일)    │  TOOLBAR-TOP (compact 스타일)    │
│  [< Back]  [Title]      [+]     │  [< Back]  [Title]      [+]     │
├─────────────────────────────────┼─────────────────────────────────┤
│                                 │ │                                │
│  CONTENT AREA (compact)         │ │  CONTENT AREA (compact)        │
│  iPhone 레이아웃과 동일          │ │  iPhone 레이아웃과 동일         │
│  ┌────────────────────────────┐ │ │  ┌───────────────────────────┐ │
│  │  List Row (full-width)     │ │ │  │  List Row (full-width)    │ │
│  │  List Row                  │ │ │  │  List Row                 │ │
│  │  List Row                  │ │ │  │  List Row                 │ │
│  └────────────────────────────┘ │ │  └───────────────────────────┘ │
│                                 │ │                                │
└─────────────────────────────────┴─────────────────────────────────┘
  ※ 두 앱 모두 compact → iPhone UI 그대로 표시 (Split View 비활성화도 고려)
```

### Slide Over (플로팅 패널)
```
┌──────────────────────────────────────────────────────────────────────────┐
│  배경 앱 (500pt — compact, 이벤트 차단 없음)       ┌──────────────────┐  │
│                                                   │▬  (드래그 핸들)  │  │
│  CONTENT AREA (배경, 상호작용 가능)                │                  │  │
│  ┌────────────────────────────────────────────┐  │  SLIDE OVER 앱   │  │
│  │  배경 앱 콘텐츠                              │  │  (320pt × 전체)  │  │
│  │  (어둡지 않음, 완전히 상호작용 가능)           │  │                  │  │
│  │                                            │  │  TOOLBAR         │  │
│  │                                            │  │  [Title]  [+]    │  │
│  │                                            │  │  ──────────────  │  │
│  │                                            │  │  List Row 1      │  │
│  │                                            │  │  List Row 2      │  │
│  └────────────────────────────────────────────┘  │  List Row 3      │  │
│                                                   │                  │  │
│                                                   │  (compact UI)    │  │
│                                                   └──────────────────┘  │
│                                                   ← 320pt →             │
│                                     ← 배경 앱 width (500pt) →           │
└──────────────────────────────────────────────────────────────────────────┘
```

### Slide Over — 최소 너비 상태 (320pt)
```
┌────────────────────────────────┐
│ ▬                              │  ← 드래그 핸들 (8pt 높이)
├────────────────────────────────┤
│  STATUS BAR (투명 오버레이)     │
├────────────────────────────────┤
│  TOOLBAR (compact 최소 스타일) │
│  [≡]  [Title]            [+]  │  ← Navigation 버튼 최소화
├────────────────────────────────┤
│  CONTENT AREA                 │
│  ┌──────────────────────────┐ │
│  │  [Icon]  제목            │ │  ← List Row (최소 44pt 높이)
│  │  [Icon]  제목            │ │
│  │  [Icon]  제목            │ │
│  └──────────────────────────┘ │
│  (320pt 이하 UI 절대 금지)     │
└────────────────────────────────┘
   ← 320pt →
```

---

## iPhone vs iPad 분기 처리

| 레이아웃 | Size Class | 대응 전략 |
|---------|-----------|----------|
| Full Width (1024pt) | regular | 최대 4열 그리드, 넓은 사이드바 |
| 2/3 Split (683pt) | regular | 3열 그리드, 표준 사이드바 |
| 1/2 Split 12.9" (512pt) | regular | 2열 그리드, 좁은 사이드바 |
| 1/2 Split 11" (410pt) | compact | iPhone 레이아웃 (1열) |
| 1/3 Split (341pt) | compact | iPhone 레이아웃, 사이드바 collapse |
| Slide Over (320pt) | compact | iPhone 최소 레이아웃 |
| iPhone portrait | compact | 기본 iPhone 레이아웃 |

---

## 각 레이아웃별 컴포넌트 크기 변화 규칙

### Toolbar (상단)
```
regular (>438pt):
  height        : 52pt
  title         : 17pt semibold (Inline) / 34pt bold (Large Title)
  button 영역   : 우측 최대 3개 버튼 표시
  search bar    : toolbar 내 또는 별도 행

compact (≤438pt):
  height        : 44pt
  title         : 17pt semibold (항상 Inline)
  button 영역   : 우측 최대 2개 버튼, 나머지 ••• 으로 묶기
  search bar    : scroll-reveal 방식 권장
```

### Grid / Collection View
```
앱 너비별 권장 열 수 (아이템 최소 너비 150pt 기준):
  1024pt → 최대 6열 (단, UX 고려 4-5열 적정)
  683pt  → 4열
  512pt  → 3열
  410pt  → 2열
  375pt  → 2열 (iPhone Max landscape 포함)
  320pt  → 1열 (Slide Over, iPhone SE)

구현 (UICollectionView compositional layout):
  let count = max(1, Int(availableWidth / 160))
  // availableWidth = bounds.width - horizontalInsets
```

### Navigation (사이드바 / 스택)
```
regular + width > 600pt:
  NavigationSplitView (사이드바 + 디테일)

regular + width 438~600pt:
  NavigationSplitView (컬럼 auto-collapse 허용)

compact (≤438pt):
  NavigationStack (풀스택 push/pop)
```

### Tab Bar
```
regular (iPad 가로):
  TabView → 자동으로 Sidebar 스타일로 표시 (iPadOS 18+)
  사이드바 너비: 240pt (기본)

compact:
  TabView → 하단 Tab Bar 스타일
  높이: 83pt (iPhone 기준)
```

### Font Size 조정 (Dynamic Type 별도)
```
regular일 때 텍스트 크기 증가는 금지 (Dynamic Type만 사용)
대신 레이아웃 여백/간격을 더 넓게:
  compact: horizontalPadding = 16pt
  regular: horizontalPadding = 24pt (최대 32pt)

섹션 헤더:
  compact: 12pt uppercase secondary
  regular: 13pt (소문자 허용)
```

---

## 애니메이션 시나리오

### 1. Full Width → Split View 진입
```
Trigger  : 멀티태스킹 핸들 드래그
Duration : 0.4s
Curve    : spring(mass: 1, stiffness: 300, damping: 35)

앱 컨테이너:
  width: 1024pt → 683pt (또는 선택 비율)

콘텐츠 재레이아웃:
  그리드 열: 4 → 3 (트랜지션 없이 즉시, 또는 crossfade 0.2s)

내부 콘텐츠 위치:
  스크롤 offset 유지 (position restoration)
```

### 2. Slide Over 등장
```
Trigger  : 화면 오른쪽 엣지에서 좌로 스와이프
Duration : 0.38s
Curve    : spring(damping: 0.85)

Slide Over 패널:
  translateX: 320pt → 0pt (오른쪽에서 슬라이드인)

배경 앱:
  width: 820pt → 500pt (좌측으로 밀림)
  (단, 배경 앱 콘텐츠는 re-layout 발생)
```

### 3. Slide Over ↔ Split View 전환
```
Slide Over 위치에서 드래그 핸들 길게 탭 → Split View 전환 제안
또는 드래그로 위치 고정

Slide Over → Split View:
  패널 width: 320 → 341pt (또는 선택 비율)
  패널 cornerRadius: 20pt → 0pt
  duration: 0.3s easeInOut

Split View → Slide Over:
  반대 방향
```

### 4. Size Class 전환 시 레이아웃 재계산
```
regular → compact (예: 앱 너비 510→400pt 로 줄어들 때):
  1. traitCollectionDidChange 호출
  2. 사이드바 collapse (0.35s spring)
  3. 그리드 열 수 재계산 (즉시, 또는 crossfade)
  4. Toolbar 재구성 (compact 버튼 배치)
  5. 스크롤 offset 복원 시도

compact → regular:
  1. 사이드바 expand (0.35s spring)
  2. 그리드 열 증가 (새 레이아웃으로 crossfade 0.2s)
```

---

## 프레임워크별 구현

### UIKit — 너비 변화 대응
```swift
// UIViewController에서 size class 및 너비 변화 감지
class AdaptiveViewController: UIViewController {

    var columnCount: Int = 2

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateLayoutForWidth(view.bounds.width)
    }

    override func traitCollectionDidChange(
        _ previousTraitCollection: UITraitCollection?
    ) {
        super.traitCollectionDidChange(previousTraitCollection)
        let isRegular = traitCollection.horizontalSizeClass == .regular
        updateNavigationStyle(isRegular: isRegular)
    }

    private func updateLayoutForWidth(_ width: CGFloat) {
        let newColumnCount: Int
        switch width {
        case 600...:    newColumnCount = 4
        case 450..<600: newColumnCount = 3
        case 350..<450: newColumnCount = 2
        default:        newColumnCount = 1
        }

        guard newColumnCount != columnCount else { return }
        columnCount = newColumnCount

        // Compositional Layout 재생성
        collectionView.setCollectionViewLayout(
            makeLayout(columns: columnCount),
            animated: true
        )
    }

    private func makeLayout(columns: Int) -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / CGFloat(columns)),
            heightDimension: .fractionalWidth(1.0 / CGFloat(columns))
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 8, leading: 8, bottom: 8, trailing: 8
        )
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0 / CGFloat(columns))
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize, subitem: item, count: columns
        )
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }

    private func updateNavigationStyle(isRegular: Bool) {
        navigationItem.largeTitleDisplayMode = isRegular ? .automatic : .never
    }
}
```

### SwiftUI — NavigationSplitView + 동적 그리드
```swift
// iOS 26 / SwiftUI
struct AdaptiveGridView: View {
    @Environment(\.horizontalSizeClass) var hSizeClass
    private let minItemWidth: CGFloat = 150

    var body: some View {
        GeometryReader { geo in
            let columns = max(1, Int(geo.size.width / minItemWidth))
            let gridColumns = Array(
                repeating: GridItem(.flexible(), spacing: 12),
                count: columns
            )

            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: 12) {
                    ForEach(items) { item in
                        ItemCard(item: item)
                    }
                }
                .padding(.horizontal, hSizeClass == .regular ? 24 : 16)
            }
        }
    }
}

// NavigationSplitView with size class awareness
struct RootAdaptiveView: View {
    @Environment(\.horizontalSizeClass) var hSizeClass
    @State private var selectedItem: Item?

    var body: some View {
        if hSizeClass == .regular {
            NavigationSplitView {
                SidebarView(selection: $selectedItem)
                    .navigationSplitViewColumnWidth(min: 280, ideal: 320, max: 380)
            } detail: {
                if let item = selectedItem {
                    DetailView(item: item)
                } else {
                    ContentUnavailableView(
                        "항목을 선택하세요",
                        systemImage: "rectangle.split.2x1"
                    )
                }
            }
        } else {
            NavigationStack {
                MasterListView()
            }
        }
    }
}
```

### Flutter — LayoutBuilder + Adaptive Scaffold
```dart
// flutter_adaptive_scaffold 패키지 + LayoutBuilder 조합
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

class MultitaskingAwareScreen extends StatelessWidget {
  const MultitaskingAwareScreen({super.key});

  static const double _compactThreshold = 600.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isCompact = width < _compactThreshold;

        // 열 수 동적 계산
        final columnCount = _calculateColumns(width);

        return Scaffold(
          appBar: _buildAppBar(context, isCompact),
          // Slide Over 최소 너비(320pt) 보장
          body: width >= 320
              ? _buildContent(columnCount, isCompact)
              : const MinWidthFallbackWidget(),
        );
      },
    );
  }

  int _calculateColumns(double width) {
    if (width >= 1000) return 5;
    if (width >= 700) return 4;
    if (width >= 500) return 3;
    if (width >= 360) return 2;
    return 1;
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, bool isCompact) {
    return AppBar(
      title: const Text('콘텐츠'),
      // compact에서는 버튼 최소화
      actions: isCompact
          ? [
              IconButton(icon: const Icon(Icons.add), onPressed: () {}),
              IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
            ]
          : [
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
              IconButton(icon: const Icon(Icons.add), onPressed: () {}),
              IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
            ],
    );
  }

  Widget _buildContent(int columns, bool isCompact) {
    return GridView.builder(
      padding: EdgeInsets.all(isCompact ? 16.0 : 24.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (_, i) => ItemCard(index: i),
      itemCount: 20,
    );
  }
}
```

---

## 최소 너비 320pt 보장 체크리스트

앱이 320pt 이하로 줄어드는 일은 없지만, 정확히 320pt(Slide Over 최솟값)에서도 동작해야 한다.

```
✅ 모든 텍스트가 320pt 너비에서 잘리지 않음
✅ 버튼 터치 영역 최소 44×44pt 유지
✅ 수평 padding 16pt × 2 = 32pt → 콘텐츠 영역 288pt 이상 확보
✅ 1열 그리드 또는 full-width 리스트로 전환
✅ 툴바 버튼 ≤ 2개 (나머지 ••• 메뉴로)
✅ Large Title 비활성화 (Inline only)
✅ 검색창: 별도 행 or 스크롤 reveal
✅ Split View 사이드바 자동 collapse
```

---

## 토큰 참조

| 토큰 | 값 | 용도 |
|------|-----|------|
| `multitask.minWidth` | 320pt | Slide Over 최소 너비 |
| `multitask.compactThreshold` | 438pt | regular/compact 전환 기준 |
| `multitask.sidebarWidth` | 320pt | Split View Primary Column |
| `grid.minItemWidth` | 150pt | 열 수 자동 계산 기준 |
| `padding.compact` | 16pt | compact 수평 패딩 |
| `padding.regular` | 24pt | regular 수평 패딩 |
| `animation.splitEnter` | 0.4s spring | Split View 진입 |
| `animation.slideOverSlide` | 0.38s spring | Slide Over 슬라이드인 |
| `animation.layoutTransition` | 0.2s crossfade | 그리드 열 변경 |
| `slideOver.cornerRadius` | 20pt | Slide Over 패널 |
| `toolbar.height.regular` | 52pt | regular toolbar |
| `toolbar.height.compact` | 44pt | compact toolbar |
