# Popovers — iOS 26 컴포넌트 스펙

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="61:65421")`

---

## 1. 개요

Popover는 트리거 요소 근처에 부유하는 컨텍스트 패널로, **iPad 전용** 컴포넌트다. iPhone에서는 자동으로 Sheet(bottom sheet)로 폴백된다.

| 항목 | 값 |
|------|-----|
| **Figma Node** | `61:65421` — COMPONENT_SET, 12 variants |
| **지원 플랫폼** | iPad (전용), iPhone → Sheet 자동 폴백 |
| **iOS 26 신규 특징** | Liquid Glass material 배경 적용 |
| **방향 결정** | 시스템 자동 (화면 공간 기준), 수동 오버라이드 가능 |
| **트리거** | 버튼, 바 버튼 아이템, 임의 뷰 |

> iOS 26에서 Popover의 가장 큰 변화는 배경이 기존 불투명 흰색/어두운 색에서 **Liquid Glass material**로 전환된 것이다. 배경 콘텐츠가 흐릿하게 비쳐 보이는 반투명 유리질 효과가 적용된다.

---

## 2. 치수 (Sizes)

### 너비 (Width)

| 항목 | 값 |
|------|-----|
| **최소 너비** | 200pt |
| **최대 너비** | 320pt |
| **기본 너비** | 콘텐츠에 따라 자동 결정 (200~320pt 내) |
| **내부 수평 패딩** | 16pt (좌우 각각) |

> 콘텐츠가 320pt를 초과하면 스크롤 가능한 콘텐츠 영역으로 처리하고 최대 너비를 유지한다.

### 높이 (Height)

| 항목 | 값 |
|------|-----|
| **최소 높이** | 44pt (단일 행 기준) |
| **최대 높이** | 화면 높이 × 0.6 |
| **내부 수직 패딩** | 12pt (상하 각각) |
| **최대 높이 초과 시** | 내부 스크롤 활성화 |

```
iPad Pro 12.9인치 (1366×1024pt) 기준:
  최대 팝오버 높이 = 1024 × 0.6 = 614.4pt ≈ 614pt

iPad mini 6세대 (1488×2266 @2x → 744×1133pt) 기준:
  최대 팝오버 높이 = 1133 × 0.6 = 679.8pt ≈ 679pt
