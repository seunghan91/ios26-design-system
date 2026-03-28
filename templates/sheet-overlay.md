# Sheet Overlay Template

> **References**
> - Components: `../components/specs/sheet.md`, `../components/specs/button.md`
> - Tokens: `../tokens/spacing.json`, `../tokens/colors.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md` (Examples page: `0:3329`)
> - Parent: `../PLAN.md`

---

## 1. Overview

Sheet Overlay(Bottom Sheet / Modal Sheet)는 현재 화면 위에 올라오는 반투명 패널이다. 화면을 완전히 교체하지 않고 추가 정보 입력, 옵션 선택, 상세 보기 등을 처리할 때 사용한다. iOS 26에서는 시트 컨테이너에 **Liquid Glass** 재질이 적용되어 뒤 콘텐츠를 굴절+흐림 처리한다.

**적용 대상**
- 필터/정렬 옵션 선택
- 상세 정보 미리보기 (지도 POI, 상품 상세 등)
- 폼 입력 (짧은 텍스트 필드)
- Action Sheet 대체 (iOS 26 권장)
- Share Sheet, Activity View

**이 템플릿이 다루지 않는 것**
- Alert / Confirmation Dialog → `alert-modal.md` 참조
- Full-screen Modal (Sheet가 100% detent로 전환 시에도 별도 구분)
- Context Menu → 별도 Component

---

## 2. Layout Diagram

```
┌─────────────────────────────────────┐
│        배경 화면 (dimming)           │  backdrop: rgba(0,0,0, 0.40)
│                                     │  탭하면 시트 닫힘 (설정에 따라)
│                                     │
│                                     │
│  ┌───────────────────────────────┐  │
│  │  ┄┄┄┄┄┄┄  ← Grabber           │  36×5pt, top 8pt, radius 9999pt
│  │                               │  색: fills.tertiary (rgba 12%)
│  │  ┌─────────────────────────┐  │
│  │  │    Sheet Title (선택)    │  │  17pt Semibold, 상단 20pt 패딩
│  │  └─────────────────────────┘  │
│  │                               │  Liquid Glass background
│  │    Content Area (scrollable)  │  frost blur: 12pt (medium)
│  │                               │  corner-radius top: 34pt (iPhone)
│  │    [ListRow / Form / Card]    │
│  │    [ListRow]                  │
│  │    [ListRow]                  │
│  │                               │
│  │  ┌─────────────────────────┐  │
│  │  │  [Liquid Glass Button]  │  │  선택적. 시트 내 인라인 버튼
│  │  └─────────────────────────┘  │
│  │                               │
│  │  ──── Safe Area ─────────── ─ │  34pt (Dynamic Island 모델)
│  └───────────────────────────────┘
└─────────────────────────────────────┘

Detent 높이 기준 (iPhone 16 Pro, 874pt logical):
  25% detent  ≈ 218pt  (Quick action / confirmation)
  50% detent  ≈ 437pt  (Standard content)
  100% detent ≈ 874pt  (Full-screen equivalent)
```

---

## 3. Detent System

Detent는 시트가 멈출 수 있는 높이 지점이다. iOS 16+에서 `UISheetPresentationController`로 제어하며, iOS 26에서 Liquid Glass와 함께 시각적으로 개선되었다.

### 표준 Detent 값

| Detent | 화면 비율 | 높이 (iPhone 16 Pro) | 적용 시나리오 |
|--------|----------|----------------------|--------------|
| `minDetent` | **25%** | ~218pt | 간단한 확인 메시지, 단일 버튼 액션 |
| `mediumDetent` | **50%** | ~437pt | 목록 선택, 짧은 폼, 미리보기 |
| `largeDetent` | **100%** | ~874pt | 전체 화면 대체, 복잡한 폼 |

**토큰 출처**: `spacing.json` → `components.sheet.minDetent(0.25)`, `mediumDetent(0.5)`, `largeDetent(1.0)`

### 커스텀 Detent

```swift
// iOS 16+: custom detent
let customDetent = UISheetPresentationController.Detent.custom(identifier: .init("customHeight")) { context in
    return 300 // 고정 높이 (pt)
}
```

### Detent 간 전환

- 드래그로 즉시 전환 가능 (grabber 영역 또는 시트 상단)
- 프로그래밍 방식: `sheetPresentationController?.animateChanges { ... }`
- 전환 애니메이션: `spring.gentle` (response: 0.55, dampingRatio: 0.825)

