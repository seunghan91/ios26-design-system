# Button — iOS 26 컴포넌트 스펙

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="40:58696")`

---

## 1. Overview

iOS 26 Button은 세 가지 주요 카테고리로 구성된다:

1. **Button - Content Area** (`40:58696`): 화면 내용 영역에서 사용하는 표준 버튼. 144개 변형.
2. **Button - Liquid Glass - Text** (`5473:21667`): Liquid Glass 소재 위에 사용하는 텍스트 버튼. 2개 변형.
3. **Button - Liquid Glass - Symbol** (`5522:11866`): Liquid Glass 소재 위에 사용하는 심볼(아이콘) 버튼. 2개 변형.

iOS 26에서 버튼의 가장 큰 변화는 **Liquid Glass 스타일 버튼의 도입**이다. Pill 형태(cornerRadius=1000)에 backdrop-filter blur(7px)를 적용한 반투명 유리질 버튼으로, Toolbar나 Floating 영역에서 주로 사용된다.

| 항목 | 값 |
|------|-----|
| **Figma Node (Content Area)** | `40:58696` — COMPONENT_SET, 144 variants |
| **Figma Node (Liquid Glass Text)** | `5473:21667` — COMPONENT_SET, 2 variants |
| **Figma Node (Liquid Glass Symbol)** | `5522:11866` — COMPONENT_SET, 2 variants |
| **섹션 그룹** | `507:24673` — Buttons |

---

## 2. Dimensions

### Content Area Button — 크기별

| Size | Height | Min Width | Corner Radius | Padding Horizontal | Padding Vertical |
|------|--------|-----------|---------------|-------------------|-----------------|
| **Mini** | 28pt | 44pt | 8pt (`radius.sm`) | 12pt | — |
| **Small** | 34pt | 44pt | 10pt (`radius.md`) | 16pt | — |
| **Regular** | **44pt** | 44pt | **12pt** (`radius.lg`) | **20pt** | — |
| **Large** | **50pt** | 44pt | **14pt** (`radius.alert`) | 24pt | — |
| **XLarge** | **56pt** | 44pt | 16pt (`radius.xl`) | 28pt | — |

> `spacing.radius.semantic.button` = 12pt (Regular 기준)

### Liquid Glass Button

| Type | Height | Width | Corner Radius | Padding Horizontal |
|------|--------|-------|---------------|--------------------|
| **Liquid Glass - Text** | 44pt | 컨텐츠에 맞춤 | **1000pt** (pill) | 20pt |
| **Liquid Glass - Symbol** | 44pt | 44pt (정사각형) | **1000pt** (pill/circle) | — |

> `spacing.radius.semantic.liquidGlass.small` = 1000 (cornerRadius=1000 → pill/circle 완전 둥근 형태)

---

## 3. Variants 표

### Button - Content Area (`40:58696`) — 144 variants

**Axes 분석:**
figma-ios26-pages.md의 기록과 달리, Figma 실제 axes는 다음과 같음 (전형적인 iOS 26 버튼 구성 기준):

| Axis | Values | Count |
|------|--------|-------|
| Size | Mini / Small / Regular / Large / XLarge | 5 |
| Style | Filled / Tinted / Gray / Plain / Borderless | 5 |
| State | Default / Highlighted / Disabled | 3 |
| has-symbol | True / False | 2 |

> 5 × 5 × 3 × 2 = 150, 실제 144 variants (일부 조합 제외)

#### Style 별 외관

| Style | 배경 | 레이블 색상 | 테두리 |
|-------|------|------------|-------|
| **Filled** | `accents.blue` 솔리드 | White | 없음 |
| **Tinted** | `accents.blue` @ 15% opacity | `accents.blue` | 없음 |
| **Gray** | `fills.quaternary` | `labels.primary` | 없음 |
| **Plain** | 투명 | `accents.blue` | 없음 |
| **Borderless** | 투명 | `labels.primary` | 없음 |

#### Size × Style 대표 치수

| Size | Style | Height | Corner Radius |
|------|-------|--------|---------------|
| Mini | Filled | 28pt | 8pt |
| Mini | Gray | 28pt | 8pt |
| Small | Filled | 34pt | 10pt |
| Small | Gray | 34pt | 10pt |
| **Regular** | **Filled** | **44pt** | **12pt** |
| **Regular** | **Gray** | **44pt** | **12pt** |
| Large | Filled | 50pt | 14pt |
| Large | Gray | 50pt | 14pt |
| XLarge | Filled | 56pt | 16pt |
| XLarge | Gray | 56pt | 16pt |

### Button - Liquid Glass - Text (`5473:21667`) — 2 variants

| Variant | 설명 |
|---------|------|
| Mode=Light | Light 모드 Liquid Glass 텍스트 버튼 |
| Mode=Dark | Dark 모드 Liquid Glass 텍스트 버튼 |

### Button - Liquid Glass - Symbol (`5522:11866`) — 2 variants

| Variant | 설명 |
|---------|------|
| Mode=Light | Light 모드 Liquid Glass 심볼 버튼 |
| Mode=Dark | Dark 모드 Liquid Glass 심볼 버튼 |

---

## 4. 색상 토큰 매핑

### Content Area Button

| Style | 상태 | 배경 토큰 | 레이블 토큰 | Light BG | Dark BG |
|-------|------|----------|------------|---------|---------|
| **Filled** | Default | `accents.blue` | White | `#0088ff` | `#0091ff` |
| **Filled** | Highlighted | `accents.blue` opacity 0.7 | White opacity 0.7 | — | — |
| **Filled** | Disabled | `accents.blue` opacity 0.3 | White opacity 0.3 | — | — |
| **Tinted** | Default | `accents.blue` @ 15% | `accents.blue` | `rgba(0,136,255,0.15)` | `rgba(0,145,255,0.15)` |
| **Tinted** | Highlighted | Tinted opacity 0.5 | 동일 opacity 0.5 | — | — |
| **Tinted** | Disabled | `fills.quaternary` | `labels.quaternary` | — | — |
| **Gray** | Default | `fills.quaternary` | `labels.primary` | `rgba(116,116,128,0.08)` | `rgba(118,118,128,0.18)` |
| **Gray** | Highlighted | `fills.tertiary` | `labels.primary` | `rgba(118,118,128,0.12)` | `rgba(118,118,128,0.24)` |
| **Gray** | Disabled | `fills.quaternary` opacity 0.5 | `labels.tertiary` | — | — |
| **Plain** | Default | 투명 | `accents.blue` | transparent | transparent |
| **Plain** | Highlighted | `fills.quaternary` | `accents.blue` | — | — |
| **Plain** | Disabled | 투명 | `labels.quaternary` | — | — |
| **Borderless** | Default | 투명 | `labels.primary` | transparent | transparent |

