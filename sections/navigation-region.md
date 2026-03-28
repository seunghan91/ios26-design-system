# Navigation Region — iOS 26 섹션 스펙

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="1:54472")`

---

## 개요

Navigation Region은 Status Bar 아래에 위치하는 화면 탐색 영역이다. iOS 26에서는 **Liquid Glass** 소재가 navigation bar 배경에 기본 적용되며, 스크롤에 따라 Large Title 모드(96pt)와 Standard(Inline) 모드(44pt) 사이에서 부드럽게 전환된다. 탭바 기반 앱의 경우 각 탭마다 독립적인 navigation stack을 유지한다.

### iOS 26 주요 변경

- **Liquid Glass 기본 적용**: navigation bar 배경이 frosted-glass 소재로 변경. `UINavigationBarAppearance`를 명시하지 않아도 자동 적용.
- **Large Title collapse 개선**: spring 애니메이션으로 더 자연스러운 축소/확장.
- **Search Bar 통합**: 기본적으로 toolbar 아래 inline으로 표시, 스크롤 시 navigation bar 내로 수납.

---

## 치수 (pt 값)

### iPhone — Top Navigation Bar

| 상태 | 높이 | 콘텐츠 영역 | 비고 |
|------|------|------------|------|
| Standard (Inline) | **44pt** | 타이틀 + 좌우 버튼 | 스크롤 후 축소 상태 |
| Large Title (expanded) | **96pt** | Large Title (34pt) + 하단 버튼 영역 | 스크롤 상단 도달 시 |
| Large Title + Search Bar | **96pt + 44pt** = **140pt** | Large Title + 검색바 inline | `searchController` 통합 시 |
| Hidden | **0pt** | — | `.navigationBarHidden(true)` |

> `spacing.json` → `components.navigationBar.height = 44`, `largeTitleHeight = 96`

```
[Standard 44pt]
┌─────────────────────────────────────────┐  ← status bar 하단
│ ← Back       타이틀          ⋮  ✏︎  │  44pt
└─────────────────────────────────────────┘

[Large Title 96pt]
┌─────────────────────────────────────────┐  ← status bar 하단
│                              Edit       │  44pt (상단 버튼 영역)
│                                         │
│  대제목                                  │  34pt (Large Title)
│                              ────────  │  나머지 여백
└─────────────────────────────────────────┘
```

### iPad — Top Navigation Bar

| 상태 | 높이 | 비고 |
|------|------|------|
| Standard | **50pt** | iPhone보다 약간 큼 |
| Large Title | **96pt** | 동일 |
| Horizontal compact (Split View) | **44pt** | iPhone과 동일 |

> `spacing.json` → `contentMargin.ipad.horizontal = 20`

### Navigation Bar 내부 여백

| 요소 | 값 |
|------|-----|
| 좌우 padding (horizontal) | **16pt** (iPhone), **20pt** (iPad) |
| 버튼 최소 터치 영역 | **44×44pt** |
| 버튼 간격 | **8pt** (인접 버튼 사이) |
| 타이틀 좌우 margin (inline) | 버튼 영역 확보 후 나머지 |
| Large Title 하단 padding | **8pt** |
| Large Title font size | **34pt** (Bold) → `typography.styles.largeTitle` |
| Inline title font size | **17pt** (Semibold) → `typography.styles.headline` |

---

## 색상 / Material 규칙

### Liquid Glass — Navigation Bar

| 속성 | 값 | 토큰 경로 |
|------|-----|----------|
| 배경 소재 | `ultraThinMaterial` + refraction | `materials.json` |
| blur | **12px** (medium frost) | `spacing.json → liquidGlass.frost.medium = 12` |
| depth | **16pt** | `spacing.json → liquidGlass.depth = 16` |
| splay | **6°** | `spacing.json → liquidGlass.splay = 6` |
| refraction | **100** | `spacing.json → liquidGlass.refraction = 100` |

### 색상 토큰 — 타이틀 / 버튼

| 요소 | Light 토큰 | Dark 토큰 |
|------|-----------|----------|
| Navigation title | `colors.labels.primary.light` (#000) | `colors.labels.primary.dark` (#fff) |
| Back button tint | `colors.accents.blue.light` (#0088ff) | `colors.accents.blue.dark` (#0091ff) |
| Bar button items | `colors.accents.blue.light` | `colors.accents.blue.dark` |
| Large Title | `colors.labels.primary.light` | `colors.labels.primary.dark` |
| 구분선 (separator) | `colors.separators.opaque.light` | `colors.separators.opaque.dark` |

### 투명도 모드별 배경

| 모드 | 배경 |
|------|------|
| Standard (scrolled) | Liquid Glass (`ultraThinMaterial`) |
| Large Title (top of scroll) | 투명 (content가 바로 뒤에 있음) |
| `scrollEdgeAppearance` 미설정 | 스크롤 상단에서 투명, 스크롤 시 Liquid Glass |
| `.clear` 명시 | 항상 투명 |
| `.opaque` 명시 | `colors.backgrounds.primary` |

---

## 동작 / 애니메이션

### Large Title Collapse

```
스크롤 위치: y=0 (상단)
  Navigation bar: 96pt (Large Title 표시)
  Status bar: 투명/lightContent (콘텐츠 색상에 따라)

