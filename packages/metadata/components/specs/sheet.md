> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/animations.json`, `../tokens/materials.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24684")`

# Sheet — Component Spec

## 1. Overview

iOS 26 Sheet는 Liquid Glass 소재를 배경으로 사용하는 Bottom Sheet 컴포넌트다. iPhone에서는 화면 하단에서 슬라이드 업, iPad에서는 popover 스타일로 표시된다. Grabber(핸들)를 통해 크기 조절이 가능하며, 복수의 detent(높이 고정점)를 지원한다.

| 항목 | 값 |
|------|-----|
| Figma Node | `507:24684` (Sheets page) |
| Section | `544:199443` (4 children) |
| 타입 | Bottom Sheet (half/full), Inspector Panel, iPad Popover-style |

---

## 2. Dimensions

### 공통 (iPhone)
| 속성 | 값 | 출처 |
|------|-----|------|
| cornerRadius (top) | `34pt` | `spacing.json` > `radius.semantic.sheet.iphoneTop` |
| cornerRadius (bottom) | `58pt` | `spacing.json` > `radius.semantic.sheet.iphoneBottom` |
| Grabber Width | `36pt` | `spacing.json` > `components.sheet.grabberWidth` |
| Grabber Height | `5pt` | `spacing.json` > `components.sheet.grabberHeight` |
| Grabber Top Margin | `8pt` | `spacing.json` > `components.sheet.grabberTop` |
| Grabber cornerRadius | `9999pt` (pill) | `spacing.json` > `radius.full` |
| Content Padding Horizontal | `16pt` | `spacing.json` > `contentMargin.iphone.horizontal` |

### iPad
| 속성 | 값 | 출처 |
|------|-----|------|
| cornerRadius | `38pt` | `spacing.json` > `radius.semantic.sheet.ipad` |
| Content Padding Horizontal | `20pt` | `spacing.json` > `contentMargin.ipad.horizontal` |

### Detents (높이 고정점)
| Detent | 화면 높이 비율 | 설명 |
|--------|--------------|------|
| Small | `25%` | `components.sheet.minDetent` |
| Medium | `50%` | `components.sheet.mediumDetent` — 기본값 |
| Large | `100%` | `components.sheet.largeDetent` — 전체 화면 |

### 내부 레이아웃 구조

```
┌─────────────────────────────────────────┐  ← width: 화면 전체 (390pt on iPhone 16)
│              ━━━━━━━━━━━                │  ← Grabber: 36×5pt, top: 8pt
│                                         │
│  Content Area                           │  ← paddingH: 16pt
│  ...                                    │
│                                         │
└─────────────────────────────────────────┘
         ↑ cornerRadius: 34pt (top)
         ↑ Liquid Glass background
```

---

## 3. Variants

### 3-1. Bottom Sheet — Half (Medium Detent)
- 화면 높이의 50% 차지
- Grabber 항상 표시
- 드래그로 Large/Small 전환 가능
- 스크롤 콘텐츠는 Large detent 도달 후 활성화

### 3-2. Bottom Sheet — Full (Large Detent)
- 화면 전체 커버 (safe area 제외)
- Navigation Bar 역할의 헤더 영역 포함 가능
- Grabber 계속 표시 (닫기 제스처 가능)

### 3-3. Inspector Panel
- iPad 우측에 슬라이드인
- 고정 너비 (320pt 권장)
- 오른쪽 가장자리에서 등장
- `UIPresentationController` 커스텀 구현 필요

### 3-4. iPad Popover-style
- Popover 위치에서 Sheet처럼 동작
- cornerRadius: `38pt` (iPad)
- 배경 탭으로 dismiss 가능

---

## 4. Color Tokens (Liquid Glass)

Sheet 배경은 `materials.json`의 `liquidGlass.regular.large`를 사용한다.

| 역할 | 토큰 경로 | Light | Dark |
|------|----------|-------|------|
| Sheet 배경 (base) | `liquidGlass.regular.large.light.bg` | `#fafafa / a:0.7` | `#000000 / a:0.8` |
| Dark tint | `liquidGlass.regular.large.dark.tint` | — | `#ffffff / a:0.06` |
| Blur (frost) | `liquidGlass.regular.large.frostRadius` | `14px blur` | `14px blur` |
| Shadow | `liquidGlass.regular.large.shadow.blur` | `blur: 40` | `blur: 40` |
| Grabber 색상 | `miscellaneous.windowGrabber` | `#000000 / a:0.18` | `#ffffff / a:0.18` |
| 오버레이 | `overlays.default` | `#000000 / a:0.2` | `#000000 / a:0.48` |
| Separator (header/content) | `separators.nonOpaque` | `#000000 / a:0.12` | `#ffffff / a:0.17` |

### Liquid Glass CSS 구현
```css
.sheet-background {
  /* Light mode */
  background: rgba(250, 250, 250, 0.7);
  backdrop-filter: blur(14px) saturate(180%);
  -webkit-backdrop-filter: blur(14px) saturate(180%);
  box-shadow: 0 0 40px rgba(0, 0, 0, 0.15);

  /* Dark mode */
  background: rgba(0, 0, 0, 0.8);
  backdrop-filter: blur(14px) saturate(150%);
}
```

---

## 5. Typography

Sheet 자체는 typography를 정의하지 않는다. 콘텐츠 영역에 임베드된 컴포넌트의 스타일을 따른다.

단, Sheet 헤더가 있는 경우:

| 요소 | Style | Font | Weight | Size |
|------|-------|------|--------|------|
| Sheet Title | Title 3 | SF Pro Display | Semibold | 20pt |
| Sheet Subtitle | Subheadline | SF Pro Text | Regular | 15pt |
| Done/Cancel 버튼 | Body | SF Pro Text | Regular/Semibold | 17pt |

