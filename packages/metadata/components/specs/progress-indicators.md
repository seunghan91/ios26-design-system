# Progress Indicators Component Spec

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="5425:3472")`

---

## 1. Overview

iOS 26의 Progress Indicators 컴포넌트. 두 가지 타입으로 구성된다:

1. **Progress Bar (UIProgressView)**: 수평 바 형태의 결정적(Determinate) 진행률 표시
2. **Activity Indicator (UIActivityIndicatorView)**: 스피너 형태의 비결정적(Indeterminate) 로딩 표시

작업 완료 예상 시간을 알 때는 Progress Bar, 알 수 없을 때는 Activity Indicator를 사용한다.

- **Figma Node**: Page `507:24682`, Section `5425:3472`
- **Light 예시**: `5433:20243` (3가지)
- **Dark 예시**: `5433:20248` (3가지)
- **UIKit 클래스**: `UIProgressView`, `UIActivityIndicatorView`
- **SwiftUI**: `ProgressView`

---

## 2. Dimensions

### Progress Bar

| 속성 | 값 |
|------|-----|
| 높이 | 4 pt |
| Corner radius | 2 pt (pill) |
| 너비 | 가용 너비 전체 |
| 최소 너비 | 64 pt |

### Activity Indicator

| 크기 | 직경 | 세그먼트 수 | 세그먼트 너비 |
|------|------|------------|-------------|
| Small | 20 pt | 12개 | ~1.5 pt |
| Medium (기본) | 37 pt | 12개 | ~2 pt |
| Large | 56 pt | 12개 | ~3 pt |

```
Activity Indicator 구조 (12세그먼트, 시계방향):
         ●
     ●       ●
   ●             ●
   ●             ●
     ●       ●
         ●

현재 세그먼트(12시 방향): opacity 1.0
이전 세그먼트: 순서대로 opacity 감소 (12분의 1씩)
가장 오래된 세그먼트(11시 방향): opacity ~0.1
```

---

## 3. Variants

### Progress Bar Variants

| Variant | 설명 |
|---------|------|
| Determinate | 0~100% 진행률 표시 (`progress` 값 설정) |
| Indeterminate | 무한 진행 애니메이션 (shimmer 또는 왕복 이동) |

### Activity Indicator Variants

| Variant | 설명 |
|---------|------|
| Small (20pt) | 버튼, 셀 내부 인라인 사용 |
| Medium (37pt, 기본) | 일반적인 화면 로딩 |
| Large (56pt) | 전체 화면 로딩 오버레이 |
| with Label | 스피너 아래 또는 우측에 텍스트 레이블 |

---

## 4. Color Tokens

### Progress Bar 색상

| 요소 | Light | Dark | 토큰 |
|------|-------|------|------|
| Fill (진행률) | `#0088ff` | `#0091ff` | `accents.blue` |
| Track (배경) | `rgba(118,118,128, 0.12)` | `rgba(118,118,128, 0.24)` | `fills.tertiary` |

### Activity Indicator 색상

| 요소 | Light | Dark |
|------|-------|------|
| 기본 색상 | `rgba(60,60,67, 0.6)` | `rgba(235,235,245, 0.7)` |
| 사용 토큰 | `labels.secondary` light | `labels.secondary` dark |

세그먼트별 opacity 분포 (12개, 현재→과거):

| 세그먼트 순서 | Opacity |
|-------------|---------|
| 1 (현재) | 1.0 |
| 2 | 0.917 |
| 3 | 0.833 |
| 4 | 0.750 |
| 5 | 0.667 |
| 6 | 0.583 |
| 7 | 0.500 |
| 8 | 0.417 |
| 9 | 0.333 |
| 10 | 0.250 |
| 11 | 0.167 |
| 12 | 0.083 |

---

## 5. Typography

Progress Bar와 함께 사용되는 텍스트:

| 역할 | 스타일 | 크기 | 색상 |
|------|--------|------|------|
| 진행률 텍스트 ("50%") | Callout | 16pt | `labels.secondary` |
| 상태 설명 | Subheadline | 15pt | `labels.secondary` |
| Activity Indicator 레이블 | Subheadline | 15pt | `labels.secondary` |
| 에러/완료 메시지 | Body | 17pt | `labels.primary` |

---

## 6. State Transitions

### Progress Bar