스크롤: y > threshold (~44pt)
  Large Title: opacity 0으로 페이드아웃 + scale 0.85
  Inline title: opacity 1로 페이드인
  Navigation bar: 96pt → 44pt 높이 축소 (spring)
  Liquid Glass blur: 강도 증가 (0 → 12px)
```

**Spring 파라미터 (Large Title collapse)**

| 파라미터 | 값 |
|---------|-----|
| stiffness | 300 |
| damping | 40 |
| initialVelocity | 스크롤 velocity에 연동 |
| 전환 거리 | ~44pt scroll offset |

### 화면 전환 (Push / Pop)

| 전환 | 애니메이션 |
|------|----------|
| Push | 새 화면 오른쪽에서 슬라이드인 (0.35s, ease-out) |
| Pop | 현재 화면 오른쪽으로 슬라이드아웃 |
| Pop gesture | 왼쪽 엣지 스와이프, interactive |
| Modal present | 아래에서 위로 슬라이드 (0.4s, spring) |

### Back 버튼 동작

- 이전 화면 타이틀이 10자 이하: 이전 화면 타이틀 표시 (`← 설정`)
- 이전 화면 타이틀이 10자 초과: `← Back` 표시
- `navigationItem.backButtonTitle = ""`: 텍스트 없이 화살표만 표시
- `navigationItem.backButtonDisplayMode = .minimal`: 항상 화살표만

### Search Bar 통합 동작

```
1. Large Title 상태: Search Bar가 navigation bar 아래 별도 행 (44pt)
   → 총 140pt (96+44)
2. 스크롤 다운: Search Bar가 navigation bar 안으로 수납
   → 44pt
3. Search Bar 탭: 키보드 올라옴, Cancel 버튼 표시
4. 스크롤 상단 복귀: Search Bar 다시 확장
```

---

## Accessibility

| 항목 | 규칙 |
|------|------|
| 버튼 최소 터치 영역 | **44×44pt** — `spacing.json → components.touchTarget.minimum = 44` |
| VoiceOver Back 버튼 | `accessibilityLabel = "뒤로 가기"` (자동 설정) |
| Large Title Dynamic Type | 지원. 시스템 텍스트 크기 설정에 따라 자동 조절 |
| Reduce Motion | Large Title collapse 애니메이션 축소 (crossfade로 대체) |
| Contrast | Liquid Glass 위 텍스트: 자동 대비 조정. 직접 색상 지정 시 4.5:1 이상 보장 |
| 포커스 이동 | navigation push 시 새 화면 첫 요소로 VoiceOver 포커스 자동 이동 |

---

## 프레임워크별 구현

### UIKit

```swift
// 기본 Navigation Controller 설정
let navController = UINavigationController(rootViewController: rootVC)

