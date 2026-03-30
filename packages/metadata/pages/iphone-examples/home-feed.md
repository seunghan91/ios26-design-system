# Home Feed — iOS 26 페이지 레시피

> **References**
> - Templates: `../../templates/`
> - Components: `../../components/specs/`
> - Tokens: `../../tokens/`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="...")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | 홈 피드 (Home Feed) |
| **용도** | 앱의 메인 탭 첫 화면 — 콘텐츠 목록을 무한 스크롤로 표시 |
| **탐색 깊이** | Root (0-depth) — Tab Bar의 첫 번째 탭 |
| **상태 수** | 로딩 / 정상 / 빈 상태 / 오류 |
| **iOS 26 특이사항** | Large Title + Liquid Glass Toolbar, Tab Bar Liquid Glass indicator |

홈 피드는 사용자가 앱을 열 때 가장 먼저 마주하는 화면이다. 스크롤 방향에 따라 Navigation Bar가 Large Title ↔ Inline Title 모드로 전환되며, Pull-to-Refresh 제스처와 무한 스크롤을 지원한다. 알림 배지는 Tab Bar 아이콘 위에 표시된다.

---

## 사용된 Template

**`standard-screen.md`** — Navigation Bar(Large Title) + Content(ScrollView) + Tab Bar 3단 구조.

```
Template 적용 포인트:
- Large Title 모드 활성화 (scrolled offset ≈ 40pt에서 inline 전환)
- Tab Bar: 하단 Safe Area 포함 (83pt + 34pt)
- Content safe inset: top = Nav Bar bottom, bottom = Tab Bar top
```

---

## 컴포넌트 계층 (ASCII 와이어프레임)

```
iPhone 16 Pro (393 × 852 pt)
┌─────────────────────────────────────────┐
│  ● ●●  9:41          ⠿ ▐▌ ■           │  ← Status Bar (54pt, Dynamic Island)
├─────────────────────────────────────────┤
│  [Edit]      ←공백→     [+] [⚙]        │  ← Navigation Bar Inline (44pt)
│              Liquid Glass Toolbar        │    (스크롤 전: Large Title 표시 중)
├─────────────────────────────────────────┤
│                                          │
│  홈                                      │  ← Large Title (34pt Bold, 11pt left)
│  ─────────────────────────────────────  │
│  [🔍 검색 또는 입력]                      │  ← Search Bar (컴포넌트: _Search-Top)
│  ─────────────────────────────────────  │
│                                          │
│  ┌─────────────────────────────────┐    │  ← List Row (피드 아이템 #1)
│  │ 🟦  제목 텍스트 첫 번째 아이템   │    │    높이: 가변 (최소 60pt)
│  │     subtitle · 2분 전           │    │    trailing: chevron.right
│  └─────────────────────────────────┘    │
│  ─────────────────────────────────────  │  ← 구분선 (insetListSeparator)
│  ┌─────────────────────────────────┐    │  ← List Row #2
│  │ 🟩  두 번째 아이템 제목          │    │
│  │     subtitle · 15분 전          │    │
│  └─────────────────────────────────┘    │
│  ─────────────────────────────────────  │
│  ┌─────────────────────────────────┐    │  ← List Row #3
│  │ 🟥  세 번째 아이템               │    │
│  │     subtitle · 1시간 전         │    │
│  └─────────────────────────────────┘    │
│  ─────────────────────────────────────  │
│  ┌─────────────────────────────────┐    │  ← List Row #4
│  │ 🟨  네 번째 아이템               │    │
│  │     subtitle · 어제              │    │
│  └─────────────────────────────────┘    │
│                                          │
│  ⋯  로딩 스피너 (무한 스크롤 트리거)      │  ← 하단 20pt 이내 진입 시 fetch
│                                          │
├─────────────────────────────────────────┤
│  [🏠홈] [🔍탐색] [＋] [🔔벨②] [👤프로필]  │  ← Tab Bar (49pt + 34pt safe)
│     ●                                   │    ● = Liquid Glass indicator
│                                          │    🔔 위 ② = 알림 배지
└─────────────────────────────────────────┘

Pull-to-Refresh 상태 (위로 당길 때):
┌─────────────────────────────────────────┐
│                                          │
│              ↻  (회전 스피너)             │  ← RefreshControl (y < 0 영역)
│                                          │
│  홈                                      │
│  ─────────────────────────────────────  │
│  ...                                     │
```

---

## 사용된 Components 목록

