# List Row — iOS 26 컴포넌트 스펙

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="550:50430")`

---

## 1. Overview

iOS 26 List Row는 `UITableView` / `UICollectionView` / SwiftUI `List`에서 사용하는 표준 목록 행 컴포넌트다. 텍스트, 이미지, accessory를 조합하며, Swipe Actions와 Header를 포함한 완전한 리스트 시스템을 구성한다. iOS 26에서는 insetGrouped 리스트 배경에 Liquid Glass 소재 처리가 추가됐다.

| 항목 | 값 |
|------|-----|
| **Figma Node (Row)** | `550:50430` — COMPONENT_SET, 2 variants |
| **Figma Node (Row-Button)** | `550:49677` — COMPONENT_SET, 3 variants |
| **Figma Node (Row with Swipe Actions)** | `550:49969` — COMPONENT_SET, 4 variants |
| **Figma Node (Header)** | `517:38042` — COMPONENT_SET, 3 variants |
| **Figma Node (Index Bar)** | `48:56457` — COMPONENT_SET, 2 variants |
| **섹션 그룹** | `507:24675` — Lists |

### 내부 컴포넌트 (Private)

| 컴포넌트 | Figma Node | Variants | 설명 |
|---------|-----------|----------|------|
| _Trailing | `212:117586` | 9 | 후행 accessory (Toggle, Disclosure, Button 등) |
| _Images/Regular | `24:55973` | 4 | Regular 행 선행 이미지 (Symbol/Rounded/Circular/Fill) |
| _Images/Tall | `508:72799` | 4 | Tall 행 선행 이미지 (더 큰 크기) |
| _Separator | `5469:7924` | 2 | 행 구분선 (Light/Dark, 0.5px) |
| _Edit Buttons/Light | `20:60364` | 4 | 편집 버튼 (Remove/Add/Selected/Unselected) |
| _Swipe Actions/Large | `27:68008` | 1 | 전체 너비 스와이프 액션 |
| _Swipe Actions/Small | `27:68007` | 2 | 축소 스와이프 액션 버튼 |
| _Grabber | `5533:12351` | 1 | 재정렬 핸들 |
| _Header Trailing | `39:67340` | 4 | 헤더 후행 요소 |

---

## 2. Dimensions

### Row 높이 기준

| 높이 타입 | 높이 | 사용 케이스 |
|----------|------|-----------|
| **Small** | **36pt** | 단순 텍스트 행, 설정 목록 |
| **Regular** | **44pt** | 표준 목록 행 ← **기본값** (Apple HIG minimum) |
| **Large (Tall)** | **58pt** | 이미지/아이콘 포함 행, 연락처 목록 |
| **Extra Tall** | **68pt** | Figma Tall variant (`_Images/Tall` 기준) |

> `spacing.components.listRow.heightSmall` = 36, `.heightRegular` = 44, `.heightLarge` = 58

### Padding 및 Inset

| 속성 | 값 | 토큰 |
|------|-----|------|
| **Padding Horizontal** | 16pt | `spacing.components.listRow.paddingHorizontal` |
| **Padding Vertical** | 11pt | `spacing.components.listRow.paddingVertical` |
| **Separator Inset (Leading)** | 16pt | `spacing.components.listRow.separatorInset` |
| **Separator Inset (이미지 있을 때)** | 56~76pt | 이미지 오른쪽 끝 + 16pt |
| **Item Gap (leading icon → 텍스트)** | 16pt | `spacing.inset.md` |
| **Item Gap (텍스트 → trailing)** | 8pt | `spacing.inset.xs` |

### 이미지 크기 (_Images 컴포넌트)

**Regular 행 이미지 (`24:55973`)**:

| Type | 크기 |
|------|------|
| Symbol | 28×20pt |
| Rounded | 30×30pt |
| Circular | 42×42pt |
| Fill | 52×52pt |

**Tall 행 이미지 (`508:72799`)**:

| Type | 크기 |
|------|------|
| Symbol | 28×20pt |
| Rounded | 44×44pt |
| Circular | 60×60pt |
| Fill | 68×68pt |

---

## 3. Variants 표

### Row (`550:50430`) — 2 variants

| Variant | Child ID | 높이 | 설명 |
|---------|---------|------|------|
| Height=Tall | child 1 | 68pt | Tall row — 큰 이미지/아이콘 포함 |
| Height=Regular | child 2 | 44pt | Regular row — 표준 목록 행 |

### Row - Button (`550:49677`) — 3 variants

| Variant | Child ID | 설명 |
|---------|---------|------|
| Value=Default | child 1 | 표준 탭 가능 행. 파란색 타이틀. |
| Value=Destructive | child 2 | 빨간색 destructive 행 (삭제 등) |
| Value=Disabled | child 3 | 비활성화 행. 회색 텍스트. |

### Row with Swipe Actions (`550:49969`) — 4 variants

| Variant | Child ID | 높이 | 스와이프 방향 |
|---------|---------|------|------------|
| Height=Tall, Swipe=Left | child 1 | 68pt | 왼쪽으로 스와이프 (trailing actions 노출) |
| Height=Tall, Swipe=Right | child 2 | 68pt | 오른쪽으로 스와이프 (leading actions 노출) |
| Height=Regular, Swipe=Left | child 3 | 44pt | 왼쪽으로 스와이프 (trailing actions 노출) |
| Height=Regular, Swipe=Right | child 4 | 44pt | 오른쪽으로 스와이프 (leading actions 노출) |

### Header (`517:38042`) — 3 variants

| Variant | Child ID | 설명 |
|---------|---------|------|
| Type=Extra Prominent | child 1 | 가장 큰 섹션 헤더. `title3` Semibold (20pt). |
| Type=Prominent | child 2 | 표준 섹션 헤더. `headline` Semibold (17pt). |
| Type=Nested | child 3 | 중첩/서브섹션 헤더. `footnote` Semibold (13pt). |

### Index Bar (`48:56457`) — 2 variants

| Variant | Child ID | 설명 |
|---------|---------|------|
| Device=iPhone | child 1 | 오른쪽 가장자리 알파벳/숫자 인덱스 바 |
| Device=iPad | child 2 | iPad 너비의 인덱스 바 |

### _Trailing (`212:117586`) — 9 variants

| Type | 설명 | 대표 크기 |
|------|------|---------|
| Pop-up | 팝업 메뉴 트리거 | 44pt min |
| Button | 인라인 액션 버튼 | 44pt min |
| Stepper | 증가/감소 스텝퍼 | 94×29pt |
| Picker-Date | 날짜 선택 트리거 | 44pt min |
| Picker-Time | 시간 선택 트리거 | 44pt min |
| Picker-DateTime | 날짜+시간 트리거 | 44pt min |
| Toggle | 토글 스위치 | 51×31pt |
| Disclosure | 꺾쇠(›) 인디케이터 | 44pt 터치 영역 |
| (+1 more) | 추가 trailing 타입 | — |

---

## 4. 색상 토큰 매핑

### Row 텍스트 색상

| 요소 | 토큰 | Light | Dark |
|------|------|-------|------|
| **Primary Title** | `labels.primary` | `#000000` (alpha 1) | `#ffffff` (alpha 1) |
| **Subtitle / Detail** | `labels.secondary` | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.7)` |
| **Tertiary Text** | `labels.tertiary` | `rgba(60,60,67,0.3)` | `rgba(235,235,245,0.3)` |
| **Disabled Text** | `labels.quaternary` | `rgba(60,60,67,0.18)` | `rgba(235,235,245,0.16)` |
| **Button Row (Default)** | `accents.blue` | `#0088ff` | `#0091ff` |
| **Button Row (Destructive)** | `accents.red` | `#ff383c` | `#ff4245` |
| **Button Row (Disabled)** | `labels.tertiary` | `rgba(60,60,67,0.3)` | `rgba(235,235,245,0.3)` |