```

### 화살표 (Arrow)

| 항목 | 값 |
|------|-----|
| **너비** | 11pt |
| **높이** | 8pt |
| **형태** | 이등변 삼각형 (꼭짓점이 트리거 방향을 향함) |
| **방향** | 위 / 아래 / 좌 / 우 (시스템 자동 결정) |
| **트리거와의 거리** | 0pt (화살표 꼭짓점이 트리거에 인접) |

### 화면 경계 여백 (Screen Edge Margin)

| 항목 | 값 |
|------|-----|
| **화면 경계 최소 여백** | 20pt (모든 방향) |
| **Safe Area 존중** | 항상 Safe Area inset 내에 위치 |

### 코너 반경 (Corner Radius)

| 항목 | 값 |
|------|-----|
| **팝오버 본체 코너** | 13pt (iOS 26 기준, Liquid Glass 표준) |
| **화살표 연결 부위** | 팝오버 본체와 자연스럽게 연결 (시스템 처리) |

---

## 3. Variants (12가지)

12가지 variant는 **화살표 방향 × 크기** 조합으로 구성된다.

### 화살표 방향 (4가지)

| Variant | 화살표 방향 | 팝오버 위치 | 적용 조건 |
|---------|-----------|-----------|----------|
| **Arrow Up** | 위쪽 | 트리거 아래 | 트리거가 화면 상단 절반 위치 |
| **Arrow Down** | 아래쪽 | 트리거 위 | 트리거가 화면 하단 절반 위치 |
| **Arrow Left** | 왼쪽 | 트리거 오른쪽 | 트리거가 화면 왼쪽 가장자리 근처 |
| **Arrow Right** | 오른쪽 | 트리거 왼쪽 | 트리거가 화면 오른쪽 가장자리 근처 |

### 크기 (3가지)

| Size | 너비 | 설명 |
|------|------|------|
| **Small** | 200pt | 짧은 메뉴, 2~3개 옵션 |
| **Medium** | 260pt | 일반적인 컨텍스트 메뉴, 설정 패널 |
| **Large** | 320pt | 복잡한 콘텐츠, 폼, 미니 뷰 |

### 12 Variant 전체 목록

| # | 이름 | 화살표 방향 | 너비 |
|---|------|-----------|------|
| 1 | `Arrow Up / Small` | ↑ | 200pt |
| 2 | `Arrow Up / Medium` | ↑ | 260pt |
| 3 | `Arrow Up / Large` | ↑ | 320pt |
| 4 | `Arrow Down / Small` | ↓ | 200pt |
| 5 | `Arrow Down / Medium` | ↓ | 260pt |
| 6 | `Arrow Down / Large` | ↓ | 320pt |
| 7 | `Arrow Left / Small` | ← | 200pt |
| 8 | `Arrow Left / Medium` | ← | 260pt |
| 9 | `Arrow Left / Large` | ← | 320pt |
| 10 | `Arrow Right / Small` | → | 200pt |
| 11 | `Arrow Right / Medium` | → | 260pt |
| 12 | `Arrow Right / Large` | → | 320pt |

---

## 4. 색상 / Material

### Liquid Glass Material

iOS 26 팝오버는 **Liquid Glass material**을 배경으로 사용한다.

| 레이어 | 속성 | 값 |
|--------|------|-----|
| **Backdrop Blur** | blur radius | 40pt |
| **배경 색조 (Light)** | fill | `rgba(255,255,255,0.72)` |
| **배경 색조 (Dark)** | fill | `rgba(30,30,30,0.78)` |
| **테두리 (Light)** | stroke | `rgba(255,255,255,0.3)`, 0.5pt |
| **테두리 (Dark)** | stroke | `rgba(255,255,255,0.15)`, 0.5pt |
| **내부 그림자** | inset shadow | `rgba(255,255,255,0.08)`, blur 1pt |
| **외부 그림자** | drop shadow | `rgba(0,0,0,0.18)`, y=8pt, blur 24pt |

### 색상 토큰 매핑

| 용도 | 토큰 | Light | Dark |
|------|------|-------|------|
| 팝오버 배경 | `colors.popover.background` | `rgba(255,255,255,0.72)` | `rgba(30,30,30,0.78)` |
| 팝오버 테두리 | `colors.popover.border` | `rgba(255,255,255,0.3)` | `rgba(255,255,255,0.15)` |
| 내부 텍스트 (기본) | `colors.label.primary` | `#000000` | `#FFFFFF` |
| 내부 텍스트 (보조) | `colors.label.secondary` | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.6)` |
| 구분선 | `colors.separator` | `rgba(60,60,67,0.29)` | `rgba(84,84,88,0.65)` |
| 화살표 | 팝오버 배경과 동일 소재 | — | — |

---

## 5. 애니메이션

팝오버 등장/퇴장 애니메이션은 **scale + opacity** 조합의 spring 애니메이션을 사용한다.

### 등장 (Present)

| 속성 | 시작값 | 끝값 | 파라미터 |
|------|--------|------|---------|
| `opacity` | 0 | 1 | spring, stiffness: 400, damping: 35 |
| `scale` | 0.85 | 1.0 | spring, stiffness: 400, damping: 35 |
| `transform-origin` | 화살표 방향 기준 | — | — |

```
transform-origin 계산:
  Arrow Up (팝오버가 트리거 아래에 위치):
    → origin: top center (팝오버 상단 중앙, 화살표 위치)
  Arrow Down (팝오버가 트리거 위에 위치):
    → origin: bottom center
  Arrow Left (팝오버가 트리거 오른쪽):
    → origin: center left
  Arrow Right (팝오버가 트리거 왼쪽):
    → origin: center right