// Large Title 활성화 (전체)
navController.navigationBar.prefersLargeTitles = true

// 특정 VC에서만 Large Title
viewController.navigationItem.largeTitleDisplayMode = .always   // 항상
viewController.navigationItem.largeTitleDisplayMode = .never    // 항상 숨김
viewController.navigationItem.largeTitleDisplayMode = .automatic // 부모 설정 따름

// iOS 26 Liquid Glass — 기본값으로 자동 적용
// 기존 UINavigationBarAppearance 커스텀 시 주의
let appearance = UINavigationBarAppearance()
appearance.configureWithDefaultBackground()  // Liquid Glass 유지
// appearance.configureWithTransparentBackground()  // 투명
// appearance.configureWithOpaqueBackground()       // 불투명

navController.navigationBar.standardAppearance = appearance
navController.navigationBar.scrollEdgeAppearance = appearance  // 스크롤 상단
navController.navigationBar.compactAppearance = appearance     // 가로모드

// Back 버튼 커스텀
navigationItem.backButtonTitle = "이전"   // 텍스트 변경
navigationItem.backButtonDisplayMode = .minimal  // 아이콘만

// Search Controller 통합
let searchController = UISearchController(searchResultsController: nil)
searchController.searchResultsUpdater = self
navigationItem.searchController = searchController
navigationItem.hidesSearchBarWhenScrolling = true  // 기본 true
```

```swift
// 우상단 버튼
let editButton = UIBarButtonItem(
    title: "편집",
    style: .plain,
    target: self,
    action: #selector(editTapped)
)
navigationItem.rightBarButtonItem = editButton

// SF Symbol 버튼
let addButton = UIBarButtonItem(
    image: UIImage(systemName: "plus"),
    style: .plain,
    target: self,
    action: #selector(addTapped)
)
```

### SwiftUI

```swift
struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(items) { item in
                NavigationLink(item.title, value: item)
            }
            .navigationTitle("받은 편지함")                // Large Title
            .navigationBarTitleDisplayMode(.large)         // .large / .inline / .automatic
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addItem) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            // iOS 26 Liquid Glass 소재 명시적 설정
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)

            // Search 통합
            .searchable(text: $searchText, placement: .navigationBarDrawer)
        }
        .navigationDestination(for: Item.self) { item in
            ItemDetailView(item: item)
        }
    }
}

// Back 버튼 타이틀 커스텀
struct DetailView: View {
    var body: some View {
        Text("Detail")
            .navigationTitle("상세")
            .navigationBarBackButtonHidden(false)
            // Back 버튼 완전 커스텀
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("이전") { dismiss() }
                }
            }
    }
}
```

### Flutter (Navigator 2.0 / GoRouter)

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// iOS 스타일 Navigation (CupertinoNavigationBar)
CupertinoPageScaffold(
  navigationBar: const CupertinoNavigationBar(
    middle: Text('타이틀'),
    leading: CupertinoNavigationBarBackButton(),
    trailing: CupertinoButton(
      padding: EdgeInsets.zero,
      child: Icon(CupertinoIcons.add),
      onPressed: null,
    ),
    // iOS 26: Liquid Glass 근사
    backgroundColor: CupertinoColors.systemBackground,
    border: null,  // 하단 구분선 제거
  ),
  child: SafeArea(child: content),
)

// Large Title 스타일 (Cupertino)
CustomScrollView(
  slivers: [
    CupertinoSliverNavigationBar(
      largeTitle: const Text('받은 편지함'),
      trailing: CupertinoButton(
        padding: EdgeInsets.zero,
        child: const Icon(CupertinoIcons.add),
        onPressed: null,
      ),
    ),
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(title: Text('항목 $index')),
        childCount: 50,
      ),
    ),
  ],
)
```

```dart
// GoRouter와 Navigation Region
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'detail/:id',
          builder: (context, state) => DetailScreen(
            id: state.pathParameters['id']!,
          ),
        ),
      ],
    ),
  ],
);

// Back 버튼 커스텀
AppBar(
  leading: BackButton(
    onPressed: () => context.pop(),
  ),
  title: const Text('상세'),
)
```