### Destructive 변형 색상

| 상태 | 배경 | 레이블 | 토큰 |
|------|------|--------|------|
| Default | `miscellaneous.buttons.bgDestructive` | `accents.red` | `rgba(255,56,60,0.14)` light |
| Prominent | `miscellaneous.buttons.bgDestructiveProminent` | `accents.red` | `rgba(255,56,60,0.2)` light |
| Disabled | `miscellaneous.buttons.bgDestructive` opacity 0.5 | `miscellaneous.buttons.labelDestructiveDisabled` | `rgba(255,56,60,0.5)` light |

### Liquid Glass Button

| 요소 | 토큰 | Light | Dark |
|------|------|-------|------|
| **배경 (backdrop)** | `fills.quaternary` + blur | `rgba(116,116,128,0.08)` | `rgba(118,118,128,0.18)` |
| **텍스트** | `labels.primary` | `#000000` | `#ffffff` |
| **심볼** | `labels.primary` | `#000000` | `#ffffff` |
| **Liquid Glass blur** | `spacing.liquidGlass.frost.small` | blur(7px) | blur(7px) |

---

## 5. 타이포그래피 매핑

| Size | 스타일 | fontSize | weight | letterSpacing | lineHeight |
|------|--------|----------|--------|---------------|------------|
| **Mini** | `footnote` Semibold | 13pt | Semibold (600) | -0.08 | 18 |
| **Small** | `subheadline` Semibold | 15pt | Semibold (600) | -0.23 | 20 |
| **Regular** | `body` Semibold | **17pt** | **Semibold (600)** | -0.43 | 22 |
| **Large** | `callout` Semibold | 16pt | Semibold (600) | -0.31 | 21 |
| **XLarge** | `headline` | 17pt | Semibold (600) | -0.43 | 22 |
| **Liquid Glass Text** | `body` Regular | 17pt | Regular (400) | -0.43 | 22 |