```

### 퇴장 (Dismiss)

| 속성 | 시작값 | 끝값 | 파라미터 |
|------|--------|------|---------|
| `opacity` | 1 | 0 | duration: 0.2s, ease-out |
| `scale` | 1.0 | 0.92 | duration: 0.2s, ease-out |

### Spring 파라미터 비교표

| 파라미터 | 값 | 체감 효과 |
|---------|-----|---------|
| stiffness | 400 | 빠른 초기 가속 |
| damping | 35 | 오버슈트 없이 부드럽게 착지 |
| initial velocity | 0 | 정지 상태에서 시작 |

> iOS 26 Liquid Glass 컴포넌트는 전반적으로 `UISpringTimingParameters(stiffness:400, damping:35)` 계열을 공통으로 사용한다.

---

## 6. Accessibility (접근성)

| 항목 | 규칙 |
|------|------|
| **최소 터치 타겟** | 팝오버 내부 인터랙티브 요소는 44×44pt 이상 |
| **포커스 관리** | 팝오버 열릴 때 첫 번째 인터랙티브 요소로 포커스 이동 |
| **닫기 접근성** | VoiceOver: 팝오버 외부 스와이프 → dismiss |
| **키보드 내비게이션** | Tab: 팝오버 내 요소 순회, Escape: 닫기 |
| **색상 대비** | WCAG AA — 본문 텍스트 4.5:1 이상, Liquid Glass 배경 고려 필요 |
| **Dynamic Type** | 팝오버 내부 텍스트는 Dynamic Type 지원 필수 |
| **접근성 레이블** | 팝오버를 여는 트리거 요소에 `accessibilityLabel` 명시 권장 |
| **팝오버 역할** | `accessibilityViewIsModal = true` 설정으로 배경 콘텐츠 VoiceOver 차단 |

---

## 7. 닫기 (Dismiss) 동작

| 트리거 | 동작 |
|--------|------|
| **팝오버 외부 탭** | 즉시 dismiss |
| **Escape 키 (iPad + 외부 키보드)** | 즉시 dismiss |
| **트리거 버튼 재탭** | 토글 dismiss |
| **내부 dismiss 버튼** | 명시적 dismiss |
| **Navigation 이동** | 자동 dismiss |
| **화면 회전** | 위치 재계산 후 유지 (dismiss 안 함) |

---

## 8. 프레임워크별 구현

### UIKit — UIPopoverPresentationController

```swift
import UIKit

class ViewController: UIViewController {

    @IBAction func showPopover(_ sender: UIButton) {
        let contentVC = PopoverContentViewController()

        // 팝오버 크기 설정
        contentVC.preferredContentSize = CGSize(width: 260, height: 200)

        // 팝오버 모달 스타일 설정
        contentVC.modalPresentationStyle = .popover

        guard let popover = contentVC.popoverPresentationController else { return }

        // 트리거 요소 설정
        popover.sourceView = sender
        popover.sourceRect = sender.bounds

        // 화살표 방향 허용 (시스템이 자동 결정)
        popover.permittedArrowDirections = [.up, .down, .left, .right]

        // iOS 26: Liquid Glass 소재 (기본 적용)
        // 별도 설정 없이 시스템이 Liquid Glass material 사용

        // 배경 흐림 효과 커스터마이즈 (선택사항)
        popover.backgroundColor = UIColor.systemBackground.withAlphaComponent(0)
        // → 투명으로 설정하면 Liquid Glass가 더 잘 보임

        // 접근성: 팝오버 배경 VoiceOver 차단
        contentVC.view.accessibilityViewIsModal = true

        // 딤 배경 제거 (iPad 팝오버 표준)
        popover.delegate = self

        present(contentVC, animated: true)
    }
}

// MARK: - UIPopoverPresentationControllerDelegate
extension ViewController: UIPopoverPresentationControllerDelegate {

