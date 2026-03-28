# Overlay Region — iOS 26 섹션 스펙

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24689")`

---

## 개요

Overlay Region은 Content Region 위에 렌더링되는 모든 플로팅 UI 요소를 포함하는 영역이다. iOS 26에서는 Sheet, Alert, Context Menu, Action Sheet, Popover 등이 이 영역에 속하며, 각각 **Liquid Glass 소재** 또는 **불투명 dimming**과 함께 표시된다.

### iOS 26 주요 변경

- **Liquid Glass Sheet**: 바텀 시트 배경이 Liquid Glass 소재 (frosted glass + refraction)로 변경
- **Context Menu 개선**: 메뉴 배경도 Liquid Glass. 프리뷰 썸네일 포함 가능
- **Alert 스타일**: 기존 불투명 배경 유지 (Liquid Glass 미적용)
- **Sheet detents**: `.fraction(0.25)`, `.fraction(0.5)`, `.large()` 기본 제공

---

## 치수 (pt 값)

### 바텀 시트 (Sheet)

| 속성 | 값 | 토큰 경로 |
|------|-----|----------|
| Grabber 너비 | **36pt** | `spacing.json → components.sheet.grabberWidth` |
| Grabber 높이 | **5pt** | `spacing.json → components.sheet.grabberHeight` |
| Grabber 상단 margin | **8pt** | `spacing.json → components.sheet.grabberTop` |
| Corner radius (상단) | **34pt** (iPhone) | `spacing.json → radius.semantic.sheet.iphoneTop` |
| Corner radius (중간/하단) | **58pt** | `spacing.json → radius.semantic.sheet.iphoneBottom` |
| Grabber 색상 | `colors.fills.tertiary` (연회색) | — |

#### Sheet Detents (UISheetPresentationController)

| Detent | 높이 비율 | 실제 높이 (852pt 화면) | 용도 |
|--------|----------|----------------------|------|
| `.fraction(0.25)` | 25% | ~213pt | 미리보기, 힌트 |
| `.fraction(0.50)` | 50% | ~426pt | 중간 크기 |
| `.large()` | ~92% | ~784pt | 전체 화면에 가까움 |
| 커스텀 `.fraction(n)` | 임의 | — | `UISheetPresentationControllerDetent.custom` |

```
[Small detent 25%]
┌────────────────────────────────┐ ← 화면 상단
│  Content Region (배경)         │
│                                │
│                                │
│                                │
│        (dimming 없음)           │
├────────────────────────────────┤ ← 25% 지점
│       ──── Grabber ────        │  8pt 상단 padding
│   Sheet 내용 (Liquid Glass)    │
└────────────────────────────────┘ ← 화면 하단 (safe area 고려)

[Large detent ~92%]
┌────────────────────────────────┐ ← 화면 상단 (status bar 아래)
│       ──── Grabber ────        │  8pt
│                                │
│   Sheet 내용 (Liquid Glass)    │
│                                │
└────────────────────────────────┘ ← 화면 하단
```

### Alert

| 속성 | 값 | 토큰 경로 |
|------|-----|----------|
| 너비 | **270pt** | `spacing.json → components.alert.width` |
| 수평 padding | **16pt** | `spacing.json → components.alert.paddingHorizontal` |
| 수직 padding (상단) | **20pt** | `spacing.json → components.alert.paddingVertical` |
| 버튼 높이 | **44pt** | `spacing.json → components.alert.buttonHeight` |
| Corner radius | **14pt** | `spacing.json → radius.semantic.alert` |
| 위치 | 화면 정중앙 (수평·수직) | — |

```
[Alert 270pt 너비]
        ┌──────────────────────┐ ← 화면 중앙에 위치
        │   타이틀 (17pt Bold) │
        │                      │
        │   메시지 본문 텍스트  │  (13pt Regular, secondary)
        │                      │
        ├──────────────────────┤ ← 구분선
        │      취소             │  44pt 버튼 (파랑, Regular)
        ├──────────────────────┤ ← 구분선
        │      확인             │  44pt 버튼 (파랑, Bold = 기본)
        └──────────────────────┘
        ← 270pt →
```

**3버튼 Alert (수직 배열)**:
```
        ┌──────────────────────┐
        │      삭제             │  44pt (빨강)
        ├──────────────────────┤
        │      수정             │  44pt (파랑)
        ├──────────────────────┤
        │      취소             │  44pt (파랑, Bold)
        └──────────────────────┘
```

