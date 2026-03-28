# Widgets — iOS 26 컴포넌트 스펙

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:26511")`

---

## 1. Overview

iOS 26 Home Screen Widgets는 홈 화면 및 잠금 화면에 배치되는 위젯 컴포넌트다. Figma 내 23종의 예시 섹션으로 구성되어 있으며, iOS 26에서는 **인터랙티브 위젯**(iOS 17+)과 **Live Activity**를 포함한 전체 위젯 패밀리를 커버한다.

iOS 26에서의 주요 변화: 위젯 배경 소재가 **Liquid Glass** 계열로 통합되었으며, 잠금 화면 위젯은 `Always-On Display` 최적화가 강화됐다.

| 항목 | 값 |
|------|-----|
| **Figma Node** | `507:26511` — COMPONENT_SET |
| **섹션 그룹** | Widgets |
| **총 예시 수** | 23종 |
| **배경 소재** | `.systemMaterial` (반투명) |
| **최소 지원** | iOS 14 (기본 위젯), iOS 16 (잠금화면), iOS 17 (인터랙티브) |

---

## 2. 위젯 크기 (Widget Families)

### 홈 화면 위젯

| 크기 | iPhone (pt) | iPad (pt) | 설명 | WidgetFamily |
|------|-------------|---------|------|--------------|
| **Small** | **158 × 158** | **170 × 170** | 2 × 2 그리드 슬롯 | `.systemSmall` |
| **Medium** | **338 × 158** | **360 × 170** | 4 × 2 그리드 슬롯 | `.systemMedium` |
| **Large** | **338 × 354** | **360 × 379** | 4 × 4 그리드 슬롯 | `.systemLarge` |
| **Extra Large** (iPad 전용) | — | **748 × 360** | 8 × 4 그리드 슬롯 | `.systemExtraLarge` |

> iPhone 크기는 iPhone 16 Pro (393pt 너비) 기준. 기기마다 다름 → `widgetConfiguration` 내 `WidgetInfo.configuration.displaySize` 사용.

### 잠금 화면 위젯 (iOS 16+)

| 크기 | iPhone (pt) | iPad (pt) | 설명 | WidgetFamily |
|------|-------------|---------|------|--------------|
| **Accessory Circular** | **44 × 44** | — | 원형 아이콘, 잠금화면 하단 | `.accessoryCircular` |
| **Accessory Rectangular** | **338 × 58** | — | 가로 직사각형, 잠금화면 중단 | `.accessoryRectangular` |
| **Accessory Inline** | 가변 (최대 ~280pt) | — | 한 줄 텍스트+아이콘, 잠금화면 상단 | `.accessoryInline` |
| **Accessory Corner** (Apple Watch) | 참고용 | — | 워치 페이스 코너 | `.accessoryCorner` |

### Smart Stack

| 항목 | 값 |
|------|-----|
| 크기 | `.systemSmall` / `.systemMedium` / `.systemLarge` 와 동일 |
| 스택 동작 | 위젯 간 스와이프로 전환 (자동 로테이션 포함) |
| 추천 알고리즘 | Siri Intelligence 기반 시간대별 자동 선택 |

---

## 3. 23종 Figma 섹션 구성

### 홈 화면 예시 (15종)

| # | 섹션 이름 | 크기 | 특징 |
|---|-----------|------|------|
| 1 | Calendar — Small | Small | 오늘 날짜, 다음 일정 |
| 2 | Calendar — Medium | Medium | 주간 달력 미니 뷰 |
| 3 | Weather — Small | Small | 현재 기온 + 날씨 아이콘 |
| 4 | Weather — Medium | Medium | 시간대별 예보 그래프 |
| 5 | Weather — Large | Large | 주간 예보 전체 |
| 6 | Clock — Small | Small | 아날로그 시계 |
| 7 | Photos — Small | Small | 메모리 사진 1장 |
| 8 | Photos — Medium | Medium | 포토 그리드 |
| 9 | Maps — Small | Small | 현재 위치 축소 지도 |
| 10 | Maps — Medium | Medium | 예상 이동 경로 |
| 11 | News — Medium | Medium | 주요 기사 헤드라인 |
| 12 | Health — Small | Small | 걸음 수 링 |
| 13 | Health — Medium | Medium | Activity Rings 3개 |
| 14 | Shortcuts — Medium | Medium | 바로가기 버튼 그리드 |
| 15 | Extra Large (iPad) | Extra Large | 달력+날씨 결합 |

### 잠금 화면 예시 (8종)