    // iPad에서 팝오버 유지 (iPhone에서는 Sheet로 자동 폴백)
    func adaptivePresentationStyle(
        for controller: UIPresentationController
    ) -> UIModalPresentationStyle {
        return .none  // iPad: 팝오버 유지
        // return .pageSheet  // iPhone: Sheet 강제
    }

    // 팝오버 dismiss 직전 콜백
    func popoverPresentationControllerShouldDismissPopover(
        _ popoverPresentationController: UIPopoverPresentationController
    ) -> Bool {
        return true  // false 반환 시 외부 탭으로 dismiss 불가
    }
}
```

#### Bar Button Item에서 팝오버 띄우기

```swift
@objc func showFromBarButton(_ barButtonItem: UIBarButtonItem) {
    let contentVC = PopoverContentViewController()
    contentVC.preferredContentSize = CGSize(width: 320, height: 300)
    contentVC.modalPresentationStyle = .popover

    guard let popover = contentVC.popoverPresentationController else { return }
    popover.barButtonItem = barButtonItem  // sourceView 대신 barButtonItem 사용

    present(contentVC, animated: true)
}
```

---

### SwiftUI — `.popover()` modifier

```swift
import SwiftUI

struct ContentView: View {
    @State private var isPopoverPresented = false

    var body: some View {
        Button("설정 열기") {
            isPopoverPresented = true
        }
        .popover(
            isPresented: $isPopoverPresented,
            attachmentAnchor: .point(.bottom),   // 트리거 기준 앵커 포인트
            arrowEdge: .top                       // 화살표 방향 (위 = 팝오버가 아래에 위치)
        ) {
            PopoverContentView()
                .frame(minWidth: 200, maxWidth: 320)
                .frame(minHeight: 100)
                // iOS 26: Liquid Glass 소재 자동 적용
                .presentationCompactAdaptation(.popover) // 작은 화면에서도 팝오버 유지 (iOS 16.4+)
        }
    }
}

struct PopoverContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("팝오버 제목")
                .font(.headline)
            Divider()
            Button("옵션 1") { }
            Button("옵션 2") { }
            Button("옵션 3") { }
        }
        .padding(16)
    }
}
```

#### iPad / iPhone 분기 처리

```swift
struct AdaptivePopoverView: View {
    @State private var isPresented = false
    @Environment(\.horizontalSizeClass) private var sizeClass

    var body: some View {
        Button("열기") {
            isPresented = true
        }
        .popover(isPresented: $isPresented) {
            PopoverContentView()
                .frame(
                    minWidth: sizeClass == .regular ? 260 : nil,  // iPad: 고정 너비
                    maxWidth: sizeClass == .regular ? 320 : nil   // iPhone: Sheet로 폴백되므로 제한 없음
                )
                // iPhone에서 sheet 스타일 적용
                .presentationDetents(
                    sizeClass == .compact ? [.medium, .large] : [.large]
                )
        }
    }
}
```

#### iOS 26 Liquid Glass Popover 커스터마이즈

```swift
// iOS 26 Liquid Glass 효과 직접 적용 (SwiftUI)
struct LiquidGlassPopoverContent: View {
    var body: some View {
        VStack(spacing: 0) {
            PopoverContentView()
        }
        .background(.thinMaterial)          // Liquid Glass 근사치 (iOS 15+)
        .cornerRadius(13)
        .overlay(
            RoundedRectangle(cornerRadius: 13)
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.3),
                            Color.white.opacity(0.1)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 0.5
                )
        )
        .shadow(color: .black.opacity(0.18), radius: 24, x: 0, y: 8)
    }
}
```

---

### Flutter — Overlay + FollowerLayer 근사 구현

Flutter에는 네이티브 iPad Popover에 해당하는 위젯이 없으므로, `Overlay` + `CompositedTransformFollower`를 활용한 커스텀 구현이 필요하다.

#### 기본 Popover 위젯 구현

```dart
import 'package:flutter/material.dart';

/// iOS 26 스타일 Popover 위젯
class IosPopover extends StatefulWidget {
  final Widget trigger;
  final Widget content;
  final double minWidth;
  final double maxWidth;
  final PopoverDirection preferredDirection;

