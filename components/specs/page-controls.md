# Page Controls Component Spec

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="488:51848")`

---

## 1. Overview

iOS 26의 Page Control 컴포넌트. 스크롤 가능한 콘텐츠(carousel, onboarding, 사진 뷰어)에서 현재 페이지 위치를 점(dot) 시리즈로 표시한다. 현재 페이지 dot은 불투명하고 비활성 dot은 반투명하게 표시되며, 인터랙티브 모드에서는 현재 dot이 pill 형태로 확장된다.

- **Figma Node**: `488:51848` (Page control COMPONENT_SET, 35 variants)
- **Light 예시**: `2666:17018` (8가지)
- **Dark 예시**: `2666:17019` (8가지)
- **UIKit 클래스**: `UIPageControl`
- **SwiftUI**: 커스텀 또는 `TabView` + `.tabViewStyle(.page)`

---

## 2. Dimensions

### Dot 크기

| 상태 | 너비 | 높이 | 형태 |
|------|------|------|------|
| Inactive dot | 7 pt | 7 pt | 원형 |
| Current dot (기본) | 7 pt | 7 pt | 원형 (색상만 다름) |
| Current dot (interactive) | 14 pt | 7 pt | Pill (가로 확장) |

### 간격

| 속성 | 값 |
|------|-----|
| Dot 중심 간 거리 | 9 pt |
| Dot 간 실제 gap | 2 pt (7pt dot + 2pt gap = 9pt center-to-center) |
| 전체 컴포넌트 높이 | 44 pt (터치 타겟) |
| 최소 좌우 패딩 | 8 pt |

```
3페이지 예시 (2번째 페이지 활성):
     ●      ⬬      ●
  7pt  9pt  14pt  9pt  7pt
        ←──────────→
         center-to-center: 9pt
```

---

## 3. Variants

총 **35 variants** = Pages(2~10) × Style(Default/Custom) × Interaction(None/Tap/Scroll)

| 차원 | 옵션 |
|------|------|
| Pages | 2, 3, 4, 5, 6, 7, 8, 9, 10 |
| Style | Default (시스템 색상), Custom (커스텀 색상 주입 가능) |
| Interaction | None (표시만), Tap (점 탭으로 페이지 이동), Scroll (드래그 연동) |

### Interaction 타입별 동작

| Interaction | 동작 |
|------------|------|
| None | 표시 전용, 인터랙션 없음 |
| Tap | 비활성 dot 탭 → 해당 페이지로 이동 |
| Scroll | 스크롤뷰 오프셋에 연동하여 실시간 dot 위치 업데이트 |

---

## 4. Color Tokens

### 기본 스타일 색상

Page Control은 일반적으로 어두운 배경(사진, 카드) 위에 표시되므로 흰색 계열을 사용한다.

| 요소 | Light | Dark | 토큰 |
|------|-------|------|------|
| Current dot | `#ffffff` (불투명) | `#ffffff` (불투명) | `fills.systemBackground` (opaque) |
| Inactive dot | `rgba(255,255,255, 0.30)` | `rgba(255,255,255, 0.30)` | `fills.systemBackground` @ 30% |

> **배경이 밝은 경우 (light context)**: 어두운 계열 사용
>
> | 요소 | Light 배경 위 |
> |------|-------------|
> | Current dot | `rgba(0,0,0, 0.85)` |
> | Inactive dot | `rgba(0,0,0, 0.20)` |

### Custom 스타일

`UIPageControl.currentPageIndicatorTintColor` / `UIPageControl.pageIndicatorTintColor`로 자유롭게 지정 가능.

---

## 5. Typography

Page Control 자체에는 텍스트 없음. 대신 접근성 레이블:

| 역할 | 내용 |
|------|------|
| 전체 레이블 | "페이지 [현재] / [전체]" |
| 각 dot | "[번호]번 페이지" |
| 현재 dot | "[번호]번 페이지, 현재" |

