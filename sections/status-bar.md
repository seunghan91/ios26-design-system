# Status Bar — iOS 26 섹션 스펙

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24689")`

---

## 개요

Status Bar는 화면 최상단에 위치하는 시스템 정보 표시 영역이다. iOS 26에서는 Dynamic Island 탑재 기기(iPhone 14 Pro 이후)와 홈버튼/노치 기기, iPad 세 가지 레이아웃을 구분한다. Status Bar 자체는 앱이 직접 렌더링하지 않으며, **UIStatusBarStyle** / `preferredStatusBarStyle` / SwiftUI `.statusBarHidden()` 등으로 표시/숨김 및 색상 모드만 제어한다.

### 주요 변경 사항 (iOS 26)

- **Liquid Glass 소재 연동**: Navigation Bar와 결합될 때 status bar 영역도 Liquid Glass 소재가 연속적으로 적용된다.
- **Dynamic Island**: 항상 표시되며, 시스템 알림/Live Activity가 있을 경우 확장된다.
- **콘텐츠 자동 전환**: status bar 아래 content region의 배경에 따라 light/dark 스타일이 자동 전환된다.

---

## 치수 (pt 값)

### iPhone — 높이

| 기기 유형 | 높이 | Safe Area top inset | 비고 |
|----------|------|---------------------|------|
| Dynamic Island 기기 (iPhone 14 Pro ~) | **54pt** | **59pt** | status bar 54pt + 5pt 여백 |
| 노치 기기 (iPhone X ~ iPhone 13) | **47pt** | **47pt** | TrueDepth 카메라 영역 |
| 홈버튼 기기 (iPhone SE 등) | **20pt** | **20pt** | 고정 높이 |
| 가로 방향 (landscape) | **0pt** | **0pt** | 가로모드에서 status bar 숨김 (기본값) |

> `spacing.json` → `safeArea.iphone16Pro.top = 59`, `safeArea.iphoneSE.top = 20` 참조

### iPad — 높이

| 기기 유형 | 높이 | Safe Area top inset | 비고 |
|----------|------|---------------------|------|
| iPad (모든 모델) | **24pt** | **24pt** | 고정. 노치/DI 없음 |
| iPad Pro M4 (2024~) | **24pt** | **24pt** | 동일 |
| iPad landscape | **24pt** | **24pt** | 세로/가로 동일 |

> `spacing.json` → `safeArea.ipadLandscape.top = 24` 참조

### Dynamic Island 치수

| 상태 | 너비 | 높이 | 위치 |
|------|------|------|------|
| 기본 (idle) | **37pt** | **12pt** | 화면 상단 중앙, 상단에서 11pt |
| 콤팩트 리딩 (compact leading) | **37pt** | **36pt** | 좌측 확장 |
| 콤팩트 트레일링 (compact trailing) | **37pt** | **36pt** | 우측 확장 |
| 미니 (minimal) | **12pt** | **12pt** | 우측 상단 분리 |
| 확장 (expanded) | **화면너비 - 24pt** | **84pt** (기본) | 상단 고정, 최대 높이 변동 |

---

## 콘텐츠 배치

### 기본 레이아웃 (Dynamic Island 기기)

```
┌──────────────────────────────────────────┐  ← 화면 상단
│  ████████████  [DI]  ██████████████████  │  ← 54pt 높이
│  9:41 AM     ╔════╗  ◎  ▲▲▲  ████▓░  │
│              ╚════╝                      │
└──────────────────────────────────────────┘
  ↑                              ↑
  시간 (좌상단, 16pt margin)    신호·와이파이·배터리 (우상단)
```

### 콘텐츠 요소별 위치

| 요소 | 위치 | 크기 | 타이포그래피 토큰 |
|------|------|------|----------------|
| 시간 | 좌상단 (leading) | — | `typography.styles.body` (17pt, Semibold) |
| 이동통신 신호 강도 | 우상단 trailing 영역 | 17×12pt | SF Symbol `cellularbars` |
| Wi-Fi | 우상단 trailing 영역 | 15×12pt | SF Symbol `wifi` |
| 배터리 | 최우상단 | 25×12pt | SF Symbol `battery.*` |
| 위치 서비스 표시 | 우상단 (서비스 사용 시) | 12×12pt | SF Symbol `location.fill` |
| 알람 표시 | 우상단 (알람 설정 시) | 12×12pt | SF Symbol `alarm` |