### CSS / Svelte (웹 근사치)

```svelte
<!-- NavigationBar.svelte — iOS 26 스타일 근사 -->
<script lang="ts">
  import { onMount } from 'svelte';

  export let title: string = '';
  export let largeTitle: boolean = true;
  export let backLabel: string = '뒤로';
  export let onBack: (() => void) | null = null;

  let scrollY = 0;
  let isCollapsed = false;

  $: isCollapsed = scrollY > 44;

  onMount(() => {
    const handler = () => { scrollY = window.scrollY; };
    window.addEventListener('scroll', handler, { passive: true });
    return () => window.removeEventListener('scroll', handler);
  });
</script>

<header
  class="navigation-bar"
  class:collapsed={isCollapsed}
  class:large-title={largeTitle && !isCollapsed}
>
  <!-- Status bar 높이만큼 상단 여백 (CSS env 변수) -->
  <div class="status-bar-spacer" />

  <div class="nav-content">
    {#if onBack}
      <button class="back-btn" on:click={onBack}>
        <svg><!-- chevron --></svg>
        <span>{backLabel}</span>
      </button>
    {/if}

    <h1 class="title" class:inline={isCollapsed}>{title}</h1>

    <div class="trailing-items">
      <slot name="trailing" />
    </div>
  </div>

  {#if largeTitle && !isCollapsed}
    <div class="large-title-row">
      <h1 class="large-title-text">{title}</h1>
    </div>
  {/if}
</header>

<style>
  .navigation-bar {
    position: sticky;
    top: 0;
    z-index: 100;
    /* Liquid Glass 근사 */
    background: rgba(255, 255, 255, 0.72);
    backdrop-filter: blur(12px) saturate(180%);
    -webkit-backdrop-filter: blur(12px) saturate(180%);
    transition: height 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }

  @media (prefers-color-scheme: dark) {
    .navigation-bar {
      background: rgba(28, 28, 30, 0.72);
    }
  }

  .status-bar-spacer {
    height: env(safe-area-inset-top, 54px);
  }

  .nav-content {
    display: flex;
    align-items: center;
    height: 44px;
    padding: 0 16px;
    gap: 8px;
  }

  .back-btn {
    display: flex;
    align-items: center;
    gap: 4px;
    color: #0088ff;
    font-size: 17px;
    min-width: 44px;
    min-height: 44px;
    background: none;
    border: none;
    cursor: pointer;
  }

  .large-title-text {
    font-size: 34px;
    font-weight: 700;
    letter-spacing: 0.4px;
    padding: 0 16px 8px;
    margin: 0;
  }

  .title.inline {
    font-size: 17px;
    font-weight: 600;
    flex: 1;
    text-align: center;
  }

  /* Large Title 상태: h=96pt, Standard: h=44pt */
  .navigation-bar.collapsed {
    /* 44pt만 */
  }

  .navigation-bar.large-title {
    /* 96pt */
  }
</style>
```

---

## 연관 섹션 / 컴포넌트

- **Status Bar** (`status-bar.md`): Navigation Region 위 54pt
- **Content Region** (`content-region.md`): Navigation Region 아래 시작점
- **Toolbar 컴포넌트** (`../components/specs/toolbar.md`): Figma 원본 스펙 (Node `1:54472`)
- **Tab Bar 컴포넌트** (`../components/specs/tab-bar.md`): 하단 탭바와의 조합

---

## Safe Area + Navigation Region 합산 높이

| 기기 | Status Bar | Nav Bar (standard) | 총 Top offset | Nav Bar (large title) | 총 Top offset |
|------|-----------|-------------------|--------------|----------------------|--------------|
| iPhone 16 Pro | 54pt | 44pt | **98pt** | 96pt | **150pt** |
| iPhone SE | 20pt | 44pt | **64pt** | 96pt | **116pt** |
| iPad | 24pt | 50pt | **74pt** | 96pt | **120pt** |