### Row 배경 색상

| 상태 | 토큰 | Light | Dark |
|------|------|-------|------|
| **기본 배경 (Plain)** | `backgrounds.secondary` | `#f2f2f7` | `#1c1c1e` |
| **Grouped Cell 배경** | `backgroundsGrouped.secondary` | `#ffffff` | `#1c1c1e` |
| **Highlighted (눌림)** | `fills.tertiary` | `rgba(118,118,128,0.12)` | `rgba(118,118,128,0.24)` |
| **Selected** | `fills.secondary` | `rgba(120,120,128,0.16)` | `rgba(120,120,128,0.32)` |

### Swipe Actions 배경

| 액션 타입 | 토큰 | Light | Dark |
|---------|------|-------|------|
| **일반 액션 배경** | `fills.quaternary` | `rgba(116,116,128,0.08)` | `rgba(118,118,128,0.18)` |
| **Destructive 액션** | `accents.red` | `#ff383c` | `#ff4245` |
| **Info 액션** | `accents.blue` | `#0088ff` | `#0091ff` |

### Separator

| 상태 | 토큰 | Light | Dark |
|------|------|-------|------|
| **Opaque** | `separators.opaque` | `#c6c6c8` | `#38383a` |
| **Non-Opaque** | `separators.nonOpaque` | `rgba(0,0,0,0.12)` | `rgba(255,255,255,0.17)` |

