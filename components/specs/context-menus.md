# Context Menus — iOS 26 컴포넌트 스펙

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:25994")`

---

## 1. 개요

Context Menu는 사용자가 요소를 **길게 누르면(long press)** 나타나는 인터랙티브 오버레이다. 두 개의 주요 구성 요소로 이루어진다: 탭한 요소를 확대 미리보기하는 **Preview 영역**과 관련 액션을 나열하는 **메뉴 카드**.

| 항목 | 값 |
|------|-----|
| **Figma Node** | `507:25994` — COMPONENT_SET, 4 variants |
| **Dimming Overlay Node** | `128:76929` — `Context Menu - Dimming Overlay` |
| **지원 플랫폼** | iOS 26 (iPhone + iPad) |
| **트리거 제스처** | Long Press (0.5초) |
| **iOS 26 신규 특징** | Liquid Glass material 배경, 개선된 spring 애니메이션 |
| **닫기 방법** | 메뉴 외부 탭, 스와이프 다운, 액션 선택 |

> iOS 26의 Context Menu는 Liquid Glass material이 메뉴 카드 배경에 적용되어, 배경 콘텐츠가 블러 처리된 채 비쳐 보이는 반투명 유리질 효과를 갖는다. 이전 iOS 버전의 불투명 흰색/어두운 배경과의 핵심 차이점이다.

---

## 2. 구성 요소

### 2-1. 전체 레이아웃

```
┌─────────────────────────────────────────────────────────────┐
│  Dimming Overlay (전체 화면, 반투명 블러)                       │
│                                                             │
│         ┌───────────────────────────┐                       │
│         │  Preview 영역              │                       │
│         │  (탭한 요소 확대 미리보기)   │                       │
│         │  코너 반경: 12pt            │                       │
│         └───────────────────────────┘                       │
│                        ↕ 8pt gap                            │
│         ┌───────────────────────────┐                       │
│         │  메뉴 카드 (250pt 너비)     │                       │
│         │  ─────────────────────── │                       │
│         │  ⎡아이콘⎤  항목 레이블   >  │  ← 서브메뉴 있는 항목  │
│         │  ─────────────────────── │  ← 섹션 구분선 1px     │
│         │  ⎡아이콘⎤  항목 레이블      │                       │
│         │  ─────────────────────── │                       │
│         │  ⎡아이콘⎤  Destructive    │  ← Colors/System/Red  │
│         └───────────────────────────┘                       │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 2-2. Preview 영역

| 항목 | 값 |
|------|-----|
| **역할** | 탭한 요소를 lift-up + scale-up하여 미리보기 |
| **코너 반경** | 12pt (컨텐츠 타입에 따라 조정 가능) |
| **최대 높이** | 화면 높이의 40% |
| **최대 너비** | 화면 너비 - 32pt (좌우 각 16pt 여백) |
| **그림자** | blur 20pt, opacity 0.3, offset (0, 8) |
| **커스터마이즈** | `UIContextMenuInteraction` delegate로 커스텀 뷰 제공 가능 |

> Preview 영역은 선택 사항이다. 미리보기가 없는 variant에서는 메뉴 카드만 단독으로 표시된다.

### 2-3. 메뉴 카드

| 항목 | 값 |
|------|-----|
| **너비** | 250pt (고정) |
| **각 항목 높이** | 44pt |
| **섹션 구분선 두께** | 1px (`Colors/Separator/Opaque`) |
| **내부 수평 패딩** | 16pt (좌우) |
| **코너 반경** | 13pt (Liquid Glass 표준) |
| **배경** | Liquid Glass material (`materials.json` > `glass.menu`) |
| **최대 항목 수** | 권장 5개 이내 (초과 시 스크롤 가능) |

### 2-4. 메뉴 항목 구성

각 항목은 다음 세 요소로 구성된다:

```
┌──────────────────────────────────────────────┐  ← 높이: 44pt
│  [아이콘 20pt]   레이블 텍스트          [오른쪽 아이콘]  │
│   ← 16pt →  ↑ 중앙 정렬              ← 16pt →  │
└──────────────────────────────────────────────┘
```

| 요소 | 규격 | 비고 |
|------|------|------|
| **왼쪽 아이콘** | SF Symbol, 20pt | 선택 사항, `Colors/Label/Primary` |
| **레이블** | Typography: Body (17pt), Regular | `colors.json` > `label.primary` |
| **오른쪽 아이콘** | SF Symbol, 17pt | 서브메뉴: `chevron.right`, 추가 힌트용 |
| **Destructive 레이블** | 동일 규격, 색상만 변경 | `Colors/System/Red` |

---

## 3. Variants (4가지)

4가지 variant는 **미리보기 유무 × 메뉴 위치(위/아래)** 조합이다.

| Variant | 미리보기 | 메뉴 위치 | 적용 조건 |
|---------|---------|----------|----------|
| **Preview + Menu Below** | 있음 | 프리뷰 아래 | 트리거가 화면 상단 영역 |
| **Preview + Menu Above** | 있음 | 프리뷰 위 | 트리거가 화면 하단 영역 |
| **No Preview + Menu Below** | 없음 | 트리거 아래 | 미리보기 비활성화 |
| **No Preview + Menu Above** | 없음 | 트리거 위 | 트리거가 하단 + 미리보기 비활성화 |

### 위치 결정 로직

```
트리거 Y 좌표 > 화면 높이 × 0.5
  → 메뉴를 트리거 위에 배치 (Menu Above)