| # | 섹션 이름 | 크기 | 특징 |
|---|-----------|------|------|
| 16 | Battery — Circular | Accessory Circular | 배터리 잔량 링 |
| 17 | Activity — Circular | Accessory Circular | 운동 링 |
| 18 | Weather — Circular | Accessory Circular | 기온 숫자 |
| 19 | Calendar — Rectangular | Accessory Rectangular | 다음 일정 텍스트 |
| 20 | Weather — Rectangular | Accessory Rectangular | 날씨 + 기온 한 줄 |
| 21 | Stocks — Rectangular | Accessory Rectangular | 주가 변동 한 줄 |
| 22 | Time — Inline | Accessory Inline | 다른 시간대 시각 |
| 23 | UV Index — Inline | Accessory Inline | UV 지수 한 줄 텍스트 |

---

## 4. 시각적 스펙

### 배경 (Background)

| 모드 | 소재 | 불투명도 | 토큰 |
|------|------|---------|------|
| Light | `.systemMaterial` | ~72% | `colors.backgrounds.secondary` |
| Dark | `.systemMaterialDark` | ~64% | `colors.backgrounds.elevated` |
| Vibrant (잠금화면) | `.widgetBackground` (iOS 16) | 가변 | 자동 적용 |

> iOS 26에서 Liquid Glass 스타일 배경으로 강화. `containerBackground(for: .widget)` API 사용.

### 코너 반경 (Corner Radius)

| 위젯 크기 | 코너 반경 | 비고 |
|---------|---------|------|
| Small | **22pt** | `spacing.radius.semantic.widget.small` |
| Medium | **22pt** | `spacing.radius.semantic.widget.medium` |
| Large | **22pt** | `spacing.radius.semantic.widget.large` |
| Extra Large | **26pt** | `spacing.radius.semantic.widget.xl` |
| Accessory Circular | **22pt** (원형 클리핑) | 반원 |
| Accessory Rectangular | **8pt** | 잠금화면 소형 |

> SwiftUI에서 `ContainerRelativeShape()`를 사용하면 자동으로 위젯 코너에 맞춰짐 (권장).

### 콘텐츠 패딩

| 위젯 크기 | 패딩 |
|---------|------|
| Small | **16pt** 전체 |
| Medium | **16pt** 전체 |
| Large | **16pt** 전체 |
| Extra Large | **20pt** 전체 |
| Accessory Circular | **4pt** (여백 최소화) |
| Accessory Rectangular | **8pt** 수직, **11pt** 수평 |

### 타이포그래피

| 요소 | 폰트 | 크기 | 굵기 | 색상 |
|------|------|------|------|------|
| 주요 수치 (기온, 시각) | SF Pro Rounded | 32–52pt | Bold | `labels.primary` |
| 서브 타이틀 | SF Pro | 13–15pt | Regular | `labels.secondary` |
| 바디 텍스트 | SF Pro | 14–16pt | Regular | `labels.primary` |
| Accessory 숫자 | SF Pro | 16–20pt | Semibold | `labels.primary` |
| Accessory 레이블 | SF Pro | 12pt | Regular | `labels.secondary` |

> Dynamic Type: 위젯은 고정 레이아웃이므로 `.minimumScaleFactor`로 대응.

### 색상

| 요소 | 값 | 토큰 |
|------|-----|------|
| 기본 레이블 | `rgba(0,0,0,1)` / `rgba(255,255,255,1)` | `colors.labels.primary` |
| 보조 레이블 | `rgba(0,0,0,0.6)` / `rgba(255,255,255,0.6)` | `colors.labels.secondary` |
| 강조 (tint) | `accents.blue` | `colors.accents.blue` |
| Vibrant (잠금화면) | `WidgetRenderingMode.vibrant` | 자동 |

---

## 5. 애니메이션

위젯은 **전환 애니메이션**만 지원 (런타임 애니메이션 없음).

| 이벤트 | 동작 | duration |
|--------|------|---------|
| 타임라인 엔트리 전환 | `.contentTransition(.identity)` | 시스템 기본 |
| Smart Stack 스와이프 | 시스템 제어 | 약 0.3s |
| 인터랙티브 위젯 버튼 탭 | 즉각 반응 → 최대 0.5s 내 업데이트 | `fast` |
| 위젯 추가 (홈 화면) | 시스템 spring 애니메이션 | 시스템 기본 |

> iOS 17+ 인터랙티브 위젯: `Button`, `Toggle` 사용 가능. 응답 시간 < 500ms 유지 권장.

---

## 6. 개발자 구현 가이드

### 6-1. SwiftUI WidgetKit (기본)