### Header 텍스트

| 타입 | 토큰 | Light | Dark |
|------|------|-------|------|
| Extra Prominent 타이틀 | `labels.primary` | `#000000` | `#ffffff` |
| Prominent 타이틀 | `labels.secondary` | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.7)` |
| Nested 타이틀 | `labels.tertiary` | `rgba(60,60,67,0.3)` | `rgba(235,235,245,0.3)` |
| Header Action 버튼 | `accents.blue` | `#0088ff` | `#0091ff` |

---

## 5. 타이포그래피 매핑

| 요소 | 스타일 | fontSize | weight | letterSpacing | lineHeight |
|------|--------|----------|--------|---------------|------------|
| **Row Primary Title** | `body` Regular | 17pt | Regular (400) | -0.43 | 22 |
| **Row Primary Title (Emphasized)** | `body` Semibold | 17pt | Semibold (600) | -0.43 | 22 |
| **Row Subtitle / Detail** | `subheadline` Regular | 15pt | Regular (400) | -0.23 | 20 |
| **Row Secondary Detail** | `footnote` Regular | 13pt | Regular (400) | -0.08 | 18 |
| **Button Row Label** | `body` Regular | 17pt | Regular (400) | -0.43 | 22 |
| **Header (Extra Prominent)** | `title3` Semibold | 20pt | Semibold (600) | -0.45 | 25 |
| **Header (Prominent)** | `headline` Semibold | 17pt | Semibold (600) | -0.43 | 22 |
| **Header (Nested)** | `footnote` Semibold | 13pt | Semibold (600) | -0.08 | 18 |
| **Index Bar Letter** | `caption2` Semibold | 11pt | Semibold (600) | 0.06 | 13 |

> Dynamic Type 지원 필수. 모든 스타일은 시스템 텍스트 크기 변경을 반영해야 한다.

---

## 6. 상태 전환

### Row 인터랙션 상태

| 상태 | 배경 | 텍스트 | 시각 변화 |
|------|------|--------|---------|
| **Default** | 투명 or `backgroundsGrouped.secondary` | `labels.primary` | — |
| **Highlighted (누름)** | `fills.tertiary` | 동일 | 배경 즉시 표시 (0s) |
| **Selected** | `fills.secondary` | 동일 | 배경 유지 |
| **Editing (재정렬)** | 동일 | 동일 | Grabber 아이콘 표시 |
| **Swipe Left (trailing)** | Row가 왼쪽으로 이동 | 동일 | 빨간 Delete 버튼 등 노출 |
| **Swipe Right (leading)** | Row가 오른쪽으로 이동 | 동일 | Leading 액션 버튼 노출 |
| **Delete 확정** | Row 높이 0 → 사라짐 | — | 높이 collapse 0.25s |

### Row 삭제 애니메이션

```
삭제 확정 시:
1. Row 높이: 현재 높이 → 0pt (duration: 0.25s, easeIn)
2. Row opacity: 1 → 0 (duration: 0.2s, easeIn)
3. 아래 Row들: 삭제된 Row 높이만큼 위로 이동
   duration: 0.25s, appleEaseOut
4. Separator도 함께 사라짐
```