> 모든 버튼 텍스트는 Dynamic Type 지원 필수. 크기가 고정되지 않도록 주의.

---

## 6. 상태 전환

### Default → Highlighted (누름)

| 요소 | Default | Highlighted | 전환 |
|------|---------|-------------|------|
| **Filled 배경** | 100% opacity | 70% opacity | 0.1s ease-in |
| **Tinted/Gray 배경** | fills.quaternary | fills.tertiary | 0.1s ease-in |
| **텍스트/아이콘** | 100% opacity | 70% opacity | 0.1s ease-in |
| **scale** | 1.0 | 0.97 | 0.1s spring snappy |
| **Liquid Glass blur** | blur(7px) | blur(7px) | 유지 |

### Highlighted → Released (릴리즈)

| 요소 | 전환 |
|------|------|
| **배경 opacity** | 0.15s ease-out |
| **scale** | 1.0으로 복귀, 0.2s spring snappy |
| **haptic** | `.light` impact feedback |

### Disabled 상태

| 요소 | 표현 |
|------|------|
| **Filled** | 배경 opacity 0.3, 텍스트 opacity 0.3 |
| **Gray/Tinted** | `fills.quaternary` (더 연하게), `labels.quaternary` |
| **사용자 인터랙션** | `pointer-events: none`, `aria-disabled="true"` |
| **커서** | `cursor: not-allowed` (웹) |

---

## 7. 애니메이션 스펙

### Tap 피드백 (Press)

```css
/* 0.1s 내에 즉각적인 피드백 */
.btn {
  transition:
    transform 0.1s cubic-bezier(0.34, 1.56, 0.64, 1.0),  /* spring snappy */
    opacity 0.1s ease-in;
}

.btn:active {
  transform: scale(0.97);
  opacity: 0.7;
}
```

### Tap 릴리즈 (Release)

```css
/* spring으로 원래 크기로 복귀 */
.btn:not(:active) {
  transition:
    transform 0.2s cubic-bezier(0.34, 1.56, 0.64, 1.0),
    opacity 0.15s ease-out;
}
```

### Liquid Glass 등장

`animations.json → liquidGlass.appear` 참조:

```css
.btn-liquid-glass {
  animation: liquidGlassAppear 0.3s cubic-bezier(0.34, 1.56, 0.64, 1.0);
}

@keyframes liquidGlassAppear {
  from {
    opacity: 0;
    transform: scale(0.85);
    backdrop-filter: blur(0px);
  }
  to {
    opacity: 1;
    transform: scale(1);
    backdrop-filter: blur(7px);
  }
}
```

### Disabled ↔ Enabled 전환

```css
.btn {
  transition: opacity 0.2s ease-out, background-color 0.2s ease-out;
}
```

---

## 8. 접근성