```swift
import WidgetKit
import SwiftUI

// 1. 타임라인 엔트리 정의
struct WeatherEntry: TimelineEntry {
    let date: Date
    let temperature: Int
    let condition: String
    let icon: String
}

// 2. 타임라인 프로바이더
struct WeatherProvider: TimelineProvider {
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: .now, temperature: 22, condition: "맑음", icon: "sun.max")
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (WeatherEntry) -> Void
    ) {
        completion(WeatherEntry(date: .now, temperature: 22, condition: "맑음", icon: "sun.max"))
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<WeatherEntry>) -> Void
    ) {
        let entry = WeatherEntry(date: .now, temperature: 22, condition: "맑음", icon: "sun.max")
        // 1시간 후 갱신
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: .now)!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
}

// 3. 위젯 뷰
struct WeatherWidgetView: View {
    let entry: WeatherEntry
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            SmallWeatherView(entry: entry)
        case .systemMedium:
            MediumWeatherView(entry: entry)
        default:
            SmallWeatherView(entry: entry)
        }
    }
}

struct SmallWeatherView: View {
    let entry: WeatherEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(systemName: entry.icon)
                .font(.title2)
                .foregroundStyle(.primary)
            Spacer()
            Text("\(entry.temperature)°")
                .font(.system(size: 40, weight: .bold, design: .rounded))
            Text(entry.condition)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(16)
        // iOS 26: containerBackground로 Liquid Glass 소재 자동 적용
        .containerBackground(.widgetBackground, for: .widget)
    }
}

// 4. 위젯 메인 진입점
@main
struct WeatherWidget: Widget {
    let kind = "WeatherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WeatherProvider()) { entry in
            WeatherWidgetView(entry: entry)
        }
        .configurationDisplayName("날씨")
        .description("현재 날씨와 기온을 표시합니다.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
```

### 6-2. 인터랙티브 위젯 (iOS 17+)

```swift
// AppIntent를 위젯 Button에 연결
import AppIntents

struct ToggleFavoriteIntent: AppIntent {
    static var title: LocalizedStringResource = "즐겨찾기 토글"

    func perform() async throws -> some IntentResult {
        // 데이터 업데이트 로직
        return .result()
    }
}

struct InteractiveWidgetView: View {
    let entry: WeatherEntry

    var body: some View {
        VStack {
            Text("\(entry.temperature)°")
                .font(.largeTitle.bold())

            // 버튼 — 위젯 내 탭 가능
            Button(intent: ToggleFavoriteIntent()) {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
            }
            .buttonStyle(.plain)
        }
        .containerBackground(.widgetBackground, for: .widget)
    }
}
```

### 6-3. 잠금 화면 위젯 (iOS 16+)

```swift
struct LockScreenWidget: Widget {
    let kind = "LockScreenWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WeatherProvider()) { entry in
            LockScreenWidgetView(entry: entry)
        }
        .configurationDisplayName("날씨")
        .supportedFamilies([
            .accessoryCircular,
            .accessoryRectangular,
            .accessoryInline
        ])
    }
}

struct LockScreenWidgetView: View {
    let entry: WeatherEntry
    @Environment(\.widgetFamily) var family
    @Environment(\.widgetRenderingMode) var renderingMode

    var body: some View {
        switch family {
        case .accessoryCircular:
            // 원형: 링 또는 아이콘+텍스트
            ZStack {
                AccessoryWidgetBackground()  // 시스템 원형 배경
                VStack(spacing: 0) {
                    Image(systemName: entry.icon)
                        .font(.caption)
                    Text("\(entry.temperature)°")
                        .font(.caption2.bold())
                }
            }

        case .accessoryRectangular:
            // 가로형: 한 줄 정보
            HStack {
                Image(systemName: entry.icon)
                VStack(alignment: .leading) {
                    Text(entry.condition)
                        .font(.caption.bold())
                    Text("\(entry.temperature)°C")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }

        case .accessoryInline:
            // 인라인: 텍스트 단독
            Label("\(entry.temperature)°C \(entry.condition)", systemImage: entry.icon)

        default:
            EmptyView()
        }
    }
}
```

### 6-4. Flutter (`home_widget` 패키지)