---

## 6. State Transitions

```
Page N 활성 ──(스와이프/탭)──→ Page N+1 활성
  └─ Dot N: pill → circle (축소)
  └─ Dot N+1: circle → pill (확장)
  └─ 전체 dot 그룹: 위치 재조정 (interactive pill 때문에 전체 너비 변화)

10페이지 초과 시: dot 수 고정 (최대 7개 표시), 외곽 dot 축소 표현
```

### 위치 재조정 (interactive pill 전환 시)

Pill(14pt)이 Circle(7pt)으로 또는 반대로 전환될 때, 전체 dot 그룹의 총 너비가 변한다. 이 변화를 모든 dot이 동시에 spring 애니메이션으로 수용하여 자연스러운 이동을 만든다.

---

## 7. Animation

### Dot 상태 전환 (Current ↔ Inactive)

| 속성 | 값 |
|------|-----|
| 타입 | Spring (snappy) |
| Duration | 0.3s |
| Spring response | 0.3 |
| Spring damping ratio | 0.8 |
| CSS approximation | `cubic-bezier(0.34, 1.56, 0.64, 1.0)` |

### 애니메이션 대상 속성

| 속성 | Inactive → Current | Current → Inactive |
|------|---------------------|---------------------|
| width | 7pt → 14pt (interactive) | 14pt → 7pt |
| opacity | 0.30 → 1.0 | 1.0 → 0.30 |
| border-radius | 3.5px (circle) → 3.5px (pill, 높이 기준) | 반대 |
| transform (위치) | 그룹 전체 재조정 | 동일 |

### 크로스디졸브 (non-interactive)

| 속성 | 값 |
|------|-----|
| 방식 | opacity 크로스디졸브 (크기 변화 없음) |
| Duration | 0.2s |
| Easing | `easeOut` |

---

## 8. Accessibility

| 속성 | 값 |
|------|-----|
| `accessibilityTraits` | `.adjustable` |
| `accessibilityValue` | "페이지 2/5" |
| `accessibilityLabel` | "페이지 컨트롤" 또는 컨텍스트 설명 |
| `accessibilityIncrement()` | 다음 페이지로 이동 |
| `accessibilityDecrement()` | 이전 페이지로 이동 |
| VoiceOver 읽기 | "[레이블], 페이지 2/5, 조정 가능" |

각 dot을 개별 요소로 노출하지 않고, 전체 컨트롤을 하나의 `adjustable` 요소로 처리한다.

---

## 9. Framework Notes

### UIKit

```swift
let pageControl = UIPageControl()
pageControl.numberOfPages = 5
pageControl.currentPage = 0

// iOS 14+ 색상 커스텀
pageControl.currentPageIndicatorTintColor = .white
pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.3)

// iOS 16+ interactive style (pill 확장)
pageControl.preferredIndicatorImage = nil // 기본 dot 사용
// pill 스타일은 별도 커스텀 필요 (아래 참고)

// UIScrollView 연동
func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let pageWidth = scrollView.frame.width
    let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
    pageControl.currentPage = currentPage
}

// 탭으로 페이지 이동
pageControl.addTarget(self, action: #selector(pageChanged(_:)), for: .valueChanged)

@objc func pageChanged(_ sender: UIPageControl) {
    let offset = CGPoint(x: CGFloat(sender.currentPage) * scrollView.frame.width, y: 0)
    scrollView.setContentOffset(offset, animated: true)
}
```

### SwiftUI