```
Hidden ──(작업 시작)──→ Visible, progress=0
progress=0 ──(업데이트)──→ progress=0~1 (linear 애니메이션)
progress=1 ──(완료)──→ 완료 상태 (fade out 또는 체크마크로 교체)
* ──(취소)──→ Hidden (fade out 0.2s)
```

### Activity Indicator

```
hidesWhenStopped=true (기본):
Stopped+Hidden ──(startAnimating())──→ Animating+Visible
Animating+Visible ──(stopAnimating())──→ Stopped+Hidden

hidesWhenStopped=false:
Stopped+Visible ──(startAnimating())──→ Animating+Visible
Animating+Visible ──(stopAnimating())──→ Stopped+Visible (회전 멈춤)
```

---

## 7. Animation

### Progress Bar — Determinate

| 속성 | 값 |
|------|-----|
| 진행률 변화 | `linear`, duration: 값 변화량에 비례 |
| 권장 업데이트 주기 | 60fps (애니메이션 프레임당 한 번) |
| 완료 후 사라짐 | fade out, 0.3s, `easeOut` |

### Progress Bar — Indeterminate (Shimmer)

```
@keyframes shimmer {
  0%   { transform: translateX(-100%); opacity: 0.6; }
  50%  { opacity: 1; }
  100% { transform: translateX(200%); opacity: 0.6; }
}
duration: 1.5s, easing: linear, iteration: infinite
```

### Activity Indicator — Spinner 회전

| 속성 | 값 |
|------|-----|
| 회전 방향 | 시계 방향 |
| 한 바퀴 시간 | 0.8s |
| Easing | `linear` (균일 회전) |
| 반복 | `infinite` |
| 출현 | fade in, 0.15s |
| 사라짐 | fade out, 0.15s |

```
CSS 구현 원리:
- 12개 막대를 원형 배치 (rotate: 0deg ~ 330deg, 30deg 간격)
- 각 막대의 animation-delay를 -0.0667s 간격으로 설정
- 전체 컨테이너를 회전시키지 않고 opacity 애니메이션으로 구현
```

---

## 8. Accessibility

### Progress Bar

| 속성 | 값 |
|------|-----|
| `accessibilityTraits` | `.updatesFrequently` |
| `accessibilityValue` | "50%" 또는 "파일 다운로드 중, 50% 완료" |
| `accessibilityLabel` | 작업 설명 ("다운로드") |
| 완료 알림 | `UIAccessibility.post(notification: .announcement, argument: "다운로드 완료")` |

### Activity Indicator

| 속성 | 값 |
|------|-----|
| `accessibilityTraits` | `.image` (시각적 표시만) |
| `accessibilityLabel` | "로딩 중" |
| 숨기기 고려 | 반복 VoiceOver 읽기 방지를 위해 `accessibilityElementsHidden = true` 후 레이블로 상태 전달 |

---

## 9. Framework Notes

### UIKit

```swift
// Progress Bar
let progressView = UIProgressView(progressViewStyle: .default)
progressView.progressTintColor = UIColor(hex: "#0088FF")
progressView.trackTintColor = UIColor(red: 118/255, green: 118/255,
                                       blue: 128/255, alpha: 0.12)
progressView.progress = 0.0

// 애니메이션으로 진행률 업데이트
UIView.animate(withDuration: 0.3) {
    progressView.setProgress(0.7, animated: true)
}

// Activity Indicator
let activityIndicator = UIActivityIndicatorView(style: .medium)
// styles: .small(20pt 없음, .medium=37pt, .large=56pt)
activityIndicator.color = UIColor.secondaryLabel
activityIndicator.hidesWhenStopped = true
activityIndicator.startAnimating()
// ... 작업 완료 후
activityIndicator.stopAnimating()
```

### SwiftUI

```swift
// Determinate Progress Bar
ProgressView(value: progress, total: 1.0)
    .progressViewStyle(.linear)
    .tint(Color(hex: "#0088FF"))
    .scaleEffect(x: 1, y: 2) // 높이 조절 (4pt 근사)

// Indeterminate Activity Indicator
ProgressView()
    .progressViewStyle(.circular)
    .tint(Color.secondary)
    .scaleEffect(1.5) // Large 사이즈

// 레이블 포함
ProgressView("파일 다운로드 중...")
    .progressViewStyle(.circular)

// 커스텀 진행률 표시
VStack(spacing: 8) {
    ProgressView(value: downloadProgress)
        .tint(Color(hex: "#0088FF"))

    HStack {
        Text("다운로드 중")
            .font(.subheadline)
            .foregroundColor(.secondary)
        Spacer()
        Text("\(Int(downloadProgress * 100))%")
            .font(.callout)
            .foregroundColor(.secondary)
    }
}
```

