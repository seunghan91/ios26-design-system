# System Region — iOS 26 섹션 스펙

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24689")`

---

## 개요

System Region은 앱이 직접 렌더링하지 않는 시스템 전용 UI 영역이다. **Home Indicator**, **Dynamic Island 확장 영역**, **키보드**, **iPad Multitasking 표시자** 등이 포함된다. 앱은 이 영역의 치수를 **Safe Area inset**으로 읽어 콘텐츠가 겹치지 않도록 처리해야 한다.

### 핵심 원칙

- System Region 내부 요소(Home Indicator, Dynamic Island 등)는 **시스템이 렌더링** — 앱이 직접 그리면 안 됨
- 앱은 `safeAreaInsets` / `UIKeyboardLayoutGuide` 로 콘텐츠 영역을 조정
- iOS 26에서 키보드 avoidance 는 `UIKeyboardLayoutGuide` (UIKit) / `.ignoresSafeArea(.keyboard)` (SwiftUI) 사용 권장

---

## 치수 (pt 값)

### Home Indicator

| 속성 | 값 | 비고 |
|------|-----|------|
| 너비 | **134pt** | iPhone 16 Pro 기준 |
| 높이 | **5pt** | 가로 막대 바 |
| 화면 하단 margin | **8pt** | Home Indicator 하단 여백 |
| Safe Area bottom inset | **34pt** (홈버튼 없는 기기) | `spacing.json → safeArea.iphone16Pro.bottom` |
| Safe Area bottom inset | **0pt** (홈버튼 기기) | `spacing.json → safeArea.iphoneSE.bottom` |
| 색상 | `colors.labels.secondary` (반투명 회색) | 배경에 따라 자동 전환 |

```
화면 하단
┌──────────────────────────────────────────┐
│  Content + Tab Bar                       │
│                                          │
│         ────────────────                 │  ← Home Indicator (134×5pt)
│                                          │  ← 8pt 하단 여백
└──────────────────────────────────────────┘
← 390pt (iPhone 16 Pro 기준) →
```

### Dynamic Island

| 상태 | 너비 | 높이 | 배경 |
|------|------|------|------|
| 기본 (idle) | **37pt** | **12pt** | `#000000` (pill 모양) |
| 콤팩트 리딩 | **최대 126pt** | **36pt** | `#000000` |
| 콤팩트 트레일링 | **최대 160pt** | **36pt** | `#000000` |
| 미니멀 (분리) | **12pt** | **12pt** | `#000000` |
| 확장 (보통) | **화면너비 - 24pt** | **84pt** | `#000000` + 콘텐츠 |
| 확장 (높음) | **화면너비 - 24pt** | **120pt** | `#000000` + 콘텐츠 |
| 확장 (최대 Live Activity) | **화면너비 - 24pt** | **160pt** | `#000000` + 콘텐츠 |

**Dynamic Island 위치**:
- 화면 상단에서 **11pt** (상단 여백)
- 수평 기준: 화면 가로 중앙

```
[아이폰 16 Pro 상단, 390pt 너비]
┌────────────────────────────────────────┐
│    11pt 여백                            │
│       ╔═══════════════╗                │  ← Dynamic Island (기본: 37×12pt)
│       ║  [DI 콘텐츠] ║                │  ← 확장 시 최대 366×84~160pt
│       ╚═══════════════╝                │
│  Status Bar 나머지 영역                 │
└────────────────────────────────────────┘

[콤팩트 모드 — 음악 재생 중]
╔═══╗  status bar 나머지  ╔══════════╗
║   ║  (앨범 아트, 8×8pt) ║  곡 제목 ║
╚═══╝                     ╚══════════╝
  ↑ 콤팩트 리딩 (12×36pt)   ↑ 콤팩트 트레일링
```

#### Dynamic Island 확장 — 주요 앱 예시

| 앱/기능 | 높이 | 콘텐츠 |
|---------|------|--------|
| 전화 수신 | **84pt** | 발신자 이름 + 수락/거절 |
| 음악 재생 | **84pt** | 앨범아트 + 곡명 + 타임라인 |
| 타이머 | **84pt** | 남은 시간 표시 |
| 내비게이션 | **84pt** | 다음 경로 정보 |
| 스포츠 생중계 | **120pt** | 스코어 + 타임 |
| Live Activity (확장) | **84~160pt** | 앱별 레이아웃 |

---

### 키보드 높이

