> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24669")`

# Action Sheet — Component Spec

## 1. Overview

iOS 26 Action Sheet는 화면 하단에서 슬라이드 업되는 선택 메뉴 컴포넌트다. 사용자가 현재 컨텍스트에서 수행할 수 있는 여러 액션 중 하나를 선택하게 하며, Cancel 버튼은 본체와 분리된 독립 카드로 표시된다. Liquid Glass 소재를 배경으로 사용한다.

| 항목 | 값 |
|------|-----|
| Figma Node | `507:24669` (Action Sheets page) |
| UIKit 대응 | `UIAlertController(preferredStyle: .actionSheet)` |
| SwiftUI 대응 | `.confirmationDialog()` |
| 배경 소재 | Liquid Glass (frosted glass effect) |

---

## 2. Dimensions

### 공통 레이아웃
| 속성 | 값 | 출처 |
|------|-----|------|
| 너비 | 화면 너비 - 16pt × 2 (safe area 내) | `spacing.json` > `contentMargin.iphone.horizontal` |
| 액션 버튼 높이 | `57pt` | `spacing.json` > `components.actionSheet.actionHeight` |
| Cancel 버튼 높이 | `57pt` | `spacing.json` > `components.actionSheet.cancelHeight` |
| Cancel 버튼과 본체 사이 간격 | `8pt` | `spacing.json` > `components.actionSheet.cancelGap` |
| 하단 safe area 여백 | `8pt` | `spacing.json` > `components.actionSheet.bottomPadding` |
| cornerRadius (본체) | `14pt` | `spacing.json` > `radius.semantic.actionSheet` |
| cornerRadius (Cancel 카드) | `14pt` | `spacing.json` > `radius.semantic.actionSheet` |
| 타이틀 영역 paddingTop | `16pt` | `spacing.json` > `components.actionSheet.headerPaddingTop` |
| 타이틀 영역 paddingBottom | `16pt` | `spacing.json` > `components.actionSheet.headerPaddingBottom` |
| 타이틀 영역 paddingHorizontal | `16pt` | `spacing.json` > `components.actionSheet.headerPaddingH` |

### iPhone 16 기준 실측 예시 (화면 너비 390pt)
| 속성 | 계산값 |
|------|--------|
| Action Sheet 너비 | `390 - 32 = 358pt` |
| 좌우 여백 (각) | `16pt` |
| 액션 버튼 너비 | `358pt` (전체 너비) |

### 내부 레이아웃 구조

```
 ← 16pt → ┌─────────────────────────────────────┐ ← 16pt →
           │  Title (Optional)                   │  ← paddingTop: 16pt
           │  Message (Optional)                 │  ← paddingH: 16pt
           ├─────────────────────────────────────┤  ← separator (nonOpaque)
           │  Action Button 1                    │  ← height: 57pt
           ├─────────────────────────────────────┤  ← separator
           │  Action Button 2                    │  ← height: 57pt
           ├─────────────────────────────────────┤  ← separator
           │  ⛔ Destructive Action              │  ← height: 57pt, red text
           └─────────────────────────────────────┘  ← cornerRadius: 14pt
                          ↑ Liquid Glass background

           ← 8pt gap ────────────────────────────
           ← 16pt → ┌─────────────────────────────────────┐ ← 16pt →
           │  **Cancel**                         │  ← 57pt, bold, 별도 카드
           └─────────────────────────────────────┘
           ← 8pt bottom safe area padding ────────
```

---

## 3. Variants

### 3-1. 기본 (액션 버튼만)
- 타이틀/메시지 영역 없음
- 액션 버튼 2개 이상
- Cancel 버튼 (별도 카드)
- 가장 단순한 형태

### 3-2. Destructive 버튼 포함
- 삭제/위험 액션을 포함하는 경우
- Destructive 버튼은 `accents.red` 텍스트 색상
- 일반적으로 목록의 마지막 액션 위치 (Cancel 직전)
- 버튼 순서: 일반 액션들 → Destructive 액션 → (8pt gap) → Cancel

### 3-3. 타이틀 + 메시지 포함
- 상단에 헤더 영역 추가
- 타이틀: `labels.secondary` 색상, Subheadline/Semibold
- 메시지: `labels.secondary` 색상, Footnote/Regular
- 헤더와 첫 번째 버튼 사이 separator 적용

### 3-4. 타이틀만
- 메시지 없이 타이틀만 표시
- 타이틀: `labels.secondary` 색상, Subheadline/Semibold
- 타이틀이 있을 때 paddingBottom은 `16pt` 유지

