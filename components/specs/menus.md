# Menus — iOS 26 컴포넌트 스펙

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24676")`

---

## 1. 개요

Menu는 버튼 또는 내비게이션 바 아이템을 **탭**하면 즉시 나타나는 드롭다운 메뉴다. Context Menu와 달리 **long press 없이 즉시 등장**하며, **미리보기(Preview) 영역이 없다**. 버튼의 액션 대안을 목록으로 제시하는 것이 주 용도다.

| 항목 | 값 |
|------|-----|
| **Figma Node** | `507:24676` — COMPONENT_SET, 18 variants |
| **지원 플랫폼** | iOS 26 (iPhone + iPad) |
| **트리거** | 버튼 탭, UIBarButtonItem 탭 |
| **iOS 26 신규 특징** | Liquid Glass material 배경 |
| **닫기 방법** | 메뉴 외부 탭, 항목 선택, 스와이프 |
| **Context Menu와 차이** | 미리보기 없음, long press 불필요, 즉시 등장 |

> iOS 26 Menu는 Liquid Glass material을 배경으로 사용한다. 18개 variants는 아이콘 유무, Inline 섹션, 체크마크, Destructive 항목, 서브메뉴, Light/Dark 조합으로 구성된다.

---

## 2. Context Menu와 비교

| 항목 | Menu | Context Menu |
|------|------|-------------|
| **트리거** | 버튼 탭 (즉시) | Long press (0.5초 이상) |
| **미리보기** | 없음 | 있음 (선택적) |
| **Dimming** | 없음 (또는 옅음) | 전체 화면 블러 |
| **주 용도** | 버튼 액션 목록 | 콘텐츠 아이템 액션 |
| **UIKit** | `UIButton.menu` | `UIContextMenuInteraction` |
| **SwiftUI** | `Menu { } label: { }` | `.contextMenu { }` |

---

## 3. 구조 및 치수

### 3-1. 전체 레이아웃

```
트리거 버튼
    ↓ 탭
┌───────────────────────────────┐  ← 메뉴 카드 (250pt 너비)
│  섹션 헤더 (선택)              │  ← 12pt 텍스트, 대문자, 색상: label.tertiary
│  ─────────────────────────── │  ← 섹션 구분선 (1px)
│  [아이콘]   항목 레이블         │  ← 높이: 44pt
│  [아이콘]   항목 레이블    ✓   │  ← 체크마크 (단일 선택)
│  ─────────────────────────── │  ← 섹션 구분선 (1px)
│  [아이콘]   항목 레이블    ›   │  ← 서브메뉴 항목
│  ─────────────────────────── │
│  [아이콘]   Destructive        │  ← 빨간색 (Colors/System/Red)
└───────────────────────────────┘
        ↑ Liquid Glass 배경
        ↑ 코너 반경: 13pt
```

### 3-2. 메뉴 카드 치수

| 항목 | 값 | 토큰 |
|------|-----|------|
| **너비** | 250pt (고정) | `components.menu.width` |
| **항목 높이** | 44pt | `components.menu.itemHeight` |
| **섹션 구분선 두께** | 1px | `components.menu.separatorHeight` |
| **내부 수평 패딩** | 16pt (좌우) | `components.menu.paddingH` |
| **코너 반경** | 13pt | `radius.semantic.menu` |
| **배경** | Liquid Glass | `materials.glass.menu` |
| **최대 높이** | 화면 높이 × 0.6 | — |
| **최대 높이 초과 시** | 내부 스크롤 활성화 | — |

### 3-3. 메뉴 항목 구조

```
┌──────────────────────────────────────────────────────────┐
│  [왼쪽 아이콘 20pt]   레이블 (17pt)   [오른쪽 요소]        │
│  ←─ 16pt ─→  ←─ 12pt ─→                ←─ 16pt ─→     │
└──────────────────────────────────────────────────────────┘
 총 높이: 44pt, 수직 중앙 정렬

오른쪽 요소 종류:
  ✓  → 체크마크 (SF Symbol: checkmark, 17pt)
  ›  → 서브메뉴 (SF Symbol: chevron.right, 17pt)
  없음 → 기본 항목
```