### Flutter

```dart
// Progress Bar — Determinate
LinearProgressIndicator(
  value: 0.7, // null이면 indeterminate
  backgroundColor: const Color(0x1F767680), // fills.tertiary light
  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0088FF)),
  minHeight: 4,
  borderRadius: BorderRadius.circular(2),
)

// Activity Indicator (CupertinoActivityIndicator 권장)
const CupertinoActivityIndicator(
  radius: 18.5, // medium: 37pt/2
  color: CupertinoColors.secondaryLabel,
)

// 크기별
const CupertinoActivityIndicator(radius: 10),   // small: 20pt
const CupertinoActivityIndicator(radius: 18.5), // medium: 37pt
const CupertinoActivityIndicator(radius: 28),   // large: 56pt

// 또는 CircularProgressIndicator (Material)
CircularProgressIndicator(
  value: null, // indeterminate
  color: Theme.of(context).brightness == Brightness.dark
      ? const Color(0xFF0091FF) : const Color(0xFF0088FF),
  strokeWidth: 2,
)
```

### CSS / Svelte

```svelte
<script>
  // Progress Bar
  export let progress = 0; // 0~1
  export let indeterminate = false;

  // Activity Indicator
  export let size = 'medium'; // small | medium | large
  const sizes = { small: 20, medium: 37, large: 56 };
</script>

<!-- Progress Bar -->
{#if !indeterminate}
  <div class="progress-bar" role="progressbar"
       aria-valuenow={Math.round(progress * 100)}
       aria-valuemin="0" aria-valuemax="100">
    <div class="track">
      <div class="fill" style:width="{progress * 100}%" />
    </div>
  </div>
{:else}
  <div class="progress-bar indeterminate">
    <div class="track">
      <div class="shimmer" />
    </div>
  </div>
{/if}

<!-- Activity Indicator -->
<div class="spinner" class:small={size==='small'} class:large={size==='large'}
     role="status" aria-label="로딩 중">
  {#each Array(12) as _, i}
    <div class="segment" style:transform="rotate({i * 30}deg)"
         style:animation-delay="{-(12 - i) * (0.8/12)}s" />
  {/each}
</div>

<style>
  /* Progress Bar */
  .track {
    height: 4px;
    border-radius: 2px;
    background: rgba(118, 118, 128, 0.12);
    overflow: hidden;
  }
  @media (prefers-color-scheme: dark) {
    .track { background: rgba(118, 118, 128, 0.24); }
  }
  .fill {
    height: 100%;
    border-radius: 2px;
    background: #0088ff;
    transition: width 0.3s linear;
  }
  @media (prefers-color-scheme: dark) {
    .fill { background: #0091ff; }
  }

  /* Shimmer (indeterminate) */
  .shimmer {
    height: 100%;
    width: 40%;
    border-radius: 2px;
    background: #0088ff;
    animation: shimmer 1.5s linear infinite;
  }
  @keyframes shimmer {
    0%   { transform: translateX(-200%); }
    100% { transform: translateX(400%); }
  }

  /* Activity Indicator */
  .spinner {
    position: relative;
    width: 37px;
    height: 37px;
  }
  .spinner.small { width: 20px; height: 20px; }
  .spinner.large { width: 56px; height: 56px; }

  .segment {
    position: absolute;
    top: 0;
    left: 50%;
    width: 2px;
    height: 30%;
    margin-left: -1px;
    border-radius: 1px;
    background: rgba(60, 60, 67, 0.6); /* labels.secondary light */
    transform-origin: center bottom;
    animation: spin-fade 0.8s linear infinite;
  }
  @media (prefers-color-scheme: dark) {
    .segment { background: rgba(235, 235, 245, 0.7); }
  }

  @keyframes spin-fade {
    0%   { opacity: 1; }
    100% { opacity: 0.083; }
  }
</style>
```