### 3-5. 단일 액션 (Cancel 포함 최소 구성)
- 액션 버튼 1개 + Cancel 버튼
- 극히 드문 케이스이나 HIG 위반 아님

---

## 4. Color Tokens

| 역할 | 토큰 경로 | Light | Dark |
|------|----------|-------|------|
| 배경 (본체 + Cancel) | Liquid Glass | `rgba(250,250,250,0.72)` | `rgba(28,28,30,0.82)` |
| 액션 버튼 텍스트 | `labels.primary` | `#000000 / a:1` | `#ffffff / a:1` |
| Destructive 버튼 텍스트 | `accents.red` | `#ff383c` | `#ff4245` |
| Cancel 버튼 텍스트 | `labels.primary` (Bold) | `#000000 / a:1` | `#ffffff / a:1` |
| 타이틀 텍스트 | `labels.secondary` | `#3c3c43 / a:0.6` | `#ebebf5 / a:0.7` |
| 메시지 텍스트 | `labels.secondary` | `#3c3c43 / a:0.6` | `#ebebf5 / a:0.7` |
| 버튼 간 구분선 | `separators.nonOpaque` | `#000000 / a:0.12` | `#ffffff / a:0.17` |
| 버튼 Highlighted (pressed) | `fills.tertiary` | `#000000 / a:0.06` | `#ffffff / a:0.08` |
| 오버레이 배경 | `overlays.default` | `#000000 / a:0.2` | `#000000 / a:0.48` |
| Blur (Liquid Glass) | `liquidGlass.thinMaterial.frostRadius` | `blur: 20px` | `blur: 20px` |

### Liquid Glass CSS 구현

```css
.action-sheet-background {
  /* Light mode */
  background: rgba(250, 250, 250, 0.72);
  backdrop-filter: blur(20px) saturate(180%);
  -webkit-backdrop-filter: blur(20px) saturate(180%);
  border-radius: 14px;

  /* Dark mode */
  background: rgba(28, 28, 30, 0.82);
  backdrop-filter: blur(20px) saturate(150%);
}

.action-sheet-overlay {
  /* Light */
  background: rgba(0, 0, 0, 0.2);
  /* Dark */
  background: rgba(0, 0, 0, 0.48);
}
```

---

## 5. Typography

| 요소 | Style | Font | Weight | Size | Line Height |
|------|-------|------|--------|------|-------------|
| 타이틀 | Subheadline | SF Pro Text | Semibold | 15pt | 20pt |
| 메시지 | Footnote | SF Pro Text | Regular | 13pt | 18pt |
| 액션 버튼 | Body | SF Pro Text | Regular | 17pt | 22pt |
| Destructive 버튼 | Body | SF Pro Text | Regular | 17pt | 22pt |
| Cancel 버튼 | Body | SF Pro Text | **Semibold** | 17pt | 22pt |

텍스트 정렬:
- 타이틀/메시지: 중앙(center) 정렬
- 액션 버튼: 중앙(center) 정렬
- Cancel 버튼: 중앙(center) 정렬

---

## 6. State Transitions

| 상태 | 시각 변화 |
|------|----------|
| 버튼 기본 (default) | 배경 없음, 텍스트 색상만 |
| 버튼 Highlighted (pressed) | `fills.tertiary` 배경 오버레이 |
| Destructive Highlighted | `accents.red / a:0.1` 배경 |
| Cancel Highlighted | `fills.tertiary` 배경 오버레이 |
| Sheet Presenting | 하단에서 슬라이드 업 + 오버레이 fade in |
| Sheet Dismissing | 하단으로 슬라이드 다운 + 오버레이 fade out |

---

## 7. Animation

### Present (등장)
```yaml
trigger: Action Sheet 표시 시
duration: 0.45s  # animations.json > duration.semantic.actionSheetPresent
easing: spring
spring:
  stiffness: 280  # animations.json > spring.actionSheet.stiffness
  damping: 36     # animations.json > spring.actionSheet.damping
properties:
  translateY: 100% → 0%  # 화면 아래에서 슬라이드 업
  Liquid Glass blur: 점진적 frosting (0 → 20px)
overlay:
  opacity: 0 → 1
  duration: 0.35s
  easing: easeOut  # cubic-bezier(0, 0, 0.58, 1.0)
cancel_card:
  translateY: 100% → 0%
  delay: 0.04s  # 본체보다 약간 늦게 등장 (스태거 효과)
```