| 요소 | 규격 | 비고 |
|------|------|------|
| **왼쪽 아이콘** | SF Symbol, 20pt | 선택 사항 |
| **레이블** | Body, 17pt, Regular | `typography.textStyles.body` |
| **체크마크** | SF Symbol `checkmark`, 17pt | 단일 선택 / 복수 선택 모두 동일 아이콘 |
| **서브메뉴 화살표** | SF Symbol `chevron.right`, 17pt | `label.secondary` 색상 |
| **Destructive** | 동일 규격, `Colors/System/Red` | 아이콘도 빨간색 |

---

## 4. Variants (18가지) 분류

18가지 variant는 다음 6개 카테고리로 구분된다.

### 카테고리 1: 기본 메뉴 — 아이콘 없음 (2종)

```
┌──────────────────────────────────────┐
│  항목 레이블 A                         │
│  ─────────────────────────────────── │
│  항목 레이블 B                         │
│  ─────────────────────────────────── │
│  항목 레이블 C                         │
└──────────────────────────────────────┘
Light variant / Dark variant
```

- 아이콘 없이 텍스트 레이블만 표시
- 가장 단순한 형태, 짧은 옵션 목록에 적합

### 카테고리 2: 기본 메뉴 — 아이콘 있음 (2종)

```
┌──────────────────────────────────────────────┐
│  [share.fill]    공유                          │
│  ─────────────────────────────────────────── │
│  [doc.on.doc]    복사                          │
│  ─────────────────────────────────────────── │
│  [bookmark.fill] 저장                          │
└──────────────────────────────────────────────┘
Light variant / Dark variant
```

- SF Symbol 아이콘 20pt + 레이블 조합
- 항목 의미를 시각적으로 보강

### 카테고리 3: Inline 섹션 (2종)

```
┌──────────────────────────────────────────────┐
│  [heart]  좋아요    [reply]  답장    [more]   │  ← Inline 섹션 (구분선 없는 수평 배치)
│  ───────────────────────────────────────────  │
│  [share]    공유                               │
│  ───────────────────────────────────────────  │
│  [trash]    삭제                               │
└──────────────────────────────────────────────┘
Light variant / Dark variant
```

- `UIMenuOptions.displayInline`로 지정된 섹션
- 섹션 내 항목들이 수평으로 나란히 배치 (아이콘만 표시)
- 빠른 접근이 필요한 자주 쓰는 액션에 사용

### 카테고리 4: 체크마크 (4종)

**단일 선택 (Single Selection):**
```
┌──────────────────────────────────────────────┐
│  작은 텍스트                                    │
│  ─────────────────────────────────────────── │
│  보통 텍스트                           ✓       │  ← 현재 선택
│  ─────────────────────────────────────────── │
│  큰 텍스트                                     │
└──────────────────────────────────────────────┘
```

**복수 선택 (Multiple Selection):**
```
┌──────────────────────────────────────────────┐
│  굵게                                  ✓       │
│  ─────────────────────────────────────────── │
│  기울임                                ✓       │
│  ─────────────────────────────────────────── │
│  밑줄                                          │
└──────────────────────────────────────────────┘
Light × 단일 / Dark × 단일 / Light × 복수 / Dark × 복수
```

- 체크마크: SF Symbol `checkmark`, `Colors/Label/Primary` 색상
- 단일 선택은 `UIMenu` state `.on` / 복수 선택도 동일 API로 처리

### 카테고리 5: Destructive 항목 포함 (2종)

```
┌──────────────────────────────────────────────┐
│  [square.and.arrow.up]    공유                 │
│  ─────────────────────────────────────────── │
│  [star]                   즐겨찾기             │
│  ─────────────────────────────────────────── │
│  [trash]                  삭제                 │  ← 빨간색
└──────────────────────────────────────────────┘
Light variant / Dark variant
```

- Destructive 항목은 아이콘 + 레이블 모두 `Colors/System/Red`
- 일반적으로 메뉴 최하단에 배치 (파괴적 액션은 실수 방지를 위해)

### 카테고리 6: 서브메뉴 포함 (2종)

```
┌──────────────────────────────────────────────┐
│  [folder]    폴더로 이동                   ›   │  ← 서브메뉴 트리거
│  ─────────────────────────────────────────── │
│  [tag]       태그 추가                     ›   │  ← 서브메뉴 트리거
│  ─────────────────────────────────────────── │
│  [trash]     삭제                              │
└──────────────────────────────────────────────┘
Light variant / Dark variant
```

