# Tab Bar — iOS 26 컴포넌트 스펙

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="3:70967")`

---

## 1. Overview

iOS 26 Tab Bar는 앱의 최상위 탐색 영역을 담당하는 컴포넌트다. iOS 26에서 가장 크게 달라진 점은 **Liquid Glass 소재의 탭 인디케이터**다 — 선택된 탭 아래에서 물방울처럼 움직이는 반투명 유리질 배경이 생기며, 탭 간 이동 시 이 인디케이터가 탄성 있게 morph된다.

| 항목 | 값 |
|------|-----|
| **Figma Node (iPhone)** | `3:70967` — COMPONENT_SET, 16 variants |
| **Figma Node (iPad)** | `2524:7957` — COMPONENT, single assembly |
| **내부 버튼 (Text)** | `5735:65307` — _Tab Bar Button - iPhone - Text (4 variants) |
| **내부 버튼 (Search)** | `5735:65306` — _Tab Bar Button - iPhone - Search (4 variants) |
| **섹션 그룹** | `507:24689` — Tab Bars |

---

## 2. Dimensions

### iPhone Tab Bar

| 속성 | 값 | 비고 |
|------|-----|------|
| 너비 | 기기 화면 너비 (100%) | Safe area 포함 |
| 높이 (일반) | **49pt** | Liquid Glass indicator 없음 |
| 높이 (인디케이터 포함) | **83pt** | Liquid Glass indicator 활성화 시 (+34pt) |
| Padding Bottom | Safe Area bottom (`34pt` — iPhone 16 Pro) | 기기별 safeArea.bottom 참조 |
| 탭 버튼 최소 너비 | 64pt | `spacing.components.tabBar.itemMinWidth` |

### iPad Tab Bar

| 속성 | 값 | 비고 |
|------|-----|------|
| 너비 | 기기 화면 너비 (100%) | — |
| 높이 | 49pt | iPad는 인디케이터 형태 다름 |
| Padding Horizontal | 20pt | `spacing.contentMargin.ipad.horizontal` |

---

## 3. Variants 표

### Tab Bar - iPhone (COMPONENT_SET `3:70967`) — 16 variants

**Axes:**
- `Separate Search`: True / False
- `Minimized`: True / False
- `Tabs`: 2 / 3 / 4 / 5

| Separate Search | Minimized | Tabs | 설명 |
|----------------|-----------|------|------|
| False | False | 2 | 기본 2탭, 전체 높이 |
| False | False | 3 | 기본 3탭, 전체 높이 |
| False | False | 4 | 기본 4탭, 전체 높이 |
| False | False | 5 | 기본 5탭, 전체 높이 |
| False | True | 2 | 2탭, Minimized (스크롤 시 탭바 축소) |
| False | True | 3 | 3탭, Minimized |
| False | True | 4 | 4탭, Minimized |
| False | True | 5 | 5탭, Minimized |
| True | False | 2 | Search 탭 별도 분리, 2탭 |
| True | False | 3 | Search 탭 별도 분리, 3탭 |
| True | False | 4 | Search 탭 별도 분리, 4탭 |
| True | False | 5 | Search 탭 별도 분리, 5탭 |
| True | True | 2 | Search 분리 + Minimized, 2탭 |
| True | True | 3 | Search 분리 + Minimized, 3탭 |
| True | True | 4 | Search 분리 + Minimized, 4탭 |
| True | True | 5 | Search 분리 + Minimized, 5탭 |

### _Tab Bar Button - iPhone - Text (`5735:65307`) — 4 variants

| Variant | 설명 |
|---------|------|
| Mode=Light, Selected=True | Light mode, 선택된 탭 (인디케이터 표시) |
| Mode=Light, Selected=False | Light mode, 비선택 탭 |
| Mode=Dark, Selected=True | Dark mode, 선택된 탭 |
| Mode=Dark, Selected=False | Dark mode, 비선택 탭 |

### _Tab Bar Button - iPhone - Search (`5735:65306`) — 4 variants

| Variant | 설명 |
|---------|------|
| Mode=Light, Selected=True | Light mode, 선택된 Search 탭 |
| Mode=Light, Selected=False | Light mode, 비선택 Search 탭 |
| Mode=Dark, Selected=True | Dark mode, 선택된 Search 탭 |
| Mode=Dark, Selected=False | Dark mode, 비선택 Search 탭 |

---

## 4. 색상 토큰 매핑

| UI 요소 | 토큰 경로 | Light | Dark |
|---------|----------|-------|------|
| **선택된 탭 레이블/심볼** | `labels.primary` | `#000000` (alpha 1) | `#ffffff` (alpha 1) |
| **비선택 탭 레이블/심볼** | `miscellaneous.tabUnselected` | `#999999` | `#7e7e7e` |
| **탭바 선택 표시** | `miscellaneous.tabBarSelection` | — | `#ffffff` |
| **Liquid Glass 인디케이터 배경** | `fills.quaternary` | `rgba(116,116,128,0.08)` | `rgba(118,118,128,0.18)` |
| **Liquid Glass backdrop-filter** | spacing.liquidGlass.frost.small | blur(7px) | blur(7px) |
| **탭바 배경** | `backgrounds.primary` + blur | `#ffffff` (+ blur) | `#000000` (+ blur) |
| **구분선** | `separators.nonOpaque` | `rgba(0,0,0,0.12)` | `rgba(255,255,255,0.17)` |