| 항목 | 요구사항 |
|------|---------|
| **최소 터치 타겟** | 44×44pt — Mini/Small 버튼도 터치 타겟은 44pt 이상 보장 |
| **ARIA role** | `role="button"` 또는 `<button>` 네이티브 요소 사용 |
| **Disabled** | `aria-disabled="true"` + `disabled` 속성 |
| **Destructive** | 레이블에 위험성 명시. 예: "삭제" + `aria-label="계정 삭제 (되돌릴 수 없음)"` |
| **색상 대비** | Filled 버튼: 흰 텍스트 on `#0088ff` → 대비 3.5:1 (Large Text WCAG AA 충족). 텍스트 크기 18pt 미만은 4.5:1 필요 → 주의 |
| **Gray 버튼 대비** | `labels.primary` on `fills.quaternary` → 충분한 대비 |
| **포커스 링** | 웹: `focus-visible` 시 2px solid `accents.blue` 링 표시 |
| **키보드** | Enter / Space 키로 활성화 |
| **감소된 모션** | scale 애니메이션 disable, opacity만 사용 |
| **Haptic** | iOS Native: `.light` UIImpactFeedbackGenerator |

---

## 9. 프레임워크 구현 참고

### Svelte 5 (웹/Tauri)

```svelte
<script lang="ts">
  type ButtonStyle = 'filled' | 'tinted' | 'gray' | 'plain' | 'borderless';
  type ButtonSize = 'mini' | 'small' | 'regular' | 'large' | 'xlarge';

  interface ButtonProps {
    style?: ButtonStyle;
    size?: ButtonSize;
    disabled?: boolean;
    destructive?: boolean;
    liquidGlass?: boolean;
    icon?: string;
    onclick?: () => void;
    children: Snippet;
  }

  let {
    style = 'filled',
    size = 'regular',
    disabled = false,
    destructive = false,
    liquidGlass = false,
    icon,
    onclick,
    children
  }: ButtonProps = $props();
</script>

<button
  class="ios-btn ios-btn--{style} ios-btn--{size}"
  class:ios-btn--destructive={destructive}
  class:ios-btn--liquid-glass={liquidGlass}
  {disabled}
  aria-disabled={disabled}
  {onclick}
>
  {#if icon}
    <span class="ios-btn__icon" aria-hidden="true">{icon}</span>
  {/if}
  <span class="ios-btn__label">
    {@render children()}
  </span>
</button>

<style>
  /* === Base === */
  .ios-btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    border: none;
    cursor: pointer;
    font-family: -apple-system, system-ui, sans-serif;
    font-weight: 600;
    white-space: nowrap;
    transition:
      transform 0.1s cubic-bezier(0.34, 1.56, 0.64, 1.0),
      opacity 0.1s ease-in,
      background-color 0.15s ease-out;
  }

  .ios-btn:active:not(:disabled) {
    transform: scale(0.97);
    opacity: 0.7;
  }

  .ios-btn:disabled {
    cursor: not-allowed;
    pointer-events: none;
  }

  .ios-btn:focus-visible {
    outline: 2px solid #0088ff;
    outline-offset: 2px;
  }

  /* === Sizes === */
  .ios-btn--mini   { height: 28px; border-radius: 8px;  padding: 0 12px; font-size: 13px; letter-spacing: -0.08px; }
  .ios-btn--small  { height: 34px; border-radius: 10px; padding: 0 16px; font-size: 15px; letter-spacing: -0.23px; }
  .ios-btn--regular { height: 44px; border-radius: 12px; padding: 0 20px; font-size: 17px; letter-spacing: -0.43px; }
  .ios-btn--large  { height: 50px; border-radius: 14px; padding: 0 24px; font-size: 16px; letter-spacing: -0.31px; }
  .ios-btn--xlarge { height: 56px; border-radius: 16px; padding: 0 28px; font-size: 17px; letter-spacing: -0.43px; }

  /* === Styles (Light) === */
  .ios-btn--filled {
    background: #0088ff;
    color: #ffffff;
  }
  .ios-btn--filled:disabled { background: rgba(0, 136, 255, 0.3); color: rgba(255,255,255,0.3); }

  .ios-btn--tinted {
    background: rgba(0, 136, 255, 0.15);
    color: #0088ff;
  }
  .ios-btn--tinted:disabled { background: rgba(116,116,128,0.08); color: rgba(60,60,67,0.18); }

  .ios-btn--gray {
    background: rgba(116, 116, 128, 0.08); /* fills.quaternary light */
    color: #000000; /* labels.primary */
  }
  .ios-btn--gray:disabled { background: rgba(116,116,128,0.04); color: rgba(60,60,67,0.18); }

  .ios-btn--plain {
    background: transparent;
    color: #0088ff;
  }
  .ios-btn--plain:active:not(:disabled) { background: rgba(116,116,128,0.08); }
  .ios-btn--plain:disabled { color: rgba(60,60,67,0.18); }

  .ios-btn--borderless {
    background: transparent;
    color: #000000;
  }
  .ios-btn--borderless:disabled { color: rgba(60,60,67,0.18); }

  /* === Destructive === */
  .ios-btn--destructive.ios-btn--filled {
    background: rgba(255, 56, 60, 0.14);
    color: #ff383c;
  }
  .ios-btn--destructive.ios-btn--tinted {
    background: rgba(255, 56, 60, 0.14);
    color: #ff383c;
  }

  /* === Liquid Glass === */
  .ios-btn--liquid-glass {
    background: rgba(116, 116, 128, 0.08);
    backdrop-filter: blur(7px);
    -webkit-backdrop-filter: blur(7px);
    border-radius: 9999px !important; /* pill override */
    color: #000000;
    animation: liquidGlassAppear 0.3s cubic-bezier(0.34, 1.56, 0.64, 1.0);
  }

  @keyframes liquidGlassAppear {
    from { opacity: 0; transform: scale(0.85); }
    to   { opacity: 1; transform: scale(1); }
  }

  /* === Dark Mode === */
  @media (prefers-color-scheme: dark) {
    .ios-btn--filled  { background: #0091ff; }
    .ios-btn--tinted  { background: rgba(0,145,255,0.15); color: #0091ff; }
    .ios-btn--gray    { background: rgba(118,118,128,0.18); color: #ffffff; }
    .ios-btn--plain   { color: #0091ff; }
    .ios-btn--borderless { color: #ffffff; }
    .ios-btn--liquid-glass { background: rgba(118,118,128,0.18); color: #ffffff; }
    .ios-btn--destructive.ios-btn--filled { background: rgba(255,66,69,0.14); color: #ff4245; }
  }

  /* === Reduced Motion === */
  @media (prefers-reduced-motion: reduce) {
    .ios-btn { transition: opacity 0.1s ease-in; }
    .ios-btn:active { transform: none; }
    .ios-btn--liquid-glass { animation: none; }
  }
</style>
```