### 카테고리별 Light/Dark 분포

Figma에서 각 카테고리는 Light 5개, Dark 5개씩 2열로 배치된다:

```
Figma 캔버스 레이아웃:
┌──────────────────────────────────────────────────────────┐
│  [Light 예시 5개]     [Dark 예시 5개]                      │
│  기본(아이콘없음)       기본(아이콘없음)                     │
│  기본(아이콘있음)       기본(아이콘있음)                     │
│  Inline              Inline                               │
│  체크마크 단일         체크마크 단일                         │
│  체크마크 복수         체크마크 복수                         │
│  Destructive         Destructive                          │
│  서브메뉴             서브메뉴                              │
│  + Inline+아이콘      + Inline+아이콘                      │
│  + 혼합              + 혼합                                │
└──────────────────────────────────────────────────────────┘
```

---

## 5. 메뉴 위치 결정 (Auto Positioning)

메뉴 카드는 트리거 버튼의 위치를 기준으로 방향을 자동 결정한다.

```
트리거 버튼 위치별 메뉴 방향:

  ┌─────────────────────────────────┐
  │  [버튼]  ← 화면 상단 좌측        │
  │    ↓                            │
  │  [메뉴] ← 버튼 아래 + 좌측 정렬  │
  │                                 │
  │                   [버튼] ← 상단 우측 │
  │                     ↓           │
  │               [메뉴] ← 아래 + 우측 정렬 │
  │                                 │
  │  [메뉴] ← 아래 + 좌측           │
  │    ↑                            │
  │  [버튼] ← 화면 하단 좌측         │
  │                                 │
  │               [메뉴] ← 아래 + 우측 │
  │                 ↑               │
  │               [버튼] ← 하단 우측  │
  └─────────────────────────────────┘
```

| 트리거 위치 | 메뉴 방향 | 정렬 |
|-----------|----------|------|
| 상단 좌측 | 아래 | 왼쪽 정렬 |
| 상단 우측 | 아래 | 오른쪽 정렬 |
| 하단 좌측 | 위 | 왼쪽 정렬 |
| 하단 우측 | 위 | 오른쪽 정렬 |
| 중앙 | 아래 (기본) | 트리거 중앙 정렬 |
| 화면 경계 초과 시 | 자동 반전 | — |

**화면 경계 여백**: 최소 8pt (Safe Area 내)

---

## 6. 토큰 참조

### 색상 (`colors.json`)

| 역할 | 토큰 경로 | Light | Dark |
|------|---------|-------|------|
| 레이블 기본 | `label.primary` | `#000000` | `#FFFFFF` |
| Destructive | `system.red` | `#FF3B30` | `#FF453A` |
| 섹션 구분선 | `separator.opaque` | `#C6C6C8` | `#38383A` |
| 보조 아이콘/화살표 | `label.secondary` | `#3C3C43/60%` | `#EBEBF5/60%` |
| 섹션 헤더 텍스트 | `label.tertiary` | `#3C3C43/30%` | `#EBEBF5/30%` |
| 체크마크 | `label.primary` | `#000000` | `#FFFFFF` |

### 간격 (`spacing.json`)

| 역할 | 토큰 경로 | 값 |
|------|---------|-----|
| 메뉴 너비 | `components.menu.width` | `250pt` |
| 항목 높이 | `components.menu.itemHeight` | `44pt` |
| 내부 수평 패딩 | `components.menu.paddingH` | `16pt` |
| 아이콘-레이블 간격 | `components.menu.iconLabelGap` | `12pt` |
| 구분선 두께 | `components.menu.separatorHeight` | `1px` |
| 코너 반경 | `radius.semantic.menu` | `13pt` |
| 화면 경계 여백 | `components.menu.screenEdgeMargin` | `8pt` |

### 타이포그래피 (`typography.json`)

| 역할 | 토큰 경로 | 값 |
|------|---------|-----|
| 항목 레이블 | `textStyles.body` | SF Pro, 17pt, Regular |
| 섹션 헤더 | `textStyles.footnote` | SF Pro, 12pt, Regular, 대문자 |
| Destructive 레이블 | `textStyles.body` (색상만 변경) | SF Pro, 17pt, Regular |