### Context Menu

| 속성 | 값 |
|------|-----|
| 메뉴 너비 | **250pt** (표준) |
| 행 높이 | **44pt** |
| Corner radius | **14pt** → `spacing.json → radius.semantic.contextMenu` |
| 화면 경계 여백 | **최소 8pt** (모든 방향) |
| 프리뷰 corner radius | **12pt** → `spacing.json → radius.semantic.card` |
| 프리뷰 최대 크기 | 화면의 60% (width), 40% (height) |

### Popover (iPad)

| 속성 | 값 |
|------|-----|
| 최소 화면 여백 | **20pt** (모든 방향) |
| 화살표 높이 | **13pt** |
| 화살표 너비 | **26pt** |
| Corner radius | **14pt** → `spacing.json → radius.semantic.popover` |
| 기본 너비 | **320pt** |

---

## 색상 / Material 규칙

### Sheet — Liquid Glass 소재

| 속성 | 값 | 토큰 |
|------|-----|------|
| 배경 blur | **14px** (large frost) | `spacing.json → liquidGlass.frost.large = 14` |
| 배경 색상 | `ultraThinMaterial` | `materials.json` |
| 배경 refraction | **100** | `spacing.json → liquidGlass.refraction` |
| Light mode 투명도 | `rgba(255,255,255,0.72)` 근사 | — |
| Dark mode 투명도 | `rgba(28,28,30,0.72)` 근사 | — |

### Alert — 불투명 배경

