# iOS 26 Pop-up Button — Component Spec

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:26009")`

---

## 1. 개요

iOS 26 Pop-up Button은 현재 선택된 값을 버튼에 표시하고, 탭 시 메뉴를 펼쳐 다른 값을 선택할 수 있는 컴포넌트다.

**Context Menu와의 차이점**:

| 특성 | Pop-up Button | Context Menu |
|---|---|---|
| 현재 값 표시 | 항상 버튼에 표시 | 표시 안 함 |
| 선택 방식 | 단일 선택 (라디오 형태) | 단일 또는 다중 |
| 체크마크 | 선택된 항목에 표시 | 선택에 따라 표시 |
| 용도 | 설정값, 옵션 선택 | 빠른 액션 |
| 메뉴 위치 | 버튼 아래 (preferred) | 누른 위치 기준 |

---

## 2. Variants (2개)

### Variant 1: Default

```
┌──────────────────────────────┐
│  현재 선택값        ▼        │  ← 높이 34pt
└──────────────────────────────┘
  border: 1pt, Colors/Fill/Tertiary
  background: Colors/Background/Primary
```

- 배경: `Colors/Background/Primary` (투명 또는 흰색)
- 테두리: 1pt, `Colors/Fill/Tertiary`
- 텍스트: `Colors/Label/Primary`
- 셰브론: `Colors/Label/Tertiary`

### Variant 2: Tinted

```
┌──────────────────────────────┐
│  현재 선택값        ▼        │  ← 높이 34pt
└──────────────────────────────┘
  background: Colors/Tint/Blue (opacity 0.15)
  text + chevron: Colors/Tint/Blue
```

- 배경: `Colors/Tint/Blue` + opacity 0.15 (`Colors/Fill/Blue/Tinted`)
- 테두리: 없음
- 텍스트: `Colors/Tint/Blue`
- 셰브론: `Colors/Tint/Blue`

---

## 3. 치수 & 레이아웃

### 3.1 버튼 본체

```
┌──────────────────────────────────────────┐
│ 12 │ [레이블 텍스트]  [---flex---]  │ 6 │ [▼] │ 12 │
└──────────────────────────────────────────┘
↑ 높이: 34pt
↑ 최소 너비: 100pt
↑ 코너 반경: 8pt
↑ 레이블↔셰브론 간격: 6pt
↑ 셰브론 크기: 12pt × 12pt (SF Symbol: chevron.up.chevron.down)
```

- **높이**: 34pt
- **최소 너비**: 100pt
- **수평 패딩**: 12pt (양쪽)
- **코너 반경**: 8pt
- **레이블↔셰브론 gap**: 6pt
- **셰브론 아이콘**: `chevron.up.chevron.down` (SF Symbol), 12×12pt

### 3.2 팝업 메뉴

```
┌──────────────────────────┐
│ 옵션 A                ✓  │  ← 선택된 항목 (체크마크)
│ 옵션 B                   │
│ 옵션 C                   │
│ ──────────────────────── │  ← 구분선 (선택적)
│ 취소                     │
└──────────────────────────┘
  min-width: 버튼 너비 (최소 200pt)
  row-height: 44pt
  corner-radius: 14pt (iOS 26 Liquid Glass)
  padding-h: 16pt
  체크마크 아이콘: checkmark (SF Symbol)
```

- **메뉴 최소 너비**: max(버튼 너비, 200pt)
- **메뉴 최대 너비**: 320pt
- **행 높이**: 44pt
- **메뉴 코너 반경**: 14pt
- **메뉴 배경**: `Colors/Background/Primary` + blur (Liquid Glass 효과)
- **선택 항목 체크마크**: `checkmark` SF Symbol, `Colors/Tint/Blue`

---

## 4. 색상 토큰