```dart
// pubspec.yaml
// dependencies:
//   home_widget: ^0.6.0

import 'package:home_widget/home_widget.dart';

class WeatherWidgetService {
  static const appGroupId = 'group.com.example.weather';

  /// 위젯 데이터 업데이트
  static Future<void> updateWidget({
    required int temperature,
    required String condition,
  }) async {
    await HomeWidget.saveWidgetData<int>('temperature', temperature);
    await HomeWidget.saveWidgetData<String>('condition', condition);

    await HomeWidget.updateWidget(
      androidName: 'WeatherWidget',   // Android AppWidgetProvider 클래스명
      iOSName: 'WeatherWidget',       // iOS WidgetKit kind
      qualifiedAndroidName: 'com.example.app.WeatherWidget',
    );
  }

  /// 위젯 탭 이벤트 처리 (딥링크)
  static void setupWidgetLaunchAction() {
    HomeWidget.widgetClicked.listen((Uri? uri) {
      if (uri != null) {
        // 딥링크 처리
        handleDeepLink(uri);
      }
    });
  }

  static void handleDeepLink(Uri uri) {
    // uri.host, uri.path 로 라우팅
  }
}

// iOS 측 Swift 코드 (WidgetKit Entry에서 AppGroup 데이터 읽기)
// let userDefaults = UserDefaults(suiteName: "group.com.example.weather")
// let temperature = userDefaults?.integer(forKey: "temperature") ?? 0
```

### 6-5. Svelte (Web Widgets — PWA 참고용)

```typescript
// Web App Manifest의 위젯 정의 (Progressive Web App Widgets, 실험적)
// manifest.json
{
  "widgets": [
    {
      "name": "날씨 위젯",
      "short_name": "날씨",
      "description": "현재 날씨를 표시합니다",
      "tag": "weather-widget",
      "ms_ac_template": "/widgets/weather-small.json",
      "data": "/api/widget/weather",
      "type": "application/json",
      "screenshots": [
        { "src": "/screenshots/widget-small.png", "sizes": "316x316" }
      ],
      "icons": [
        { "src": "/icons/weather.png", "sizes": "any" }
      ],
      "backgrounds": ["#F0F8FF"],
      "multiple": false
    }
  ]
}
```

```svelte
<!-- Svelte: 위젯 미리보기 컴포넌트 (디자인 확인용) -->
<script lang="ts">
  export let size: 'small' | 'medium' | 'large' = 'small';
  export let temperature = 22;
  export let condition = '맑음';

  const dimensions = {
    small:  { width: 158, height: 158 },
    medium: { width: 338, height: 158 },
    large:  { width: 338, height: 354 },
  };

  $: dim = dimensions[size];
</script>

<div
  class="widget-preview"
  style="
    width: {dim.width}px;
    height: {dim.height}px;
    border-radius: 22px;
    background: rgba(255,255,255,0.72);
    backdrop-filter: blur(40px);
    padding: 16px;
    display: flex;
    flex-direction: column;
    gap: 4px;
  "
>
  <span style="font-size: 2rem; font-weight: 700;">{temperature}°</span>
  <span style="font-size: 0.875rem; color: rgba(0,0,0,0.6);">{condition}</span>
</div>
```

---

## 7. 타임라인 정책 (Timeline Policy)

| 정책 | API | 적합한 상황 |
|------|-----|-----------|
| 특정 시각 이후 갱신 | `.after(Date)` | 날씨 (1시간 간격), 주가 (장 마감 후) |
| 갱신 불필요 | `.never` | 정적 콘텐츠, 카운트다운 완료 |
| 즉시 갱신 가능 | `.atEnd` | 순차 콘텐츠 (뉴스 피드) |
| 앱에서 수동 갱신 | `WidgetCenter.shared.reloadTimelines(ofKind:)` | 사용자 액션 후 즉시 반영 |

```swift
// 앱에서 위젯 즉시 갱신
import WidgetKit

// 특정 위젯만
WidgetCenter.shared.reloadTimelines(ofKind: "WeatherWidget")

// 모든 위젯
WidgetCenter.shared.reloadAllTimelines()
```

---

## 8. 주의 사항 & 제약

| 제약 | 내용 |
|------|------|
| 네트워크 요청 | 타임라인 생성 시에만 가능 (렌더링 중 불가) |
| 렌더링 시간 | ~5초 이내. 느린 위젯 = 캐시된 스냅샷 표시 |
| 메모리 | Small: 30MB, Medium: 30MB, Large: 30MB 제한 |
| 갱신 빈도 | 시스템이 배터리/사용 패턴에 따라 갱신 횟수 조절 |
| 애니메이션 | 위젯 내 SwiftUI 애니메이션 제한적. `TimelineView` 활용 |
| 유저 인터랙션 | iOS 17+ Button/Toggle만 가능. Gesture Recognizer 불가 |
| 딥링크 | `widgetURL()` 또는 `Link()` 컴포넌트로 앱 연결 |
| ContainerBackground | iOS 17+. 이전에는 배경 직접 그리기 |