### 애니메이션 (`animations.json`)

| 역할 | 토큰 경로 | 값 |
|------|---------|-----|
| 등장 spring stiffness | `spring.menu.stiffness` | `400` |
| 등장 spring damping | `spring.menu.damping` | `38` |
| 등장 scale 시작 | `menu.scaleFrom` | `0.8` |
| 등장 scale 끝 | `menu.scaleTo` | `1.0` |
| 등장 origin | 트리거 방향 기준 | 방향별 다름 (아래 참조) |

---

## 7. 애니메이션 상세

### 등장 origin (transform-origin)

메뉴는 트리거 버튼 방향 기준으로 확장된다:

```
트리거가 상단인 경우 (메뉴가 아래로 펼쳐짐):
  transform-origin: top center  (또는 top-left / top-right)

트리거가 하단인 경우 (메뉴가 위로 펼쳐짐):
  transform-origin: bottom center  (또는 bottom-left / bottom-right)

트리거가 좌측인 경우 (메뉴가 오른쪽으로):
  transform-origin: left center

트리거가 우측인 경우 (메뉴가 왼쪽으로):
  transform-origin: right center
```

### 등장 (Presentation)

```
타임라인:
  0ms    → 탭 인식 (햅틱 없음, 즉시)
  0ms    → scale 0.8 + opacity 0.0 상태 시작
           transform-origin: 트리거 방향
  0~250ms → scale 1.0 + opacity 1.0
            spring: stiffness 400, damping 38
```

### 닫힘 (Dismissal)

```
타임라인:
  0ms    → 닫기 트리거 (외부 탭 / 항목 선택)
  0~180ms → scale 0.8 + opacity 0.0
            easeIn curve (등장의 역방향)
```

### 서브메뉴 전환

```
탭 시:
  0~200ms → 현재 메뉴 → 오른쪽으로 슬라이드 + fade out
  0~200ms → 서브메뉴 → 오른쪽에서 슬라이드 in + fade in
  동시 진행 (crossfade + translate)

서브메뉴에서 뒤로:
  0~200ms → 서브메뉴 → 오른쪽으로 슬라이드 + fade out
  0~200ms → 부모 메뉴 → 왼쪽에서 슬라이드 in + fade in
```

---

## 8. 플랫폼별 구현

### UIKit

```swift
// UIButton.menu (iOS 14+, iOS 26 권장 방식)
let button = UIButton(type: .system)
button.configuration = .bordered()
button.setTitle("옵션", for: .normal)

// 메뉴 구성
button.menu = UIMenu(children: [
    // 기본 항목 (아이콘 없음)
    UIAction(title: "보기") { _ in },

    // 아이콘 있는 항목
    UIAction(
        title: "공유",
        image: UIImage(systemName: "square.and.arrow.up")
    ) { _ in },

    // Inline 섹션
    UIMenu(options: .displayInline, children: [
        UIAction(title: "좋아요", image: UIImage(systemName: "heart")) { _ in },
        UIAction(title: "답장", image: UIImage(systemName: "arrowshape.turn.up.left")) { _ in },
    ]),

    // 서브메뉴
    UIMenu(title: "폴더로 이동", children: [
        UIAction(title: "받은 편지함") { _ in },
        UIAction(title: "보관함") { _ in },
    ]),

    // 체크마크 (단일 선택)
    UIAction(
        title: "선택됨",
        state: .on  // 체크마크 표시
    ) { _ in },

    // Destructive
    UIAction(
        title: "삭제",
        image: UIImage(systemName: "trash"),
        attributes: .destructive
    ) { _ in },
])

// iOS 15+: showsMenuAsPrimaryAction
button.showsMenuAsPrimaryAction = true  // 탭으로 바로 메뉴 표시

// UIBarButtonItem 메뉴
let barButton = UIBarButtonItem(
    title: "정렬",
    image: UIImage(systemName: "arrow.up.arrow.down"),
    primaryAction: nil,
    menu: button.menu
)
```

### SwiftUI