#### iPhone Portrait (세로 방향)

| 키보드 유형 | 높이 | 비고 |
|-----------|------|------|
| 기본 키보드 (영문) | **216pt** | iPhone 표준 |
| 기본 키보드 (한글) | **216pt** | 동일 |
| 키보드 + 제안 바 | **260pt** | QuickType suggestions 포함 |
| 키보드 + 툴바 | **260pt** | 앱 키보드 툴바 포함 |
| 이모지 키보드 | **291pt** | — |
| 숫자패드 | **216pt** | — |
| 전화번호패드 | **216pt** | — |

#### iPhone Landscape (가로 방향)

| 키보드 유형 | 높이 |
|-----------|------|
| 기본 키보드 | **162pt** |
| 키보드 + 제안 바 | **194pt** |

#### iPad

| 기기 | 키보드 높이 | 분리 키보드 |
|------|-----------|-----------|
| iPad 11" | **264pt** | 화면 하단 1/3 위치, 분리 가능 |
| iPad Pro 13" | **338pt** | 동일 |
| 플로팅 키보드 | **273pt** | 드래그로 이동 가능 |

---

### Safe Area Bottom Inset 요약

| 기기 | bottom inset | 비고 |
|------|-------------|------|
| iPhone (홈버튼 없는 모든 기기) | **34pt** | Dynamic Island 또는 노치 기기 |
| iPhone SE (3세대, 홈버튼) | **0pt** | 홈버튼 있음 |
| iPad (홈버튼 없는 모델) | **20pt** | `spacing.json → safeArea.ipadLandscape.bottom` |
| iPad (홈버튼 있는 모델) | **0pt** | — |

> `spacing.json → safeArea` 전체 참조

---

## iPad 멀티태스킹 고려사항

### Split View / Slide Over 화면 크기