| 속성 | Light | Dark |
|------|-------|------|
| 배경 | `rgba(255,255,255,0.95)` | `rgba(44,44,46,0.95)` |
| 타이틀 색상 | `colors.labels.primary.light` (#000) | `colors.labels.primary.dark` (#fff) |
| 메시지 색상 | `colors.labels.secondary` (60% black) | — |
| 버튼 기본 | `colors.accents.blue.light` (#0088ff) | `colors.accents.blue.dark` (#0091ff) |
| 버튼 Destructive | `colors.accents.red.light` (#ff383c) | — |
| 구분선 | `colors.separators.opaque` | — |

### Dimming 규칙

| Overlay 유형 | Dimming | 투명도 | 비고 |
|-------------|---------|--------|------|
| Sheet (half/small) | **없음** | — | 배경 계속 보임 |
| Sheet (large, fullscreen) | **있음** | `rgba(0,0,0,0.4)` | 배경 어두워짐 |
| Alert | **있음** | `rgba(0,0,0,0.5)` | 배경 인터랙션 차단 |
| Context Menu | **있음** | blur + scale down 배경 | `UIPreviewParameters` |
| Action Sheet | **있음** | `rgba(0,0,0,0.4)` | iPad에서 Popover로 변환 |
| Popover (iPad) | **없음** | — | 배경 인터랙션 유지 |
| Menu (SwiftUI) | **있음** | 살짝 blur | — |

---

## 동작 / 애니메이션

### Sheet present / dismiss

```
Present (아래 → 위):
  spring(stiffness: 300, damping: 40)
  y: 화면 하단 → detent 위치
  동시에: 배경 dimming fade-in (0.3s ease)

Dismiss (위 → 아래):
  spring(stiffness: 300, damping: 40)
  y: detent 위치 → 화면 하단
  동시에: 배경 dimming fade-out (0.25s ease)

Detent 변경 (gesture drag):
  스크롤이 상단에서 아래로 드래그 → detent 순서대로 전환
  실시간 interactive: spring resistance 적용
  snap: 손 뗄 때 가장 가까운 detent로 spring
```

**Spring 파라미터**:

| 파라미터 | Sheet present | Detent snap |
|---------|--------------|------------|
| stiffness | **300** | **380** |
| damping | **40** | **45** |
| initialVelocity | 0 | 드래그 속도 연동 |

> `animations.json` 참조 (spring 토큰)

### Alert appear / dismiss

```
Appear:
  scale: 1.2 → 1.0 (spring, stiffness:400, damping:38)
  opacity: 0 → 1 (0.2s ease)
  background dimming: fade-in (0.2s)

Dismiss (버튼 탭):
  scale: 1.0 → 0.9 (0.15s ease-in)
  opacity: 1 → 0 (0.15s ease-in)
  background dimming: fade-out (0.2s)
```

### Context Menu appear

```
Long press (0.5s 이상):
  1. 배경: scale 0.96, brightness 감소, blur 강화 (interactive)
  2. 프리뷰: 원래 위치에서 약간 lift-up + scale 1.05
  3. 메뉴: 프리뷰 옆 또는 아래에 spring 등장

Dismiss:
  tap outside: 모든 요소 원위치로 spring (0.25s)
  메뉴 선택: 선택된 항목 highlight 후 dismiss (0.15s)
```

### Popover (iPad)

```
Present:
  화살표 방향으로 scale 0 → 1 (spring, stiffness:350, damping:42)
  opacity: 0 → 1

Dismiss:
  반대 방향으로 scale 1 → 0 (0.2s ease-in)
```

---

## Accessibility

| 항목 | 규칙 |
|------|------|
| VoiceOver — Sheet | present 시 포커스 Sheet 첫 요소로 이동. dismiss 시 이전 포커스 복원 |
| VoiceOver — Alert | 자동으로 타이틀 읽음. 버튼 포커스. 배경 인터랙션 차단 |
| VoiceOver — Context Menu | "길게 누르면 메뉴 표시" accessibilityHint. 메뉴 항목 순서대로 포커스 |
| Keyboard (iPad) | Escape: dismiss. Tab: 메뉴 항목 이동. Enter: 선택 |
| Reduce Motion | Spring 애니메이션 → crossfade (0.2s) 대체 |
| Reduce Transparency | Liquid Glass blur 제거, 불투명 배경으로 대체 |
| Alert 버튼 접근성 | `accessibilityTraits = .button`, destructive 버튼에 `accessibilityHint = "이 작업은 되돌릴 수 없습니다"` |
| 최소 터치 | Alert 버튼 최소 **44pt** 높이 |

---

## 프레임워크별 구현

### UIKit

```swift
// 바텀 시트 (UISheetPresentationController)
let vc = SheetViewController()
if let sheet = vc.sheetPresentationController {
    // Detents 설정
    sheet.detents = [
        .custom(resolver: { context in
            context.maximumDetentValue * 0.25  // 25%
        }),
        .medium(),   // ~50%
        .large()     // ~92%
    ]
    sheet.prefersGrabberVisible = true
    sheet.preferredCornerRadius = 34  // spacing.json → radius.semantic.sheet.iphoneTop
    sheet.largestUndimmedDetentIdentifier = .medium  // medium 이하에서 dimming 없음
    sheet.prefersScrollingExpandsWhenScrolledToEdge = true

    // detent 변경 이벤트
    sheet.animateChanges {
        sheet.selectedDetentIdentifier = .large
    }
}
present(vc, animated: true)

// Alert
let alert = UIAlertController(
    title: "항목 삭제",
    message: "이 항목을 삭제하면 되돌릴 수 없습니다.",
    preferredStyle: .alert  // .actionSheet for action sheet
)
alert.addAction(UIAlertAction(title: "취소", style: .cancel))
alert.addAction(UIAlertAction(title: "삭제", style: .destructive) { _ in
    self.deleteItem()
})
present(alert, animated: true)
```

```swift
// Context Menu (UIContextMenuConfiguration)
func tableView(
    _ tableView: UITableView,
    contextMenuConfigurationForRowAt indexPath: IndexPath,
    point: CGPoint
) -> UIContextMenuConfiguration? {
    return UIContextMenuConfiguration(
        identifier: nil,
        previewProvider: {
            // 프리뷰 뷰 컨트롤러 반환 (선택사항)
            return ItemPreviewViewController(item: self.items[indexPath.row])
        },
        actionProvider: { _ in
            UIMenu(children: [
                UIAction(
                    title: "공유",
                    image: UIImage(systemName: "square.and.arrow.up")
                ) { _ in self.shareItem(at: indexPath) },
                UIAction(
                    title: "삭제",
                    image: UIImage(systemName: "trash"),
                    attributes: .destructive
                ) { _ in self.deleteItem(at: indexPath) }
            ])
        }
    )
}

// Popover (iPad)
let popover = PopoverContentViewController()
popover.modalPresentationStyle = .popover
if let pc = popover.popoverPresentationController {
    pc.barButtonItem = sender
    pc.permittedArrowDirections = [.up, .down]
}
present(popover, animated: true)
```

### SwiftUI

```swift
// Sheet (SwiftUI .sheet)
struct ParentView: View {
    @State private var showSheet = false
    @State private var detent: PresentationDetent = .fraction(0.5)

    var body: some View {
        Button("시트 열기") { showSheet = true }
            .sheet(isPresented: $showSheet) {
                SheetContent()
                    .presentationDetents([
                        .fraction(0.25),
                        .fraction(0.5),
                        .large
                    ], selection: $detent)
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(34)       // iOS 26 기본값
                    .presentationBackground(.ultraThinMaterial)  // Liquid Glass
                    // 중간 detent 이하: dimming 없음
                    .presentationBackgroundInteraction(
                        .enabled(upThrough: .fraction(0.5))
                    )
            }
    }
}

// Alert
struct AlertView: View {
    @State private var showAlert = false

    var body: some View {
        Button("삭제") { showAlert = true }
            .alert("항목 삭제", isPresented: $showAlert) {
                Button("삭제", role: .destructive) { deleteItem() }
                Button("취소", role: .cancel) { }
            } message: {
                Text("이 항목을 삭제하면 되돌릴 수 없습니다.")
            }
    }
}

// Context Menu
Text("항목")
    .contextMenu {
        Button {
            shareItem()
        } label: {
            Label("공유", systemImage: "square.and.arrow.up")
        }
        Button(role: .destructive) {
            deleteItem()
        } label: {
            Label("삭제", systemImage: "trash")
        }
    } preview: {
        ItemPreviewView()  // 프리뷰 (선택사항)
    }

// Popover (iPad)
Button("메뉴") { showPopover = true }
    .popover(isPresented: $showPopover, arrowEdge: .bottom) {
        PopoverContent()
            .frame(width: 320)
            .presentationCompactAdaptation(.none)  // iPad에서 popover 유지
    }

// Confirmation Dialog (Action Sheet 대체)
Button("옵션") { showConfirmation = true }
    .confirmationDialog("작업 선택", isPresented: $showConfirmation) {
        Button("삭제", role: .destructive) { deleteItem() }
        Button("공유") { shareItem() }
        Button("취소", role: .cancel) { }
    }
```

### Flutter

```dart
// 바텀 시트 (iOS 스타일)
import 'package:flutter/cupertino.dart';

// CupertinoModalPopupRoute (iOS 스타일 시트)
showCupertinoModalPopup(
  context: context,
  builder: (context) => CupertinoActionSheet(
    title: const Text('항목 삭제'),
    message: const Text('삭제하면 되돌릴 수 없습니다.'),
    actions: [
      CupertinoActionSheetAction(
        isDestructiveAction: true,
        onPressed: () {
          Navigator.pop(context);
          deleteItem();
        },
        child: const Text('삭제'),
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
      onPressed: () => Navigator.pop(context),
      child: const Text('취소'),
    ),
  ),
);

// DraggableScrollableSheet — detent 근사
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (context) => DraggableScrollableSheet(
    initialChildSize: 0.5,   // 50% detent
    minChildSize: 0.25,       // 25% detent
    maxChildSize: 0.92,       // large detent
    snap: true,
    snapSizes: const [0.25, 0.5, 0.92],
    builder: (context, controller) => ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
      child: Container(
        // Liquid Glass 근사
        decoration: BoxDecoration(
          color: CupertinoColors.systemBackground.resolveFrom(context)
              .withOpacity(0.72),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: SheetContent(scrollController: controller),
        ),
      ),
    ),
  ),
);

// Alert (iOS 스타일)
showCupertinoDialog(
  context: context,
  builder: (context) => CupertinoAlertDialog(
    title: const Text('항목 삭제'),
    content: const Text('이 항목을 삭제하면 되돌릴 수 없습니다.'),
    actions: [
      CupertinoDialogAction(
        onPressed: () => Navigator.pop(context),
        child: const Text('취소'),
      ),
      CupertinoDialogAction(
        isDestructiveAction: true,
        onPressed: () {
          Navigator.pop(context);
          deleteItem();
        },
        child: const Text('삭제'),
      ),
    ],
  ),
);
```

### CSS / Svelte (웹 근사치)

```svelte
<!-- BottomSheet.svelte -->
<script lang="ts">
  import { spring } from 'svelte/motion';

  export let isOpen = false;
  export let detent: 0.25 | 0.5 | 1.0 = 0.5;

  const translateY = spring(100, { stiffness: 300, damping: 40 });

  $: if (isOpen) {
    translateY.set(0);
  } else {
    translateY.set(100);
  }
</script>

{#if isOpen || $translateY < 100}
  <!-- Dimming (large detent만) -->
  {#if detent >= 1.0}
    <div
      class="dimming"
      style:opacity={isOpen ? 0.4 : 0}
      on:click={() => (isOpen = false)}
    />
  {/if}

  <div
    class="sheet"
    style:height="{detent * 100}dvh"
    style:transform="translateY({$translateY}%)"
  >
    <div class="grabber" />
    <slot />
  </div>
{/if}

<style>
  .dimming {
    position: fixed;
    inset: 0;
    background: rgba(0, 0, 0, 0.4);
    z-index: 200;
    transition: opacity 0.3s ease;
  }

  .sheet {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    z-index: 300;
    border-radius: 34px 34px 0 0;
    /* Liquid Glass 근사 */
    background: rgba(255, 255, 255, 0.72);
    backdrop-filter: blur(14px) saturate(180%);
    -webkit-backdrop-filter: blur(14px) saturate(180%);
    padding-bottom: env(safe-area-inset-bottom);
  }

  @media (prefers-color-scheme: dark) {
    .sheet { background: rgba(28, 28, 30, 0.72); }
  }

  .grabber {
    width: 36px;
    height: 5px;
    background: rgba(60, 60, 67, 0.3);
    border-radius: 3px;
    margin: 8px auto;
  }
</style>
```

```svelte
<!-- Alert.svelte -->
<script lang="ts">
  import { scale, fade } from 'svelte/transition';
  import { cubicOut } from 'svelte/easing';

  export let isOpen = false;
  export let title = '';
  export let message = '';
  export let onConfirm: () => void;
  export let onCancel: () => void;
  export let destructive = false;
</script>

{#if isOpen}
  <!-- 배경 dimming -->
  <div
    class="dimming"
    transition:fade={{ duration: 200 }}
  />

  <!-- Alert 본체 -->
  <div
    class="alert-wrapper"
    transition:scale={{ start: 1.1, duration: 200, easing: cubicOut }}
  >
    <div class="alert">
      <div class="alert-content">
        <h2>{title}</h2>
        {#if message}<p>{message}</p>{/if}
      </div>
      <div class="alert-actions">
        <button class="action cancel" on:click={onCancel}>취소</button>
        <div class="divider-v" />
        <button
          class="action confirm"
          class:destructive
          on:click={onConfirm}
        >확인</button>
      </div>
    </div>
  </div>
{/if}

<style>
  .dimming {
    position: fixed;
    inset: 0;
    background: rgba(0, 0, 0, 0.5);
    z-index: 400;
  }

  .alert-wrapper {
    position: fixed;
    inset: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 500;
  }

  .alert {
    width: 270px;
    background: rgba(255, 255, 255, 0.95);
    border-radius: 14px;
    overflow: hidden;
  }

  @media (prefers-color-scheme: dark) {
    .alert { background: rgba(44, 44, 46, 0.95); }
  }

  .alert-content {
    padding: 20px 16px 16px;
    text-align: center;
  }

  .alert-content h2 {
    font-size: 17px;
    font-weight: 600;
    margin: 0 0 8px;
  }

  .alert-content p {
    font-size: 13px;
    color: rgba(60, 60, 67, 0.6);
    margin: 0;
  }

  .alert-actions {
    display: flex;
    border-top: 0.5px solid rgba(60, 60, 67, 0.36);
  }

  .action {
    flex: 1;
    height: 44px;
    font-size: 17px;
    color: #0088ff;
    background: none;
    border: none;
    cursor: pointer;
  }

  .action.confirm { font-weight: 600; }
  .action.destructive { color: #ff383c; }
  .divider-v { width: 0.5px; background: rgba(60, 60, 67, 0.36); }
</style>
```

---

## 연관 섹션 / 컴포넌트

- **Content Region** (`content-region.md`): Overlay의 배경 레이어
- **System Region** (`system-region.md`): Home Indicator safe area와 Sheet 하단 처리
- **Sheet 컴포넌트** (`../components/specs/sheet.md`): Figma 원본 시트 스펙
- **Alert 컴포넌트** (`../components/specs/alert.md`): Figma 원본 Alert 스펙 (Node `507:24689`)