```json
// ../tokens/colors.json 참조
{
  "popupButton": {
    "default": {
      "background": "Colors/Background/Primary",
      "border": "Colors/Fill/Tertiary",
      "label": "Colors/Label/Primary",
      "chevron": "Colors/Label/Tertiary",
      "pressed": {
        "background": "Colors/Fill/Tertiary"
      }
    },
    "tinted": {
      "background": "Colors/Fill/Blue/Tinted",
      "border": "transparent",
      "label": "Colors/Tint/Blue",
      "chevron": "Colors/Tint/Blue",
      "pressed": {
        "background": "Colors/Fill/Blue/Tinted/Pressed"
      }
    },
    "disabled": {
      "opacity": 0.4
    },
    "menu": {
      "background": "Colors/Background/Primary",
      "blur": "UIBlurEffect.Style.systemMaterial",
      "separator": "Colors/Separator/Opaque",
      "rowLabel": "Colors/Label/Primary",
      "rowLabelDestructive": "Colors/System/Red",
      "checkmark": "Colors/Tint/Blue",
      "rowHighlight": "Colors/Fill/Quaternary"
    }
  }
}
```

---

## 5. 타이포그래피

```json
// ../tokens/typography.json 참조
{
  "popupButton": {
    "buttonLabel": {
      "fontStyle": "Subheadline",
      "weight": "Regular",
      "size": "15pt"
    },
    "menuItem": {
      "fontStyle": "Body",
      "weight": "Regular",
      "size": "17pt"
    },
    "menuItemSelected": {
      "fontStyle": "Body",
      "weight": "Regular",
      "size": "17pt"
    },
    "menuSectionHeader": {
      "fontStyle": "Footnote",
      "weight": "Regular",
      "size": "13pt",
      "color": "Colors/Label/Secondary"
    }
  }
}
```

- **버튼 레이블**: Subheadline, 15pt, Regular
- **메뉴 항목**: Body, 17pt, Regular
- **선택된 항목**: Body, 17pt, Regular (체크마크로 구분, 굵기 변화 없음)

---

## 6. 간격 토큰

```json
// ../tokens/spacing.json 참조
{
  "popupButton": {
    "buttonHeight": 34,
    "buttonMinWidth": 100,
    "buttonPaddingH": 12,
    "buttonCornerRadius": 8,
    "buttonBorderWidth": 1,
    "chevronSize": 12,
    "chevronGap": 6,
    "menuMinWidth": 200,
    "menuMaxWidth": 320,
    "menuRowHeight": 44,
    "menuCornerRadius": 14,
    "menuPaddingH": 16,
    "menuPaddingV": 8,
    "checkmarkSize": 17,
    "checkmarkTrailingPadding": 16,
    "menuOffsetY": 4
  }
}
```

---

## 7. 애니메이션

```json
// ../tokens/animations.json 참조
{
  "popupButton": {
    "menuPresent": {
      "type": "spring",
      "stiffness": 450,
      "damping": 36,
      "initialScale": 0.8,
      "targetScale": 1.0,
      "transformOrigin": "top center",
      "duration": "~0.3s"
    },
    "menuDismiss": {
      "type": "easeIn",
      "duration": 0.15,
      "endScale": 0.9,
      "endOpacity": 0
    },
    "buttonPress": {
      "type": "spring",
      "scale": 0.97,
      "stiffness": 600,
      "damping": 30
    },
    "chevronRotate": {
      "type": "spring",
      "startAngle": 0,
      "endAngle": 180,
      "stiffness": 400,
      "damping": 32
    }
  }
}
```

### 7.1 메뉴 표시

1. 버튼 scale 0.97 (press 피드백)
2. 버튼 위 또는 아래에 메뉴 레이어 생성
3. scale 0.8 → 1.0 spring (origin: 버튼 중앙 상단)
4. opacity 0 → 1 (0.15s)
5. 셰브론 0° → 180° 회전 (메뉴가 위에 표시될 때) 또는 그대로 유지

### 7.2 항목 선택

1. 행 배경 `Colors/Fill/Quaternary` highlight (즉각)
2. 햅틱 피드백 (selection style)
3. 메뉴 dismiss (easeIn 0.15s)
4. 버튼 레이블 텍스트 crossfade (선택 전 값 → 선택 후 값, 0.2s)

### 7.3 메뉴 닫기 (외부 탭)

