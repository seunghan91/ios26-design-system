# Windows — iPadOS 26 / macOS 컴포넌트 스펙

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="5413:10149")`

---

## 1. 개요

iPadOS 26 Windows 컴포넌트는 **Stage Manager** 환경에서 사용되는 멀티 윈도우 UI 시스템이다. macOS 스타일의 윈도우 컨트롤(닫기/최소화/전체화면)과 크기 조절 핸들, 포커스/비포커스 상태 관리를 포함한다.

| 서브컴포넌트 | Node | 설명 |
|------------|------|------|
| `_Window Controls` | `5413:10149` 내부 | 닫기 / 최소화 / 전체화면 버튼 (2 variants) |
| `_Window Resize` | `5413:10149` 내부 | 8방향 크기 조절 핸들 |
| `Window Container` | `5413:10149` | 전체 윈도우 프레임 + 그림자 |

**플랫폼 지원**:
- iPadOS 13+ Stage Manager (iPad Pro M1 이상, iPadOS 16+에서 외부 디스플레이 지원)
- macOS Catalyst 앱 (동일 API)
- iPhone: 미지원 (단일 앱 전체화면만)

---

## 2. 치수 & 레이아웃

### 2.1 윈도우 크기 규칙

```
┌─────────────────────────────────────────────┐
│  ●  ●  ●  [  App Title           ] [─] [□] │  ← 타이틀 바, 높이 36pt
├─────────────────────────────────────────────┤
│                                             │
│              앱 콘텐츠 영역                  │
│                                             │
└─────────────────────────────────────────────┘
      ← 기본: 1180pt →
  ↕ 기본: 820pt
```

| 크기 | 너비 | 높이 | 비율 | 사용 장면 |
|------|------|------|------|---------|
| **기본 (Standard)** | 1180pt | 820pt | ~16:11 | iPad Pro 13" 기본 윈도우 |
| **중형** | 860pt | 640pt | ~4:3 | 두 창 나란히 배치 |
| **소형** | 620pt | 480pt | ~4:3 | 보조 창 |
| **최소** | 320pt | 320pt | 1:1 | 허용 최소 크기 |
| **최대** | 전체화면 | 전체화면 | 기기 비율 | 전체화면 모드 |

| 항목 | 값 |
|------|-----|
| **코너 반경** | 12pt (전체 윈도우) |
| **타이틀 바 높이** | 36pt |
| **최소 크기** | 320×320pt |
| **크기 조절 핸들 크기** | 12×12pt (모서리), 8pt (엣지 중앙) |
| **그림자 offset** | 0, 8pt (아래 방향) |
| **그림자 blur** | 24pt |
| **그림자 opacity** | 0.25 (포커스), 0.10 (비포커스) |

### 2.2 윈도우 코너 반경 상세

```
┌──────────────────────────────────┐
│  r=12pt                  r=12pt  │ ← 상단 코너
│                                  │
│                                  │
│  r=12pt                  r=12pt  │ ← 하단 코너
└──────────────────────────────────┘
```

- **코너 반경**: 12pt 전체 균일 (`radius.window` = 12)
- 타이틀 바 + 콘텐츠 영역이 연속적 radius 공유 (클리핑으로 처리)

---

## 3. Window Controls (`_Window Controls`)

### 3.1 버튼 배치

```
┌──────────────────────────────────────────────┐
│ ●  ●  ●                                     │
│ ↑  ↑  ↑                                     │
│ 닫  최  전                                   │
│ 기  소  체                                   │
│    화  화                                   │
│    면  면                                   │
└──────────────────────────────────────────────┘
  12pt 12pt 12pt (각 버튼 간격 8pt)
  ← 컨트롤 영역 시작: 왼쪽 패딩 12pt →