```swift
// TabView로 페이징 구현 (내장 Page Control 자동 표시)
TabView(selection: $currentPage) {
    ForEach(0..<pages.count, id: \.self) { index in
        PageContent(data: pages[index])
            .tag(index)
    }
}
.tabViewStyle(.page(indexDisplayMode: .always))
.indexViewStyle(.page(backgroundDisplayMode: .always))
// backgroundDisplayMode: .always → 반투명 캡슐 배경 표시

// 커스텀 Page Control (pill 효과 포함)
struct CustomPageControl: View {
    let totalPages: Int
    @Binding var currentPage: Int

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<totalPages, id: \.self) { index in
                Capsule()
                    .fill(index == currentPage
                          ? Color.white
                          : Color.white.opacity(0.3))
                    .frame(
                        width: index == currentPage ? 14 : 7,
                        height: 7
                    )
                    .animation(
                        .spring(response: 0.3, dampingFraction: 0.8),
                        value: currentPage
                    )
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            currentPage = index
                        }
                    }
            }
        }
    }
}
```

### Flutter

```dart
class IOSPageControl extends StatelessWidget {
  const IOSPageControl({
    required this.totalPages,
    required this.currentPage,
    this.onPageTap,
    this.interactive = true,
  });

  final int totalPages;
  final int currentPage;
  final ValueChanged<int>? onPageTap;
  final bool interactive;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalPages, (index) {
        final isCurrent = index == currentPage;
        return GestureDetector(
          onTap: interactive ? () => onPageTap?.call(index) : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: const Cubic(0.34, 1.56, 0.64, 1.0), // spring snappy
            margin: const EdgeInsets.symmetric(horizontal: 1),
            width: (interactive && isCurrent) ? 14.0 : 7.0,
            height: 7.0,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(isCurrent ? 1.0 : 0.30),
              borderRadius: BorderRadius.circular(3.5),
            ),
          ),
        );
      }),
    );
  }
}

// PageView 연동
PageView(
  controller: _pageController,
  onPageChanged: (page) => setState(() => _currentPage = page),
  children: pages,
)

IOSPageControl(
  totalPages: pages.length,
  currentPage: _currentPage,
  onPageTap: (page) => _pageController.animateToPage(
    page,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOut,
  ),
)
```

### CSS / Svelte

```svelte
<script>
  export let total = 5;
  export let current = 0;
  export let interactive = true;

  // spring snappy 커브
  const springCurve = 'cubic-bezier(0.34, 1.56, 0.64, 1.0)';
</script>

<div class="page-control" role="tablist" aria-label="페이지 컨트롤">
  {#each Array(total) as _, i}
    <button
      class="dot"
      class:current={i === current}
      class:interactive
      role="tab"
      aria-selected={i === current}
      aria-label="{i + 1}번 페이지{i === current ? ', 현재' : ''}"
      on:click={() => interactive && (current = i)}
    />
  {/each}
</div>

<style>
  .page-control {
    display: flex;
    align-items: center;
    gap: 2px; /* 9pt center-to-center - 7pt dot = 2pt gap */
    padding: 18.5px 8px; /* 전체 높이 44pt 터치타겟 */
  }

  .dot {
    width: 7px;
    height: 7px;
    border-radius: 3.5px;
    background: rgba(255, 255, 255, 0.30);
    border: none;
    padding: 0;
    cursor: default;
    flex-shrink: 0;
    transition:
      width 0.3s cubic-bezier(0.34, 1.56, 0.64, 1.0),
      opacity 0.3s cubic-bezier(0.34, 1.56, 0.64, 1.0),
      background-color 0.3s cubic-bezier(0.34, 1.56, 0.64, 1.0);
  }

  .dot.interactive {
    cursor: pointer;
  }

  .dot.current {
    background: rgba(255, 255, 255, 1.0);
    width: 14px; /* pill 확장 (interactive 시) */
  }

  /* non-interactive: 크기 변화 없이 opacity만 */
  .dot:not(.interactive).current {
    width: 7px;
  }

  /* 밝은 배경 위 사용 시 */
  .page-control.light .dot {
    background: rgba(0, 0, 0, 0.20);
  }
  .page-control.light .dot.current {
    background: rgba(0, 0, 0, 0.85);
  }
</style>
```