- 메뉴 opacity 1 → 0, scale 1.0 → 0.9 (0.15s easeIn)
- 셰브론 원위치 회전

---

## 8. 상태 정의

| 상태 | Default Variant | Tinted Variant |
|---|---|---|
| `default` | 흰 배경 + 회색 테두리 | 파란 틴트 배경 |
| `hovered` | 배경 약간 진해짐 | 틴트 진해짐 |
| `pressed` | Fill/Tertiary 배경 | 더 진한 틴트 |
| `menu-open` | pressed 상태 유지 + 셰브론 회전 | 동일 |
| `disabled` | opacity 0.4 | opacity 0.4 |

---

## 9. 메뉴 구조 상세

```
메뉴 팝업 레이아웃:
┌─────────────────────────────────┐
│                                 │  ← 상단 패딩 8pt
│  옵션 A              ✓         │  ← 선택된 항목 (체크마크 trailing)
│  ─────────────────────────────  │  ← divider 0.5pt
│  옵션 B                         │
│  옵션 C                         │
│  옵션 D                         │
│                                 │  ← 하단 패딩 8pt
└─────────────────────────────────┘

행 내부 레이아웃:
┌──────────────────────────────────────┐
│ 16 │ [아이콘(선택)] │ 12 │ [레이블] [flex] │ [✓] │ 16 │
└──────────────────────────────────────┘
  아이콘: 20×20pt (선택적)
  체크마크: 17pt SF Symbol "checkmark"
  행 높이: 44pt
```

### 9.1 항목 구성 옵션

- **텍스트만**: 레이블 + 체크마크
- **아이콘 + 텍스트**: Leading SF Symbol (20pt) + 레이블 + 체크마크
- **구분선**: 항목 그룹 사이 구분 (0.5pt separator)
- **섹션 헤더**: 항목 그룹 이름 (Footnote, `Colors/Label/Secondary`)
- **파괴적 항목**: 레이블 `Colors/System/Red`, 선택 체크마크도 Red

---

## 10. 플랫폼별 구현

### 10.1 UIKit

```swift
import UIKit

class PopupButtonExample: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPopupButton()
    }

    func setupPopupButton() {
        // 현재 선택값 추적
        var currentSelection = "옵션 A"

        // 메뉴 항목 생성
        let options = ["옵션 A", "옵션 B", "옵션 C", "옵션 D"]

        func makeMenu() -> UIMenu {
            let actions = options.map { option in
                UIAction(
                    title: option,
                    state: option == currentSelection ? .on : .off
                ) { [weak self] _ in
                    currentSelection = option
                    button.setTitle(option, for: .normal)
                    button.menu = makeMenu() // 체크마크 갱신
                }
            }
            return UIMenu(children: actions)
        }

        // Default 스타일
        var config = UIButton.Configuration.tinted()
        config.title = currentSelection
        config.image = UIImage(systemName: "chevron.up.chevron.down")
        config.imagePlacement = .trailing
        config.imagePadding = 6
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 12, bottom: 0, trailing: 12
        )

        let button = UIButton(configuration: config)
        button.menu = makeMenu()
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = false

        // 크기 설정
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 34),
            button.widthAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])

        // Tinted 스타일 (파란 배경)
        var tintedConfig = UIButton.Configuration.filled()
        tintedConfig.baseBackgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
        tintedConfig.baseForegroundColor = .systemBlue
        tintedConfig.title = currentSelection
        tintedConfig.image = UIImage(systemName: "chevron.up.chevron.down")
        tintedConfig.imagePlacement = .trailing
        tintedConfig.imagePadding = 6
        tintedConfig.cornerStyle = .medium
    }
}
```

### 10.2 SwiftUI