### Swipe 상태 전환

```
스와이프 시작:
  Row: translateX(0) → translateX(-actionWidth) (gesture-driven, 실시간)
  Action Buttons: 오른쪽에서 reveal (opacity 0 → 1)

Delete 풀 스와이프:
  Row: translateX(-screenWidth) (duration: 0.2s, easeIn)
  → 삭제 애니메이션 실행
```

---

## 7. 애니메이션 스펙

`animations.json → duration.semantic.listRowSwipe` = 0.2s

### Row Highlight (Tap Press)

```css
/* 즉각적인 피드백 (0s delay) */
.list-row {
  transition: background-color 0s;
}
.list-row:active {
  background-color: rgba(118, 118, 128, 0.12); /* fills.tertiary light */
  transition: background-color 0s;
}
/* 릴리즈 시 서서히 복귀 */
.list-row:not(:active) {
  transition: background-color 0.15s ease-out;
}
```

### Row 삽입/삭제 (Insert/Delete)

```css
/* 삽입 */
@keyframes rowInsert {
  from { height: 0; opacity: 0; padding-top: 0; padding-bottom: 0; }
  to   { height: var(--row-height, 44px); opacity: 1; }
}
.list-row--inserting {
  animation: rowInsert 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94); /* spring gentle */
}

/* 삭제 */
@keyframes rowDelete {
  from { height: var(--row-height, 44px); opacity: 1; }
  to   { height: 0; opacity: 0; padding-top: 0; padding-bottom: 0; }
}
.list-row--deleting {
  animation: rowDelete 0.25s cubic-bezier(0.42, 0, 1.0, 1.0) forwards; /* easeIn */
  overflow: hidden;
}
```

### Swipe 액션 노출

```css
.list-row-container {
  position: relative;
  overflow: hidden;
}

/* gesture-driven: JS로 실시간 transform 적용 */
.list-row {
  transition: transform 0.2s cubic-bezier(0.0, 0, 0.6, 1.0); /* snap back */
}

.swipe-actions {
  position: absolute;
  right: 0; top: 0; height: 100%;
  display: flex; align-items: stretch;
}

.swipe-action-btn {
  width: 80px;
  display: flex; align-items: center; justify-content: center;
  color: white; font-size: 15px; font-weight: 600;
  transition: width 0.2s cubic-bezier(0.0, 0, 0.6, 1.0);
}
/* 풀 스와이프 시 전체 너비로 확장 */
.swipe-action-btn.full-swipe { width: 100vw; }
```

### 재정렬 (Reorder)

```css
.list-row--dragging {
  z-index: 10;
  transform: scale(1.03);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
  transition:
    transform 0.2s cubic-bezier(0.34, 1.56, 0.64, 1.0),
    box-shadow 0.2s ease-out;
}
```

---

## 8. 접근성

| 항목 | 요구사항 |
|------|---------|
| **최소 터치 타겟** | 44×44pt — Small(36pt) 행도 터치 영역은 44pt 이상 보장 |
| **ARIA role** | `role="listitem"` (HTML list 내), `role="button"` (탭 가능 행) |
| **Swipe Actions** | VoiceOver에서 swipe action 대안 수단 제공 필수 (액션 버튼 직접 노출 or context menu) |
| **Disclosure Indicator** | "자세히 보기" aria-label 또는 네비게이션 목적 명시 |
| **Destructive Row** | `aria-label`에 위험성 명시. 예: `aria-label="계정 삭제 (되돌릴 수 없음)"` |
| **색상 대비** | Primary `labels.primary` → 대비 충족. Secondary `labels.secondary` (60% opacity) → 보조 정보로 허용 |
| **편집 모드 재정렬** | VoiceOver: "재정렬 핸들" 레이블 + 상하 이동 Accessibility Action 제공 |
| **Toggle Trailing** | `role="switch"`, `aria-checked` 상태 반영 |
| **Dynamic Type** | 모든 텍스트 스타일 Dynamic Type 지원 필수 |
| **감소된 모션** | Swipe, Insert/Delete, Reorder 애니메이션 즉시 전환 (`prefers-reduced-motion: reduce`) |