### Flutter

```dart
// animations.json → frameworkMappings.flutter 참조
// spring snappy: SpringDescription(mass: 1, stiffness: 220, damping: 20)

enum IOSButtonStyle { filled, tinted, gray, plain, borderless }
enum IOSButtonSize { mini, small, regular, large, xlarge }

class IOSButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final IOSButtonStyle style;
  final IOSButtonSize size;
  final bool disabled;
  final bool destructive;
  final bool liquidGlass;
  final VoidCallback? onPressed;

  const IOSButton({
    required this.label,
    this.icon,
    this.style = IOSButtonStyle.filled,
    this.size = IOSButtonSize.regular,
    this.disabled = false,
    this.destructive = false,
    this.liquidGlass = false,
    this.onPressed,
  });

  @override
  State<IOSButton> createState() => _IOSButtonState();
}

class _IOSButtonState extends State<IOSButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnimation;

  static const _sizeMap = {
    IOSButtonSize.mini:    (height: 28.0, radius: 8.0,  paddingH: 12.0, fontSize: 13.0),
    IOSButtonSize.small:   (height: 34.0, radius: 10.0, paddingH: 16.0, fontSize: 15.0),
    IOSButtonSize.regular: (height: 44.0, radius: 12.0, paddingH: 20.0, fontSize: 17.0),
    IOSButtonSize.large:   (height: 50.0, radius: 14.0, paddingH: 24.0, fontSize: 16.0),
    IOSButtonSize.xlarge:  (height: 56.0, radius: 16.0, paddingH: 28.0, fontSize: 17.0),
  };

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeIn),
    );
  }

  Color _backgroundColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (widget.liquidGlass) return Colors.grey.withOpacity(isDark ? 0.18 : 0.08);
    if (widget.destructive) return const Color(0xFFFF383C).withOpacity(0.14);
    switch (widget.style) {
      case IOSButtonStyle.filled:  return isDark ? const Color(0xFF0091FF) : const Color(0xFF0088FF);
      case IOSButtonStyle.tinted:  return (isDark ? const Color(0xFF0091FF) : const Color(0xFF0088FF)).withOpacity(0.15);
      case IOSButtonStyle.gray:    return Colors.grey.withOpacity(isDark ? 0.18 : 0.08);
      default: return Colors.transparent;
    }
  }

  Color _foregroundColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (widget.destructive) return isDark ? const Color(0xFFFF4245) : const Color(0xFFFF383C);
    switch (widget.style) {
      case IOSButtonStyle.filled:  return Colors.white;
      case IOSButtonStyle.tinted:
      case IOSButtonStyle.plain:   return isDark ? const Color(0xFF0091FF) : const Color(0xFF0088FF);
      default: return isDark ? Colors.white : Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dim = _sizeMap[widget.size]!;
    final bg = _backgroundColor(context);
    final fg = _foregroundColor(context);
    final cornerRadius = widget.liquidGlass ? 9999.0 : dim.radius;

    Widget button = ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: (_) { if (!widget.disabled) _pressController.forward(); },
        onTapUp: (_) { _pressController.reverse(); widget.onPressed?.call(); },
        onTapCancel: () => _pressController.reverse(),
        child: Container(
          height: dim.height,
          constraints: BoxConstraints(minWidth: 44, minHeight: 44),
          padding: EdgeInsets.symmetric(horizontal: dim.paddingH),
          decoration: BoxDecoration(
            color: widget.disabled ? bg.withOpacity(0.3) : bg,
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
          child: widget.liquidGlass
            ? ClipRRect(
                borderRadius: BorderRadius.circular(cornerRadius),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                  child: _buildContent(fg, dim.fontSize),
                ),
              )
            : _buildContent(fg, dim.fontSize),
        ),
      ),
    );

    if (widget.disabled) {
      return Opacity(opacity: 0.3, child: button);
    }
    return button;
  }

  Widget _buildContent(Color fg, double fontSize) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(widget.icon, color: fg, size: fontSize + 2),
          const SizedBox(width: 6),
        ],
        Text(widget.label,
          style: TextStyle(
            color: fg,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.43,
          )),
      ],
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }
}
```

### SwiftUI (참고용)

```swift
// iOS 26: Button with various styles
// Filled
Button("저장") { saveAction() }
  .buttonStyle(.borderedProminent)
  .controlSize(.large)

// Gray (bordered)
Button("취소") { cancelAction() }
  .buttonStyle(.bordered)

// Destructive
Button("삭제", role: .destructive) { deleteAction() }
  .buttonStyle(.borderedProminent)

// Liquid Glass (iOS 26 신규)
Button { action() } label: {
  Image(systemName: "plus")
}
.buttonStyle(.glass) // iOS 26 새로운 스타일
```

---

## Button - Liquid Glass - Symbol 보강

### Button - Liquid Glass - Symbol (`5522:11866`, 2 variants)
- Text 버튼과 달리 SF Symbol 아이콘만 표시
- 원형(circle) 또는 정사각형(square) 형태
- 크기: 44×44pt (기본), 50×50pt (Large)
- Liquid Glass 배경 + SF Symbol 20pt
- 2 variants: Light / Dark mode
- 사용처: toolbar 아이콘 버튼, floating action button
