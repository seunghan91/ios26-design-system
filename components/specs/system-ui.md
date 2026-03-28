# System UI — iOS 26 시스템 레벨 UI 컴포넌트 스펙

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24688")`

---

## 1. 개요

iOS 26 System UI는 앱이 **직접 커스터마이징할 수 없는** 시스템 레벨 UI 컴포넌트 32종을 포함한다. 이 스펙은 **참조 및 레이아웃 계획용**이며, 각 컴포넌트의 크기/위치/여백을 앱 콘텐츠 배치에 활용하는 것이 목적이다.

**중요**: 아래 컴포넌트들은 시스템이 렌더링하며 서드파티 앱에서 직접 수정 불가.
앱은 다음만 제어 가능:
- Safe Area Inset을 통한 콘텐츠 영역 제한
- `UIContentUnavailableConfiguration`으로 Spotlight 검색 결과 제공
- `ActivityKit`으로 Dynamic Island / Lock Screen 위젯 콘텐츠 제공
- `WidgetKit`으로 Control Center / Lock Screen 위젯 제공

---

## 2. 컴포넌트 인덱스 (32종)

| # | 컴포넌트 | 크기 | 커스터마이징 |
|---|---------|------|-----------|
| 1 | Dynamic Island (비활성) | 126×37pt | ActivityKit |
| 2 | Dynamic Island (콤팩트 Leading) | 250×37pt | ActivityKit |
| 3 | Dynamic Island (콤팩트 Trailing) | 250×37pt | ActivityKit |
| 4 | Dynamic Island (최소화) | 8pt 원형 | ActivityKit |
| 5 | Dynamic Island (확장형) | 최대 250×160pt | ActivityKit |
| 6 | Status Bar (기본) | 44pt 높이 | 없음 (색상 모드만) |
| 7 | Status Bar (가로) | 32pt 높이 | 없음 |
| 8 | Battery 아이콘 | 25×13pt | 없음 |
| 9 | Network 아이콘 | 가변 ×18pt | 없음 |
| 10 | Home Indicator | 134×5pt | 숨김 가능 |
| 11 | Control Center (2×2 타일) | 91×91pt | WidgetKit |
| 12 | Control Center (2×4 타일) | 91×206pt | WidgetKit |
| 13 | Control Center (4×4 타일) | 전체 행 너비 | WidgetKit |
| 14 | Spotlight 검색바 | (화면너비-32pt)×50pt | UISearchController |
| 15 | Siri UI | 320pt 높이 overlay | SiriKit Intent |
| 16 | Lock Screen 위젯 (accessory) | 338pt 너비 영역 | WidgetKit |
| 17 | Lock Screen 위젯 (circular) | 36×36pt | WidgetKit |
| 18 | Lock Screen 위젯 (rectangular) | 338×68pt | WidgetKit |
| 19 | Lock Screen 시계 | 가변 | 없음 |
| 20 | App Library 그리드 | 3×3 폴더, 60pt 아이콘 | 없음 |
| 21 | App Library 검색 | 화면너비-32pt | 없음 |
| 22 | 알림 배너 (Compact) | (화면너비-32pt)×60pt | UNUserNotification |
| 23 | 알림 배너 (Expanded) | (화면너비-32pt)×가변 | UNUserNotification |
| 24 | 알림 뷰 (Lock Screen) | (화면너비-32pt)×가변 | UNUserNotification |
| 25 | 알림 센터 (전체) | 전체화면 | UNUserNotification |
| 26 | App Icon (홈 화면) | 60×60pt | 없음 (Alternative Icon 제외) |
| 27 | App Icon (홈 화면, 라지) | 76×76pt (iPad) | 없음 |
| 28 | App Icon Dock | 60×60pt | 없음 |
| 29 | Dock (iPhone) | 화면너비×83pt | 없음 |
| 30 | Dock (iPad) | 가변 높이 | 없음 |
| 31 | Today View 위젯 (small) | 155×155pt | WidgetKit |
| 32 | Today View 위젯 (medium) | 329×155pt | WidgetKit |

---

## 3. Dynamic Island 상세 스펙

Dynamic Island은 iPhone 14 Pro 이상에서 전면 카메라/Face ID 센서를 포함하는 캡슐형 디스플레이 영역이다.

### 3.1 5가지 상태