### 홈버튼 기기 (SE 등)

```
┌──────────────────────────────────────────┐  ← 화면 상단
│  9:41 AM           ◎  ▲▲▲  ████▓░  │  ← 20pt 높이
└──────────────────────────────────────────┘
```

---

## 색상 / Material 규칙

### Status Bar Style (UIStatusBarStyle)

| 스타일 | 콘텐츠 색상 | 사용 시점 |
|--------|------------|---------|
| `.default` | 자동 (Dark 시스템: 흰색, Light: 검정) | 기본값 |
| `.lightContent` | **흰색** | 어두운 배경 위 (dark navigation bar 등) |
| `.darkContent` | **검정** | 밝은 배경 위 (white navigation bar 등) |

### 자동 전환 규칙

1. **Navigation Bar 배경이 불투명(opaque)할 때**: navigation bar의 `barStyle`에 연동
2. **Navigation Bar가 투명(translucent)하거나 hidden일 때**: scroll position에 따라 변동
3. **Liquid Glass navigation bar**: 배경 blur 소재가 어두우면 `.lightContent`, 밝으면 `.darkContent`
4. **풀스크린 콘텐츠**: `preferredStatusBarStyle`을 오버라이드하여 강제 지정

### 색상 토큰 매핑

| 상황 | 토큰 경로 | 값 (Light) | 값 (Dark) |
|------|----------|-----------|----------|
| 기본 텍스트 (light content) | `colors.labels.primary.dark` | — | `#ffffff` |
| 기본 텍스트 (dark content) | `colors.labels.primary.light` | `#000000` | — |
| 배경 투명 | — | `rgba(0,0,0,0)` | `rgba(0,0,0,0)` |

---

## 동작 / 애니메이션

### 스크롤에 따른 변화

```
스크롤 전 (Large Title visible)
┌──────────────┐
│ Status Bar   │  lightContent (네비바 투명)
│ Nav Bar      │  투명 + Large Title
│ Content      │  배경색에 따라 status bar 스타일 결정

스크롤 후 (inline title)
┌──────────────┐
│ Status Bar   │  Liquid Glass nav bar 색상에 따라 자동 전환
│ Nav Bar      │  Liquid Glass, blur(12px), inline title
│ Content      │
```

### 전환 애니메이션

| 이벤트 | 애니메이션 |
|--------|----------|
| Push 전환 | 함께 슬라이드 (status bar는 고정) |
| Sheet present | status bar 스타일 즉시 전환 (크로스페이드, 0.3s) |
| Alert present | status bar 스타일 유지 |
| 가로/세로 전환 | status bar 숨김/표시 rotation과 함께 애니메이션 |
| Live Activity 활성화 | Dynamic Island 확장 (spring, stiffness:260, damping:28) |

### Dynamic Island 확장 애니메이션

```
idle (37×12pt)
  ↓ spring 시작 (stiffness:300, damping:35)
expanded (화면너비-24pt × 84pt~120pt)
  ↓ 콘텐츠에 따라 높이 동적 결정
  ↓ 탭 시 앱으로 전환
```

---

## Accessibility

| 항목 | 규칙 |
|------|------|
| VoiceOver | Status bar 요소는 시스템이 자동 읽어줌. 앱이 별도 접근성 처리 불필요 |
| Dynamic Type | status bar 시간 등 시스템 텍스트는 Dynamic Type 미적용 (고정 17pt) |
| Reduce Transparency | status bar 배경 blurring 비활성화, 불투명 배경으로 대체 |
| Dark Mode | `.default` 스타일 사용 시 시스템 모드에 따라 자동 대응 |
| 대비율 | 시스템 UI — 앱 제어 불가. Light/Dark 스타일 올바르게 설정 필요 |

---

## 프레임워크별 구현

### UIKit

```swift
// ViewController 단위 override
override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent  // 또는 .darkContent, .default
}

// 숨김 처리
override var prefersStatusBarHidden: Bool {
    return false
}

// 애니메이션과 함께 스타일 변경
UIView.animate(withDuration: 0.3) {
    self.setNeedsStatusBarAppearanceUpdate()
}

// Info.plist에서 뷰 컨트롤러 기반 제어 활성화
// UIViewControllerBasedStatusBarAppearance = YES (기본값)
```