| 모드 | 가로 너비 | Safe Area 변화 |
|------|----------|---------------|
| Full Screen | **전체 너비** (1024pt iPad Pro 13") | 기본 |
| Split View 2/3 | **약 690pt** | 변화 없음 |
| Split View 1/2 | **약 512pt** | 변화 없음 |
| Split View 1/3 | **약 320pt** | Compact horizontal → iPhone 레이아웃 사용 |
| Slide Over | **320pt** | Compact — iPhone 레이아웃 |

### 크기 클래스 분기

| 가로 Size Class | 세로 Size Class | 기기 컨텍스트 |
|---------------|---------------|-------------|
| `.regular` | `.regular` | iPad full screen |
| `.compact` | `.regular` | iPhone portrait, iPad 1/3 Split |
| `.regular` | `.compact` | iPhone landscape (Plus/Max) |
| `.compact` | `.compact` | iPhone landscape (표준) |

### Multitasking 관련 Notification

```
.didEnterBackground — Slide Over로 전환 시
.sceneWillEnterForeground — 다시 포커스
UIWindowScene.activationState — foreground/background 구분
```

---

## 동작 / 애니메이션

### Home Indicator 숨김 동작

```
기본: 항상 표시 (5pt 막대)
사용자 비활성 후 3~4초: 희미해짐 (opacity 0.4)
첫 번째 스와이프 제스처 시: 완전히 나타났다 사라짐
풀스크린 콘텐츠: prefersHomeIndicatorAutoHidden = true → 자동 숨김
```

### Dynamic Island 애니메이션

```
[기본 → 콤팩트]
  spring(stiffness: 260, damping: 28)
  duration: ~0.3s
  동작: pill 형태에서 좌우 분리 또는 단방향 확장

[콤팩트 → 확장]
  spring(stiffness: 300, damping: 35)
  duration: ~0.4s
  동작: 좌우 합쳐지며 아래로 확장 (morphing)

[확장 → 기본 (탭하여 앱 진입)]
  배경 앱으로 전환 애니메이션 (zoom-in: 0.35s)
```

### 키보드 나타남 / 사라짐

```
Present:
  아래에서 위로 슬라이드 (duration: 0.25s, curve: keyboard)
  콘텐츠 영역: keyboardLayoutGuide.topAnchor에 맞춰 올라감

Dismiss:
  위에서 아래로 슬라이드 (duration: 0.25s)
  콘텐츠 영역: 원래 위치로 내려감

Interactive dismiss (아래로 드래그):
  키보드와 콘텐츠가 손가락을 따라 이동
```

**키보드 커브**: `UIKeyboardAnimationCurveUserInfoKey` — 시스템 정의 커브 (UIKit 애니메이션에 반드시 적용)

---

## Accessibility

| 항목 | 규칙 |
|------|------|
| Home Indicator 색상 | 배경 대비에 따라 자동 반전. 앱 제어 불가 |
| Dynamic Island VoiceOver | Live Activity는 `NSLocalizedString`으로 accessibilityLabel 필수 |
| 키보드 접근성 | `UIKeyboardType`, `UITextContentType`, `UIReturnKeyType` 올바르게 설정 |
| 외부 키보드 (iPad) | `UIKeyCommand` / `.keyboardShortcut()` (SwiftUI)로 단축키 지원 |
| Reduce Motion | Dynamic Island 확장 애니메이션 단순화 |
| 포인터 기기 (iPad) | 마우스/트랙패드 호버 시 Home Indicator 비표시 |

---

## 프레임워크별 구현

### UIKit

```swift
// ─────────────────────────────────────────
// Home Indicator 제어
// ─────────────────────────────────────────
class FullscreenViewController: UIViewController {
    // 풀스크린 콘텐츠에서 자동 숨김 허용
    override var prefersHomeIndicatorAutoHidden: Bool { true }

    // 하단 Safe Area 높이 읽기
    func contentBottomInset() -> CGFloat {
        return view.safeAreaInsets.bottom  // iPhone: 34pt, SE: 0pt
    }
}

// ─────────────────────────────────────────
// 키보드 Avoidance (UIKeyboardLayoutGuide)
// ─────────────────────────────────────────
class ChatViewController: UIViewController {
    let textField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        // iOS 15+ 권장 방식
        textField.bottomAnchor.constraint(
            equalTo: view.keyboardLayoutGuide.topAnchor,
            constant: -8
        ).isActive = true

        // keyboardDismissMode: 스크롤 중 키보드 내리기
        tableView.keyboardDismissMode = .interactive
    }
}

// 레거시 방식 (iOS 15 미만)
NotificationCenter.default.addObserver(
    self,
    selector: #selector(keyboardWillShow),
    name: UIResponder.keyboardWillShowNotification,
    object: nil
)

@objc func keyboardWillShow(_ notification: Notification) {
    guard let info = notification.userInfo,
          let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
          let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
          let curveValue = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int
    else { return }

    let curve = UIView.AnimationCurve(rawValue: curveValue) ?? .easeInOut
    let keyboardHeight = keyboardFrame.height

    UIView.animate(
        withDuration: duration,
        delay: 0,
        options: UIView.AnimationOptions(rawValue: UInt(curve.rawValue << 16))
    ) {
        self.bottomConstraint.constant = -keyboardHeight
        self.view.layoutIfNeeded()
    }
}

// ─────────────────────────────────────────
// iPad 크기 클래스 분기
// ─────────────────────────────────────────
override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    if traitCollection.horizontalSizeClass == .compact {
        // iPhone 레이아웃 (Slide Over, Split 1/3)
        useCompactLayout()
    } else {
        // iPad 레이아웃
        useRegularLayout()
    }
}

// ─────────────────────────────────────────
// Live Activity (Dynamic Island)
// ─────────────────────────────────────────
import ActivityKit

// ActivityAttributes 정의
struct TimerAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {
        var remainingSeconds: Int
    }
    var taskName: String
}

// Live Activity 시작
let attributes = TimerAttributes(taskName: "요리")
let state = TimerAttributes.ContentState(remainingSeconds: 300)
let content = ActivityContent(state: state, staleDate: nil)

let activity = try? Activity.request(
    attributes: attributes,
    content: content,
    pushType: nil
)

// 업데이트
await activity?.update(
    ActivityContent(
        state: TimerAttributes.ContentState(remainingSeconds: 120),
        staleDate: Date.now.addingTimeInterval(120)
    )
)

// 종료
await activity?.end(nil, dismissalPolicy: .immediate)
```

### SwiftUI

```swift
// Home Indicator 제어
struct FullscreenView: View {
    var body: some View {
        VideoPlayer()
            .persistentSystemOverlays(.hidden)  // iOS 16+ Home Indicator 숨김
    }
}

// 키보드 Avoidance
struct ChatView: View {
    @State private var text = ""

    var body: some View {
        VStack {
            ScrollView { messageList }
            TextField("메시지", text: $text)
                .padding()
        }
        // 키보드 위로 자동 올라가도록
        .safeAreaInset(edge: .bottom) {
            HStack {
                TextField("메시지 입력", text: $text)
                Button("전송") { send() }
            }
            .padding()
            .background(.ultraThinMaterial)
        }
        // 키보드 safe area 무시하고 직접 처리할 때
        // .ignoresSafeArea(.keyboard)
    }
}

// iPad 크기 클래스 분기
struct AdaptiveView: View {
    @Environment(\.horizontalSizeClass) private var hSizeClass

    var body: some View {
        if hSizeClass == .regular {
            // iPad 레이아웃
            HStack {
                SidebarView()
                ContentView()
            }
        } else {
            // iPhone / Compact 레이아웃
            TabView {
                ContentView()
            }
        }
    }
}

// Live Activity 위젯 (WidgetKit)
struct TimerLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerAttributes.self) { context in
            // Lock Screen / Notification Center
            LockScreenLiveActivityView(context: context)
                .activityBackgroundTint(Color.black)
        } dynamicIsland: { context in
            DynamicIsland {
                // 확장 영역
                DynamicIslandExpandedRegion(.leading) {
                    Label("\(context.state.remainingSeconds)초", systemImage: "timer")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.attributes.taskName)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    ProgressView(
                        value: Double(context.state.remainingSeconds),
                        total: 300
                    )
                }
            } compactLeading: {
                // 콤팩트 리딩 (작은 아이콘)
                Image(systemName: "timer")
            } compactTrailing: {
                // 콤팩트 트레일링 (시간)
                Text("\(context.state.remainingSeconds)s")
                    .font(.caption2)
            } minimal: {
                // 미니멀 (점 하나)
                Image(systemName: "timer")
            }
        }
    }
}
```

### Flutter

```dart
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

// ─────────────────────────────────────────
// Safe Area / Home Indicator 처리
// ─────────────────────────────────────────
class AppScaffold extends StatelessWidget {
  final Widget child;
  const AppScaffold({required this.child});

  @override
  Widget build(BuildContext context) {
    // MediaQuery로 Safe Area insets 조회
    final bottomInset = MediaQuery.of(context).padding.bottom;
    // iPhone 16 Pro → 34.0, iPhone SE → 0.0

    return SafeArea(
      // 키보드가 올라올 때 bottom safe area 유지하려면 false
      bottom: false,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: child,
      ),
    );
  }
}

// Home Indicator 색상 제어 (간접)
SystemChrome.setSystemUIOverlayStyle(
  const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ),
);

// 풀스크린 (Home Indicator 자동 관리)
SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
// 복원
SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

// ─────────────────────────────────────────
// 키보드 Avoidance
// ─────────────────────────────────────────
class ChatInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 키보드 높이를 viewInsets.bottom으로 읽음
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      // resizeToAvoidBottomInset: true 가 기본값
      // → 키보드 올라오면 body 자동 축소
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(child: MessageList()),
          // 입력 필드
          Container(
            padding: EdgeInsets.fromLTRB(
              16,
              8,
              16,
              // Safe area bottom + 8pt
              MediaQuery.of(context).padding.bottom + 8,
            ),
            child: CupertinoTextField(
              placeholder: '메시지 입력',
            ),
          ),
        ],
      ),
    );
  }
}

// 키보드 높이 변화 감지
class _ChatState extends State<ChatScreen> with WidgetsBindingObserver {
  double _keyboardHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    final bottom = WidgetsBinding.instance.platformDispatcher
        .views.first.viewInsets.bottom;
    final ratio = WidgetsBinding.instance.platformDispatcher
        .views.first.devicePixelRatio;
    setState(() => _keyboardHeight = bottom / ratio);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

// ─────────────────────────────────────────
// iPad 크기 클래스 분기
// ─────────────────────────────────────────
Widget build(BuildContext context) {
  final isRegular = MediaQuery.of(context).size.width > 600;

  return isRegular
    ? Row(children: [SidebarView(), Expanded(child: ContentView())])
    : CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: tabs),
        tabBuilder: (context, i) => tabs[i].builder(context),
      );
}

// ─────────────────────────────────────────
// Live Activity (iOS 플러그인)
// ─────────────────────────────────────────
// Flutter에서 Live Activity는 네이티브 iOS 코드로 구현 필요
// MethodChannel 또는 live_activities 패키지 사용:
// https://pub.dev/packages/live_activities

import 'package:live_activities/live_activities.dart';

final liveActivities = LiveActivities();

// 시작
final activityId = await liveActivities.createActivity({
  'taskName': '요리',
  'remainingSeconds': 300,
});

// 업데이트
await liveActivities.updateActivity(activityId, {
  'remainingSeconds': 120,
});

// 종료
await liveActivities.endActivity(activityId);
```

### CSS / Svelte (웹 근사치)

웹(PWA)에서 System Region을 직접 제어하는 것은 제한적이다. `env()` CSS 변수와 meta 태그로 처리한다.

```svelte
<!-- SystemSafeArea.svelte — Safe Area 처리 래퍼 -->
<script lang="ts">
  // 키보드 높이 감지 (Visual Viewport API)
  import { onMount } from 'svelte';

  let keyboardHeight = 0;

  onMount(() => {
    if (!window.visualViewport) return;

    const handler = () => {
      // visualViewport.height < window.innerHeight → 키보드 열림
      keyboardHeight = window.innerHeight - window.visualViewport!.height;
    };

    window.visualViewport.addEventListener('resize', handler);
    return () => window.visualViewport!.removeEventListener('resize', handler);
  });
</script>

<div
  class="safe-area-container"
  style:padding-bottom="{keyboardHeight > 0 ? keyboardHeight : 0}px"
>
  <slot />
</div>

<style>
  /* CSS env() 변수 — iPhone Safari Safe Area */
  .safe-area-container {
    padding-top: env(safe-area-inset-top, 0px);
    padding-bottom: max(
      env(safe-area-inset-bottom, 0px),
      34px  /* Home Indicator 근사값 */
    );
    padding-left: env(safe-area-inset-left, 0px);
    padding-right: env(safe-area-inset-right, 0px);
    min-height: 100dvh;  /* dynamic viewport height */
  }

  /* 키보드 올라올 때 viewport 높이 기반 처리 */
  @supports (height: 100dvh) {
    .safe-area-container {
      min-height: 100dvh;
    }
  }
</style>
```

```html
<!-- HTML head — PWA safe area 설정 -->
<meta name="viewport" content="
  width=device-width,
  initial-scale=1,
  viewport-fit=cover
">
<!-- viewport-fit=cover 필수: safe area env() 변수 활성화 -->

<!-- iOS PWA 풀스크린 -->
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
```

```css
/* 키보드 Avoidance — CSS만으로 처리 */
.chat-container {
  display: flex;
  flex-direction: column;
  height: 100dvh;           /* dynamic viewport height */
}

.message-list {
  flex: 1;
  overflow-y: auto;
  -webkit-overflow-scrolling: touch;
}

.chat-input {
  position: sticky;
  bottom: 0;
  /* 키보드 올라오면 dvh가 줄어들어 자동으로 올라감 */
  padding-bottom: max(env(safe-area-inset-bottom), 8px);
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(10px);
}
```

---

## 기기별 참조 치수 종합표

| 기기 | 화면 높이 | Status Bar | Nav Bar | Tab Bar | Home Indicator | 콘텐츠 가용 높이 |
|------|---------|-----------|---------|---------|---------------|----------------|
| iPhone 16 Pro | 852pt | 54pt | 44pt | 83pt | 34pt (safe) | 637pt |
| iPhone 16 | 852pt | 54pt | 44pt | 83pt | 34pt | 637pt |
| iPhone SE 3 | 667pt | 20pt | 44pt | 49pt | 0pt | 554pt |
| iPhone 15 Pro Max | 932pt | 54pt | 44pt | 83pt | 34pt | 717pt |
| iPad Pro 11" (portrait) | 1194pt | 24pt | 50pt | 83pt | 20pt | 1017pt |
| iPad Pro 13" (landscape) | 1024pt | 24pt | 50pt | 83pt | 20pt | 847pt |

> `spacing.json → safeArea`, `components.tabBar.heightWithIndicator`, `components.navigationBar.height` 참조

---

## 연관 섹션 / 컴포넌트

- **Status Bar** (`status-bar.md`): Dynamic Island 기본 상태 (idle) 스펙
- **Navigation Region** (`navigation-region.md`): Safe Area top 계산에 포함
- **Overlay Region** (`overlay-region.md`): 키보드 avoidance와 Sheet 하단 처리 연동
- **Tab Bar 컴포넌트** (`../components/specs/tab-bar.md`): Tab Bar 높이 (83pt with indicator)