```
비활성(Idle):
╔══════════════╗
║  ████████   ║  ← 126×37pt pill
╚══════════════╝

콤팩트 Leading (알림 확장 왼쪽):
╔════════════════════════════╗
║ [앱아이콘]   텍스트 내용    ║  ← 250×37pt
╚════════════════════════════╝

콤팩트 Trailing (알림 확장 오른쪽):
╔════════════════════════════╗
║  내용       [아이콘/값]     ║  ← 250×37pt
╚════════════════════════════╝

최소화(Minimal):
╔╗
║●║  ← 8×8pt 원형 점
╚╝

확장형(Expanded):
╔═══════════════════════════════════╗
║                                   ║
║   ActivityKit 콘텐츠 영역          ║  ← 최대 250×160pt
║   (앱별 커스텀 뷰)                 ║
║                                   ║
╚═══════════════════════════════════╝
```

| 상태 | 너비 | 높이 | 코너 반경 |
|------|------|------|---------|
| **비활성 (Idle)** | 126pt | 37pt | 18.5pt (pill) |
| **콤팩트 Leading** | 250pt | 37pt | 18.5pt → 좌측 확장 |
| **콤팩트 Trailing** | 250pt | 37pt | 18.5pt → 우측 확장 |
| **최소화 (Minimal)** | 8pt | 8pt | 4pt (원형) |
| **확장형 (Expanded)** | 250pt | 최대 160pt | 24pt |

### 3.2 상태 전환 애니메이션

```json
// ../tokens/animations.json 참조
{
  "dynamicIsland": {
    "idleToCompact": {
      "type": "spring",
      "stiffness": 320,
      "damping": 26,
      "duration": "~0.35s"
    },
    "compactToExpanded": {
      "type": "spring",
      "stiffness": 280,
      "damping": 24,
      "duration": "~0.45s"
    },
    "expandedToIdle": {
      "type": "spring",
      "stiffness": 380,
      "damping": 30,
      "duration": "~0.3s"
    },
    "minimalPulse": {
      "type": "scale",
      "from": 1.0,
      "to": 1.2,
      "duration": "0.6s",
      "repeatCount": "infinity",
      "easing": "easeInOut"
    }
  }
}
```

### 3.3 ActivityKit으로 Dynamic Island 콘텐츠 제공

```swift
import ActivityKit
import SwiftUI

// Live Activity 데이터 모델
struct DeliveryAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var status: String
        var eta: Date
        var progress: Double      // 0.0 ~ 1.0
    }

    var orderID: String
    var courierName: String
}

// Dynamic Island 뷰 정의
struct DeliveryLiveActivityView: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DeliveryAttributes.self) { context in
            // Lock Screen + Expanded 뷰
            VStack(alignment: .leading) {
                Text(context.state.status)
                    .font(.headline)
                ProgressView(value: context.state.progress)
                Text("도착 예정: \(context.state.eta, style: .relative)")
                    .font(.caption)
            }
            .padding()
            .activityBackgroundTint(.blue.opacity(0.2))
        } dynamicIsland: { context in
            DynamicIsland {
                // 확장형 (Expanded) 영역
                DynamicIslandExpandedRegion(.leading) {
                    Label(context.attributes.courierName, systemImage: "person.fill")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.eta, style: .timer)
                        .monospacedDigit()
                        .font(.caption2)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    ProgressView(value: context.state.progress)
                        .tint(.blue)
                }
            } compactLeading: {
                // 콤팩트 Leading (250×37pt 왼쪽)
                Image(systemName: "shippingbox.fill")
                    .foregroundStyle(.blue)
            } compactTrailing: {
                // 콤팩트 Trailing (250×37pt 오른쪽)
                Text(context.state.eta, style: .timer)
                    .monospacedDigit()
                    .font(.caption2)
            } minimal: {
                // 최소화 (8pt 원형)
                Image(systemName: "shippingbox.fill")
                    .foregroundStyle(.blue)
            }
        }
    }
}

// Live Activity 시작
func startDeliveryActivity(orderID: String, courierName: String) async {
    let attributes = DeliveryAttributes(orderID: orderID, courierName: courierName)
    let contentState = DeliveryAttributes.ContentState(
        status: "배달 중",
        eta: Date().addingTimeInterval(1800),
        progress: 0.3
    )

    do {
        let activity = try Activity.request(
            attributes: attributes,
            contentState: contentState,
            pushType: nil
        )
        print("Live Activity 시작: \(activity.id)")
    } catch {
        print("Live Activity 실패: \(error)")
    }
}
```