### Dismiss (퇴장)
```yaml
trigger: 버튼 탭 또는 배경 탭
duration: 0.3s  # animations.json > duration.semantic.actionSheetDismiss
easing: easeIn  # cubic-bezier(0.42, 0, 1.0, 1.0)
properties:
  translateY: 0% → 100%
overlay:
  opacity: 1 → 0
  duration: 0.25s
```

### Reduce Motion 처리
```yaml
prefers-reduced-motion:
  translateY: 비활성화 (움직임 없음)
  opacity: 0 → 1 (fade만, 0.2s)
  spring: 일반 easeOut으로 대체
```

---

## 8. iOS Native 구현 (UIKit)

```swift
// 기본 Action Sheet
let actionSheet = UIAlertController(
    title: "제목 (Optional)",
    message: "메시지 (Optional)",
    preferredStyle: .actionSheet
)

// 일반 액션 추가
actionSheet.addAction(UIAlertAction(title: "공유하기", style: .default) { _ in
    // handle action
})

// Destructive 액션 (빨간색 자동 적용)
actionSheet.addAction(UIAlertAction(title: "삭제", style: .destructive) { _ in
    // handle destructive
})

// Cancel 버튼 (항상 마지막 추가, 별도 카드로 자동 분리)
actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel))

// iPad 대응 필수 — popoverPresentationController 설정 없으면 크래시
if let popover = actionSheet.popoverPresentationController {
    popover.sourceView = sender   // 트리거 버튼
    popover.sourceRect = sender.bounds
    popover.permittedArrowDirections = .any
}

present(actionSheet, animated: true)
```

---

## 9. SwiftUI 구현

```swift
struct ContentView: View {
    @State private var showActionSheet = false
    @State private var selectedAction: String = ""

    var body: some View {
        Button("액션 시트 열기") {
            showActionSheet = true
        }
        .confirmationDialog(
            "제목 (Optional)",
            isPresented: $showActionSheet,
            titleVisibility: .visible  // .hidden 으로 타이틀 숨김 가능
        ) {
            // 일반 액션
            Button("공유하기") {
                selectedAction = "share"
            }
            Button("복사하기") {
                selectedAction = "copy"
            }

            // Destructive 액션
            Button("삭제", role: .destructive) {
                selectedAction = "delete"
            }

            // Cancel은 자동으로 추가됨 (role: .cancel 명시 가능)
            Button("취소", role: .cancel) { }
        } message: {
            // 메시지가 필요한 경우
            Text("메시지 내용 (Optional)")
        }
    }
}
```

---

## 10. Flutter 구현

```dart
// showCupertinoModalPopup + CupertinoActionSheet
Future<void> showActionSheet(BuildContext context) async {
  await showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      // 타이틀 (Optional)
      title: const Text(
        '제목',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: CupertinoColors.secondaryLabel,
        ),
      ),
      // 메시지 (Optional)
      message: const Text(
        '메시지 내용',
        style: TextStyle(
          fontSize: 13,
          color: CupertinoColors.secondaryLabel,
        ),
      ),
      // 액션 버튼들
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, 'share');
          },
          child: const Text('공유하기'),  // height: 57pt 자동
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, 'copy');
          },
          child: const Text('복사하기'),
        ),
        // Destructive 액션
        CupertinoActionSheetAction(
          isDestructiveAction: true,  // accents.red 자동 적용
          onPressed: () {
            Navigator.pop(context, 'delete');
          },
          child: const Text('삭제'),
        ),
      ],
      // Cancel 버튼 (별도 카드로 자동 분리, 8pt gap)
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,  // Semibold weight 자동 적용
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('취소'),
      ),
    ),
  );
}
```

---

## 11. Svelte/Web 구현 (Bottom Sheet 패턴)