```swift
import SwiftUI

struct PopupButtonDemo: View {
    @State private var selectedOption = "옵션 A"

    let options = ["옵션 A", "옵션 B", "옵션 C", "옵션 D"]

    var body: some View {
        VStack(spacing: 24) {
            // Default 스타일: Picker + .menu
            Picker("옵션 선택", selection: $selectedOption) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(.menu)
            // iOS 26에서 자동으로 popup button 형태로 표시

            // Tinted 스타일: 커스텀
            Menu {
                Picker("", selection: $selectedOption) {
                    ForEach(options, id: \.self) { option in
                        Label(option, systemImage: selectedOption == option ? "checkmark" : "")
                            .tag(option)
                    }
                }
            } label: {
                HStack(spacing: 6) {
                    Text(selectedOption)
                        .font(.subheadline)
                        .foregroundStyle(Color.accentColor)
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.accentColor)
                }
                .padding(.horizontal, 12)
                .frame(height: 34)
                .background(Color.accentColor.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            // 아이콘 포함 메뉴
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(action: { selectedOption = option }) {
                        HStack {
                            Image(systemName: "circle.fill")
                            Text(option)
                            if selectedOption == option {
                                Spacer()
                                Image(systemName: "checkmark")
                                    .foregroundStyle(Color.accentColor)
                            }
                        }
                    }
                }
            } label: {
                HStack(spacing: 6) {
                    Text(selectedOption)
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 12))
                        .foregroundStyle(.tertiary)
                }
                .padding(.horizontal, 12)
                .frame(height: 34)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.tertiarySystemFill), lineWidth: 1)
                )
            }
        }
        .padding()
    }
}
```

### 10.3 Flutter (Cupertino 스타일 커스텀)

```dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PopupButton extends StatefulWidget {
  const PopupButton({
    super.key,
    required this.options,
    required this.value,
    required this.onChanged,
    this.isTinted = false,
  });

  final List<String> options;
  final String value;
  final ValueChanged<String> onChanged;
  final bool isTinted;

  @override
  State<PopupButton> createState() => _PopupButtonState();
}

class _PopupButtonState extends State<PopupButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  void _showMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    final selected = await showMenu<String>(
      context: context,
      position: position,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      items: widget.options.map((option) {
        final isSelected = option == widget.value;
        return PopupMenuItem<String>(
          value: option,
          height: 44,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  option,
                  style: const TextStyle(
                    fontSize: 17,
                    color: CupertinoColors.label,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(
                  CupertinoIcons.checkmark,
                  size: 17,
                  color: CupertinoColors.activeBlue,
                ),
            ],
          ),
        );
      }).toList(),
    );

    if (selected != null) {
      widget.onChanged(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pressController.forward(),
      onTapUp: (_) {
        _pressController.reverse();
        _showMenu(context);
      },
      onTapCancel: () => _pressController.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          height: 34,
          constraints: const BoxConstraints(minWidth: 100),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: widget.isTinted
                ? CupertinoColors.activeBlue.withOpacity(0.15)
                : CupertinoColors.systemBackground,
            border: widget.isTinted
                ? null
                : Border.all(
                    color: CupertinoColors.tertiarySystemFill,
                    width: 1,
                  ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  widget.value,
                  style: TextStyle(
                    fontSize: 15,
                    color: widget.isTinted
                        ? CupertinoColors.activeBlue
                        : CupertinoColors.label,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                CupertinoIcons.chevron_up_chevron_down,
                size: 12,
                color: widget.isTinted
                    ? CupertinoColors.activeBlue
                    : CupertinoColors.tertiaryLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 사용 예시
class PopupButtonExample extends StatefulWidget {
  const PopupButtonExample({super.key});

  @override
  State<PopupButtonExample> createState() => _PopupButtonExampleState();
}

class _PopupButtonExampleState extends State<PopupButtonExample> {
  String _selected = '옵션 A';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Default 스타일
        PopupButton(
          options: ['옵션 A', '옵션 B', '옵션 C'],
          value: _selected,
          onChanged: (v) => setState(() => _selected = v),
        ),
        const SizedBox(height: 16),
        // Tinted 스타일
        PopupButton(
          options: ['옵션 A', '옵션 B', '옵션 C'],
          value: _selected,
          onChanged: (v) => setState(() => _selected = v),
          isTinted: true,
        ),
      ],
    );
  }
}
```

### 10.4 Svelte