---

## 4. Presentation Animation

시트가 화면에 나타날 때의 애니메이션이다.

### 파라미터

| 항목 | 값 | 토큰 |
|------|-----|------|
| Duration | **0.5s** | `duration.semantic.sheetPresent` |
| Easing | spring.gentle | `spring.presets.gentle` |
| Start Position | `translateY(100%)` — 화면 아래 밖 |
| End Position | `translateY(0)` — 최종 detent 위치 |
| Backdrop Start | `opacity: 0` |
| Backdrop End | `opacity: 0.40` |

### Native Spring 파라미터

```
response: 0.55
dampingRatio: 0.825
→ 약간의 overshoot 없이 부드럽게 안착
```

### CSS 근사값

```css
.sheet-container {
    transform: translateY(100%);
    transition: transform 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    /* animations.json: css.sheetTransition */
}

.sheet-container.presented {
    transform: translateY(0);
}

.backdrop {
    opacity: 0;
    transition: opacity 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.backdrop.presented {
    opacity: 0.40;
}
```

---

## 5. Dismissal — 드래그 다운 제스처 + 애니메이션

### 제스처 처리

1. **grabber 또는 시트 상단 드래그** → 드래그 거리에 따라 시트 실시간 이동
2. **50% 이상 드래그** → 손가락 뗄 때 자동 닫힘
3. **50% 미만 드래그** → 손가락 뗄 때 원래 detent로 복귀
4. **빠른 플릭 다운** → 속도 임계값 초과 시 즉시 닫힘 (거리 무관)

### Dismiss 애니메이션

| 항목 | 값 | 토큰 |
|------|-----|------|
| Duration | **0.3s** | `duration.semantic.sheetDismiss` |
| Easing | `appleEaseIn` | `easing.appleEaseIn` |
| End Position | `translateY(100%)` |
| Backdrop End | `opacity: 0` |

```swift
// Swift: 프로그래밍 방식 dismiss
dismiss(animated: true)

// SwiftUI
@Environment(\.dismiss) var dismiss
// ...
Button("닫기") { dismiss() }
```

---

## 6. Stacking — 여러 시트 겹치기

iOS 26에서는 시트 위에 시트를 올릴 수 있다 (Sheet Stacking).

### 시각적 규칙

```
┌───────────────────────────────┐
│  Sheet Level 3 (top / active) │  100% 크기, 최전면
│  scale: 1.0                   │
└───────────────────────────────┘
    ┌─────────────────────────┐
    │  Sheet Level 2          │  scale: 0.92, y-offset: +10pt
    │  scale: 0.92            │
    └─────────────────────────┘
        ┌─────────────────────┐
        │  Sheet Level 1      │  scale: 0.84, y-offset: +20pt
        │  (oldest)           │
        └─────────────────────┘
```

| 스택 레벨 | Scale | Y-Offset | Opacity |
|----------|-------|----------|---------|
| 최상단 (active) | 1.0 | 0pt | 1.0 |
| -1 레벨 | 0.92 | +10pt | 0.9 |
| -2 레벨 | 0.84 | +20pt | 0.8 |

### 최대 스택 깊이

실용적으로 3단 이하 권장. 4단 이상은 UX 복잡도 문제 발생.

---

## 7. Backdrop Tap Dismiss

| 상황 | 탭하면 닫히나? |
|------|--------------|
| 단순 정보 표시 시트 | 닫힘 (기본값) |
| 필수 선택 필요 시트 | 닫히지 않음 (`isModalInPresentation = true`) |
| 폼 입력 미완료 상태 | 확인 대화상자 표시 후 닫힘 |
| Full-screen detent | 닫히지 않음 (탭 영역 없음) |

```swift
// Backdrop 탭 dismiss 비활성화
sheetViewController.isModalInPresentation = true

// SwiftUI: interactiveDismissDisabled
.sheet(isPresented: $isShowing) {
    ContentView()
        .interactiveDismissDisabled(true)
}
```

---

## 8. Keyboard Avoidance

키보드가 올라올 때 시트가 자동으로 위로 이동한다.

### 동작 방식

```
키보드 없음:
  시트 위치 = 50% detent

키보드 올라옴 (높이 ~346pt):
  시트 = 키보드 상단 기준 + 0pt (자동 재배치)
  → 시트 내 텍스트 필드가 항상 보이도록 보장

키보드 내려감:
  시트 = 원래 detent 위치 복귀
```