```svelte
<script lang="ts">
  import { fly, fade } from 'svelte/transition';
  import { cubicOut } from 'svelte/easing';

  export let open = false;
  export let title: string | undefined = undefined;
  export let message: string | undefined = undefined;

  interface Action {
    label: string;
    destructive?: boolean;
    onTap: () => void;
  }

  export let actions: Action[] = [];
  export let onCancel: () => void = () => (open = false);

  // spring 설정 (stiffness: 280, damping: 36)
  const springTransition = {
    duration: 450,
    easing: cubicOut, // spring 근사
    y: '100%',
  };
</script>

{#if open}
  <!-- 오버레이 -->
  <!-- svelte-ignore a11y-click-events-have-key-events -->
  <div
    class="action-sheet-overlay"
    role="button"
    tabindex="-1"
    transition:fade={{ duration: 350 }}
    on:click={onCancel}
    aria-label="닫기"
  />

  <!-- Action Sheet 본체 -->
  <div
    class="action-sheet-container"
    role="dialog"
    aria-modal="true"
    aria-label={title ?? '액션 선택'}
    transition:fly={springTransition}
  >
    <!-- 헤더 (Optional) -->
    {#if title || message}
      <div class="action-sheet-header">
        {#if title}
          <p class="action-sheet-title">{title}</p>
        {/if}
        {#if message}
          <p class="action-sheet-message">{message}</p>
        {/if}
      </div>
    {/if}

    <!-- 액션 버튼들 -->
    <div class="action-sheet-actions">
      {#each actions as action, i}
        {#if i > 0}
          <div class="action-sheet-separator" role="separator" />
        {/if}
        <button
          class="action-sheet-button"
          class:destructive={action.destructive}
          on:click={() => { action.onTap(); open = false; }}
        >
          {action.label}
        </button>
      {/each}
    </div>
  </div>

  <!-- Cancel 카드 (별도, 8pt gap) -->
  <div
    class="action-sheet-cancel-card"
    transition:fly={{ ...springTransition, delay: 40 }}
  >
    <button class="action-sheet-cancel" on:click={onCancel}>
      취소
    </button>
  </div>
{/if}

<style>
  .action-sheet-overlay {
    position: fixed;
    inset: 0;
    background: rgba(0, 0, 0, 0.2);  /* overlays.default light */
    z-index: 100;
  }

  .action-sheet-container {
    position: fixed;
    bottom: calc(57px + 8px + 8px + env(safe-area-inset-bottom));
    /* cancel height + gap + bottom padding + safe area */
    left: 16px;
    right: 16px;
    border-radius: 14px;  /* radius.semantic.actionSheet */
    background: rgba(250, 250, 250, 0.72);
    backdrop-filter: blur(20px) saturate(180%);
    -webkit-backdrop-filter: blur(20px) saturate(180%);
    z-index: 101;
    overflow: hidden;
  }

  .action-sheet-header {
    padding: 16px 16px;
    text-align: center;
  }

  .action-sheet-title {
    font-size: 15px;
    font-weight: 600;  /* Semibold */
    line-height: 20px;
    color: rgba(60, 60, 67, 0.6);  /* labels.secondary light */
    margin: 0 0 4px;
  }

  .action-sheet-message {
    font-size: 13px;
    font-weight: 400;
    line-height: 18px;
    color: rgba(60, 60, 67, 0.6);
    margin: 0;
  }

  .action-sheet-separator {
    height: 1px;
    background: rgba(0, 0, 0, 0.12);  /* separators.nonOpaque light */
    margin: 0;
  }

  .action-sheet-button {
    display: block;
    width: 100%;
    height: 57px;
    font-size: 17px;
    font-weight: 400;
    line-height: 22px;
    color: #000000;  /* labels.primary light */
    background: transparent;
    border: none;
    cursor: pointer;
    text-align: center;
  }

  .action-sheet-button.destructive {
    color: #ff383c;  /* accents.red light */
  }

  .action-sheet-button:active {
    background: rgba(0, 0, 0, 0.06);  /* fills.tertiary light */
  }

  .action-sheet-cancel-card {
    position: fixed;
    bottom: calc(8px + env(safe-area-inset-bottom));
    left: 16px;
    right: 16px;
    border-radius: 14px;
    background: rgba(250, 250, 250, 0.72);
    backdrop-filter: blur(20px) saturate(180%);
    -webkit-backdrop-filter: blur(20px) saturate(180%);
    z-index: 101;
    overflow: hidden;
  }

  .action-sheet-cancel {
    display: block;
    width: 100%;
    height: 57px;
    font-size: 17px;
    font-weight: 600;  /* Semibold — Cancel은 Bold */
    line-height: 22px;
    color: #000000;
    background: transparent;
    border: none;
    cursor: pointer;
    text-align: center;
  }

  .action-sheet-cancel:active {
    background: rgba(0, 0, 0, 0.06);
  }

  /* Dark mode */
  @media (prefers-color-scheme: dark) {
    .action-sheet-overlay {
      background: rgba(0, 0, 0, 0.48);
    }
    .action-sheet-container,
    .action-sheet-cancel-card {
      background: rgba(28, 28, 30, 0.82);
    }
    .action-sheet-title,
    .action-sheet-message {
      color: rgba(235, 235, 245, 0.7);
    }
    .action-sheet-separator {
      background: rgba(255, 255, 255, 0.17);
    }
    .action-sheet-button {
      color: #ffffff;
    }
    .action-sheet-button.destructive {
      color: #ff4245;
    }
    .action-sheet-button:active,
    .action-sheet-cancel:active {
      background: rgba(255, 255, 255, 0.08);
    }
    .action-sheet-cancel {
      color: #ffffff;
    }
  }

  /* Reduce Motion */
  @media (prefers-reduced-motion: reduce) {
    .action-sheet-container,
    .action-sheet-cancel-card {
      transition: opacity 0.2s ease-out;
    }
  }
</style>
```