```svelte
<script lang="ts">
  interface Option {
    value: string;
    label: string;
    icon?: string;
    destructive?: boolean;
  }

  let {
    options = [],
    value = $bindable(''),
    isTinted = false,
    placeholder = '선택',
  }: {
    options: Option[];
    value: string;
    isTinted?: boolean;
    placeholder?: string;
  } = $props();

  let isOpen = $state(false);
  let isPressed = $state(false);
  let buttonEl = $state<HTMLButtonElement | null>(null);

  const selectedOption = $derived(options.find(o => o.value === value));
  const displayLabel = $derived(selectedOption?.label ?? placeholder);

  function selectOption(option: Option) {
    value = option.value;
    isOpen = false;
  }

  function handleKeydown(e: KeyboardEvent) {
    if (e.key === 'Escape') isOpen = false;
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      isOpen = !isOpen;
    }
    if (e.key === 'ArrowDown') {
      e.preventDefault();
      const idx = options.findIndex(o => o.value === value);
      const next = options[idx + 1];
      if (next) selectOption(next);
    }
    if (e.key === 'ArrowUp') {
      e.preventDefault();
      const idx = options.findIndex(o => o.value === value);
      const prev = options[idx - 1];
      if (prev) selectOption(prev);
    }
  }
</script>

<div style="position: relative; display: inline-block;">
  <!-- 팝업 버튼 -->
  <button
    bind:this={buttonEl}
    onclick={() => isOpen = !isOpen}
    onmousedown={() => isPressed = true}
    onmouseup={() => isPressed = false}
    onmouseleave={() => isPressed = false}
    onkeydown={handleKeydown}
    aria-haspopup="listbox"
    aria-expanded={isOpen}
    aria-label="{displayLabel} 선택됨, 변경하려면 클릭"
    style="
      height: 34px;
      min-width: 100px;
      padding: 0 12px;
      display: flex;
      align-items: center;
      gap: 6px;
      border: {isTinted ? 'none' : '1px solid var(--color-fill-tertiary)'};
      border-radius: 8px;
      background: {isTinted
        ? 'color-mix(in srgb, var(--color-tint-blue) 15%, transparent)'
        : 'var(--color-background-primary)'};
      cursor: pointer;
      transform: scale({isPressed ? 0.97 : 1});
      transition: transform 0.1s ease, background 0.15s ease;
      white-space: nowrap;
    "
  >
    <span style="
      font-size: 15px;
      color: {isTinted ? 'var(--color-tint-blue)' : 'var(--color-label-primary)'};
      flex: 1;
      text-align: left;
      overflow: hidden;
      text-overflow: ellipsis;
      max-width: 200px;
    ">
      {displayLabel}
    </span>

    <!-- 셰브론 아이콘 -->
    <svg
      width="12" height="12"
      viewBox="0 0 12 12"
      fill="none"
      style="
        color: {isTinted ? 'var(--color-tint-blue)' : 'var(--color-label-tertiary)'};
        transform: rotate({isOpen ? '180deg' : '0deg'});
        transition: transform 0.2s ease;
        flex-shrink: 0;
      "
    >
      <path d="M2 4L6 8L10 4" stroke="currentColor" stroke-width="1.5"
            stroke-linecap="round" stroke-linejoin="round"/>
    </svg>
  </button>

  <!-- 팝업 메뉴 -->
  {#if isOpen}
    <ul
      role="listbox"
      aria-label="옵션 목록"
      style="
        position: absolute;
        top: calc(100% + 4px);
        left: 0;
        min-width: max(100%, 200px);
        max-width: 320px;
        background: var(--color-background-primary);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border: 1px solid var(--color-separator-opaque);
        border-radius: 14px;
        padding: 8px 0;
        list-style: none;
        margin: 0;
        box-shadow: 0 8px 30px rgba(0,0,0,0.12), 0 2px 8px rgba(0,0,0,0.08);
        z-index: 1000;
        animation: menuAppear 0.2s cubic-bezier(0.34, 1.56, 0.64, 1);
      "
    >
      {#each options as option}
        <li
          role="option"
          aria-selected={option.value === value}
          onclick={() => selectOption(option)}
          onkeydown={(e) => e.key === 'Enter' && selectOption(option)}
          tabindex="0"
          style="
            height: 44px;
            padding: 0 16px;
            display: flex;
            align-items: center;
            gap: 12px;
            cursor: pointer;
            background: transparent;
            transition: background 0.1s ease;
            color: {option.destructive ? 'var(--color-system-red)' : 'var(--color-label-primary)'};

            &:hover { background: var(--color-fill-quaternary); }
          "
        >
          <!-- Leading 아이콘 (선택적) -->
          {#if option.icon}
            <span style="width: 20px; height: 20px; flex-shrink: 0;">
              {option.icon}
            </span>
          {/if}

          <!-- 레이블 -->
          <span style="flex: 1; font-size: 17px;">
            {option.label}
          </span>

          <!-- 체크마크 (선택된 항목) -->
          {#if option.value === value}
            <svg
              width="17" height="17"
              viewBox="0 0 17 17"
              fill="none"
              style="color: var(--color-tint-blue); flex-shrink: 0;"
            >
              <path d="M2 8.5L6.5 13L15 4" stroke="currentColor"
                    stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
          {/if}
        </li>
      {/each}
    </ul>

    <!-- 외부 클릭 닫기 -->
    <div
      role="button"
      tabindex="-1"
      onclick={() => isOpen = false}
      onkeydown={(e) => e.key === 'Escape' && (isOpen = false)}
      style="position: fixed; inset: 0; z-index: 999;"
    />
  {/if}
</div>

<style>
  @keyframes menuAppear {
    from {
      opacity: 0;
      transform: scale(0.85);
      transform-origin: top center;
    }
    to {
      opacity: 1;
      transform: scale(1);
      transform-origin: top center;
    }
  }
</style>
```