```

| 항목 | 값 |
|------|-----|
| **버튼 직경** | 12pt |
| **버튼 간격** | 8pt |
| **왼쪽 여백** | 12pt |
| **상하 여백** | 타이틀 바 내 중앙 정렬 (36pt 높이 기준) |
| **전체 컨트롤 너비** | 12+8+12+8+12 = 52pt |
| **터치 타겟** | 최소 44×44pt (실제 버튼보다 히트 영역 확장) |

### 3.2 버튼 색상 (2 Variants)

**Variant 1: Focused (포커스 상태)**

| 버튼 | 배경색 | 아이콘 | 아이콘 색상 |
|------|--------|--------|-----------|
| **닫기 (Close)** | `#FF5F57` | × | `#7C0000` |
| **최소화 (Minimize)** | `#FEBC2E` | − | `#7C4D00` |
| **전체화면 (Fullscreen)** | `#28C840` | ⤢ | `#006500` |

**Variant 2: Unfocused (비포커스 상태)**

| 버튼 | 배경색 | 아이콘 |
|------|--------|--------|
| **닫기** | `rgba(0,0,0,0.12)` (회색) | 숨김 |
| **최소화** | `rgba(0,0,0,0.12)` (회색) | 숨김 |
| **전체화면** | `rgba(0,0,0,0.12)` (회색) | 숨김 |

> **아이콘 표시 규칙**: 포커스 상태에서만 아이콘 표시. 비포커스 시 단색 원형 점만 표시.

**호버 상태** (마우스 오버 — iPadOS 26 포인터 지원):

| 버튼 | 배경색 변화 | 아이콘 강조 |
|------|-----------|-----------|
| **닫기** | `#FF5F57` → `#FF2D20` | × 진하게 |
| **최소화** | `#FEBC2E` → `#FFA800` | − 진하게 |
| **전체화면** | `#28C840` → `#00A820` | ⤢ 진하게 |

### 3.3 버튼 아이콘 스펙

| 아이콘 | 크기 | 선 두께 | 설명 |
|--------|------|---------|------|
| × (Close) | 6×6pt | 1.5pt | 대각선 × 형태 |
| − (Minimize) | 6×2pt | 1.5pt | 수평선 |
| ⤢ (Fullscreen) | 6×6pt | 1.5pt | 양방향 화살표 또는 최대화 기호 |

---

## 4. Window Resize 핸들

### 4.1 8방향 리사이즈 핸들 배치

```
┌●──────────────●──────────────●┐
│  NW           N           NE  │
●                               ●
│ W                           E │
●                               ●
│  SW           S           SE  │
└●──────────────●──────────────●┘
```

| 핸들 위치 | 커서 | 방향 |
|---------|------|------|
| NW (왼상) | `↖` resize | 너비↔높이 동시 |
| N (상단 중앙) | `↕` resize | 높이만 |
| NE (우상) | `↗` resize | 너비↔높이 동시 |
| W (좌측 중앙) | `↔` resize | 너비만 |
| E (우측 중앙) | `↔` resize | 너비만 |
| SW (좌하) | `↙` resize | 너비↔높이 동시 |
| S (하단 중앙) | `↕` resize | 높이만 |
| SE (우하) | `↘` resize | 너비↔높이 동시 |

### 4.2 핸들 치수

| 항목 | 값 |
|------|-----|
| **모서리 핸들 크기** | 12×12pt |
| **엣지 핸들 크기** | 너비 방향 8pt (시각적), 터치 타겟 20pt |
| **핸들 히트 영역** | 외곽에서 내부/외부 각 6pt 확장 |
| **핸들 색상 (포커스)** | `rgba(0,0,0,0)` 투명 (시각적으로 숨김) |
| **핸들 색상 (드래그 중)** | `accents.blue` 미세 하이라이트 |

> 핸들은 평소에 투명 — 경계 근처에서 커서 변경으로만 인식 가능.

---

## 5. 색상 토큰 매핑