---

## 5. 타이포그래피 매핑

| 요소 | 스타일 | fontSize | weight | letterSpacing |
|------|--------|----------|--------|---------------|
| 탭 레이블 (일반) | `caption2` | 11pt | Regular | 0.06 |
| 탭 레이블 (선택됨) | `caption2` Emphasized | 11pt | Semibold | 0.06 |
| Search 탭 레이블 | `caption2` | 11pt | Regular | 0.06 |

> Dynamic Type: caption2는 xSmall~Large 범위에서 11pt 고정. xxLarge부터 12pt로 증가.

---

## 6. 상태 전환

### 탭 버튼 상태

| 상태 | 레이블 색상 | 심볼 색상 | 인디케이터 |
|------|------------|----------|-----------|
| **Default (비선택)** | `tabUnselected` (#999999 / #7e7e7e) | 동일 | 없음 |
| **Selected (선택됨)** | `labels.primary` | 동일 | Liquid Glass pill 표시 |
| **Highlighted (누름)** | `labels.secondary` (opacity 0.6/0.7) | 동일 | 인디케이터 scale 0.95 |
| **Minimized** | `labels.tertiary` | 동일 | 인디케이터 축소 |

### 탭 전환 시퀀스

```
탭 A 선택 → 탭 B 탭 시
1. 탭 B 레이블: tabUnselected → labels.primary (fade, 0.2s)
2. Liquid Glass 인디케이터: 탭 A 위치 → 탭 B 위치 morph
   - 이동 방향으로 40% 지점에서 pill이 늘어남 (stretch)
   - 100% 지점에서 목표 크기로 snapping
   duration: 0.45s, easing: snappy spring
3. 탭 A 레이블: labels.primary → tabUnselected (fade, 0.2s)
```

---

## 7. 애니메이션 스펙

### Liquid Glass 탭 인디케이터 이동

`animations.json → liquidGlass.tabIndicator` 참조

| 파라미터 | 값 |
|----------|-----|
| **Duration** | 0.45s |
| **Spring preset** | snappy (response: 0.3, dampingRatio: 0.8) |
| **CSS approximation** | `cubic-bezier(0.34, 1.56, 0.64, 1.0)` |
| **Animated properties** | `width`, `height`, `border-radius`, `transform`, `backdrop-filter` |
| **Corner radius** | 9999px (pill, 항상 유지) |
| **Blur** | `blur(7px)` — `spacing.liquidGlass.frost.small` |

### Fluid Keyframes (CSS)

```css
@keyframes liquid-tab-move {
  0%   { width: 64px; border-radius: 9999px; }
  40%  { width: 80px; border-radius: 9999px; }   /* 이동 방향으로 stretch */
  100% { width: 64px; border-radius: 9999px; }   /* 목표 위치에서 snap */
}
```

### 전체 CSS 트랜지션

```css
/* animations.json → frameworkMappings.css.tabIndicatorTransition */
.tab-indicator {
  transition:
    width 0.45s cubic-bezier(0.34, 1.56, 0.64, 1.0),
    transform 0.45s cubic-bezier(0.34, 1.56, 0.64, 1.0),
    border-radius 0.45s cubic-bezier(0.34, 1.56, 0.64, 1.0);
  backdrop-filter: blur(7px);
  -webkit-backdrop-filter: blur(7px);
  border-radius: 9999px;
}
```

### 탭 레이블 페이드

```css
.tab-label {
  transition: color 0.2s ease-out, opacity 0.2s ease-out;
}
```

### Minimized 애니메이션

스크롤 시 탭바가 아래로 숨겨지는 애니메이션:
```css
.tab-bar {
  transition: transform 0.3s cubic-bezier(0.0, 0, 0.6, 1.0); /* appleEaseOut */
}
.tab-bar.minimized {
  transform: translateY(calc(100% + var(--safe-area-inset-bottom)));
}
```

---

## 8. 접근성

| 항목 | 요구사항 |
|------|---------|
| **최소 터치 타겟** | 44×44pt (`spacing.components.touchTarget.minimum`) |
| **탭 버튼 ARIA role** | `tab` (웹) / `UITabBarItem` (iOS Native) |
| **선택 상태 전달** | `aria-selected="true/false"` / `accessibilityTraits: .selected` |
| **레이블 색상 대비** | 선택: `labels.primary` — WCAG AA 4.5:1 충족. 비선택: `tabUnselected` (#999) — 대비 2.85:1 (informational, not critical) |
| **Dynamic Type** | caption2 스타일 지원, 시스템 텍스트 크기 변경 반영 |
| **VoiceOver** | 탭 이름 + "탭, 총 N개 중 M번째" 읽어줌 |
| **감소된 모션** | `prefers-reduced-motion: reduce` 시 morph 애니메이션 disable, 즉시 전환 |

---

## 9. 프레임워크 구현 참고

### Svelte 5 (웹/Tauri)

```svelte
<script lang="ts">
  import { spring } from 'svelte/motion';

  let selectedIndex = $state(0);

  // Liquid Glass indicator position
  const indicatorX = spring(0, {
    stiffness: 0.2,  // snappy spring 근사
    damping: 0.8
  });

  function selectTab(index: number) {
    selectedIndex = index;
    indicatorX.set(index * TAB_WIDTH);
  }
</script>

<nav class="tab-bar" role="tablist">
  <!-- Liquid Glass indicator -->
  <div
    class="tab-indicator"
    style="transform: translateX({$indicatorX}px);"
  ></div>

  {#each tabs as tab, i}
    <button
      role="tab"
      aria-selected={selectedIndex === i}
      onclick={() => selectTab(i)}
      class="tab-button"
      class:selected={selectedIndex === i}
    >
      <span class="tab-symbol">{tab.symbol}</span>
      <span class="tab-label">{tab.label}</span>
    </button>
  {/each}
</nav>

<style>
  .tab-bar {
    position: relative;
    display: flex;
    height: 49px;
    background: rgba(255, 255, 255, 0.85);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border-top: 0.5px solid rgba(0, 0, 0, 0.12);
  }

  .tab-indicator {
    position: absolute;
    height: 32px;
    width: 64px;
    border-radius: 9999px;
    background: rgba(116, 116, 128, 0.08);
    backdrop-filter: blur(7px);
    -webkit-backdrop-filter: blur(7px);
    transition:
      width 0.45s cubic-bezier(0.34, 1.56, 0.64, 1.0),
      border-radius 0.45s cubic-bezier(0.34, 1.56, 0.64, 1.0);
    /* transform은 svelte spring이 처리 */
  }

  .tab-button {
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-width: 64px;
    min-height: 44px; /* 접근성: 최소 터치 타겟 */
    color: #999999; /* tabUnselected light */
    font-size: 11px;
    font-family: -apple-system, system-ui, sans-serif;
    letter-spacing: 0.06px;
  }

  .tab-button.selected {
    color: #000000; /* labels.primary light */
    font-weight: 600;
  }

  .tab-label {
    transition: color 0.2s ease-out;
  }

  @media (prefers-color-scheme: dark) {
    .tab-bar { background: rgba(0, 0, 0, 0.85); border-top-color: rgba(255, 255, 255, 0.17); }
    .tab-button { color: #7e7e7e; }
    .tab-button.selected { color: #ffffff; }
    .tab-indicator { background: rgba(118, 118, 128, 0.18); }
  }

  @media (prefers-reduced-motion: reduce) {
    .tab-indicator { transition: none; }
    .tab-label { transition: none; }
  }
</style>
```

### Flutter

```dart
// animations.json → frameworkMappings.flutter 참조
// SpringDescription(mass: 1, stiffness: 220, damping: 20) — snappy spring

class LiquidGlassTabBar extends StatefulWidget {
  final List<TabItem> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  const LiquidGlassTabBar({required this.tabs, required this.selectedIndex, required this.onTabSelected});

  @override
  State<LiquidGlassTabBar> createState() => _LiquidGlassTabBarState();
}

class _LiquidGlassTabBarState extends State<LiquidGlassTabBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _indicatorX;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  void _selectTab(int index) {
    widget.onTabSelected(index);
    // Spring animation with snappy preset
    _controller.animateTo(
      index / (widget.tabs.length - 1),
      duration: const Duration(milliseconds: 450),
      curve: Curves.elasticOut, // snappy spring 근사
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 49,
      child: Stack(
        children: [
          // Liquid Glass indicator
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => Positioned(
              left: _indicatorX.value,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9999),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7), // frost small
                  child: Container(
                    width: 64, height: 32,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Tab buttons
          Row(
            children: widget.tabs.asMap().entries.map((entry) {
              final isSelected = entry.key == widget.selectedIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => _selectTab(entry.key),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(entry.value.icon,
                        color: isSelected ? Colors.black : const Color(0xFF999999)),
                      Text(entry.value.label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected ? Colors.black : const Color(0xFF999999),
                          letterSpacing: 0.06,
                        )),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
```

### SwiftUI (참고용)

```swift
// iOS 26 Native: TabView with .tabViewStyle(.sidebarAdaptable)
TabView(selection: $selectedTab) {
  ForEach(tabs) { tab in
    tab.view
      .tabItem {
        Label(tab.title, systemImage: tab.icon)
      }
      .tag(tab.id)
  }
}
// Liquid Glass indicator는 시스템이 자동으로 처리
// UITabBarAppearance로 외관 커스터마이징 가능
```
