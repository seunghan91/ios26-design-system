# Toolbar — iOS 26 컴포넌트 스펙

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="1:54472")`

---

## 1. Overview

iOS 26 Toolbar(Navigation Bar / Bottom Toolbar)는 화면 상단 또는 하단에 위치하는 탐색 및 액션 컨트롤 영역이다. iOS 26에서는 **Liquid Glass 소재**가 toolbar 배경에 적용되어 반투명 frosted-glass 효과를 기본으로 제공한다. Large Title 스타일과 Inline 스타일 두 가지 주요 높이 모드가 있다.

| 항목 | 값 |
|------|-----|
| **Figma Node (Top iPhone)** | `1:54472` — COMPONENT_SET, 5 variants |
| **Figma Node (Bottom iPhone)** | `4:55732` — COMPONENT_SET, 6 variants |
| **Figma Node (Top iPad)** | `5561:41165` — COMPONENT_SET, 8 variants |
| **Figma Node (Top Sheet)** | `5726:33474` — COMPONENT_SET, 5 variants |
| **섹션 그룹** | `507:25993` — Toolbars |

### 내부 컴포넌트 (Private)

| 컴포넌트 | Figma Node | Variants |
|---------|-----------|----------|
| _Button - Back | `5431:813` | 4 (Mode × Label) |
| _Button - Text | `5429:6984` | 8 (Mode × Style) |
| _Button - Symbol | `5426:2003` | 8 (Mode × Style) |
| _Buttons - Top | `5720:29596` | 10 |
| _Buttons - Top - Sheets | `5720:27703` | 4 |
| _Button - Bottom | `5720:47981` | 9 |
| _Search - Top | `5720:33677` | 6 (Mode × State) |
| _Search - Bottom | `5720:33170` | 6 (Mode × State) |
| _Search Accessory | `5573:24624` | 2 (Mode) |
| _Segmented Control Button | `5573:24524` | 4 |
| _Title - Large Title | `5827:57551` | 2 (Mode) |
| _Title - Body | `5827:57554` | 2 (Mode) |

---

## 2. Dimensions

### Top Toolbar — iPhone

| 속성 | Standard (Inline) | Large Title |
|------|-------------------|-------------|
| 높이 | **44pt** | **96pt** |
| Padding Horizontal | **16pt** | **16pt** |
| 타이틀 위치 | 수직 중앙 | 하단 (32pt에서 시작) |
| 버튼 최소 너비 | 44pt | 44pt |
| Blur (Liquid Glass) | blur(12px) — medium | blur(12px) — medium |

### Bottom Toolbar — iPhone

| 속성 | 값 |
|------|-----|
| 높이 | **44pt** |
| Padding Horizontal | **16pt** |
| Padding Bottom | Safe Area bottom (34pt on iPhone 16 Pro) |
| 버튼 최소 너비 | 44pt |

### Top Toolbar — iPad

| 속성 | 값 |
|------|-----|
| Standard 높이 | **50pt** (iPad는 약간 더 큼) |
| Large Title 높이 | **96pt** |
| Padding Horizontal | **20pt** (`spacing.contentMargin.ipad.horizontal`) |

---

## 3. Variants 표

### Toolbar - Top - iPhone (`1:54472`) — 5 variants

| Variant | Child ID | 높이 | 설명 |
|---------|---------|------|------|
| Style=Large Title | child 1 | 96pt | 대형 타이틀 네비게이션 바. 스크롤 시 Inline으로 축소. |
| Style=Large Title + Search | child 2 | 96pt | 대형 타이틀 + 검색바 통합 |
| Style=Inline | child 3 | 44pt | 압축된 인라인 타이틀. 뒤로가기 버튼 포함. |
| Style=Inline + Search | child 4 | 44pt | 인라인 타이틀 + 검색 아이콘 |
| Style=Search Only | child 5 | 44pt | 검색바만 표시 |

### Toolbar - Bottom - iPhone (`4:55732`) — 6 variants

| Variant | Child ID | 설명 |
|---------|---------|------|
| Style=Default | child 1 | 아이콘 버튼 그룹. 기본 bottom toolbar. |
| Style=Tab Bar | child 2 | 탭바와 통합된 bottom toolbar |
| Style=Segmented | child 3 | Segmented Control 포함 |
| Style=Page Control | child 4 | 페이지 인디케이터 (점) 포함 |
| Style=Text Buttons | child 5 | 텍스트 액션 버튼들 |
| Style=Icon Buttons | child 6 | 아이콘 액션 버튼들 |

### Toolbar - Top - iPad (`5561:41165`) — 8 variants

| Variant | Child ID | 설명 |
|---------|---------|------|
| Style=Large Title | child 1 | iPad 대형 타이틀 |
| Style=Large Title + Search | child 2 | iPad 대형 타이틀 + 검색 |
| Style=Inline | child 3 | iPad 인라인 타이틀 |
| Style=Inline + Search | child 4 | iPad 인라인 + 검색 |
| Style=Sidebar | child 5 | 사이드바 툴바 스타일 |
| Style=Sidebar + Search | child 6 | 사이드바 + 검색 |
| Style=Browser | child 7 | 브라우저 스타일 (URL 바 형태) |
| Style=Browser + Search | child 8 | 브라우저 + 검색 통합 |

### Toolbar - Top - Sheet (`5726:33474`) — 5 variants

| Variant | Child ID | 설명 |
|---------|---------|------|
| Style=Title Only | child 1 | 시트 타이틀만 |
| Style=Title + Subtitle | child 2 | 타이틀 + 서브타이틀 |
| Style=Title + Actions | child 3 | 타이틀 + 액션 버튼 |
| Style=Grabber + Title | child 4 | 그래버 핸들 + 타이틀 |
| Style=Grabber Only | child 5 | 그래버 핸들만 |

---

## 4. 색상 토큰 매핑

| UI 요소 | 토큰 경로 | Light | Dark |
|---------|----------|-------|------|
| **타이틀 텍스트** | `labels.primary` | `#000000` | `#ffffff` |
| **네비게이션 버튼 (Back, Text)** | `accents.blue` | `#0088ff` | `#0091ff` |
| **Destructive 버튼** | `accents.red` | `#ff383c` | `#ff4245` |
| **Disabled 버튼** | `labels.tertiary` | `rgba(60,60,67,0.3)` | `rgba(235,235,245,0.3)` |
| **Symbol 버튼 (Default)** | `labels.primary` | `#000000` | `#ffffff` |
| **Toolbar 배경 (Liquid Glass)** | `backgrounds.primary` + blur | `rgba(255,255,255,0.85)` | `rgba(0,0,0,0.85)` |
| **구분선 (Hairline)** | `separators.nonOpaque` | `rgba(0,0,0,0.12)` | `rgba(255,255,255,0.17)` |
| **Segmented Control 선택 Fill** | `miscellaneous.segmentedControlSelectedFill` | `#ffffff` (alpha 1) | `rgba(255,255,255,0.27)` |

