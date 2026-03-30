# Content Region — iOS 26 섹션 스펙

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:25993")`

---

## 개요

Content Region은 Navigation Region 아래부터 Tab Bar / Home Indicator 위까지, 실제 앱 콘텐츠가 표시되는 영역이다. iOS 26에서는 **scroll edge effect** (스크롤 시 콘텐츠가 navigation bar와 자연스럽게 블렌딩되는 효과)가 기본 적용되며, Safe Area inset을 올바르게 처리하는 것이 핵심이다.

### 주요 특성

- **사용 가능 영역**: 전체 화면 높이 - Status Bar - Navigation Bar - Tab Bar - Home Indicator
- **기본 배경**: `colors.backgrounds.primary` (light: #ffffff, dark: #000000)
- **Grouped 스타일**: `colors.backgroundsGrouped.primary` (light: #f2f2f7, dark: #000000)
- **스크롤 오버슈팅**: iOS 특유의 bounce 스크롤, rubber-band 효과

---

## 치수 (pt 값)

### 사용 가능한 콘텐츠 높이 (iPhone 16 Pro 기준)

| 구성 요소 | 높이 | 누적 |
|----------|------|------|
| 화면 전체 | **852pt** | 852pt |
| ↑ Status Bar | -54pt | 798pt |
| ↑ Navigation Bar (standard) | -44pt | 754pt |
| ↑ Tab Bar | -83pt | 671pt |
| ↑ Home Indicator safe area | -34pt | **637pt** (사용 가능) |

> Large Title 모드: 671pt - 96pt(LT) + 44pt(standard) = **619pt** (Large Title 표시 시)

### 콘텐츠 가로 마진

| 컨텍스트 | 좌우 margin | 사용 너비 (iPhone 390pt 기준) |
|---------|------------|------------------------------|
| Plain 스타일 | **16pt** | 390 - 32 = **358pt** |
| Grouped 스타일 | **20pt** | 390 - 40 = **350pt** |
| Full-bleed (이미지 등) | **0pt** | **390pt** |
| iPad (regular width) | **20pt** 이상 | 적응형 |

> `spacing.json` → `contentMargin.iphone.horizontal = 16`, `contentMargin.ipad.horizontal = 20`

### Row / Cell 높이

| 크기 | 높이 | 용도 |
|------|------|------|
| 소형 (small) | **36pt** | 아이콘만 있는 단순 행 |
| 표준 (regular) | **44pt** | 텍스트 1줄, 기본 목록 행 |
| 중형 (medium) | **58pt** | 텍스트 2줄 또는 부제목 포함 |
| 대형 (large) | **74pt** | 썸네일 + 텍스트 2줄 |
| 커스텀 | **가변** | Dynamic Type 지원 시 자동 확장 |

> `spacing.json` → `components.listRow.heightRegular = 44` (Apple HIG 최솟값)

### 섹션 간격

| 컨텍스트 | 간격 | 토큰 |
|---------|------|------|
| 같은 그룹 내 행 사이 | 0pt (구분선만) | — |
| 그룹(섹션)과 그룹 사이 | **16pt** | `spacing.inset.md = 16` |
| 주요 콘텐츠 블록 사이 | **32pt** | `spacing.inset.xxl = 32` |
| 섹션 헤더 상단 padding | **32pt** | `spacing.inset.xxl = 32` |
| 섹션 헤더 하단 padding | **6pt** | — |
| 섹션 푸터 상단 padding | **8pt** | — |
| 섹션 푸터 하단 padding | **28pt** | — |

### List Insets (구분선 시작 위치)

| 유형 | Leading inset | 용도 |
|------|--------------|------|
| 기본 (no icon) | **16pt** | 텍스트 전용 행 |
| 아이콘 포함 | **60pt** | 설정 앱 스타일 (32pt 아이콘 + 12pt 간격 + 16pt margin) |
| 이미지 썸네일 | **76pt** | 46pt 썸네일 + 14pt + 16pt |
| Full-width (edge-to-edge) | **0pt** | 구분선 없음 |

---

## 색상 / Material 규칙

### 배경 색상

| 스타일 | Light | Dark | 사용처 |
|--------|-------|------|--------|
| Plain primary | `#ffffff` | `#000000` | 기본 앱 배경, 네비게이션 스택 |
| Plain secondary | `#f2f2f7` | `#1c1c1e` | 보조 배경, 카드 배경 |
| Grouped primary | `#f2f2f7` | `#000000` | 설정 앱, 폼 화면 |
| Grouped secondary | `#ffffff` | `#1c1c1e` | Grouped 섹션 셀 배경 |
| Grouped tertiary | `#ffffff` | `#2c2c2e` | 3단계 중첩 그룹 |

> `colors.json` → `backgrounds.*`, `backgroundsGrouped.*` 참조

### 구분선 색상

| 유형 | Light | Dark |
|------|-------|------|
| Opaque separator | `rgba(60,60,67,0.36)` | `rgba(84,84,88,0.65)` |
| Non-opaque separator | `rgba(60,60,67,0.29)` | `rgba(84,84,88,0.60)` |

### Scroll Edge Effect

스크롤 상단 도달 시 콘텐츠가 navigation bar의 Liquid Glass 소재와 블렌딩:
- `scrollEdgeAppearance`가 nil이면 navigation bar가 투명해짐
- `scrollEdgeAppearance`를 명시하면 해당 스타일 적용

---

## 동작 / 애니메이션

### 스크롤 동작

| 특성 | iOS 기본값 |
|------|-----------|
| Bounce (rubber-band) | 활성화 (위/아래 양방향) |
| Scroll indicator | 오른쪽 세로 스크롤 인디케이터, 자동 숨김 |
| Deceleration rate | `.normal` (0.998) / `.fast` (0.990) |
| Paging | UIScrollView `.isPagingEnabled` 으로 선택 |
| Content inset | Safe Area inset 자동 적용 (`.adjustedContentInset`) |

### Overscroll (Pull-to-Refresh)

```
콘텐츠 아래로 당기기 (overscroll)
  ↓ 일정 threshold (~80pt) 초과
  ↓ 로딩 스피너 나타남 + 햅틱 피드백
  ↓ 손 떼면: 새로고침 시작 → 스피너 유지
  ↓ 완료 시: 스피너 사라짐 + 콘텐츠 리로드
```

애니메이션: UIRefreshControl 기본 스피너. 커스텀 시 `LottieAnimationView` 또는 CALayer.

### 스크롤 엣지 이펙트 (Scroll Edge Effect)

```
스크롤 상단 (y=0):
  Navigation bar 투명 → 콘텐츠 배경 그대로 보임
  Status bar 스타일: 콘텐츠 색상에 따라 결정

스크롤 다운 (y > 0):
  Navigation bar: Liquid Glass 소재 가시화 (opacity 0 → 1, ~20pt 구간)
  콘텐츠가 nav bar 아래로 스크롤

스크롤 하단 (y = max):
  Tab bar: Liquid Glass 소재 가시화 (동일한 방식)
```

### 빈 상태 (Empty State)

```
콘텐츠가 없을 때 배치 규칙:

┌────────────────────────────────┐
│  Navigation Bar                │
├────────────────────────────────┤
│                                │
│                                │
│         [SF Symbol]            │  ← 아이콘 (40pt × 40pt)
│                                │  ← 16pt 간격
│        주 메시지 텍스트         │  ← headline (17pt, semibold)
│   부가 설명 (선택사항)          │  ← subheadline (15pt, secondary)
│                                │
│         [액션 버튼]             │  ← 선택사항
│                                │
└────────────────────────────────┘

위치: 수직 가운데 정렬 (전체 content region 기준)
```

---

## Accessibility

| 항목 | 규칙 |
|------|------|
| 최소 터치 영역 | **44×44pt** — `spacing.json → components.touchTarget.minimum` |
| Dynamic Type | 모든 텍스트 요소 Dynamic Type 지원. `adjustsFontForContentSizeCategory = true` |
| 대비율 | 4.5:1 이상 (WCAG AA). `colors.labels.primary` vs 배경 기본 충족 |
| VoiceOver | 스크롤 가능 영역에 `accessibilityTraits = .scrollable` 자동 적용 |
| 키보드 내비게이션 (iPad) | tab/arrow key로 포커스 이동. `UIFocusSystem` |
| Reduce Motion | bounce 스크롤 감소. `UIAccessibility.isReduceMotionEnabled` 확인 후 처리 |
| 행 높이 | Dynamic Type 최대 크기(xxxLarge)에서도 44pt 최솟값 유지 |

---

## 프레임워크별 구현

### UIKit

```swift
// 기본 TableView 설정 (Grouped 스타일)
let tableView = UITableView(frame: .zero, style: .insetGrouped)
tableView.backgroundColor = .systemGroupedBackground
tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)

// Auto-sizing rows (Dynamic Type 지원)
tableView.estimatedRowHeight = 44
tableView.rowHeight = UITableView.automaticDimension

// Section 간격 커스텀
func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return section == 0 ? 16 : 32  // 첫 섹션: 16pt, 나머지: 32pt
}

// Pull to Refresh
let refreshControl = UIRefreshControl()
refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
tableView.refreshControl = refreshControl

// Content Inset (Safe Area 자동)
tableView.contentInsetAdjustmentBehavior = .automatic

// Scroll Edge Effect (iOS 15+)
tableView.fillerRowHeight = 0  // 빈 행 제거

// 빈 상태
func showEmptyState() {
    let emptyView = EmptyStateView(
        symbol: "tray",
        title: "항목 없음",
        message: "새 항목을 추가해 보세요"
    )
    tableView.backgroundView = emptyView
}
```

```swift
// CollectionView (컴포지셔널 레이아웃)
let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
let layout = UICollectionViewCompositionalLayout.list(using: config)
let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

// 섹션 간격
var listConfig = UICollectionLayoutListConfiguration(appearance: .plain)
listConfig.headerMode = .supplementary
listConfig.footerMode = .supplementary
```

### SwiftUI

```swift
// List (가장 일반적인 Content Region)
struct ContentListView: View {
    var body: some View {
        List {
            // Grouped 섹션
            Section("기본 정보") {
                LabeledContent("이름", value: "홍길동")
                LabeledContent("이메일", value: "hong@example.com")
            }

            Section {
                ForEach(items) { item in
                    ItemRow(item: item)
                }
            } header: {
                Text("항목")
            } footer: {
                Text("항목을 탭하여 편집하세요.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .listStyle(.insetGrouped)  // 또는 .plain, .grouped, .sidebar
        .background(Color(.systemGroupedBackground))
    }
}

// 빈 상태 처리
struct EmptyStateView: View {
    var body: some View {
        ContentUnavailableView(
            "항목 없음",
            systemImage: "tray",
            description: Text("새 항목을 추가해 보세요.")
        )
        // iOS 17+: ContentUnavailableView 사용
    }
}

// ScrollView + 커스텀 콘텐츠
ScrollView {
    LazyVStack(spacing: 0) {
        ForEach(sections) { section in
            Section {
                ForEach(section.items) { item in
                    ItemRow(item: item)
                        .padding(.horizontal, 16)  // contentMargin.iphone.horizontal
                }
            } header: {
                SectionHeader(title: section.title)
                    .padding(.top, 32)  // spacing.inset.xxl
                    .padding(.horizontal, 16)
            }
        }
    }
    .padding(.bottom, 16)
}
.scrollBounceBehavior(.basedOnSize)  // iOS 16.4+
```

### Flutter

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// iOS 스타일 Grouped List
CupertinoListSection.insetGrouped(
  header: const Text('기본 정보'),
  footer: const Text('항목을 탭하여 편집하세요.'),
  children: [
    CupertinoListTile(
      title: const Text('이름'),
      trailing: const Text('홍길동'),
      onTap: () {},
    ),
    CupertinoListTile(
      title: const Text('이메일'),
      additionalInfo: const Text('hong@example.com'),
    ),
  ],
)

// CustomScrollView + 섹션 (권장)
CustomScrollView(
  physics: const BouncingScrollPhysics(  // iOS bounce
    parent: AlwaysScrollableScrollPhysics(),
  ),
  slivers: [
    // Pull to Refresh
    CupertinoSliverRefreshControl(
      onRefresh: () async {
        await refreshData();
      },
    ),
    // 섹션 헤더
    SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 6),
        child: Text(
          '항목',
          style: TextStyle(
            fontSize: 13,
            color: CupertinoColors.secondaryLabel.resolveFrom(context),
          ),
        ),
      ),
    ),
    // 콘텐츠 목록
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(
          title: Text('항목 $index'),
          minTileHeight: 44.0,  // 최소 row 높이
        ),
        childCount: items.length,
      ),
    ),
    // 하단 Safe Area 여백
    const SliverToBoxAdapter(
      child: SizedBox(height: 34),  // home indicator safe area
    ),
  ],
)