```swift
// 기본 Menu
Menu {
    Button("공유") { share() }
    Button("복사") { copy() }
    Divider()
    Button(role: .destructive) {
        delete()
    } label: {
        Label("삭제", systemImage: "trash")
    }
} label: {
    Label("옵션", systemImage: "ellipsis.circle")
}

// 아이콘 있는 항목
Menu {
    Button {
        save()
    } label: {
        Label("저장", systemImage: "bookmark.fill")
    }

    Button {
        share()
    } label: {
        Label("공유", systemImage: "square.and.arrow.up")
    }
} label: {
    Image(systemName: "ellipsis")
        .font(.title2)
}

// Inline 섹션 (ControlGroup으로 표현)
Menu {
    ControlGroup {
        Button { like() } label: { Image(systemName: "heart") }
        Button { reply() } label: { Image(systemName: "arrowshape.turn.up.left") }
        Button { more() } label: { Image(systemName: "ellipsis") }
    }
    Divider()
    Button("공유") { share() }
} label: {
    Image(systemName: "ellipsis.circle")
}

// 체크마크 (Picker 활용)
Menu {
    Picker("텍스트 크기", selection: $textSize) {
        Text("작게").tag(TextSize.small)
        Text("보통").tag(TextSize.medium)
        Text("크게").tag(TextSize.large)
    }
    // Picker는 자동으로 체크마크 표시
} label: {
    Text("텍스트 크기")
}

// 서브메뉴
Menu {
    Menu("폴더로 이동") {
        Button("받은 편지함") { moveToInbox() }
        Button("보관함") { moveToArchive() }
        Button("보낸 편지함") { moveToSent() }
    }
    Button(role: .destructive) {
        delete()
    } label: {
        Label("삭제", systemImage: "trash")
    }
} label: {
    Image(systemName: "folder.badge.gearshape")
}
```

### Flutter

```dart
// PopupMenuButton (Material)
PopupMenuButton<String>(
  onSelected: (value) => _handleAction(value),
  // 메뉴 스타일 (iOS 느낌 근사)
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(13),
  ),
  elevation: 8,
  color: CupertinoColors.systemBackground.resolveFrom(context),
  itemBuilder: (context) => [
    // 아이콘 있는 항목
    PopupMenuItem<String>(
      value: 'share',
      height: 44,
      child: _buildMenuItem(
        icon: CupertinoIcons.share,
        label: '공유',
      ),
    ),
    PopupMenuDivider(height: 1),
    // 체크마크 항목
    CheckedPopupMenuItem<String>(
      value: 'checked',
      checked: _isSelected,
      height: 44,
      child: Text('선택됨', style: TextStyle(fontSize: 17)),
    ),
    PopupMenuDivider(height: 1),
    // Destructive
    PopupMenuItem<String>(
      value: 'delete',
      height: 44,
      child: _buildMenuItem(
        icon: CupertinoIcons.trash,
        label: '삭제',
        isDestructive: true,
      ),
    ),
  ],
  child: Icon(CupertinoIcons.ellipsis_circle, size: 22),
)

// 헬퍼 위젯
Widget _buildMenuItem({
  required IconData icon,
  required String label,
  bool isDestructive = false,
}) {
  final color = isDestructive
      ? CupertinoColors.systemRed
      : CupertinoColors.label;
  return Row(
    children: [
      Icon(icon, size: 20, color: color),
      SizedBox(width: 12),
      Text(
        label,
        style: TextStyle(fontSize: 17, color: color),
      ),
    ],
  );
}

// 서브메뉴가 필요한 경우: CupertinoContextMenu 또는 커스텀 overlay 사용
// flutter_context_menu 패키지도 고려 가능
```

### Svelte (웹, @floating-ui 기반)