---

## 5. 타이포그래피 매핑

| 요소 | 스타일 | fontSize | weight | letterSpacing |
|------|--------|----------|--------|---------------|
| **Large Title** | `largeTitle` Regular | **34pt** | Regular (400) | 0.4 |
| **Large Title (Emphasized)** | `largeTitle` Bold | 34pt | Bold (700) | 0.4 |
| **Inline Title** | `headline` Semibold | **17pt** | Semibold (600) | -0.43 |
| **Back Button Label** | `body` Regular | 17pt | Regular (400) | -0.43 |
| **Text Button** | `body` Regular | 17pt | Regular (400) | -0.43 |
| **Bold Text Button** | `body` Semibold | 17pt | Semibold (600) | -0.43 |
| **Subtitle (Sheet)** | `subheadline` Regular | 15pt | Regular (400) | -0.23 |

> Dynamic Type 지원 필수. 시스템 설정에 따라 모든 텍스트 크기 자동 조정.

---

## 6. 상태 전환

### _Button - Text 스타일 상태

| 상태 | 텍스트 색상 | 아이콘 색상 | 불투명도 |
|------|------------|-----------|---------|
| **Default** | `accents.blue` | — | 1.0 |
| **Bold** | `accents.blue` Bold weight | — | 1.0 |
| **Destructive** | `accents.red` | — | 1.0 |
| **Disabled** | `labels.tertiary` | — | 1.0 (색상으로 disabled 표현) |
| **Highlighted (누름)** | `accents.blue` | — | 0.4 (opacity 감소) |

### _Button - Symbol 스타일 상태

| 상태 | 심볼 색상 | 불투명도 |
|------|---------|---------|
| **Default** | `labels.primary` | 1.0 |
| **Bold** | `labels.primary` Bold weight | 1.0 |
| **Destructive** | `accents.red` | 1.0 |
| **Disabled** | `labels.tertiary` | 1.0 |
| **Highlighted** | `labels.primary` | 0.4 |

### Large Title → Inline 전환 (스크롤 축소)