트리거 Y 좌표 ≤ 화면 높이 × 0.5
  → 메뉴를 트리거 아래에 배치 (Menu Below)

메뉴 카드 + 프리뷰 높이가 화면을 초과하는 경우
  → 자동으로 스크롤 가능 모드 전환
```

---

## 4. Dimming Overlay

| 항목 | 값 |
|------|-----|
| **Figma Node** | `128:76929` |
| **이름** | `Context Menu - Dimming Overlay` |
| **크기** | 전체 화면 (Safe Area 포함) |
| **배경** | 블러 반경 20pt + 알파 0.0 (블러만 적용) |
| **색상** | 투명 (iOS 26 기준 배경 blur만 사용) |

```
iOS 15~17:  dimming = rgba(0, 0, 0, 0.4) + blur
iOS 26:     dimming = blur만 (색상 오버레이 없음, Liquid Glass와 조화)
```

---

## 5. 서브메뉴 (Submenu)

서브메뉴가 있는 항목은 오른쪽에 `chevron.right` 아이콘이 표시된다.

```
┌──────────────────────────────────────────────┐
│  [아이콘]   더 많은 옵션                  ›   │  ← 서브메뉴 트리거
└──────────────────────────────────────────────┘
        탭하면 →  슬라이드 전환 (오른쪽에서)

┌─────────────────────────────────────────────────────────────┐
│         ┌───────────────────────────┐                       │
│         │  ‹  뒤로가기              │  ← 헤더 (탭으로 복귀)  │
│         │  ─────────────────────── │                       │
│         │  서브메뉴 항목 1           │                       │
│         │  서브메뉴 항목 2           │                       │
│         │  서브메뉴 항목 3           │                       │
│         └───────────────────────────┘                       │
└─────────────────────────────────────────────────────────────┘
```

| 항목 | 값 |
|------|-----|
| **전환 애니메이션** | 슬라이드 (leading → trailing, 200ms) |
| **되돌아가기** | 헤더 `chevron.left` 탭 또는 스와이프 |
| **최대 깊이** | 2단계 권장 (UX 가이드라인) |

---

## 6. 토큰 참조

### 색상 (`colors.json`)

| 역할 | 토큰 경로 | Light | Dark |
|------|---------|-------|------|
| 레이블 기본 | `label.primary` | `#000000` | `#FFFFFF` |
| Destructive | `system.red` | `#FF3B30` | `#FF453A` |
| 섹션 구분선 | `separator.opaque` | `#C6C6C8` | `#38383A` |
| 보조 아이콘 | `label.secondary` | `#3C3C43 / 60%` | `#EBEBF5 / 60%` |

### 간격 (`spacing.json`)