---

## 9. 프레임워크 구현 참고

### Svelte 5 (웹/Tauri)

```svelte
<script lang="ts">
  interface ListRowProps {
    title: string;
    subtitle?: string;
    detail?: string;
    height?: 'small' | 'regular' | 'large';
    leadingImage?: { src: string; alt: string; shape?: 'rounded' | 'circular'; size?: number };
    trailing?: 'disclosure' | 'toggle' | 'button' | 'none';
    trailingValue?: boolean;
    trailingLabel?: string;
    destructive?: boolean;
    disabled?: boolean;
    onclick?: () => void;
  }

  let {
    title, subtitle, detail,
    height = 'regular',
    leadingImage, trailing = 'none',
    trailingValue = false, trailingLabel,
    destructive = false, disabled = false,
    onclick
  }: ListRowProps = $props();

  const heightMap = { small: 36, regular: 44, large: 58 };
</script>

<div class="list-row-wrapper">
  <div
    class="list-row list-row--{height}"
    class:list-row--destructive={destructive}
    class:list-row--disabled={disabled}
    role={onclick ? 'button' : 'listitem'}
    tabindex={onclick ? 0 : -1}
    aria-disabled={disabled}
    onclick={disabled ? undefined : onclick}
    onkeydown={(e) => { if ((e.key === 'Enter' || e.key === ' ') && onclick && !disabled) onclick(); }}
  >
    <!-- Leading Image -->
    {#if leadingImage}
      <div
        class="leading-image"
        style="
          width: {leadingImage.size ?? (height === 'large' ? 60 : 42)}px;
          height: {leadingImage.size ?? (height === 'large' ? 60 : 42)}px;
          border-radius: {leadingImage.shape === 'rounded' ? '8px' : '50%'};
        "
      >
        <img src={leadingImage.src} alt={leadingImage.alt} />
      </div>
    {/if}

    <!-- Text Content -->
    <div class="row-content">
      <span class="row-title">{title}</span>
      {#if subtitle}
        <span class="row-subtitle">{subtitle}</span>
      {/if}
    </div>

    <!-- Detail -->
    {#if detail}
      <span class="row-detail">{detail}</span>
    {/if}

    <!-- Trailing -->
    <div class="row-trailing">
      {#if trailing === 'disclosure'}
        <span class="disclosure" aria-hidden="true">›</span>
      {:else if trailing === 'toggle'}
        <input
          type="checkbox"
          role="switch"
          checked={trailingValue}
          aria-label={trailingLabel}
          onchange={onclick}
        />
      {:else if trailing === 'button'}
        <button class="trailing-btn" onclick|stopPropagation={onclick} aria-label={trailingLabel}>
          {trailingLabel}
        </button>
      {/if}
    </div>
  </div>

  <!-- Separator -->
  <div class="separator" role="separator" aria-hidden="true"></div>
</div>

<style>
  .list-row-wrapper { background: #fff; } /* backgroundsGrouped.secondary light */

  .list-row {
    display: flex; align-items: center;
    min-height: 44px; padding: 11px 16px; gap: 16px;
    background: transparent;
    transition: background-color 0s;
    cursor: pointer;
  }
  .list-row[role="listitem"] { cursor: default; }
  .list-row:active:not(.list-row--disabled) {
    background: rgba(118, 118, 128, 0.12); /* fills.tertiary */
  }
  .list-row--small { min-height: 36px; }
  .list-row--large { min-height: 58px; }
  .list-row--disabled { opacity: 0.4; pointer-events: none; }
  .list-row:focus-visible { outline: 2px solid #0088ff; outline-offset: -2px; }

  .leading-image { flex-shrink: 0; overflow: hidden; }
  .leading-image img { width: 100%; height: 100%; object-fit: cover; }

  .row-content { flex: 1; display: flex; flex-direction: column; gap: 2px; min-width: 0; }

  .row-title {
    font-size: 17px; font-weight: 400; letter-spacing: -0.43px;
    color: #000; /* labels.primary */
    white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
  }
  .list-row--destructive .row-title { color: #ff383c; } /* accents.red */

  .row-subtitle {
    font-size: 15px; font-weight: 400; letter-spacing: -0.23px; line-height: 20px;
    color: rgba(60, 60, 67, 0.6); /* labels.secondary */
  }

  .row-detail {
    font-size: 15px; letter-spacing: -0.23px;
    color: rgba(60, 60, 67, 0.6);
    flex-shrink: 0;
  }

  .row-trailing { display: flex; align-items: center; min-width: 44px; min-height: 44px; justify-content: flex-end; }

  .disclosure { color: rgba(60, 60, 67, 0.3); font-size: 20px; line-height: 1; }

  .trailing-btn {
    color: #0088ff; font-size: 17px;
    min-height: 44px; padding: 0 4px;
  }

  .separator {
    height: 0.5px;
    background: rgba(0, 0, 0, 0.12); /* separators.nonOpaque */
    margin-left: 16px; /* separatorInset */
  }

  @media (prefers-color-scheme: dark) {
    .list-row-wrapper { background: #1c1c1e; }
    .list-row:active:not(.list-row--disabled) { background: rgba(118,118,128,0.24); }
    .row-title  { color: #fff; }
    .list-row--destructive .row-title { color: #ff4245; }
    .row-subtitle, .row-detail { color: rgba(235,235,245,0.7); }
    .disclosure { color: rgba(235,235,245,0.3); }
    .trailing-btn { color: #0091ff; }
    .separator { background: rgba(255,255,255,0.17); }
  }

  @media (prefers-reduced-motion: reduce) {
    .list-row { transition: none; }
  }
</style>
```