| 컴포넌트 | 파일 | 사용 위치 | Variant |
|---------|------|---------|---------|
| Toolbar (Top) | `toolbar.md` | 상단 Navigation Bar | Large Title, Inline |
| List Row | `list-row.md` | 피드 아이템 반복 | Icon + Title + Subtitle + Disclosure |
| Tab Bar | `tab-bar.md` | 하단 탭 내비게이션 | 5-tab, Liquid Glass indicator |
| Search Bar | `toolbar.md` (_Search-Top) | Large Title 하단 | Default |
| Notification Badge | `notifications.md` | Tab Bar 아이콘 위 | Count (1~99+) |
| Progress Indicator | `progress-indicators.md` | Pull-to-Refresh / 무한스크롤 | Spinner |

---

## 레이아웃 구조

```
Safe Area 기준 치수 (iPhone 16 Pro, 393pt 너비):

┌── Status Bar ─────────────── 54pt ──┐
├── Navigation Bar (Large) ─── 52pt ──┤  Liquid Glass, blur-radius 12pt
│   Large Title: y = 96pt             │  Large Title은 Content 내 첫 요소
├── Search Bar ─────────────── 36pt ──┤  top-padding 8pt
├── Content Area ──────────── flex ───┤
│   ├── Section Header (선택)          │  28pt, 13pt Semibold, labels.secondary
│   ├── List Row × N ─── min 60pt ────│  padding: 16pt horizontal
│   │   │  icon 40×40pt               │  icon corner-radius: 8pt
│   │   │  leading-padding: 20pt      │
│   │   │  title: 17pt Regular        │
│   │   │  subtitle: 15pt, secondary  │
│   │   └── disclosure 8pt chevron    │
│   └── Loading Footer ───── 60pt ────│  ActivityIndicator centered
├── Tab Bar ─────────────────  49pt ──┤  + 34pt Safe Area
└─────────────────────────────────────┘
```

### 색상 토큰 매핑

| 요소 | 토큰 | 값 (Light) |
|------|------|-----------|
| Background | `backgrounds.primary` | `#ffffff` |
| List Row BG | `backgrounds.secondary` | `#f2f2f7` |
| Title | `labels.primary` | `#000000` |
| Subtitle | `labels.secondary` | `#3c3c43 60%` |
| Separator | `fills.opaque.separator` | `#c6c6c8` |
| Toolbar BG | Liquid Glass | blur 12pt + `fills.glass` |
| Accent / Badge | `accents.blue.light` | `#0088ff` |

---

## 특이사항 / 커스터마이징 포인트

### Large Title 전환 타이밍
- `contentOffset.y >= 40pt` → Inline Title 모드로 전환
- Navigation Bar가 Large Title일 때 배경: 완전 투명
- Inline 전환 후: Liquid Glass 배경 나타남 (fade-in 0.2s)

### Pull-to-Refresh
- `UIRefreshControl` / SwiftUI `refreshable` modifier
- 스피너 색: `accents.blue.light`
- 완료 후 콘텐츠 자동 스크롤 복귀 (애니메이션 없이)

### 무한 스크롤 트리거
- 마지막 Row로부터 20pt 이내 진입 시 다음 페이지 fetch
- 로딩 중 하단 `ActivityIndicator` 표시
- 더 이상 데이터 없으면 "모두 불러왔습니다" 텍스트 표시 (13pt, tertiary)

### 알림 배지
- 미확인 알림 수 ≤ 99: 숫자 표시
- > 99: "99+" 표시
- 0: 배지 숨김 (animated fade-out)
- 색: `accents.red.light` (`#ff383c`)
- 크기: 최소 16×16pt, 내부 패딩 4pt horizontal

### 빈 상태 (Empty State)
```
┌─────────────────────────────────────────┐
│                                          │
│              📭                          │  (SF Symbol: tray.fill, 60pt)
│                                          │
│         아직 콘텐츠가 없어요              │  (17pt Semibold)
│    새 항목을 추가하면 여기 나타납니다     │  (15pt Regular, secondary)
│                                          │
│         [+ 첫 번째 항목 추가]            │  (Button: primary)
│                                          │
└─────────────────────────────────────────┘
```

---

## 애니메이션 시나리오

### 1. Large Title → Inline 전환
```
트리거: scrollOffset.y crosses 40pt threshold
Duration: 0.25s
Curve: easeInOut
요소:
  - Large Title: opacity 1→0, y 0→-8pt
  - Inline Title: opacity 0→1, y +8pt→0
  - Toolbar 배경: blur 0→12pt, opacity 0→0.8
```

### 2. Pull-to-Refresh 완료
```
트리거: 데이터 fetch 완료
Duration: 0.4s
Curve: spring(damping: 0.75)
요소:
  - RefreshControl: scale 1→0.8, opacity 1→0
  - 새 Row 삽입: y -20pt→0, opacity 0→1 (staggered 0.05s per row)
```