| 역할 | 토큰 경로 | 값 |
|------|---------|-----|
| 메뉴 너비 | `components.contextMenu.width` | `250pt` |
| 항목 높이 | `components.contextMenu.itemHeight` | `44pt` |
| 내부 수평 패딩 | `components.contextMenu.paddingH` | `16pt` |
| 구분선 두께 | `components.contextMenu.separatorHeight` | `1px` |
| 프리뷰 하단 간격 | `components.contextMenu.previewGap` | `8pt` |
| 코너 반경 | `radius.semantic.menu` | `13pt` |
| 프리뷰 코너 반경 | `radius.semantic.contextMenuPreview` | `12pt` |

### 타이포그래피 (`typography.json`)

| 역할 | 토큰 경로 | 값 |
|------|---------|-----|
| 항목 레이블 | `textStyles.body` | SF Pro, 17pt, Regular |
| Destructive 항목 | `textStyles.body` (색상만 변경) | SF Pro, 17pt, Regular |

### 애니메이션 (`animations.json`)

| 역할 | 토큰 경로 | 값 |
|------|---------|-----|
| 등장 spring stiffness | `spring.contextMenu.stiffness` | `400` |
| 등장 spring damping | `spring.contextMenu.damping` | `38` |
| 등장 scale 시작 | `contextMenu.scaleFrom` | `0.8` |
| 등장 scale 끝 | `contextMenu.scaleTo` | `1.0` |
| 닫힘 방향 | 등장 애니메이션의 역방향 | — |

---

## 7. 애니메이션 상세

### 등장 (Presentation)

```
타임라인:
  0ms    → long press 인식 (햅틱 피드백: UIImpactFeedbackGenerator, .medium)
  0ms    → scale 0.8 + opacity 0.0 상태로 시작
  0~300ms → scale 1.0 + opacity 1.0 (spring: stiffness 400, damping 38)
  0ms    → dimming overlay 블러 동시 시작 (opacity 0→1, duration 200ms)

효과:
  Preview: scale-up + fade-in (같은 spring)
  메뉴 카드: scale-up + fade-in (살짝 지연, delay 30ms)
```

### 닫힘 (Dismissal)

```
타임라인:
  0ms    → 닫기 트리거 (외부 탭 / 액션 선택 / 스와이프 다운)
  0~200ms → scale 0.8 + opacity 0.0 (easeIn curve, 등장의 역방향)
  0~150ms → dimming overlay 블러 해제 (동시 진행)
```

### 서브메뉴 전환

```
타임라인:
  0ms    → 서브메뉴 항목 탭
  0~200ms → 현재 메뉴 카드 → 왼쪽으로 슬라이드 아웃 (translationX -30pt + fade)
  0~200ms → 서브메뉴 카드 → 오른쪽에서 슬라이드 인 (translationX 30pt→0 + fade)
```

---

## 8. 접근성 (Accessibility)

| 항목 | 구현 방법 |
|------|----------|
| **VoiceOver** | 메뉴 열릴 때 "Context menu, N options" 읽기 |
| **항목 접근** | 각 항목 `accessibilityLabel` 설정 필수 |
| **Destructive** | "Destructive action" 접미사 자동 추가 (UIAccessibility) |
| **서브메뉴** | "Submenu, double-tap to open" 힌트 제공 |
| **닫기** | 두 손가락 스크럽 제스처로 닫기 가능 |
| **UIMenu** | 자동으로 `UIMenu` 의미론적 역할 부여 |

---

## 9. 플랫폼별 구현

### UIKit

```swift
// UIContextMenuInteraction 설정
let interaction = UIContextMenuInteraction(delegate: self)
view.addInteraction(interaction)

// UIContextMenuInteractionDelegate 구현
extension MyViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(
        _ interaction: UIContextMenuInteraction,
        configurationForMenuAtLocation location: CGPoint
    ) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: {
                // nil = 기본 미리보기 (탭한 뷰 사용)
                // 커스텀 뷰컨트롤러 반환 가능
                return nil
            },
            actionProvider: { _ in
                // UIMenu 구성
                let shareAction = UIAction(
                    title: "공유",
                    image: UIImage(systemName: "square.and.arrow.up")
                ) { _ in
                    // 액션 처리
                }

                let deleteAction = UIAction(
                    title: "삭제",
                    image: UIImage(systemName: "trash"),
                    attributes: .destructive  // 자동으로 빨간색 적용
                ) { _ in
                    // 삭제 처리
                }

                // 서브메뉴 예시
                let moreMenu = UIMenu(
                    title: "더 보기",
                    children: [
                        UIAction(title: "복사", image: UIImage(systemName: "doc.on.doc")) { _ in },
                        UIAction(title: "즐겨찾기", image: UIImage(systemName: "star")) { _ in }
                    ]
                )

                return UIMenu(children: [shareAction, moreMenu, deleteAction])
            }
        )
    }
}
```