```json
// ../tokens/colors.json 참조
{
  "window": {
    "background": "Colors/Background/Primary",
    "titleBar": {
      "background": "Colors/Background/Secondary",
      "label": "Colors/Label/Primary",
      "separator": "Colors/Separator/Opaque"
    },
    "shadow": {
      "focused": "rgba(0, 0, 0, 0.25)",
      "unfocused": "rgba(0, 0, 0, 0.10)"
    },
    "overlay": {
      "unfocused": "rgba(0, 0, 0, 0.08)"
    },
    "controls": {
      "close": { "default": "#FF5F57", "hover": "#FF2D20" },
      "minimize": { "default": "#FEBC2E", "hover": "#FFA800" },
      "fullscreen": { "default": "#28C840", "hover": "#00A820" },
      "unfocused": "rgba(0, 0, 0, 0.12)"
    },
    "resize": {
      "handle": "transparent",
      "handleActive": "Colors/Tint/Blue"
    }
  }
}
```

| 요소 | Light | Dark |
|------|-------|------|
| **타이틀 바 배경** | `rgba(246,246,246,0.85)` | `rgba(30,30,30,0.85)` |
| **구분선** | `rgba(0,0,0,0.1)` | `rgba(255,255,255,0.08)` |
| **비포커스 오버레이** | `rgba(0,0,0,0.08)` | `rgba(0,0,0,0.2)` |
| **닫기 버튼** | `#FF5F57` | `#FF5F57` (동일) |
| **최소화 버튼** | `#FEBC2E` | `#FEBC2E` (동일) |
| **전체화면 버튼** | `#28C840` | `#28C840` (동일) |
| **비포커스 버튼** | `rgba(0,0,0,0.12)` | `rgba(255,255,255,0.12)` |

---

## 6. 타이포그래피 (타이틀 바)

```json
// ../tokens/typography.json 참조
{
  "window": {
    "title": {
      "fontStyle": "Subheadline",
      "weight": "Semibold",
      "size": "15pt",
      "letterSpacing": "-0.23pt",
      "alignment": "center"
    }
  }
}
```

| 항목 | 값 |
|------|-----|
| **폰트** | SF Pro Display, 15pt Semibold |
| **Letter Spacing** | -0.23pt |
| **정렬** | 가운데 정렬 (컨트롤 버튼과 겹치지 않도록) |
| **색상 (포커스)** | `labels.primary` |
| **색상 (비포커스)** | `labels.tertiary` |
| **최대 너비** | 윈도우 너비 - 120pt (좌우 컨트롤 공간 제외) |
| **오버플로우** | 말줄임표 (center truncation) |

---

## 7. 간격 토큰

```json
// ../tokens/spacing.json 참조
{
  "window": {
    "cornerRadius": 12,
    "titleBarHeight": 36,
    "controls": {
      "buttonDiameter": 12,
      "buttonGap": 8,
      "leftPadding": 12
    },
    "shadow": {
      "offsetY": 8,
      "blur": 24,
      "focusedOpacity": 0.25,
      "unfocusedOpacity": 0.10
    },
    "sizes": {
      "default": { "width": 1180, "height": 820 },
      "medium": { "width": 860, "height": 640 },
      "small": { "width": 620, "height": 480 },
      "minimum": { "width": 320, "height": 320 }
    },
    "resize": {
      "cornerHandleSize": 12,
      "edgeHandleSize": 8,
      "hitAreaExpand": 6
    }
  }
}
```

---

## 8. 애니메이션

```json
// ../tokens/animations.json 참조
{
  "window": {
    "appear": {
      "type": "spring",
      "from": { "opacity": 0, "scale": 0.85 },
      "to": { "opacity": 1, "scale": 1 },
      "stiffness": 320,
      "damping": 28,
      "duration": "~0.4s"
    },
    "dismiss": {
      "type": "spring",
      "from": { "opacity": 1, "scale": 1 },
      "to": { "opacity": 0, "scale": 0.85 },
      "stiffness": 400,
      "damping": 35,
      "duration": "~0.3s"
    },
    "minimize": {
      "type": "spring",
      "to": { "scale": 0.1, "opacity": 0 },
      "origin": "stage_manager_thumbnail",
      "stiffness": 350,
      "damping": 30
    },
    "restore": {
      "type": "spring",
      "from": "stage_manager_thumbnail",
      "to": { "scale": 1, "opacity": 1 },
      "stiffness": 320,
      "damping": 26
    },
    "focusTransition": {
      "type": "easeOut",
      "duration": "0.2s",
      "properties": ["shadow", "overlay", "titleBarOpacity"]
    },
    "resize": {
      "type": "linear",
      "followCursor": true,
      "minConstraintHaptic": "UIImpactFeedbackGenerator.FeedbackStyle.rigid"
    },
    "fullscreen": {
      "type": "spring",
      "stiffness": 280,
      "damping": 24,
      "duration": "~0.5s"
    }
  }
}
```