### Header 컴포넌트 (Svelte 5)

```svelte
<script lang="ts">
  let {
    type = 'prominent',
    title,
    actionLabel,
    onaction
  }: { type?: 'extra-prominent' | 'prominent' | 'nested'; title: string; actionLabel?: string; onaction?: () => void } = $props();
</script>

<div class="list-header list-header--{type}" role="rowgroup">
  <span class="header-title">{title}</span>
  {#if actionLabel}
    <button class="header-action" onclick={onaction}>{actionLabel}</button>
  {/if}
</div>

<style>
  .list-header {
    display: flex; align-items: flex-end; justify-content: space-between;
    padding: 20px 16px 6px;
    font-family: -apple-system, system-ui, sans-serif;
  }
  .list-header--extra-prominent .header-title {
    font-size: 20px; font-weight: 600; letter-spacing: -0.45px; color: #000;
  }
  .list-header--prominent .header-title {
    font-size: 13px; font-weight: 600; letter-spacing: -0.08px;
    color: rgba(60,60,67,0.6); text-transform: uppercase;
  }
  .list-header--nested .header-title {
    font-size: 13px; font-weight: 400; letter-spacing: -0.08px; color: rgba(60,60,67,0.3);
  }
  .header-action {
    font-size: 17px; color: #0088ff; min-height: 44px; padding: 0 4px;
  }
  @media (prefers-color-scheme: dark) {
    .list-header--extra-prominent .header-title { color: #fff; }
    .list-header--prominent .header-title       { color: rgba(235,235,245,0.7); }
    .list-header--nested .header-title          { color: rgba(235,235,245,0.3); }
    .header-action { color: #0091ff; }
  }
</style>
```

### Flutter