```
스크롤 시작 (>0pt):
  Large Title: opacity 1 → 0 (duration: 0.2s)
  Inline Title: opacity 0 → 1 (duration: 0.2s)
  Toolbar 높이: 96pt → 44pt (duration: 0.3s, appleEaseOut)
```

---

## 7. 애니메이션 스펙

### Large Title 축소 (Scroll Collapse)

| 파라미터 | 값 |
|----------|-----|
| **Duration** | 0.3s |
| **Easing** | `appleEaseOut` — `cubic-bezier(0.0, 0, 0.6, 1.0)` |
| **Height** | 96pt → 44pt |
| **Large Title opacity** | 1 → 0 (0.2s, easeOut) |
| **Inline Title opacity** | 0 → 1 (0.2s, easeOut, delay 0.05s) |

### Toolbar Appear (화면 진입 시)

```css
/* animations.json → transitions.push 참고 */
.toolbar {
  animation: toolbarAppear 0.35s cubic-bezier(0.0, 0, 0.6, 1.0);
}
@keyframes toolbarAppear {
  from { opacity: 0; transform: translateY(-8px); }
  to   { opacity: 1; transform: translateY(0); }
}
```

### Liquid Glass 배경

```css
.toolbar-bg {
  backdrop-filter: blur(12px); /* frost medium */
  -webkit-backdrop-filter: blur(12px);
  background: rgba(255, 255, 255, 0.85); /* light mode */
  /* dark mode: rgba(0, 0, 0, 0.85) */
  transition: opacity 0.2s ease-out;
}
```

### 버튼 Tap 피드백

```css
.toolbar-button {
  transition: opacity 0.1s ease-in-out;
}
.toolbar-button:active {
  opacity: 0.4;
}
```

---

## 8. 접근성