---

## 11. 다크모드 대응

| 토큰 | 라이트 | 다크 |
|---|---|---|
| `Colors/Background/Primary` | #FFFFFF | #1C1C1E |
| `Colors/Fill/Tertiary` | rgba(118,118,128,0.12) | rgba(118,118,128,0.24) |
| `Colors/Tint/Blue` | #007AFF | #0A84FF |
| `Colors/Fill/Blue/Tinted` | rgba(0,122,255,0.15) | rgba(10,132,255,0.15) |
| `Colors/Label/Primary` | rgba(0,0,0,1) | rgba(255,255,255,1) |
| `Colors/Label/Tertiary` | rgba(60,60,67,0.3) | rgba(235,235,245,0.3) |

---

## 12. 접근성

- **ARIA**: `role="button"`, `aria-haspopup="listbox"`, `aria-expanded={isOpen}`
- **VoiceOver**: "옵션 A 선택됨, 팝업 버튼, 두 번 탭하여 메뉴 열기"
- **키보드**: `Enter`/`Space`로 메뉴 토글, `ArrowUp`/`ArrowDown`으로 항목 이동, `Escape`로 닫기
- **터치 타겟**: 최소 44×44pt (버튼은 34pt → 탭 영역을 invisible padding으로 44pt 확장)
- **포커스 트래핑**: 메뉴 열린 상태에서 Tab 탭 순서가 메뉴 내부로 한정

---

## 13. 체크리스트

- [ ] 버튼 높이 34pt, 최소 너비 100pt
- [ ] 코너 반경 8pt (버튼), 14pt (메뉴)
- [ ] 셰브론 `chevron.up.chevron.down` SF Symbol
- [ ] 선택된 항목에 체크마크 표시
- [ ] Default / Tinted 두 variant 구현
- [ ] Spring 메뉴 등장 애니메이션 (scale 0.8 → 1.0)
- [ ] 외부 탭으로 메뉴 닫기
- [ ] 다크모드 토큰 대응
- [ ] ARIA aria-haspopup, aria-expanded 속성
- [ ] 키보드 Arrow 키 탐색
- [ ] 햅틱 피드백 (항목 선택 시)