```svelte
<script>
  import { computePosition, flip, shift, offset, autoUpdate } from '@floating-ui/dom';
  import { tick } from 'svelte';
  import { fade, scale } from 'svelte/transition';
  import { cubicOut } from 'svelte/easing';

  export let items = [];       // { label, icon, action, destructive, divider, submenu, checked }
  export let placement = 'bottom-start';

  let open = false;
  let triggerEl;
  let menuEl;
  let menuX = 0;
  let menuY = 0;
  let cleanup;

  // transform-origin 방향 결정
  $: transformOrigin = getTransformOrigin(placement);

  function getTransformOrigin(p) {
    if (p.startsWith('bottom')) return 'top';
    if (p.startsWith('top')) return 'bottom';
    if (p.startsWith('left')) return 'right';
    if (p.startsWith('right')) return 'left';
    return 'top';
  }

  async function toggleMenu() {
    open = !open;
    if (open) {
      await tick();
      cleanup = autoUpdate(triggerEl, menuEl, updatePosition);
    } else {
      cleanup?.();
    }
  }

  async function updatePosition() {
    const { x, y, placement: actualPlacement } = await computePosition(
      triggerEl,
      menuEl,
      {
        placement,
        middleware: [
          offset(4),
          flip(),
          shift({ padding: 8 }),
        ],
      }
    );
    menuX = x;
    menuY = y;
    // 실제 배치 방향으로 transform-origin 업데이트
    transformOrigin = getTransformOrigin(actualPlacement);
  }

  function closeMenu() {
    open = false;
    cleanup?.();
  }
</script>

<!-- 트리거 -->
<button
  bind:this={triggerEl}
  on:click={toggleMenu}
  aria-haspopup="menu"
  aria-expanded={open}
  class="menu-trigger"
>
  <slot name="trigger">
    <span>옵션</span>
  </slot>
</button>

<!-- 배경 닫기 -->
{#if open}
  <div
    class="menu-backdrop"
    on:click={closeMenu}
    aria-hidden="true"
    transition:fade={{ duration: 150 }}
  />
{/if}

<!-- 메뉴 카드 -->
{#if open}
  <div
    bind:this={menuEl}
    role="menu"
    aria-orientation="vertical"
    class="menu-card"
    style="
      left: {menuX}px;
      top: {menuY}px;
      transform-origin: {transformOrigin};
    "
    transition:scale={{
      start: 0.8,
      opacity: 0,
      duration: 250,
      easing: cubicOut,
    }}
  >
    {#each items as item}
      {#if item.divider}
        <div class="menu-divider" role="separator" />
      {:else if item.submenu}
        <!-- 서브메뉴 항목 -->
        <button
          class="menu-item has-submenu"
          role="menuitem"
          aria-haspopup="true"
        >
          {#if item.icon}
            <span class="menu-icon" aria-hidden="true">{@html item.icon}</span>
          {/if}
          <span class="menu-label">{item.label}</span>
          <span class="menu-chevron" aria-hidden="true">›</span>
        </button>
      {:else}
        <!-- 일반 항목 -->
        <button
          class="menu-item"
          class:destructive={item.destructive}
          role="menuitem"
          aria-checked={item.checked}
          on:click={() => { item.action?.(); closeMenu(); }}
        >
          {#if item.icon}
            <span class="menu-icon" aria-hidden="true">{@html item.icon}</span>
          {/if}
          <span class="menu-label">{item.label}</span>
          {#if item.checked}
            <span class="menu-checkmark" aria-hidden="true">✓</span>
          {/if}
        </button>
      {/if}
    {/each}
  </div>
{/if}

<style>
  .menu-trigger {
    position: relative;
    cursor: pointer;
  }

  .menu-backdrop {
    position: fixed;
    inset: 0;
    z-index: 40;
    background: transparent;
  }

  .menu-card {
    position: fixed;
    z-index: 50;
    width: 250px;
    border-radius: 13px;
    overflow: hidden;
    /* Liquid Glass */
    background: rgba(255, 255, 255, 0.72);
    backdrop-filter: blur(20px) saturate(180%);
    -webkit-backdrop-filter: blur(20px) saturate(180%);
    box-shadow:
      0 0 0 0.5px rgba(0, 0, 0, 0.1),
      0 4px 16px rgba(0, 0, 0, 0.12),
      0 8px 24px rgba(0, 0, 0, 0.08);
  }

  /* Dark mode */
  @media (prefers-color-scheme: dark) {
    .menu-card {
      background: rgba(44, 44, 46, 0.72);
    }
  }

  .menu-item {
    display: flex;
    align-items: center;
    width: 100%;
    min-height: 44px;
    padding: 0 16px;
    gap: 12px;
    background: none;
    border: none;
    cursor: pointer;
    font-size: 17px;
    line-height: 1.4;
    color: var(--color-label-primary, #000);
    text-align: left;
    -webkit-tap-highlight-color: transparent;
  }

  .menu-item:hover,
  .menu-item:focus-visible {
    background: rgba(0, 0, 0, 0.05);
    outline: none;
  }

  @media (prefers-color-scheme: dark) {
    .menu-item:hover,
    .menu-item:focus-visible {
      background: rgba(255, 255, 255, 0.08);
    }
  }

  .menu-item.destructive {
    color: #FF3B30;
  }

  @media (prefers-color-scheme: dark) {
    .menu-item.destructive {
      color: #FF453A;
    }
  }

  .menu-icon {
    flex-shrink: 0;
    width: 20px;
    height: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
  }

  .menu-label {
    flex: 1;
  }

  .menu-checkmark {
    flex-shrink: 0;
    font-size: 17px;
    color: var(--color-label-primary, #000);
  }

  .menu-chevron {
    flex-shrink: 0;
    font-size: 17px;
    color: rgba(60, 60, 67, 0.6);
  }

  .menu-divider {
    height: 1px;
    background: rgba(60, 60, 67, 0.29);
    margin: 0;
  }

  @media (prefers-color-scheme: dark) {
    .menu-divider {
      background: rgba(235, 235, 245, 0.29);
    }
  }
</style>
```