| 항목 | 요구사항 |
|------|---------|
| **최소 터치 타겟** | 44×44pt — `spacing.components.touchTarget.minimum` |
| **Back 버튼** | ARIA label="뒤로" / `accessibilityLabel: "Back"` |
| **타이틀 ARIA** | `role="heading"` level=1 (Large Title), level=2 (Inline) |
| **대비** | 타이틀 `labels.primary` → 대비 충족. 버튼 `accents.blue` (#0088ff on white) → 대비 3.5:1 (Large Text 기준 충족) |
| **VoiceOver 순서** | 왼쪽 버튼 → 타이틀 → 오른쪽 버튼 순으로 포커스 이동 |
| **감소된 모션** | Scroll collapse 애니메이션 즉시 전환 |
| **키보드 내비게이션** | Tab 키로 버튼 순서 탐색 지원 |

---

## 9. 프레임워크 구현 참고

### Svelte 5 (웹/Tauri)

```svelte
<script lang="ts">
  interface ToolbarProps {
    title: string;
    style: 'large-title' | 'inline' | 'search-only';
    backButton?: { label: string; onClick: () => void };
    trailingButtons?: Array<{ icon: string; label: string; onClick: () => void }>;
  }

  let {
    title,
    style = 'inline',
    backButton,
    trailingButtons = []
  }: ToolbarProps = $props();

  let scrollY = $state(0);
  let isCollapsed = $derived(style === 'large-title' && scrollY > 44);
</script>

<header
  class="toolbar"
  class:large-title={style === 'large-title'}
  class:collapsed={isCollapsed}
  role="banner"
>
  <div class="toolbar-bg"></div>

  <div class="toolbar-content">
    <!-- Leading: Back Button -->
    {#if backButton}
      <button
        class="toolbar-button back-button"
        onclick={backButton.onClick}
        aria-label={backButton.label}
      >
        <span class="back-chevron">‹</span>
        <span class="back-label">{backButton.label}</span>
      </button>
    {/if}

    <!-- Title -->
    <div class="toolbar-title-container">
      {#if style === 'large-title'}
        <h1
          class="large-title"
          class:hidden={isCollapsed}
          aria-hidden={isCollapsed}
        >{title}</h1>
        <h2
          class="inline-title"
          class:visible={isCollapsed}
          aria-hidden={!isCollapsed}
        >{title}</h2>
      {:else}
        <h1 class="inline-title visible">{title}</h1>
      {/if}
    </div>

    <!-- Trailing Buttons -->
    <div class="toolbar-trailing">
      {#each trailingButtons as btn}
        <button
          class="toolbar-button symbol-button"
          onclick={btn.onClick}
          aria-label={btn.label}
        >
          {btn.icon}
        </button>
      {/each}
    </div>
  </div>

  <!-- Large Title (아래쪽 별도 영역) -->
  {#if style === 'large-title' && !isCollapsed}
    <div class="large-title-area">
      <h1 class="large-title-text">{title}</h1>
    </div>
  {/if}
</header>

<style>
  .toolbar {
    position: sticky;
    top: 0;
    z-index: 100;
    width: 100%;
    height: 44px;
    transition: height 0.3s cubic-bezier(0.0, 0, 0.6, 1.0);
  }

  .toolbar.large-title:not(.collapsed) {
    height: 96px;
  }

  .toolbar-bg {
    position: absolute;
    inset: 0;
    background: rgba(255, 255, 255, 0.85);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border-bottom: 0.5px solid rgba(0, 0, 0, 0.12);
  }

  .toolbar-content {
    position: relative;
    display: flex;
    align-items: center;
    height: 44px;
    padding: 0 16px;
    gap: 8px;
  }

  .back-button {
    display: flex;
    align-items: center;
    gap: 4px;
    color: #0088ff; /* accents.blue light */
    font-size: 17px;
    min-width: 44px;
    min-height: 44px;
  }

  .inline-title {
    flex: 1;
    text-align: center;
    font-size: 17px;
    font-weight: 600; /* Semibold */
    letter-spacing: -0.43px;
    color: #000000; /* labels.primary */
    opacity: 0;
    transition: opacity 0.2s ease-out;
  }

  .inline-title.visible { opacity: 1; }

  .large-title-area {
    padding: 0 16px 8px;
  }

  .large-title-text {
    font-size: 34px;
    font-weight: 400;
    letter-spacing: 0.4px;
    color: #000000;
    transition: opacity 0.2s ease-out;
  }

  .symbol-button {
    min-width: 44px;
    min-height: 44px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #000000; /* labels.primary */
    transition: opacity 0.1s ease-in-out;
  }

  .symbol-button:active { opacity: 0.4; }

  @media (prefers-color-scheme: dark) {
    .toolbar-bg {
      background: rgba(0, 0, 0, 0.85);
      border-bottom-color: rgba(255, 255, 255, 0.17);
    }
    .back-button { color: #0091ff; }
    .inline-title, .large-title-text, .symbol-button { color: #ffffff; }
  }

  @media (prefers-reduced-motion: reduce) {
    .toolbar, .inline-title, .large-title-text {
      transition: none;
    }
  }
</style>
```

### Flutter

```dart
// iOS 26 스타일 AppBar
class LiquidGlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isLargeTitle;
  final VoidCallback? onBack;
  final String? backLabel;
  final List<Widget>? actions;

  const LiquidGlassAppBar({
    required this.title,
    this.isLargeTitle = false,
    this.onBack,
    this.backLabel,
    this.actions,
  });

  @override
  Size get preferredSize => Size.fromHeight(isLargeTitle ? 96 : 44);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), // frost medium
        child: Container(
          height: preferredSize.height,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            border: const Border(
              bottom: BorderSide(
                color: Color(0x1F000000), // separators.nonOpaque light
                width: 0.5,
              ),
            ),
          ),
          child: Column(
            children: [
              // Standard 44pt 영역
              SizedBox(
                height: 44,
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    if (onBack != null)
                      GestureDetector(
                        onTap: onBack,
                        child: Row(children: [
                          const Icon(CupertinoIcons.chevron_back,
                            color: Color(0xFF0088FF), size: 20), // accents.blue
                          if (backLabel != null)
                            Text(backLabel!,
                              style: const TextStyle(
                                color: Color(0xFF0088FF),
                                fontSize: 17, fontWeight: FontWeight.w400)),
                        ]),
                      ),
                    const Spacer(),
                    if (!isLargeTitle)
                      Text(title,
                        style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600,
                          letterSpacing: -0.43, color: Colors.black)),
                    const Spacer(),
                    ...?actions,
                    const SizedBox(width: 16),
                  ],
                ),
              ),
              // Large Title 영역 (96pt 모드에서만)
              if (isLargeTitle)
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(title,
                      style: const TextStyle(
                        fontSize: 34, fontWeight: FontWeight.w400,
                        letterSpacing: 0.4, color: Colors.black)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### SwiftUI (참고용)

```swift
// iOS 26 NavigationStack with Large Title
NavigationStack {
  ContentView()
    .navigationTitle("Title")
    .navigationBarTitleDisplayMode(.large) // or .inline
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button("Back") { dismiss() }
      }
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: { }) {
          Image(systemName: "plus")
        }
      }
    }
}
// iOS 26: Liquid Glass 배경은 시스템이 자동 적용
// UINavigationBarAppearance로 커스터마이징 가능
```