### SwiftUI

```swift
// .contextMenu 모디파이어 사용
Text("길게 누르세요")
    .contextMenu {
        // 기본 항목
        Button {
            shareItem()
        } label: {
            Label("공유", systemImage: "square.and.arrow.up")
        }

        // 서브메뉴
        Menu("더 보기") {
            Button("복사") { copyItem() }
            Button("즐겨찾기") { favoriteItem() }
        }

        // Destructive 항목
        Button(role: .destructive) {
            deleteItem()
        } label: {
            Label("삭제", systemImage: "trash")
        }
    } preview: {
        // 커스텀 미리보기 (선택 사항)
        ItemPreviewView(item: item)
            .frame(width: 280, height: 180)
    }

// iOS 16+: primaryAction + contextMenu 조합
Image(systemName: "photo")
    .contextMenu(menuItems: {
        Button("저장") { saveImage() }
    }, preview: {
        Image(systemName: "photo.fill")
            .resizable()
            .frame(width: 200, height: 200)
    })
```

### Flutter

```dart
// GestureDetector + showMenu 조합 (커스텀 구현)
GestureDetector(
  onLongPressStart: (details) async {
    // 햅틱 피드백
    HapticFeedback.mediumImpact();

    final result = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx + 1,
        details.globalPosition.dy + 1,
      ),
      // 메뉴 스타일 (Liquid Glass 근사)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      elevation: 8,
      items: [
        PopupMenuItem<String>(
          value: 'share',
          height: 44,
          child: Row(
            children: [
              Icon(CupertinoIcons.share, size: 20),
              SizedBox(width: 12),
              Text('공유', style: TextStyle(fontSize: 17)),
            ],
          ),
        ),
        PopupMenuDivider(height: 1),
        PopupMenuItem<String>(
          value: 'delete',
          height: 44,
          child: Row(
            children: [
              Icon(CupertinoIcons.trash, size: 20, color: CupertinoColors.systemRed),
              SizedBox(width: 12),
              Text('삭제', style: TextStyle(fontSize: 17, color: CupertinoColors.systemRed)),
            ],
          ),
        ),
      ],
    );

    if (result != null) {
      _handleMenuAction(result);
    }
  },
  child: widget,
)

// iOS 네이티브에 가까운 구현이 필요하면 cupertino_context_menu 패키지 사용
// CupertinoContextMenu(actions: [...], child: ...)
```

### Svelte (웹, @floating-ui 기반)