### 주요 애니메이션 상세

#### 윈도우 등장 (appear)
1. 스케일 0.85 + opacity 0 에서 시작
2. spring (stiffness 320, damping 28)으로 scale 1.0 + opacity 1.0으로 전환
3. 총 소요 시간: ~400ms

#### 포커스 전환 (포커스 ↔ 비포커스)
1. 그림자 opacity: 0.25 → 0.10 (또는 역방향), 200ms ease-out
2. 오버레이: `rgba(0,0,0,0)` → `rgba(0,0,0,0.08)`, 200ms ease-out
3. 컨트롤 버튼: 색상 → 회색, 150ms ease-out
4. 타이틀 색상: `labels.primary` → `labels.tertiary`

#### 리사이즈 (resize)
- 실시간 팔로우 (선형, 60fps)
- 최소 크기(320×320pt) 도달 시 `.rigid` haptic
- 리사이즈 완료 후 레이아웃 spring 재조정

---

## 9. 포커스 / 비포커스 상태

### 9.1 포커스 상태 (Focused)

```
┌──────────────────────────────────────────┐
│ ●  ●  ●   앱 이름           [─] [□]     │ ← 타이틀 바 불투명
├──────────────────────────────────────────┤
│                                          │
│              콘텐츠                       │ ← 완전 선명
│                                          │
└──────────────────────────────────────────┘
         그림자 강함 (opacity 0.25)
```

| 요소 | 포커스 상태 |
|------|-----------|
| 그림자 opacity | 0.25 |
| 컨트롤 버튼 | 빨강/노랑/초록 색상 |
| 타이틀 색상 | `labels.primary` |
| 콘텐츠 오버레이 | 없음 |
| z-order | 최상단 |

### 9.2 비포커스 상태 (Unfocused)

```
┌──────────────────────────────────────────┐
│ ○  ○  ○   앱 이름 (연하게)               │ ← 타이틀 바 dim
├──────────────────────────────────────────┤
│                                          │
│        콘텐츠 (dimmed 오버레이)           │ ← rgba(0,0,0,0.08)
│                                          │
└──────────────────────────────────────────┘
         그림자 약함 (opacity 0.10)
```

| 요소 | 비포커스 상태 |
|------|------------|
| 그림자 opacity | 0.10 |
| 컨트롤 버튼 | 회색 원형 (`rgba(0,0,0,0.12)`) |
| 타이틀 색상 | `labels.tertiary` |
| 콘텐츠 오버레이 | `rgba(0,0,0,0.08)` dimmed |
| z-order | 포커스 윈도우 아래 |

---

## 10. Stage Manager 통합

### 10.1 썸네일 (Shelf)

Stage Manager 좌측 세로 선반(Shelf)에 표시되는 앱 썸네일:

| 항목 | 값 |
|------|-----|
| **썸네일 크기** | 약 170×120pt |
| **썸네일 코너 반경** | 8pt |
| **선택 링** | 2pt `accents.blue` |
| **그룹 최대 앱 수** | 4개 앱 동시 표시 |
| **그룹 레이아웃** | 2×2 격자 또는 오버랩 |

### 10.2 최근 앱 영역

최근 실행 앱 썸네일 그룹:

| 항목 | 값 |
|------|-----|
| **그룹 너비** | 160pt |
| **그룹 높이** | 120pt |
| **앱 아이콘 크기** | 30pt (그룹 내 오버레이) |
| **그룹 코너 반경** | 12pt |

---

## 11. 플랫폼별 구현

### UIKit / UIScene