---

## 4. Status Bar

### 4.1 치수

| 기기 / 방향 | 높이 | 항목 |
|-----------|------|------|
| iPhone (세로, Dynamic Island) | 59pt (Dynamic Island 포함) | 시간/배터리/신호 |
| iPhone (세로, Notch) | 44pt | 시간/배터리/신호 |
| iPhone (세로, Legacy) | 20pt | 시간/배터리/신호 |
| iPhone (가로) | 0pt (숨김) 또는 32pt | — |
| iPad | 24pt | 시간/배터리/신호/Wi-Fi |

### 4.2 Battery 아이콘

```
┌──────────┐┐
│          ││  ← 25×13pt (본체) + 2×8pt (돌기)
│  ████    ││
└──────────┘┘
```

| 항목 | 값 |
|------|-----|
| **배터리 본체** | 25×13pt |
| **배터리 돌기** | 2×8pt (오른쪽) |
| **코너 반경** | 3.5pt |
| **충전 중 볼트 아이콘** | 8×11pt SF Symbol: `bolt.fill` |
| **낮은 배터리 색상** | `accents.red` (≤20%) |
| **충전 중 색상** | `accents.green` |
| **일반 색상** | `labels.primary` (흰색/검정 자동) |

### 4.3 Network 아이콘

| 네트워크 타입 | 아이콘 | 너비 | 높이 |
|-------------|--------|------|------|
| Wi-Fi (강) | `wifi` | 16pt | 12pt |
| Wi-Fi (중) | `wifi` (2바) | 16pt | 12pt |
| Wi-Fi (약) | `wifi` (1바) | 16pt | 12pt |
| 5G | 텍스트 "5G" | 가변 | 14pt |
| LTE | 텍스트 "LTE" | 가변 | 14pt |
| 3G / E / GPRS | 텍스트 | 가변 | 14pt |
| 비행기 모드 | `airplane` | 14pt | 14pt |
| 모두 기준 높이 | — | — | **18pt** |

---

## 5. Control Center 위젯

### 5.1 위젯 크기 시스템

Control Center는 12열 격자(각 셀 약 42pt)로 구성된다.

```
┌─────────────────────────────────────┐
│ Control Center (전체 패널)           │
│                                     │
│ [2×2][2×2][2×2]                     │ ← 91pt 타일
│ [──────2×4──────][2×2]              │ ← 206pt 타일
│ [─────────4×4─────────────────────] │ ← 전체 행
└─────────────────────────────────────┘
```

| 타일 크기 | 너비 | 높이 | 예시 컨트롤 |
|---------|------|------|----------|
| **2×2** | 91pt | 91pt | Wi-Fi 토글, 블루투스, 무음 |
| **2×4** | 91pt | 206pt | 미디어 재생 컨트롤 |
| **4×2** | 206pt | 91pt | 밝기/볼륨 슬라이더 |
| **4×4** | 전체 행 | 91pt | — (커스텀 앱 사용) |

| 항목 | 값 |
|------|-----|
| **2×2 타일 크기** | 91×91pt |
| **2×4 타일 크기** | 91×206pt |
| **타일 코너 반경** | 18pt |
| **타일 간격** | 8pt |
| **패널 배경** | Liquid Glass (translucent + blur) |
| **패널 코너 반경** | 28pt |
| **패널 상단 여백** | Dynamic Island / Status Bar + 16pt |

### 5.2 WidgetKit으로 Control Center 위젯 제공

```swift
import SwiftUI
import WidgetKit

// Control Center 위젯 (iOS 18+ / iOS 26)
struct FlashlightControlWidget: ControlWidget {
    var body: some ControlWidgetConfiguration {
        StaticControlWidget(kind: "com.myapp.flashlight") {
            ControlWidgetToggle(
                "손전등",
                isOn: FlashlightManager.isOn,
                action: ToggleFlashlightIntent()
            ) { isOn in
                Label(isOn ? "켜짐" : "꺼짐",
                      systemImage: isOn ? "flashlight.on.fill" : "flashlight.off.fill")
            }
        }
        .displayName("손전등")
        .description("손전등을 빠르게 켜고 끕니다.")
    }
}
```