---

## 12. Accessibility

| 항목 | 요구사항 |
|------|---------|
| 최소 탭 타겟 | 버튼 높이 `57pt` — Apple HIG 44pt 초과 ✅ |
| VoiceOver role | 컨테이너: `UIAccessibilityTraitNone` + modal context, 버튼: `UIAccessibilityTraitButton` |
| VoiceOver 포커스 | 시트 등장 시 첫 번째 액션 버튼으로 자동 포커스 이동 |
| Destructive 버튼 레이블 | VoiceOver가 "삭제, 버튼" 읽을 때 추가 경고 없음 — 버튼 레이블에 위험성 명시 권장 |
| Cancel 버튼 | 항상 접근 가능, ESC 키(iPadOS/macOS 외부 키보드) → Cancel 트리거 |
| 오버레이 배경 탭 | `isAccessibilityElement = false` — 오버레이 자체는 VoiceOver 탐색에서 제외 |
| Dynamic Type | 버튼 텍스트 `.body` ~ `.accessibilityLarge` 지원. 텍스트 증가 시 버튼 높이 자동 확장 |
| 색상 대비 | 액션 버튼: 4.5:1 이상 (WCAG AA), Destructive: `#ff383c` vs 흰 배경 약 4.0:1 (AA Large 충족) |
| Reduce Motion | 슬라이드 애니메이션 비활성화 → fade only |
| 키보드 탐색 | Tab 키로 액션 간 이동, Space/Enter로 선택, Escape로 Cancel |

---

## 13. iPhone vs iPad 동작 차이

### iPhone
- 화면 하단에서 슬라이드 업
- 너비 = 화면 너비 - 32pt (좌우 16pt 여백)
- Cancel 버튼 별도 카드 (8pt gap)
- `UIModalPresentationStyle.automatic` → `overCurrentContext`

### iPad
- **Popover로 자동 변환** (UIKit 기본 동작)
- `UIAlertController.popoverPresentationController` 반드시 설정 필요
- 너비 약 320pt (Popover 기본 너비)
- Cancel 버튼이 Popover 내에 통합됨 (별도 카드 없음)
- 배경 탭으로 dismiss 가능 (Cancel 역할)
- `sourceView` + `sourceRect` 또는 `barButtonItem` 설정 필수 (미설정 시 크래시)

```swift
// iPad 대응 패턴
if UIDevice.current.userInterfaceIdiom == .pad {
    actionSheet.modalPresentationStyle = .popover
    if let popover = actionSheet.popoverPresentationController {
        popover.barButtonItem = navigationItem.rightBarButtonItem
        // 또는
        popover.sourceView = triggerButton
        popover.sourceRect = triggerButton.bounds
    }
}
```

### SwiftUI iPad 자동 처리
```swift
// SwiftUI .confirmationDialog은 iPad에서 자동으로 Popover로 표시됨
// 별도 처리 불필요
.confirmationDialog("제목", isPresented: $show) {
    // ...
}
```

---

## 14. 사용 가이드라인 (Apple HIG 기준)

| 규칙 | 내용 |
|------|------|
| 최소 버튼 수 | Cancel 포함 최소 2개 (Cancel만 있는 경우 사용 금지) |
| 최대 버튼 수 | 엄격한 제한 없음. 단 5개 이상은 UX 저하 — List/Menu 대안 검토 |
| Destructive 위치 | 항상 Cancel 바로 위 (맨 아래 일반 액션 다음) |
| Cancel 필수 여부 | 항상 포함. 사용자에게 탈출구 보장 |
| 타이틀 사용 | 액션의 컨텍스트를 명확히 할 때만. 불필요한 타이틀은 인지 부하 증가 |
| Alert vs Action Sheet | 되돌릴 수 없는 단일 위험 액션 → Alert 사용. 여러 선택지 → Action Sheet |
| 3개 이상 선택지 | Action Sheet 적합. 2개 선택지는 Alert 2-button도 고려 |