```swift
import UIKit

// Info.plist: UIApplicationSupportsMultipleScenes = true

// Scene 설정
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // 윈도우 크기 요청 (Stage Manager)
        if let sizeRestrictions = windowScene.sizeRestrictions {
            sizeRestrictions.minimumSize = CGSize(width: 320, height: 320)
            sizeRestrictions.maximumSize = CGSize(width: CGFloat.infinity, height: CGFloat.infinity)
        }

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
    }
}

// 새 씬(윈도우) 열기
func openNewWindow(userActivity: NSUserActivity? = nil) {
    let options = UIScene.ActivationRequestOptions()
    options.requestingScene = view.window?.windowScene

    UIApplication.shared.requestSceneSessionActivation(
        nil,           // nil = 새 씬 생성
        userActivity: userActivity,
        options: options
    ) { error in
        if let error = error {
            print("윈도우 열기 실패: \(error)")
        }
    }
}

// 씬 닫기
func closeCurrentWindow() {
    guard let scene = view.window?.windowScene else { return }
    UIApplication.shared.requestSceneSessionDestruction(
        scene.session,
        options: nil
    ) { _ in }
}
```

### SwiftUI (`WindowGroup`)

```swift
import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        // 메인 윈도우 그룹
        WindowGroup {
            ContentView()
        }
        // 보조 윈도우 그룹 (다른 뷰)
        WindowGroup("설정", id: "settings") {
            SettingsView()
        }
        .defaultSize(width: 620, height: 480)                    // 기본 크기
        .windowResizability(.contentMinSize)                      // 최소 크기 기준
    }
}

// 윈도우 열기 (SwiftUI 환경에서)
struct ContentView: View {
    @Environment(\.supportsMultipleWindows) private var supportsMultipleWindows
    @Environment(\.openWindow) private var openWindow

    var body: some View {
        VStack {
            Text("메인 윈도우")

            if supportsMultipleWindows {
                Button("설정 창 열기") {
                    openWindow(id: "settings")
                }
            }
        }
    }
}

// 윈도우 크기 제약
struct ResizableWindow: View {
    var body: some View {
        NavigationStack { /* ... */ }
            .frame(minWidth: 320, minHeight: 320)   // 최소 크기
    }
}
```

### Svelte 5 (웹 — 윈도우 컨트롤 UI 구현)