---

## 6. Spotlight 검색

### 6.1 치수

```
  16pt                              16pt
│←───────────────────────────────────→│
┌─────────────────────────────────────┐
│ 🔍 [  앱, 연락처, 파일 검색...    ] │  ← 높이 50pt
└─────────────────────────────────────┘
   ↑ corner-radius 12pt
```

| 항목 | 값 |
|------|-----|
| **너비** | 화면 너비 - 32pt (좌우 각 16pt 여백) |
| **높이** | 50pt |
| **코너 반경** | 12pt |
| **플레이스홀더** | "앱, 연락처, 파일 검색" (Body, 17pt, `labels.tertiary`) |
| **배경** | `fills.secondary` + backdrop blur |
| **검색 아이콘** | SF Symbol `magnifyingglass`, 20pt, `labels.secondary` |
| **취소 버튼** | Body 17pt, `accents.blue` |
| **결과 영역 행 높이** | 52pt |
| **섹션 헤더 높이** | 28pt |

### 6.2 UISearchController 연동

```swift
import UIKit

class SearchableViewController: UIViewController, UISearchResultsUpdating {
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // 검색 바 설정
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "검색"

        // Navigation Bar에 통합
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true

        // Spotlight 제안 (iOS 26)
        navigationItem.preferredSearchBarPlacement = .stacked
        definesPresentationContext = true
    }

    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        // 검색 결과 업데이트
        filterContent(for: query)
    }

    func filterContent(for query: String) {
        // 검색 로직
    }
}
```

---

## 7. Siri UI

### 7.1 치수

```
┌───────────────────────────────────────────┐
│  앱 콘텐츠 (dimmed)                        │
│  rgba(0,0,0,0.4) 오버레이                  │
│                                           │
│                                           │
├───────────────────────────────────────────┤
│                                           │
│   ~~~~  Siri 응답 버블 (가변 높이)  ~~~~   │  ← 최대 240pt
│                                           │
│  ●●●●●●●●●●●●  (Siri Pulse 애니메이션)    │  ← 40pt
├───────────────────────────────────────────┤
│           Home Indicator                  │
└───────────────────────────────────────────┘
  ← 전체 오버레이 높이: ~320pt →
```

| 항목 | 값 |
|------|-----|
| **Siri 오버레이 높이** | 약 320pt (하단에서 올라옴) |
| **배경 오버레이** | `rgba(0,0,0,0.4)` 블러 |
| **Pulse 애니메이션 높이** | 40pt |
| **응답 버블 최대 높이** | 240pt |
| **Siri 버블 코너 반경** | 16pt |
| **Siri 버블 배경** | Liquid Glass |
| **폰트** | SF Pro Display, 17pt Regular |

### 7.2 Siri Intent 등록

```swift
import Intents

// App Intent (iOS 26 / AppIntents 프레임워크)
import AppIntents

struct OrderCoffeeIntent: AppIntent {
    static var title: LocalizedStringResource = "커피 주문"
    static var description = IntentDescription("빠르게 커피를 주문합니다.")

    // Siri에서 "커피 주문해줘" 발화 시 실행
    @Parameter(title: "종류")
    var coffeeType: String

    func perform() async throws -> some IntentResult & ProvidesDialog {
        // 주문 로직
        let result = await CoffeeService.order(type: coffeeType)
        return .result(
            dialog: "\(coffeeType) 주문이 완료되었습니다. 예상 소요 시간: \(result.eta)분"
        )
    }
}

// Info.plist: NSUserActivityTypes 등록 필요
```

---

## 8. Lock Screen 위젯

### 8.1 위젯 크기 시스템

```
Lock Screen 위젯 영역:
┌──────────────────────────────────────────┐
│ [circular] [circular] [circular] [circ.] │ ← accessory row
│ [─────────────rectangular─────────────]  │ ← 338pt 너비
└──────────────────────────────────────────┘
```

| 위젯 종류 | 너비 | 높이 | 설명 |
|---------|------|------|------|
| **accessoryCircular** | 36pt | 36pt | 원형 위젯 (날씨 기온, 활동 링 등) |
| **accessoryRectangular** | 338pt | 68pt | 직사각형 위젯 (미디어, 이벤트 등) |
| **accessoryInline** | 화면너비 | 14pt | 시계 위 1행 텍스트 |
| **accessoryCorner** | 32pt | 32pt | Lock Screen 모서리 (watchOS 패리티) |