### 3. 무한 스크롤 새 Row 삽입
```
Duration: 0.3s per batch
Curve: easeOut
요소:
  - 로딩 스피너: opacity 1→0
  - 새 Row들: y +20pt→0, opacity 0→1 (stagger 0.04s)
```

### 4. Tab Bar Liquid Glass Indicator
```
트리거: 다른 탭 탭
Duration: 0.35s
Curve: spring(damping: 0.8, response: 0.4)
요소:
  - Indicator pill: x 이동 + scale 0.9→1.0
  - 선택된 아이콘: opacity 0.6→1.0
```

---

## 프레임워크별 전체 코드 예시

### SwiftUI (iOS 26)

```swift
import SwiftUI

struct HomeFeedView: View {
    @StateObject private var viewModel = FeedViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.items) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        FeedRowView(item: item)
                    }
                    .listRowBackground(Color(.secondarySystemBackground))
                    .onAppear {
                        // 무한 스크롤: 마지막 아이템 등장 시 fetch
                        if item == viewModel.items.last {
                            viewModel.fetchNextPage()
                        }
                    }
                }

                // 무한 스크롤 로딩 푸터
                if viewModel.isLoadingMore {
                    HStack {
                        Spacer()
                        ProgressView()
                            .padding(.vertical, 16)
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.insetGrouped)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .refreshable {
                await viewModel.refresh()
            }
            .navigationTitle("홈")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { viewModel.showAdd() }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { viewModel.showSettings() }) {
                        Image(systemName: "gearshape")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .overlay {
                // 빈 상태
                if viewModel.items.isEmpty && !viewModel.isLoading {
                    EmptyFeedView(onAdd: viewModel.showAdd)
                }
            }
            .task {
                await viewModel.loadInitial()
            }
        }
    }
}

// MARK: - 피드 Row 컴포넌트
struct FeedRowView: View {
    let item: FeedItem

    var body: some View {
        HStack(spacing: 12) {
            // 아이콘 (40×40pt, corner-radius 8pt)
            RoundedRectangle(cornerRadius: 8)
                .fill(item.accentColor.opacity(0.15))
                .frame(width: 40, height: 40)
                .overlay {
                    Image(systemName: item.iconName)
                        .font(.system(size: 20))
                        .foregroundStyle(item.accentColor)
                }

            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .font(.body)                          // 17pt Regular
                    .foregroundStyle(.primary)
                    .lineLimit(1)

                Text(item.subtitle + " · " + item.relativeTime)
                    .font(.subheadline)                   // 15pt Regular
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer()
        }
        .padding(.vertical, 4)
    }
}

// MARK: - 빈 상태 View
struct EmptyFeedView: View {
    let onAdd: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "tray.fill")
                .font(.system(size: 60))
                .foregroundStyle(.tertiary)

            VStack(spacing: 6) {
                Text("아직 콘텐츠가 없어요")
                    .font(.headline)
                Text("새 항목을 추가하면 여기 나타납니다")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            Button("+ 첫 번째 항목 추가", action: onAdd)
                .buttonStyle(.borderedProminent)
                .controlSize(.regular)
        }
        .padding(.horizontal, 32)
    }
}
```

### Flutter (BLoC 패턴)

```dart
// home_feed_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeFeedPage extends StatelessWidget {
  const HomeFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          // Large Title Navigation Bar
          CupertinoSliverNavigationBar(
            largeTitle: const Text('홈'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(CupertinoIcons.plus),
                  onPressed: () => _showAdd(context),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(CupertinoIcons.gear),
                  onPressed: () => _showSettings(context),
                ),
              ],
            ),
          ),
          // Pull-to-Refresh + 피드 목록
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              context.read<FeedBloc>().add(FeedRefreshRequested());
              await context.read<FeedBloc>().stream
                  .firstWhere((s) => s is! FeedLoadInProgress);
            },
          ),
          BlocBuilder<FeedBloc, FeedState>(
            builder: (context, state) {
              if (state is FeedLoadSuccess) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == state.items.length) {
                        // 무한 스크롤 트리거
                        context.read<FeedBloc>().add(FeedNextPageRequested());
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CupertinoActivityIndicator()),
                        );
                      }
                      return _FeedRow(item: state.items[index]);
                    },
                    childCount: state.items.length + (state.hasMore ? 1 : 0),
                  ),
                );
              }
              return const SliverFillRemaining(
                child: Center(child: CupertinoActivityIndicator()),
              );
            },
          ),
        ],
      ),
    );
  }
}
```