```svelte
<script lang="ts">
  interface WindowProps {
    title: string;
    width?: number;
    height?: number;
    focused?: boolean;
    onclose?: () => void;
    onminimize?: () => void;
    onfullscreen?: () => void;
    children: import('svelte').Snippet;
  }

  let {
    title,
    width = 1180,
    height = 820,
    focused = true,
    onclose,
    onminimize,
    onfullscreen,
    children
  }: WindowProps = $props();

  let isHoveringControls = $state(false);
  let isDragging = $state(false);
  let isResizing = $state(false);

  let pos = $state({ x: 100, y: 60 });
  let size = $state({ w: width, h: height });

  // 드래그 (타이틀 바)
  function startDrag(e: PointerEvent) {
    if ((e.target as HTMLElement).closest('.window-controls')) return;
    isDragging = true;
    const startX = e.clientX - pos.x;
    const startY = e.clientY - pos.y;

    const onMove = (e: PointerEvent) => {
      pos = { x: e.clientX - startX, y: e.clientY - startY };
    };
    const onUp = () => {
      isDragging = false;
      window.removeEventListener('pointermove', onMove);
      window.removeEventListener('pointerup', onUp);
    };
    window.addEventListener('pointermove', onMove);
    window.addEventListener('pointerup', onUp);
  }
</script>

<div
  class="window"
  class:focused
  class:dragging={isDragging}
  style="
    width: {size.w}px;
    height: {size.h}px;
    transform: translate({pos.x}px, {pos.y}px);
    border-radius: 12px;
    box-shadow: {focused
      ? '0 8px 24px rgba(0,0,0,0.25)'
      : '0 4px 12px rgba(0,0,0,0.10)'};
  "
>
  <!-- 타이틀 바 -->
  <div
    class="title-bar"
    onpointerdown={startDrag}
    onmouseenter={() => isHoveringControls = false}
    style="
      height: 36px;
      display: flex;
      align-items: center;
      padding: 0 12px;
      background: {focused ? 'rgba(246,246,246,0.85)' : 'rgba(246,246,246,0.6)'};
      backdrop-filter: blur(20px);
      border-bottom: 1px solid rgba(0,0,0,0.1);
      border-radius: 12px 12px 0 0;
      cursor: default;
      user-select: none;
    "
  >
    <!-- Window Controls -->
    <div
      class="window-controls"
      style="display: flex; gap: 8px; align-items: center;"
      onmouseenter={() => isHoveringControls = true}
      onmouseleave={() => isHoveringControls = false}
    >
      <!-- 닫기 -->
      <button
        class="control-btn close"
        onclick={onclose}
        aria-label="창 닫기"
        style="
          width: 12px; height: 12px; border-radius: 50%; border: none; cursor: pointer;
          background: {focused ? '#FF5F57' : 'rgba(0,0,0,0.12)'};
          display: flex; align-items: center; justify-content: center;
        "
      >
        {#if focused && isHoveringControls}
          <svg width="6" height="6" viewBox="0 0 6 6" fill="none">
            <path d="M1 1L5 5M5 1L1 5" stroke="#7C0000" stroke-width="1.5" stroke-linecap="round"/>
          </svg>
        {/if}
      </button>

      <!-- 최소화 -->
      <button
        class="control-btn minimize"
        onclick={onminimize}
        aria-label="창 최소화"
        style="
          width: 12px; height: 12px; border-radius: 50%; border: none; cursor: pointer;
          background: {focused ? '#FEBC2E' : 'rgba(0,0,0,0.12)'};
          display: flex; align-items: center; justify-content: center;
        "
      >
        {#if focused && isHoveringControls}
          <svg width="6" height="2" viewBox="0 0 6 2" fill="none">
            <path d="M0 1H6" stroke="#7C4D00" stroke-width="1.5" stroke-linecap="round"/>
          </svg>
        {/if}
      </button>

      <!-- 전체화면 -->
      <button
        class="control-btn fullscreen"
        onclick={onfullscreen}
        aria-label="전체화면"
        style="
          width: 12px; height: 12px; border-radius: 50%; border: none; cursor: pointer;
          background: {focused ? '#28C840' : 'rgba(0,0,0,0.12)'};
          display: flex; align-items: center; justify-content: center;
        "
      >
        {#if focused && isHoveringControls}
          <svg width="6" height="6" viewBox="0 0 6 6" fill="none">
            <path d="M1 5L5 1M1 1L1 5L5 5" stroke="#006500" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
          </svg>
        {/if}
      </button>
    </div>

    <!-- 타이틀 -->
    <div style="
      flex: 1; text-align: center; font-size: 15px; font-weight: 600;
      letter-spacing: -0.23px;
      color: {focused ? '#000000' : 'rgba(60,60,67,0.3)'};
      overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
      margin: 0 60px;
    ">
      {title}
    </div>
  </div>

  <!-- 콘텐츠 영역 -->
  <div
    class="window-content"
    style="
      flex: 1; overflow: auto; position: relative;
      border-radius: 0 0 12px 12px;
    "
  >
    {#if !focused}
      <!-- 비포커스 오버레이 -->
      <div style="
        position: absolute; inset: 0;
        background: rgba(0,0,0,0.08);
        pointer-events: none; z-index: 100;
        border-radius: 0 0 12px 12px;
      " />
    {/if}
    {@render children()}
  </div>
</div>

<style>
  .window {
    position: absolute;
    display: flex;
    flex-direction: column;
    overflow: hidden;
    transition:
      box-shadow 0.2s ease-out,
      opacity 0.2s ease-out;
  }

  .window.focused { z-index: 100; }

  .control-btn {
    flex-shrink: 0;
    transition: background-color 0.15s ease;
  }

  .control-btn:focus-visible {
    outline: 2px solid #0088FF;
    outline-offset: 2px;
  }

  @media (prefers-reduced-motion: reduce) {
    .window { transition: none; }
    .control-btn { transition: none; }
  }
</style>
```