| 항목 | 값 |
|------|-----|
| **accessoryCircular 코너 반경** | 18pt (원형) |
| **accessoryRectangular 코너 반경** | 8pt |
| **위젯 간격** | 8pt |
| **accessory 영역 상단 여백** | Status Bar 하단 + 8pt |

### 8.2 WidgetKit으로 Lock Screen 위젯 구현

```swift
import SwiftUI
import WidgetKit

struct LockScreenWidget: Widget {
    let kind: String = "LockScreenWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: LockScreenProvider()) { entry in
            LockScreenWidgetView(entry: entry)
        }
        .configurationDisplayName("오늘 일정")
        .description("다음 일정을 Lock Screen에 표시합니다.")
        .supportedFamilies([
            .accessoryCircular,
            .accessoryRectangular,
            .accessoryInline
        ])
    }
}

struct LockScreenWidgetView: View {
    @Environment(\.widgetFamily) var family
    var entry: LockScreenEntry

    var body: some View {
        switch family {
        case .accessoryCircular:
            // 36×36pt 원형
            ZStack {
                AccessoryWidgetBackground()
                VStack(spacing: 0) {
                    Image(systemName: "calendar")
                        .font(.system(size: 14, weight: .medium))
                    Text("\(entry.eventCount)")
                        .font(.system(size: 18, weight: .bold))
                        .monospacedDigit()
                }
            }

        case .accessoryRectangular:
            // 338×68pt 직사각형
            VStack(alignment: .leading, spacing: 4) {
                Label("다음 일정", systemImage: "calendar")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                Text(entry.nextEventTitle)
                    .font(.headline)
                    .lineLimit(1)
                Text(entry.nextEventTime, style: .time)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .containerBackground(.fill.tertiary, for: .widget)

        case .accessoryInline:
            // 1행 텍스트
            Label(entry.nextEventTitle, systemImage: "calendar")
                .font(.caption)

        default:
            Text("미지원")
        }
    }
}
```

---

## 9. App Library

### 9.1 치수

```
App Library:
┌───────────────────────────────────────┐
│ [──────────────검색바──────────────]   │ ← 화면너비-32pt
├───────────────────────────────────────┤
│                                       │
│  [폴더1]  [폴더2]  [폴더3]             │ ← 3×3 폴더 격자
│  [폴더4]  [폴더5]  [폴더6]             │
│                                       │
└───────────────────────────────────────┘
   ↑ 폴더 크기: ~133pt (화면너비-32pt를 3등분)
```

| 항목 | 값 |
|------|-----|
| **폴더 크기** | ~133pt (414pt 기준: (414-32-24) / 3 = ~119pt) |
| **폴더 코너 반경** | 18pt |
| **폴더 내 앱 아이콘** | 3×3 배치, 각 26pt |
| **폴더 내 아이콘 간격** | 4pt |
| **앱 아이콘 크기 (홈 화면)** | 60×60pt |
| **아이콘 코너 반경** | 13.5pt (iOS 26 기준) |
| **아이콘 아래 레이블** | Caption2, 11pt, 중앙 정렬, 1줄 |
| **행 간격** | 32pt (아이콘 60pt + 레이블 14pt + 여백 26pt) |
| **열 수** | 4 (홈 화면 기본) |
| **검색 바 높이** | 44pt |

---

## 10. 알림 배너

### 10.1 치수

```
Notification Banner (Compact — 기본):
  16pt                                16pt
│←────────────────────────────────────→│
┌─────────────────────────────────────┐
│ [앱아이콘] 앱 이름          시간    │ ← 높이 ~60pt
│           알림 내용 1줄             │
└─────────────────────────────────────┘
  ↑ 상단 Safe Area + 8pt 에서 시작

Notification Banner (Expanded — 탭으로 확장):
┌─────────────────────────────────────┐
│ [앱아이콘] 앱 이름          시간    │
│           알림 제목                 │
│           알림 본문 (최대 4줄)       │
│ [액션버튼1]             [액션버튼2] │ ← 선택적
└─────────────────────────────────────┘
  ↑ 높이: 콘텐츠에 따라 가변 (최소 72pt)
```