---

## 9. 접근성 (Accessibility)

| 항목 | 구현 방법 |
|------|----------|
| **VoiceOver** | `UIMenu` / `role="menu"` 시맨틱 자동 |
| **트리거 레이블** | `accessibilityLabel` 명시 ("더 보기, 팝업 버튼") |
| **항목 역할** | `accessibilityRole: .menuItem` 자동 |
| **체크 상태** | `accessibilityValue: "선택됨"` 또는 `aria-checked` |
| **Destructive** | "삭제, 위험한 동작" 접미사 힌트 추가 |
| **서브메뉴** | "하위 메뉴, 탭하여 펼치기" 힌트 |
| **닫기** | Escape 키 (iPad), 두 손가락 스크럽 |
| **키보드 탐색 (iPad)** | 위/아래 화살표로 항목 간 이동, Enter 선택 |

---

## 10. 체크리스트

### 구현 전 확인

- [ ] 트리거가 버튼/바 버튼 아이템인지 확인 (Context Menu와 혼동 금지)
- [ ] Inline 섹션 필요 여부 결정 (`UIMenuOptions.displayInline`)
- [ ] 체크마크 방식 결정 (단일: Picker, 복수: 상태 토글)
- [ ] Destructive 항목 메뉴 최하단 배치

### 디자인 확인

- [ ] 메뉴 카드 너비 250pt 준수
- [ ] 각 항목 높이 44pt (터치 타겟 44×44pt 충족)
- [ ] 섹션 구분선 1px (`Colors/Separator/Opaque`)
- [ ] Liquid Glass 배경 적용
- [ ] Destructive 항목 `Colors/System/Red` (아이콘 포함)
- [ ] 체크마크 `Colors/Label/Primary`

### 애니메이션 확인

- [ ] 등장: scale 0.8→1.0 (spring stiffness 400, damping 38)
- [ ] transform-origin: 트리거 방향 기준
- [ ] 닫힘: 등장 역방향 (180ms)

### 접근성 확인

- [ ] `role="menu"` / `UIMenu` 시맨틱 적용
- [ ] 트리거 버튼 `aria-haspopup="menu"` 설정
- [ ] 각 항목 `role="menuitem"` 설정
- [ ] 체크 상태 `aria-checked` 표시
- [ ] VoiceOver에서 메뉴 항목 탐색 가능

---

## 11. 주의사항 및 엣지 케이스

| 케이스 | 처리 방법 |
|--------|----------|
| **항목 5개 초과** | 내부 스크롤 활성화, 화면 높이 × 0.6 제한 |
| **화면 경계 근처 트리거** | `flip()` 미들웨어로 자동 반전 |
| **Dynamic Type 최대 크기** | 항목 높이 자동 증가 (44pt 최소 유지) |
| **메뉴 중 화면 회전** | 메뉴 닫고 재계산 (시스템 처리) |
| **빠른 연속 탭** | `showsMenuAsPrimaryAction = true`로 디바운스 필요 없음 |
| **UIBarButtonItem** | `menu` 프로퍼티에 직접 `UIMenu` 할당 |
| **Dark Mode** | Liquid Glass가 자동으로 대응, 별도 처리 불필요 |
| **서브메뉴 2단계 초과** | UX 가이드라인상 권장하지 않음, 최대 2단계 |