```dart
// iOS 26 스타일 List Row
class IOSListRow extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? detail;
  final double rowHeight;
  final Widget? leadingImage;
  final bool showDisclosure;
  final bool destructive;
  final bool disabled;
  final VoidCallback? onTap;

  const IOSListRow({
    required this.title,
    this.subtitle, this.detail,
    this.rowHeight = 44,
    this.leadingImage,
    this.showDisclosure = false,
    this.destructive = false,
    this.disabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Semantics(
      button: onTap != null,
      enabled: !disabled,
      child: Material(
        color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        child: InkWell(
          onTap: disabled ? null : onTap,
          splashColor: Colors.grey.withOpacity(isDark ? 0.24 : 0.12),
          highlightColor: Colors.grey.withOpacity(isDark ? 0.24 : 0.12),
          child: Opacity(
            opacity: disabled ? 0.4 : 1.0,
            child: Container(
              constraints: BoxConstraints(minHeight: rowHeight, minWidth: double.infinity),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              child: Row(
                children: [
                  if (leadingImage != null) ...[leadingImage!, const SizedBox(width: 16)],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(title,
                          style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: -0.43,
                            color: destructive
                              ? (isDark ? const Color(0xFFFF4245) : const Color(0xFFFF383C))
                              : (isDark ? Colors.white : Colors.black),
                          )),
                        if (subtitle != null)
                          Text(subtitle!,
                            style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: -0.23,
                              color: isDark ? const Color(0xFFEBEBF5).withOpacity(0.7)
                                           : const Color(0xFF3C3C43).withOpacity(0.6),
                            )),
                      ],
                    ),
                  ),
                  if (detail != null) ...[
                    const SizedBox(width: 8),
                    Text(detail!,
                      style: TextStyle(fontSize: 15, letterSpacing: -0.23,
                        color: isDark ? const Color(0xFFEBEBF5).withOpacity(0.7)
                                      : const Color(0xFF3C3C43).withOpacity(0.6))),
                  ],
                  if (showDisclosure) ...[
                    const SizedBox(width: 4),
                    Icon(CupertinoIcons.chevron_right, size: 14,
                      color: isDark ? const Color(0xFFEBEBF5).withOpacity(0.3)
                                    : const Color(0xFF3C3C43).withOpacity(0.3)),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

### SwiftUI (참고용)

```swift
// iOS 26 List with full features
List {
  Section {
    // 표준 행
    HStack {
      // Leading image (Circular 60pt for Tall)
      AsyncImage(url: item.imageURL)
        .frame(width: 60, height: 60)
        .clipShape(Circle())

      VStack(alignment: .leading, spacing: 2) {
        Text(item.title)
          .font(.body) // 17pt Regular, labels.primary
        Text(item.subtitle)
          .font(.subheadline) // 15pt Regular, labels.secondary
          .foregroundStyle(.secondary)
      }
      Spacer()
      Text(item.detail)
        .foregroundStyle(.secondary)
      Image(systemName: "chevron.right")
        .foregroundStyle(.tertiary)
        .imageScale(.small)
    }
    .frame(minHeight: 44) // 최소 터치 타겟
    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
      Button(role: .destructive) { delete(item) } label: {
        Label("삭제", systemImage: "trash")
      }
      Button { archive(item) } label: {
        Label("보관", systemImage: "archivebox")
      }
      .tint(.blue)
    }

    // Row-Button (Destructive)
    Button(role: .destructive) { deleteAccount() } label: {
      Text("계정 삭제")
    }
  } header: {
    // Extra Prominent Header
    Text("섹션")
      .font(.title3) // 20pt Semibold
      .textCase(nil)
  } footer: {
    Text("추가 설명")
      .font(.footnote) // 13pt Regular
      .foregroundStyle(.secondary)
  }
}
.listStyle(.insetGrouped)
// iOS 26: Liquid Glass 배경 자동 적용
```

---

## 추가 Variants (보강)

### Row - Button (`550:49677`, 3 variants)
- List row가 전체 버튼인 경우 (탭 전체 영역 = 버튼)
- 배경 탭 highlight: `Colors/System/Fill/Tertiary`
- 3 variants: Default / Pressed / Disabled

### Row with Swipe Actions (`550:49969`, 4 variants)
- 좌우 스와이프로 액션 버튼 노출
- Leading swipe: 초록/파랑 계열 (긍정적 액션)
- Trailing swipe: 빨간 계열 (삭제 등)
- 스와이프 버튼 높이 = 행 높이 동일
- 4 variants: Leading Small / Leading Large / Trailing Small / Trailing Large
- Large = full swipe → 즉시 실행 (destructive)

### List Header (`517:38042`, 3 variants)
- Section 헤더 행
- 높이: 28pt (Plain), 38pt (Grouped Inset)
- 3 variants: Default / With Button / Editing

### Index Bar (`48:56457`, 2 variants)
- 알파벳 인덱스 바 (오른쪽 측면)
- 너비: 15pt, 각 인덱스 글자 간격 4pt
- 2 variants: Default / Pressed