| 항목 | 값 |
|------|-----|
| **너비** | 화면 너비 - 32pt (좌우 각 16pt) |
| **Compact 높이** | 약 60pt |
| **Expanded 최소 높이** | 72pt |
| **코너 반경** | 16pt |
| **앱 아이콘 크기** | 24×24pt |
| **앱 아이콘 코너 반경** | 5.5pt |
| **상단 여백** | Safe Area top + 8pt |
| **내부 패딩** | 수평 16pt, 수직 12pt |
| **배경** | Liquid Glass (translucent + blur) |
| **앱 이름 폰트** | Caption1, 12pt, Medium |
| **시간 표시** | Caption2, 11pt, `labels.tertiary` |
| **알림 제목** | Subheadline, 15pt, Semibold |
| **알림 본문** | Subheadline, 15pt, Regular |
| **액션 버튼** | 버튼 스타일, 각 버튼 너비 = (배너너비 - 48pt) / 2 |

### 10.2 알림 배너 등장/퇴장 애니메이션

```json
// ../tokens/animations.json 참조
{
  "notificationBanner": {
    "appear": {
      "type": "spring",
      "from": { "y": -80, "opacity": 0 },
      "to": { "y": 0, "opacity": 1 },
      "stiffness": 400,
      "damping": 30,
      "duration": "~0.35s"
    },
    "dismiss": {
      "type": "spring",
      "from": { "y": 0, "opacity": 1 },
      "to": { "y": -80, "opacity": 0 },
      "stiffness": 450,
      "damping": 35,
      "duration": "~0.3s"
    },
    "expand": {
      "type": "spring",
      "stiffness": 380,
      "damping": 28,
      "duration": "~0.4s"
    },
    "autoDismissDelay": "4s"
  }
}
```

### 10.3 UNUserNotification 구현

```swift
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    func requestPermission() async -> Bool {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        do {
            return try await UNUserNotificationCenter.current()
                .requestAuthorization(options: options)
        } catch {
            return false
        }
    }

    func scheduleLocalNotification(
        title: String,
        body: String,
        after seconds: TimeInterval,
        categoryIdentifier: String? = nil
    ) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.badge = 1

        // 액션 버튼 카테고리 등록
        if let categoryID = categoryIdentifier {
            content.categoryIdentifier = categoryID
        }

        // iOS 15+ Interruption Level
        content.interruptionLevel = .active      // 배너 표시
        // .passive = 소리 없이 알림 센터에만
        // .timeSensitive = 집중 모드에서도 표시
        // .critical = 무음 모드에서도 표시 (특별 권한 필요)

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: seconds,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

    func registerCategories() {
        // 액션 버튼 정의
        let acceptAction = UNNotificationAction(
            identifier: "ACCEPT",
            title: "승인",
            options: .foreground
        )
        let rejectAction = UNNotificationAction(
            identifier: "REJECT",
            title: "거절",
            options: .destructive
        )

        let category = UNNotificationCategory(
            identifier: "REQUEST_CATEGORY",
            actions: [acceptAction, rejectAction],
            intentIdentifiers: [],
            options: .customDismissAction
        )

        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
}
```

---

## 11. Home Indicator

```
┌───────────────────────────────────────┐
│                                       │
│          앱 콘텐츠                     │
│                                       │
│          134pt                        │
│     ┌──────────┐                      │ ← 5pt 높이 pill
│     └──────────┘                      │
└───────────────────────────────────────┘
  ↑ 하단 Safe Area: 34pt (iPhone 14 Pro 기준)
```

| 항목 | 값 |
|------|-----|
| **Home Indicator 크기** | 134×5pt |
| **코너 반경** | 2.5pt |
| **색상** | `labels.secondary` (자동 밝기/어둠 대응) |
| **하단 Safe Area (iPhone 14 Pro+)** | 34pt |
| **하단 Safe Area (iPhone SE 3세대)** | 0pt (홈 버튼 있음) |
| **숨김 가능 여부** | 가능 — 2초 후 자동 페이드 (게임/영상 모드) |

```swift
// Home Indicator 숨김 (게임/영상 앱)
override var prefersHomeIndicatorAutoHidden: Bool {
    return isPlayingVideo  // 영상 재생 중일 때만 숨김
}

// 강제 숨김 업데이트
setNeedsUpdateOfHomeIndicatorAutoHidden()
```

---

## 12. 색상 토큰 매핑 (System UI 공통)