```swift
// NavigationController에서 일괄 적용
class AppNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
```

### SwiftUI

```swift
// 뷰 단위 제어
struct ContentView: View {
    @State private var isPresented = false

    var body: some View {
        NavigationStack {
            Text("Content")
                .navigationTitle("Home")
        }
        // preferredColorScheme으로 간접 제어
        .preferredColorScheme(.dark) // status bar → lightContent
    }
}

// 숨김 처리
struct FullscreenView: View {
    var body: some View {
        Image("photo")
            .ignoresSafeArea()
            .statusBarHidden(true)
    }
}

// iOS 26 — toolbarBackground로 nav bar 투명화 → status bar 연동
NavigationStack {
    ScrollView { content }
        .navigationTitle("대제목")
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        // → Liquid Glass 소재 적용, status bar 스타일 자동
}
```

### Flutter

```dart
// Status bar 스타일 제어 (SystemChrome)
import 'package:flutter/services.dart';

// 다크 status bar (밝은 배경 위)
SystemChrome.setSystemUIOverlayStyle(
  const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,          // iOS
    statusBarIconBrightness: Brightness.dark,        // Android
  ),
);

// 라이트 status bar (어두운 배경 위)
SystemChrome.setSystemUIOverlayStyle(
  const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,            // iOS
    statusBarIconBrightness: Brightness.light,       // Android
  ),
);

// Safe area 상단 inset 활용
SafeArea(
  top: true,
  child: Column(
    children: [/* content */],
  ),
)

// MediaQuery로 status bar 높이 조회
final statusBarHeight = MediaQuery.of(context).padding.top;
// iPhone 16 Pro → 59.0 (논리 픽셀, 54pt status bar + 5pt gap)
// iPhone SE → 20.0
// iPad → 24.0
```

```dart
// AppBar와 함께 사용 (권장)
Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  extendBodyBehindAppBar: true,
  body: /* content */,
)
```

### CSS / Svelte (웹 근사치)

웹에서는 status bar를 직접 렌더링하지 않는다. PWA 또는 WebView 환경에서의 고려 사항:

```svelte
<script lang="ts">
  // CSS env() 변수로 Safe Area 처리
  // iOS Safari PWA에서 status bar 영역 보호
</script>

<style>
  .app-root {
    /* Safe area 전체 적용 */
    padding-top: env(safe-area-inset-top);
    padding-bottom: env(safe-area-inset-bottom);
    padding-left: env(safe-area-inset-left);
    padding-right: env(safe-area-inset-right);
  }

  .navigation-bar {
    /* status bar 높이만큼 padding-top 추가 */
    padding-top: env(safe-area-inset-top);
    height: calc(44px + env(safe-area-inset-top));
  }

  /* status-bar-style meta tag 제어 */
  /* <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent"> */
  /* content 옵션: default | black | black-translucent */
</style>

<!-- PWA manifest에서 display_override 설정 -->
<!-- "display_override": ["window-controls-overlay"] -->
```

```html
<!-- HTML head — PWA status bar 색상 제어 -->
<meta name="theme-color" content="#ffffff" media="(prefers-color-scheme: light)">
<meta name="theme-color" content="#000000" media="(prefers-color-scheme: dark)">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
```

---

## Safe Area 참조 치수 요약

| 기기 | top | bottom | left | right |
|------|-----|--------|------|-------|
| iPhone 16 Pro (Dynamic Island) | 59pt | 34pt | 0pt | 0pt |
| iPhone 16 (Dynamic Island) | 59pt | 34pt | 0pt | 0pt |
| iPhone SE 3 (홈버튼) | 20pt | 0pt | 0pt | 0pt |
| iPhone (landscape, 노치) | 0pt | 21pt | 59pt | 59pt |
| iPad Pro 11" | 24pt | 20pt | 0pt | 0pt |
| iPad landscape (split view) | 24pt | 20pt | 20pt | 20pt |

> `spacing.json` → `safeArea` 객체 전체 참조

---

## 연관 섹션 / 컴포넌트

- **Navigation Region** (`navigation-region.md`): status bar 바로 아래, Safe Area top 포함 height 합산
- **System Region** (`system-region.md`): Dynamic Island 확장 상세 스펙
- **Toolbar 컴포넌트** (`../components/specs/toolbar.md`): navigation bar Liquid Glass 소재