### 애니메이션

| 항목 | 값 | 토큰 |
|------|-----|------|
| Duration | **0.25s** | `duration.semantic.keyboardSlide` |
| Easing | `appleEaseOut` | `easing.appleEaseOut` |

### 구현

```swift
// UIKit: 자동 처리 (UISheetPresentationController가 keyboard avoidance 내장)
// SwiftUI: 자동 처리 (.sheet modifier 사용 시)

// 수동 조정이 필요한 경우 (Custom Bottom Sheet)
NotificationCenter.default.addObserver(
    forName: UIResponder.keyboardWillShowNotification,
    object: nil, queue: .main
) { notification in
    guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
    let keyboardHeight = keyboardFrame.height
    // bottom constraint 조정
    bottomConstraint.constant = keyboardHeight
    UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
        self.view.layoutIfNeeded()
    }
}
```

---

## 9. SwiftUI / UIKit / Flutter Implementation

### SwiftUI

```swift
struct ParentView: View {
    @State private var showSheet = false

    var body: some View {
        Button("시트 열기") { showSheet = true }
            .sheet(isPresented: $showSheet) {
                SheetContent()
                    .presentationDetents([.fraction(0.5), .large]) // 50% / 100%
                    .presentationDragIndicator(.visible)           // grabber 표시
                    .presentationBackground(.regularMaterial)      // Liquid Glass
                    .presentationCornerRadius(34)                  // spacing.json: radius.semantic.sheet.iphoneTop
            }
    }
}

struct SheetContent: View {
    var body: some View {
        NavigationStack {
            List { /* 내용 */ }
                .navigationTitle("시트 제목")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
```

### UIKit

```swift
class ParentViewController: UIViewController {
    @IBAction func showSheet() {
        let sheetVC = SheetViewController()
        if let sheet = sheetVC.sheetPresentationController {
            // Detent 설정 (25%, 50%, 100%)
            sheet.detents = [
                .custom(identifier: .init("quarter")) { _ in return 218 }, // 25%
                .medium(),   // 50%
                .large()     // 100%
            ]
            sheet.preferredCornerRadius = 34  // radius.semantic.sheet.iphoneTop
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
        }
        present(sheetVC, animated: true)
    }
}
```

### Flutter

```dart
// Flutter: showModalBottomSheet
Future<void> showSheet(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,  // 키보드 avoidance 활성화
        useSafeArea: true,
        backgroundColor: Colors.transparent,
        builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.5,   // 50% detent
            minChildSize: 0.25,      // 25% detent
            maxChildSize: 1.0,       // 100% detent
            snap: true,
            snapSizes: const [0.25, 0.5, 1.0],
            builder: (context, scrollController) => ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(34),  // spacing.json: radius.semantic.sheet.iphoneTop
                ),
                child: BackdropFilter(
                    // animations.json: flutter.liquidGlassBlur
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                        color: Colors.white.withOpacity(0.7),
                        child: Column(children: [
                            // Grabber: 36×5pt, top 8pt
                            Container(
                                margin: const EdgeInsets.only(top: 8),
                                width: 36,  // spacing.json: components.sheet.grabberWidth
                                height: 5,  // spacing.json: components.sheet.grabberHeight
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(9999),
                                ),
                            ),
                            Expanded(
                                child: ListView(
                                    controller: scrollController,
                                    children: [/* 내용 */],
                                ),
                            ),
                        ]),
                    ),
                ),
            ),
        ),
    );
}
```

### 핵심 토큰 요약

| 항목 | 값 | 토큰 경로 |
|------|-----|----------|
| Grabber 폭 | **36pt** | `components.sheet.grabberWidth` |
| Grabber 높이 | **5pt** | `components.sheet.grabberHeight` |
| Grabber 상단 간격 | **8pt** | `components.sheet.grabberTop` |
| 시트 상단 radius (iPhone) | **34pt** | `radius.semantic.sheet.iphoneTop` |
| 시트 하단 radius (iPhone) | **58pt** | `radius.semantic.sheet.iphoneBottom` |
| Liquid Glass frost blur | **12pt** | `liquidGlass.frost.medium` |
| Backdrop opacity | **0.40** | `overlays.default.light.a = 0.2` → Sheet는 0.40 사용 |
| Present duration | **0.5s** | `duration.semantic.sheetPresent` |
| Dismiss duration | **0.3s** | `duration.semantic.sheetDismiss` |