```json
// ../tokens/colors.json 참조
{
  "systemUI": {
    "dynamicIsland": {
      "background": "#000000",
      "content": "#FFFFFF"
    },
    "statusBar": {
      "lightContent": "#FFFFFF",
      "darkContent": "#000000"
    },
    "controlCenter": {
      "tileBackground": "Colors/Fill/Quaternary + blur",
      "activeBackground": "Colors/Tint/Blue",
      "label": "Colors/Label/Primary"
    },
    "spotlight": {
      "background": "Colors/Fill/Secondary + blur",
      "placeholder": "Colors/Label/Tertiary",
      "icon": "Colors/Label/Secondary"
    },
    "notificationBanner": {
      "background": "Liquid Glass",
      "title": "Colors/Label/Primary",
      "body": "Colors/Label/Secondary",
      "time": "Colors/Label/Tertiary"
    },
    "lockScreenWidget": {
      "background": "Colors/Fill/Quaternary",
      "label": "Colors/Label/Primary",
      "tint": "Colors/Tint/Blue"
    }
  }
}
```

---

## 13. 타이포그래피 요약

```json
// ../tokens/typography.json 참조
{
  "systemUI": {
    "statusBarTime": { "size": "15pt", "weight": "Medium", "monospacedDigit": true },
    "notificationAppName": { "style": "Caption1", "size": "12pt", "weight": "Medium" },
    "notificationTitle": { "style": "Subheadline", "size": "15pt", "weight": "Semibold" },
    "notificationBody": { "style": "Subheadline", "size": "15pt", "weight": "Regular" },
    "spotlightPlaceholder": { "style": "Body", "size": "17pt", "weight": "Regular" },
    "spotlightResult": { "style": "Body", "size": "17pt", "weight": "Regular" },
    "controlCenterLabel": { "style": "Caption2", "size": "11pt", "weight": "Medium" },
    "dynamicIslandContent": { "size": "13pt", "weight": "Regular" },
    "lockScreenWidgetLabel": { "style": "Caption1", "size": "12pt", "weight": "Regular" }
  }
}
```

---

## 14. 간격 토큰 요약

```json
// ../tokens/spacing.json 참조
{
  "systemUI": {
    "statusBarHeight": {
      "dynamicIsland": 59,
      "notch": 44,
      "legacy": 20,
      "landscape": 32
    },
    "homeIndicator": {
      "width": 134,
      "height": 5,
      "safeAreaHeight": 34
    },
    "dynamicIsland": {
      "idleWidth": 126,
      "idleHeight": 37,
      "compactWidth": 250,
      "expandedMaxHeight": 160,
      "minimalDiameter": 8
    },
    "notificationBanner": {
      "marginH": 16,
      "paddingH": 16,
      "paddingV": 12,
      "cornerRadius": 16,
      "appIconSize": 24
    },
    "controlCenter": {
      "tileSmall": 91,
      "tileMediumH": 206,
      "tileGap": 8,
      "panelCornerRadius": 28
    },
    "spotlight": {
      "marginH": 16,
      "height": 50,
      "cornerRadius": 12,
      "resultRowHeight": 52
    },
    "lockScreen": {
      "widgetAreaWidth": 338,
      "circularSize": 36,
      "rectangularHeight": 68,
      "widgetGap": 8
    },
    "appIcon": {
      "homeScreen": 60,
      "homeScreeniPad": 76,
      "dock": 60,
      "cornerRadius": 13.5,
      "spotlight": 40,
      "notification": 24
    }
  }
}
```

---

## 15. Safe Area 레이아웃 가이드

앱 콘텐츠를 배치할 때 반드시 Safe Area를 준수해야 한다.

| 기기 | 상단 SA | 하단 SA | 좌/우 SA (가로) |
|------|---------|---------|--------------|
| iPhone 16 Pro (Dynamic Island) | 59pt | 34pt | 59pt / 59pt |
| iPhone 15 (Dynamic Island) | 59pt | 34pt | 59pt / 59pt |
| iPhone SE 3세대 (홈 버튼) | 20pt | 0pt | 0pt / 0pt |
| iPad Pro 13" | 24pt | 20pt | 0pt (무시 가능) |