  const IosPopover({
    super.key,
    required this.trigger,
    required this.content,
    this.minWidth = 200,
    this.maxWidth = 320,
    this.preferredDirection = PopoverDirection.down,
  });

  @override
  State<IosPopover> createState() => _IosPopoverState();
}

enum PopoverDirection { up, down, left, right }

class _IosPopoverState extends State<IosPopover>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  late AnimationController _animController;
  late Animation<double> _scaleAnim;
  late Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );

    // Spring 근사: Curves.easeOutBack
    _scaleAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
    );
    _opacityAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _showPopover() {
    _overlayEntry = _buildOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _animController.forward(from: 0);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Future<void> _hidePopover() async {
    await _animController.reverse();
    _removeOverlay();
  }

  OverlayEntry _buildOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // 배경 탭 감지 (dismiss)
          Positioned.fill(
            child: GestureDetector(
              onTap: _hidePopover,
              behavior: HitTestBehavior.opaque,
              child: const SizedBox.expand(),
            ),
          ),
          // 팝오버 본체
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: _calculateOffset(),
            child: FadeTransition(
              opacity: _opacityAnim,
              child: ScaleTransition(
                scale: _scaleAnim,
                alignment: _scaleAlignment(),
                child: _PopoverContent(
                  minWidth: widget.minWidth,
                  maxWidth: widget.maxWidth,
                  direction: widget.preferredDirection,
                  child: widget.content,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Offset _calculateOffset() {
    const arrowHeight = 8.0;
    switch (widget.preferredDirection) {
      case PopoverDirection.down:
        return const Offset(0, 44 + arrowHeight); // 트리거 높이 + 화살표
      case PopoverDirection.up:
        return const Offset(0, -(200 + arrowHeight)); // 팝오버 높이 추정값
      case PopoverDirection.right:
        return const Offset(44 + arrowHeight, 0);
      case PopoverDirection.left:
        return const Offset(-(260 + arrowHeight), 0);
    }
  }

  Alignment _scaleAlignment() {
    switch (widget.preferredDirection) {
      case PopoverDirection.down:
        return Alignment.topCenter;
      case PopoverDirection.up:
        return Alignment.bottomCenter;
      case PopoverDirection.right:
        return Alignment.centerLeft;
      case PopoverDirection.left:
        return Alignment.centerRight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _overlayEntry == null ? _showPopover : _hidePopover,
        child: widget.trigger,
      ),
    );
  }
}

/// 팝오버 내부 콘텐츠 + Liquid Glass 효과
class _PopoverContent extends StatelessWidget {
  final Widget child;
  final double minWidth;
  final double maxWidth;
  final PopoverDirection direction;

  const _PopoverContent({
    required this.child,
    required this.minWidth,
    required this.maxWidth,
    required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth,
        maxWidth: maxWidth,
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: BackdropFilter(
          // Liquid Glass blur 효과
          filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xC71E1E1E)  // rgba(30,30,30,0.78)
                  : const Color(0xB8FFFFFF), // rgba(255,255,255,0.72)
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withValues(alpha: 0.15)
                    : Colors.white.withValues(alpha: 0.3),
                width: 0.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

#### 사용 예시

```dart
// iPad에서만 팝오버, iPhone에서는 BottomSheet
class AdaptivePopoverExample extends StatelessWidget {
  const AdaptivePopoverExample({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    if (isTablet) {
      // iPad: 팝오버 사용
      return IosPopover(
        preferredDirection: PopoverDirection.down,
        trigger: const Icon(Icons.more_horiz),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('공유'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('편집'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('삭제', style: TextStyle(color: Colors.red)),
              onTap: () {},
            ),
          ],
        ),
      );
    } else {
      // iPhone: 바텀 시트로 폴백
      return IconButton(
        icon: const Icon(Icons.more_horiz),
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (ctx) => const BottomSheetContent(),
        ),
      );
    }
  }
}
```

---

### Svelte (웹 근사치)

웹에서는 CSS `backdrop-filter` + Floating UI 라이브러리로 팝오버를 구현한다.

#### 설치

```bash
npm install @floating-ui/dom
# 또는
pnpm add @floating-ui/dom
```

#### Svelte 5 Popover 컴포넌트

```svelte
<script lang="ts">
  import { computePosition, flip, shift, offset, arrow } from '@floating-ui/dom';
  import { onMount, onDestroy } from 'svelte';

  interface Props {
    open?: boolean;
    preferredPlacement?: 'top' | 'bottom' | 'left' | 'right';
    minWidth?: number;
    maxWidth?: number;
    onClose?: () => void;
    children: import('svelte').Snippet;
    trigger: import('svelte').Snippet;
  }

  let {
    open = $bindable(false),
    preferredPlacement = 'bottom',
    minWidth = 200,
    maxWidth = 320,
    onClose,
    children,
    trigger,
  }: Props = $props();

  let triggerEl: HTMLElement;
  let popoverEl: HTMLElement;
  let arrowEl: HTMLElement;

  $effect(() => {
    if (open && triggerEl && popoverEl) {
      updatePosition();
    }
  });

  async function updatePosition() {
    const { x, y, placement, middlewareData } = await computePosition(
      triggerEl,
      popoverEl,
      {
        placement: preferredPlacement,
        middleware: [
          offset(11), // 화살표 높이(8pt) + 여백(3pt)
          flip(),     // 화면 벗어나면 방향 반전
          shift({ padding: 20 }), // 화면 경계 20pt 여백
          arrow({ element: arrowEl }),
        ],
      }
    );

    Object.assign(popoverEl.style, {
      left: `${x}px`,
      top: `${y}px`,
    });

    // 화살표 위치 계산
    const { x: arrowX, y: arrowY } = middlewareData.arrow ?? {};
    const staticSide = {
      top: 'bottom',
      right: 'left',
      bottom: 'top',
      left: 'right',
    }[placement.split('-')[0]]!;

    Object.assign(arrowEl.style, {
      left: arrowX != null ? `${arrowX}px` : '',
      top: arrowY != null ? `${arrowY}px` : '',
      right: '',
      bottom: '',
      [staticSide]: '-4px', // 화살표 튀어나온 길이
    });
  }

  function handleOutsideClick(e: MouseEvent) {
    if (
      open &&
      popoverEl &&
      !popoverEl.contains(e.target as Node) &&
      !triggerEl.contains(e.target as Node)
    ) {
      open = false;
      onClose?.();
    }
  }

  onMount(() => {
    document.addEventListener('mousedown', handleOutsideClick);
  });

  onDestroy(() => {
    document.removeEventListener('mousedown', handleOutsideClick);
  });
</script>

<div class="popover-wrapper">
  <!-- 트리거 -->
  <div
    bind:this={triggerEl}
    class="trigger"
    onclick={() => (open = !open)}
    role="button"
    tabindex="0"
    onkeydown={(e) => e.key === 'Enter' && (open = !open)}
    aria-haspopup="true"
    aria-expanded={open}
  >
    {@render trigger()}
  </div>

  <!-- 팝오버 본체 -->
  {#if open}
    <div
      bind:this={popoverEl}
      class="popover"
      style:min-width="{minWidth}px"
      style:max-width="{maxWidth}px"
      role="dialog"
      aria-modal="true"
    >
      <!-- Liquid Glass 화살표 -->
      <div bind:this={arrowEl} class="popover-arrow"></div>
      <!-- 콘텐츠 -->
      <div class="popover-content">
        {@render children()}
      </div>
    </div>
  {/if}
</div>

<style>
  .popover-wrapper {
    position: relative;
    display: inline-block;
  }

  .popover {
    position: absolute;
    top: 0;
    left: 0;
    z-index: 1000;
    border-radius: 13px;
    /* Liquid Glass: backdrop-filter */
    backdrop-filter: blur(40px) saturate(1.8);
    -webkit-backdrop-filter: blur(40px) saturate(1.8);
    background: rgba(255, 255, 255, 0.72);
    border: 0.5px solid rgba(255, 255, 255, 0.3);
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.18);
    /* 등장 애니메이션 */
    animation: popoverIn 0.28s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
    overflow: hidden;
  }

  @media (prefers-color-scheme: dark) {
    .popover {
      background: rgba(30, 30, 30, 0.78);
      border-color: rgba(255, 255, 255, 0.15);
    }
  }

  .popover-content {
    padding: 12px 16px;
    max-height: 60vh;
    overflow-y: auto;
    /* 스크롤바 숨기기 (iOS 느낌) */
    scrollbar-width: none;
  }
  .popover-content::-webkit-scrollbar {
    display: none;
  }

  .popover-arrow {
    position: absolute;
    width: 11px;
    height: 11px;
    background: inherit;
    border: inherit;
    transform: rotate(45deg);
    border-radius: 2px;
  }

  /* 등장 spring 애니메이션 근사 */
  @keyframes popoverIn {
    from {
      opacity: 0;
      transform: scale(0.85);
    }
    to {
      opacity: 1;
      transform: scale(1);
    }
  }

  /* 터치 타겟 최소 44×44pt (CSS px 기준 44px) */
  .trigger {
    min-width: 44px;
    min-height: 44px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
  }
</style>
```

#### 사용 예시 (Svelte)

```svelte
<script lang="ts">
  import Popover from '$lib/components/Popover.svelte';
  let isOpen = $state(false);
</script>

<Popover bind:open={isOpen} preferredPlacement="bottom" maxWidth={260}>
  {#snippet trigger()}
    <button class="icon-btn">
      <MoreHorizIcon />
    </button>
  {/snippet}

  {#snippet children()}
    <ul class="menu-list">
      <li><button onclick={() => {}}>공유</button></li>
      <li><button onclick={() => {}}>편집</button></li>
      <li class="danger"><button onclick={() => {}}>삭제</button></li>
    </ul>
  {/snippet}
</Popover>
```

---

## 9. 위치 결정 알고리즘

시스템이 팝오버 방향을 자동 결정하는 로직:

```
1. 트리거 요소의 화면 내 위치 계산
2. 각 방향(위/아래/좌/우)으로 팝오버를 배치했을 때 화면 밖으로 나가는 면적 계산
3. 사용자가 지정한 preferredArrowDirections 중 가장 적합한 방향 선택
4. 모든 방향이 부적합하면: 아래(down) 방향 우선, 팝오버 위치 오프셋으로 화면 내 배치
5. 화면 경계에서 최소 20pt 여백 보장
6. Safe Area inset 고려 (노치, 홈 인디케이터 영역 회피)
```

---

## 10. 자주 발생하는 문제 및 해결책

| 문제 | 원인 | 해결 |
|------|------|------|
| iPhone에서 Sheet 대신 팝오버가 표시됨 | `adaptivePresentationStyle` 미설정 | `return .none`을 `return .formSheet` 또는 `.pageSheet`로 변경 |
| 팝오버 배경이 불투명하게 보임 | iOS 버전이 Liquid Glass 미지원 | iOS 26+ 조건부 처리 또는 fallback material 사용 |
| 팝오버 위치가 트리거와 어긋남 | `sourceRect`를 좌표계 변환 없이 설정 | `sender.convert(sender.bounds, to: nil)` 사용 |
| Flutter에서 팝오버가 다른 위젯 위로 렌더링 안 됨 | Overlay를 Navigator 위에 삽입해야 함 | `Overlay.of(context, rootOverlay: true)` 사용 |
| Svelte 팝오버가 overflow hidden 컨테이너에서 잘림 | CSS overflow 제약 | Floating UI `Portal`을 body에 마운트하거나 `position: fixed` 사용 |
| 다크 모드에서 Liquid Glass가 너무 어두움 | 배경 불투명도가 높음 | Dark 배경 불투명도를 0.72~0.78 범위 내에서 조정 |