```svelte
<script>
  import { computePosition, flip, shift, offset } from '@floating-ui/dom';

  let menuVisible = false;
  let menuX = 0;
  let menuY = 0;
  let triggerEl;
  let menuEl;
  let longPressTimer;

  function handlePointerDown(e) {
    longPressTimer = setTimeout(async () => {
      menuVisible = true;
      await tick();

      const { x, y } = await computePosition(triggerEl, menuEl, {
        placement: 'bottom-start',
        middleware: [
          offset(8),
          flip(),
          shift({ padding: 16 }),
        ],
      });

      menuX = x;
      menuY = y;
    }, 500); // 500ms long press
  }

  function handlePointerUp() {
    clearTimeout(longPressTimer);
  }

  function closeMenu() {
    menuVisible = false;
  }

  const menuItems = [
    { label: '공유', icon: 'share', action: () => share() },
    { label: '복사', icon: 'copy', action: () => copy() },
    { divider: true },
    { label: '삭제', icon: 'trash', destructive: true, action: () => deleteItem() },
  ];
</script>

<!-- 트리거 -->
<div
  bind:this={triggerEl}
  on:pointerdown={handlePointerDown}
  on:pointerup={handlePointerUp}
  on:pointercancel={handlePointerUp}
>
  {#if $$slots.default}
    <slot />
  {/if}
</div>

<!-- 딤 오버레이 -->
{#if menuVisible}
  <div
    class="fixed inset-0 z-40 backdrop-blur-sm"
    on:click={closeMenu}
    transition:fade={{ duration: 200 }}
  />
{/if}

<!-- 메뉴 카드 -->
{#if menuVisible}
  <div
    bind:this={menuEl}
    class="context-menu"
    style="left: {menuX}px; top: {menuY}px;"
    transition:scale={{ start: 0.8, duration: 300, easing: cubicOut }}
  >
    {#each menuItems as item}
      {#if item.divider}
        <hr class="menu-divider" />
      {:else}
        <button
          class="menu-item"
          class:destructive={item.destructive}
          on:click={() => { item.action(); closeMenu(); }}
        >
          <span class="menu-icon">{item.icon}</span>
          <span class="menu-label">{item.label}</span>
        </button>
      {/if}
    {/each}
  </div>
{/if}

<style>
  .context-menu {
    position: fixed;
    z-index: 50;
    width: 250px;
    background: rgba(255, 255, 255, 0.72);
    backdrop-filter: blur(20px) saturate(180%);
    -webkit-backdrop-filter: blur(20px) saturate(180%);
    border-radius: 13px;
    overflow: hidden;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
  }

  .menu-item {
    display: flex;
    align-items: center;
    width: 100%;
    height: 44px;
    padding: 0 16px;
    gap: 12px;
    background: none;
    border: none;
    cursor: pointer;
    font-size: 17px;
    color: var(--color-label-primary);
    text-align: left;
  }

  .menu-item:hover {
    background: rgba(0, 0, 0, 0.05);
  }

  .menu-item.destructive {
    color: #FF3B30;
  }

  .menu-divider {
    height: 1px;
    background: rgba(60, 60, 67, 0.29);
    border: none;
    margin: 0;
  }
</style>
```

---

## 10. 체크리스트

### 구현 전 확인

- [ ] `UIContextMenuInteraction` 또는 `.contextMenu { }` 사용 확인
- [ ] 미리보기 필요 여부 결정 (previewProvider nil vs 커스텀)
- [ ] Destructive 항목에 `attributes: .destructive` / `role: .destructive` 설정
- [ ] 서브메뉴 깊이 2단계 이내

### 디자인 확인

- [ ] 메뉴 카드 너비 250pt 준수
- [ ] 각 항목 높이 44pt (터치 타겟 44×44pt 충족)
- [ ] 섹션 구분선 1px (`Colors/Separator/Opaque`)
- [ ] Liquid Glass 배경 (`materials.json` > `glass.menu`)
- [ ] Destructive 항목 색상 `Colors/System/Red`

### 애니메이션 확인

- [ ] 등장: scale 0.8→1.0, spring stiffness 400 / damping 38
- [ ] 닫힘: 등장의 역방향 (200ms)
- [ ] 햅틱 피드백 (long press 인식 시)

### 접근성 확인

- [ ] VoiceOver에서 메뉴 항목 순서대로 탐색 가능
- [ ] 각 항목 `accessibilityLabel` 명시적 설정
- [ ] Destructive 항목 VoiceOver 힌트 포함
- [ ] 두 손가락 스크럽으로 닫기 가능

---

## 11. 주의사항 및 엣지 케이스

| 케이스 | 처리 방법 |
|--------|----------|
| **항목 5개 초과** | 메뉴 카드 내 스크롤 활성화, 최대 높이 제한 |
| **화면 경계 근처 트리거** | 시스템이 자동으로 위/아래 위치 결정 |
| **빠른 연속 long press** | 이전 메뉴 닫힘 애니메이션 완료 후 새 메뉴 등장 |
| **텍스트 선택과 충돌** | `UITextView` 기본 context menu 오버라이드 주의 |
| **Dynamic Type** | 레이블 크기 변경 시 항목 높이 자동 조정 (44pt 최소) |
| **Dark Mode** | Liquid Glass가 자동으로 light/dark 모드 대응 |