// 빈 상태
if (items.isEmpty)
  Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          CupertinoIcons.tray,
          size: 40,
          color: CupertinoColors.systemGrey,
        ),
        const SizedBox(height: 16),
        const Text(
          '항목 없음',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '새 항목을 추가해 보세요.',
          style: TextStyle(
            fontSize: 15,
            color: CupertinoColors.secondaryLabel.resolveFrom(context),
          ),
        ),
      ],
    ),
  )
```

### CSS / Svelte (웹 근사치)

```svelte
<!-- ContentRegion.svelte -->
<script lang="ts">
  export let grouped: boolean = false;
  export let isEmpty: boolean = false;
</script>

<main
  class="content-region"
  class:grouped
>
  {#if isEmpty}
    <div class="empty-state">
      <slot name="empty" />
    </div>
  {:else}
    <slot />
  {/if}
</main>

<style>
  .content-region {
    /* Safe area insets 적용 */
    padding-left: max(16px, env(safe-area-inset-left));
    padding-right: max(16px, env(safe-area-inset-right));
    padding-bottom: env(safe-area-inset-bottom);
    background-color: #ffffff;
    min-height: 100%;
  }

  @media (prefers-color-scheme: dark) {
    .content-region {
      background-color: #000000;
    }
  }

  .content-region.grouped {
    background-color: #f2f2f7;
    padding-left: 20px;
    padding-right: 20px;
  }

  @media (prefers-color-scheme: dark) {
    .content-region.grouped {
      background-color: #000000;
    }
  }

  /* 빈 상태 — 수직 가운데 정렬 */
  .empty-state {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: inherit;
    gap: 16px;
    padding: 32px 16px;
  }
</style>
```

```svelte
<!-- SectionList.svelte — iOS Grouped List 근사 -->
<script lang="ts">
  export let sections: Array<{
    header?: string;
    footer?: string;
    items: any[];
  }> = [];
</script>

<div class="section-list">
  {#each sections as section, i}
    <div class="section" style:margin-top={i === 0 ? '16px' : '32px'}>
      {#if section.header}
        <div class="section-header">{section.header}</div>
      {/if}

      <div class="section-body">
        {#each section.items as item, j}
          <div
            class="list-row"
            class:first={j === 0}
            class:last={j === section.items.length - 1}
          >
            <slot name="item" {item} />
          </div>
        {/each}
      </div>

      {#if section.footer}
        <div class="section-footer">{section.footer}</div>
      {/if}
    </div>
  {/each}
</div>

<style>
  .section-header {
    font-size: 13px;
    color: rgba(60, 60, 67, 0.6);
    padding: 0 20px 6px;
    text-transform: uppercase;
    letter-spacing: 0.02em;
  }

  .section-body {
    background: #ffffff;
    border-radius: 10px;
    overflow: hidden;
  }

  .list-row {
    min-height: 44px;                           /* 최소 row 높이 */
    padding: 11px 16px;                          /* paddingVertical + horizontal */
    border-bottom: 0.5px solid rgba(60, 60, 67, 0.36);
    display: flex;
    align-items: center;
  }

  .list-row.last {
    border-bottom: none;
  }

  .section-footer {
    font-size: 13px;
    color: rgba(60, 60, 67, 0.6);
    padding: 8px 20px 28px;
  }

  /* Scroll bounce 시뮬레이션 */
  .section-list {
    -webkit-overflow-scrolling: touch;
    overscroll-behavior-y: contain;
  }
</style>
```

---

## 연관 섹션 / 컴포넌트

- **Navigation Region** (`navigation-region.md`): Content Region 상단 경계
- **Overlay Region** (`overlay-region.md`): Content Region 위에 떠있는 Sheet/Alert
- **System Region** (`system-region.md`): 하단 경계 (Home Indicator, Tab Bar)
- **List Row** (`../components/specs/list-row.md`): 행 상세 스펙 (Node `550:50430`)
- **Tab Bar** (`../components/specs/tab-bar.md`): 하단 Tab Bar 컴포넌트