---

## 6. State Transitions

| 상태 | 설명 |
|------|------|
| Presenting | 하단에서 슬라이드 업 |
| Dragging (Grabber) | 손가락 위치를 따라 높이 실시간 변화, Spring으로 가장 가까운 detent에 스냅 |
| Scrolling (내부 콘텐츠) | Large detent일 때만 스크롤 가능. 스크롤 상단 도달 시 drag-to-dismiss 활성화 |
| Dismissing | 아래로 스와이프 또는 배경 탭 |
| Detent Snapping | 드래그 릴리즈 시 가장 가까운 detent로 spring 이동 |

---

## 7. Animation

### Present (등장)
```yaml
trigger: Sheet 표시 시
duration: 0.5s  # animations.json > duration.semantic.sheetPresent
easing: spring.gentle  # cubic-bezier(0.25, 0.46, 0.45, 0.94)
properties:
  translateY: 100% → 0%
  Liquid Glass blur: 0 → 14px (점진적 frosting)
overlay:
  opacity: 0 → 1
  duration: 0.5s
  easing: easeOut
```

### Dismiss (퇴장)
```yaml
trigger: 하단 스와이프 또는 배경 탭
duration: 0.3s  # animations.json > duration.semantic.sheetDismiss
easing: easeIn  # cubic-bezier(0.42, 0, 1.0, 1.0)
properties:
  translateY: 0% → 100%
overlay:
  opacity: 1 → 0
  duration: 0.3s
```

### Detent Snap (드래그 릴리즈)
```yaml
trigger: 드래그 제스처 릴리즈
duration: 0.35s
easing: spring.gentle  # cubic-bezier(0.25, 0.46, 0.45, 0.94)
properties:
  translateY: current → target detent position
velocity: 제스처 속도 연동 (UISpringTimingParameters.initialVelocity)
```

### iOS Native 구현 (UIKit)
```swift
let sheet = MyViewController()
let sheetController = sheet.sheetPresentationController

sheetController?.detents = [
    .custom(identifier: .init("small")) { _ in UIScreen.main.bounds.height * 0.25 },
    .medium(),  // 50%
    .large()    // 100%
]
sheetController?.prefersGrabberVisible = true
sheetController?.preferredCornerRadius = 34  // iphoneTop
present(sheet, animated: true)
```

### SwiftUI
```swift
.sheet(isPresented: $isPresented) {
    ContentView()
        .presentationDetents([.fraction(0.25), .medium, .large])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(34)
        .presentationBackground(.regularMaterial) // Liquid Glass approximation
}
```

### Flutter 구현
```dart
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(34), // iphoneTop
    ),
  ),
  backgroundColor: Colors.transparent,
  builder: (context) => BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14), // frostRadius: 14
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7), // liquidGlass.regular.large.light.bg
        borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
      ),
      child: content,
    ),
  ),
);
```

### CSS/Svelte 구현
```css
/* animations.json CSS mappings */
.sheet-enter {
  animation: sheet-slide-up 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
}
.sheet-exit {
  animation: sheet-slide-down 0.3s cubic-bezier(0.42, 0, 1.0, 1.0) forwards;
}

@keyframes sheet-slide-up {
  from { transform: translateY(100%); }
  to   { transform: translateY(0); }
}
@keyframes sheet-slide-down {
  from { transform: translateY(0); }
  to   { transform: translateY(100%); }
}
```

---

## 8. Accessibility

| 항목 | 요구사항 |
|------|---------|
| Grabber accessibilityLabel | "크기 조절 핸들" (`NSLocalizedString("Resize Handle")`) |
| Grabber accessibilityHint | "드래그하여 패널 크기를 조절하세요" |
| Grabber accessibilityActions | 더블 탭 → 다음 detent로 이동 |
| 오버레이 Dismiss | 배경 탭 가능 여부는 UX context에 따라 결정 (`presentsWithGrabber` 없을 때 배경 tap 기본 dismiss) |
| VoiceOver 포커스 | Sheet 등장 시 첫 번째 interactive element로 포커스 이동 |
| Dynamic Type | Sheet 내 텍스트 모두 Dynamic Type 지원 |
| 스크롤 접근성 | UIScrollView accessibility 기본 지원 |
| Reduce Motion | Spring 효과 → 단순 fade + 짧은 translateY (50px만 이동) |
| 키보드 인식 | TextField 포커스 시 `.keyboardDismissMode = .interactive` 적용 |
| safe area | `.ignoresSafeArea(edges: .bottom)` 로 bottom safe area 확장 처리 |

---

## 9. Framework Notes

### Liquid Glass 렌더링 우선순위
1. **iOS 26 Native**: `UISheetPresentationController` + `.presentationBackground(.regularMaterial)` → 시스템이 자동으로 Liquid Glass 적용
2. **SwiftUI**: `.presentationBackground(.regularMaterial)` or `.glassBackgroundEffect()`
3. **Flutter/Web**: `BackdropFilter` + 반투명 배경으로 근사 구현

### cornerRadius 주의사항
- iPhone: top `34pt`, bottom `58pt` — 하단이 더 크게 둥근 것이 iOS 26 디자인 언어
- iPad: 모서리 `38pt` 균일 적용
- `UISheetPresentationController.preferredCornerRadius`는 top corner만 제어. bottom은 자동.

### Detent 커스텀 (iOS 16+)
```swift
// iOS 16+ custom detent
.custom(identifier: .init("twentyFive")) { context in
    context.maximumDetentValue * 0.25
}
```

### Inspector Panel (iPad) 구현
- `UISplitViewController` 또는 커스텀 `UIPresentationController` 사용
- 오른쪽 trailing edge에서 슬라이드인
- cornerRadius `38pt` (iPad 기준)