```swift
// UIKit에서 Safe Area 사용
view.safeAreaInsets  // UIEdgeInsets

// AutoLayout
view.topAnchor.constraint(
    equalTo: view.safeAreaLayoutGuide.topAnchor
)

// SwiftUI에서 Safe Area 사용
struct ContentView: View {
    var body: some View {
        VStack { /* ... */ }
            .safeAreaInset(edge: .bottom) {
                // 하단 Safe Area 위에 배치될 뷰
                TabBar()
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)  // 키보드 무시
    }
}
```

---

## 16. 접근성

| 컴포넌트 | 접근성 지원 |
|---------|-----------|
| **Dynamic Island** | VoiceOver: 탭 시 확장형 뷰 포커스 이동 |
| **Control Center** | VoiceOver: 각 타일 레이블 읽기, 토글 상태 읽기 |
| **Spotlight** | VoiceOver: 검색 결과 행 포커스 이동 |
| **알림 배너** | VoiceOver: 배너 탭 시 앱으로 이동 |
| **Lock Screen 위젯** | VoiceOver: 위젯 콘텐츠 읽기, 롱프레스로 편집 |
| **Status Bar** | 배터리/시간 정보는 시스템이 VoiceOver 제공 |
| **Home Indicator** | 없음 (시스템 관리) |

**앱에서 접근성 지원 방법**:
```swift
// Live Activity 접근성 레이블
Text(entry.status)
    .accessibilityLabel("배달 상태: \(entry.status)")

// Widget 접근성
Text(eventTitle)
    .accessibilityHint("두 번 탭하면 앱을 엽니다.")
```

---

## 17. 엣지 케이스 & 주의사항

- **Dynamic Island 없는 기기**: `UIDevice.current.userInterfaceIdiom` + notch 여부 확인. `ActivityKit` API는 Dynamic Island 없는 기기에서도 Lock Screen Live Activity만 표시
- **Stage Manager + Dynamic Island**: iPadOS 16+에서 iPad에도 Dynamic Island 있는 모델 존재 (M4 iPad Pro)
- **Control Center 커스텀 위젯**: iOS 18+에서 서드파티 앱이 Control Center에 `ControlWidget` 추가 가능
- **Spotlight 인덱싱**: `CSSearchableItem`으로 앱 콘텐츠를 Spotlight에 인덱싱 가능
- **알림 그룹핑**: `threadIdentifier`로 동일 앱의 알림 그룹핑 (`UNMutableNotificationContent.threadIdentifier`)
- **Lock Screen 위젯 업데이트 제한**: 하루 최대 40~70회 (WidgetKit 정책, 기기 상태에 따라 다름)
- **Critical Alert**: 무음 모드 무시 알림은 Apple 특별 허가 필요 (`UNAuthorizationOptions.criticalAlert`)
- **Siri 개인정보**: SiriKit Intent에서 개인정보 포함 데이터 처리 시 `NSUserActivityTypes` 및 Privacy 정책 명시 필수

---

## 18. 체크리스트

- [ ] Dynamic Island 5가지 상태 크기 파악 (비활성/콤팩트Leading/콤팩트Trailing/최소화/확장)
- [ ] ActivityKit으로 Live Activity 구현 (Dynamic Island + Lock Screen)
- [ ] Safe Area Inset 준수 (기기별 상단/하단 값 확인)
- [ ] WidgetKit: `.accessoryCircular`, `.accessoryRectangular` 지원
- [ ] WidgetKit: Control Center `ControlWidget` 지원 (iOS 18+)
- [ ] UNUserNotification: 알림 권한 요청 + 카테고리(액션 버튼) 등록
- [ ] UNUserNotification: `interruptionLevel` 적절히 설정
- [ ] Spotlight: `CSSearchableItem` 인덱싱 (콘텐츠 검색 지원)
- [ ] Home Indicator: 게임/영상 앱에서 `prefersHomeIndicatorAutoHidden` 구현
- [ ] Status Bar style: `UIStatusBarStyle` (.lightContent / .darkContent) 설정
- [ ] 알림 배너 배경: Liquid Glass (iOS 26 스타일)
- [ ] VoiceOver: 모든 시스템 UI와 연동되는 콘텐츠에 접근성 레이블 추가
- [ ] Dynamic Island 등장 spring 애니메이션 (stiffness 320, damping 26)
- [ ] 알림 배너 등장 spring (stiffness 400, damping 30, 4초 후 자동 dismiss)