---

## 12. 다크모드 대응

| 요소 | Light | Dark |
|------|-------|------|
| 타이틀 바 배경 | `rgba(246,246,246,0.85)` | `rgba(30,30,30,0.85)` |
| 구분선 | `rgba(0,0,0,0.10)` | `rgba(255,255,255,0.08)` |
| 타이틀 텍스트 (포커스) | `#000000` | `#FFFFFF` |
| 타이틀 텍스트 (비포커스) | `rgba(60,60,67,0.3)` | `rgba(235,235,245,0.3)` |
| 비포커스 버튼 | `rgba(0,0,0,0.12)` | `rgba(255,255,255,0.12)` |
| 비포커스 오버레이 | `rgba(0,0,0,0.08)` | `rgba(0,0,0,0.20)` |
| 컨트롤 버튼 (닫기/최소화/전체화면) | 동일 (#FF5F57 등) | 동일 (#FF5F57 등) |

---

## 13. 엣지 케이스

- **최소 크기 제약**: 리사이즈 중 320×320pt 미만 시 `.rigid` haptic + 크기 고정
- **외부 디스플레이**: iPadOS 16+에서 외부 모니터 연결 시 최대 크기 확장 (4K 해상도 기준)
- **슬라이드 오버**: Stage Manager 비활성 상태에서는 슬라이드 오버(Slide Over) 모드 사용 — 320pt 고정 너비
- **분할 화면(Split View)**: Stage Manager 비활성 시 50/50 또는 75/25 분할
- **iPhone**: `UIApplication.shared.supportsMultipleScenes` = false — 윈도우 관련 API 사용 불가
- **키보드 단축키**: Cmd+W 닫기, Cmd+M 최소화, Ctrl+Cmd+F 전체화면 (UIKeyCommand)
- **Pointer Lock**: 게임 앱에서 커서 잠금 시 리사이즈 핸들 히트 영역 무효화 필요

---

## 14. 접근성

| 항목 | 요구사항 |
|------|---------|
| **VoiceOver (Close)** | `"닫기, 버튼"`, 더블 탭으로 창 닫기 |
| **VoiceOver (Minimize)** | `"최소화, 버튼"`, 더블 탭으로 Stage Manager 썸네일로 이동 |
| **VoiceOver (Fullscreen)** | `"전체화면, 버튼"`, 더블 탭으로 전체화면 전환 |
| **키보드 포커스** | 컨트롤 버튼은 Tab으로 접근 가능 |
| **최소 터치 타겟** | 컨트롤 버튼 12pt → 44pt 히트 영역 확장 |
| **포커스 링** | `focus-visible` 시 2px `accents.blue` 링 |
| **감소된 모션** | 윈도우 등장/사라짐 — scale 없이 fade만 |

---

## 15. 체크리스트

- [ ] 윈도우 코너 반경 12pt
- [ ] 타이틀 바 높이 36pt
- [ ] 컨트롤 버튼 직경 12pt, 간격 8pt
- [ ] 포커스 그림자: offset(0,8pt), blur 24pt, opacity 0.25
- [ ] 비포커스 그림자: opacity 0.10
- [ ] 비포커스 오버레이: rgba(0,0,0,0.08)
- [ ] 2 variants (포커스/비포커스) 구현
- [ ] 포커스 전환 0.2s ease-out
- [ ] 최소 크기 320×320pt 제약
- [ ] 컨트롤 버튼 호버 상태 (색상 강화)
- [ ] 타이틀 말줄임표 (center truncation)
- [ ] 다크모드 타이틀 바/오버레이 대응
- [ ] VoiceOver: 버튼 레이블 제공
- [ ] 키보드 단축키 (Cmd+W, Cmd+M, Ctrl+Cmd+F)
- [ ] `UIApplicationSupportsMultipleScenes = true` (Info.plist)
