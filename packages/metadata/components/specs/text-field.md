# Text Field Component Spec

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="5433:20204")`

---

## 1. Overview

iOS 26의 표준 Text Field 컴포넌트. 사용자 텍스트 입력을 위한 단일 행(Single-line) 및 다중 행(Multiline) 입력 필드. 검색창, 폼 입력, 로그인/가입 화면에서 광범위하게 사용된다. UITextField / UITextView를 베이스로 하며, 포커스 상태에서는 파란 테두리와 함께 키보드가 슬라이드 업된다.

- **Figma Node**: Page `553:22762`, Section `5433:20204`
- **Light 예시**: `5433:15705` (2가지 상태)
- **Dark 예시**: `5433:15709` (2가지 상태)
- **UIKit 클래스**: `UITextField` (단일행), `UITextView` (다중행)
- **SwiftUI**: `TextField`, `TextEditor`

---

## 2. Dimensions

### Single-line (기본)

| 속성 | 값 |
|------|-----|
| 높이 | 44 pt (HIG 최소 터치 타겟과 동일) |
| 가로 패딩 | 12 pt (양쪽) |
| 세로 패딩 | 11 pt (상하) |
| Corner radius | 10 pt |
| Border width (기본) | 0.5 pt |
| Border width (포커스) | 2 pt |
| 최소 너비 | 전체 가용 너비 (content margin 제외) — iPhone: 16pt 마진 기준 |

### Multiline (TextEditor)

| 속성 | 값 |
|------|-----|
| 높이 | 가변 (내용에 따라 확장) |
| 최소 높이 | 88 pt (약 4행) |
| 최대 높이 | 제한 없음 (스크롤 가능) |
| 가로 패딩 | 12 pt |
| 세로 패딩 | 11 pt (시작 기준) |

```
단일행 레이아웃:
┌──────────────────────────────────────────┐
│ 12pt │ [placeholder 또는 입력 텍스트]      │ 12pt │  44pt 높이
└──────────────────────────────────────────┘
        ↑ 11pt top padding 포함
```

---

## 3. Variants

| Variant | 설명 |
|---------|------|
| Empty | 초기 상태. Placeholder 텍스트 표시, 테두리 없음(0.5pt separator) |
| Focused | 포커스 획득. 파란 2pt 테두리, 키보드 슬라이드업 |
| Filled | 텍스트 입력 완료, 포커스 해제. 기본 테두리 유지 |
| Error | 유효성 검사 실패. 빨간 테두리(`accents.red`), 에러 메시지 표시 |
| Disabled | 비활성화. 50% opacity, 터치 불가 |

---

## 4. Color Tokens

### 배경 색상

| 컨텍스트 | Light | Dark | 토큰 |
|---------|-------|------|------|
| 기본 배경 | `#f2f2f7` | `#1c1c1e` | `backgrounds.secondary` |
| 포커스 배경 | `#f2f2f7` | `#1c1c1e` | `backgrounds.secondary` (변화 없음) |

> **Note**: Figma 내 `miscellaneous.textField.bg`는 `#ffffff` / `#000000`으로 명시되어 있으나,
> 실제 iOS 26 시스템 스타일은 `fills.secondarySystemBackground` (`backgrounds.secondary`)를 사용한다.

### 테두리 색상

| 상태 | Light | Dark | 토큰 |
|------|-------|------|------|
| 기본 | `rgba(60,60,67, 0.29)` | `rgba(235,235,245, 0.30)` | `miscellaneous.textField.outline` |
| 포커스 | `#0088ff` | `#0091ff` | `accents.blue` |
| Error | `#ff383c` | `#ff4245` | `accents.red` |

### 텍스트 색상

| 역할 | Light | Dark | 토큰 |
|------|-------|------|------|
| 입력 텍스트 | `#000000` | `#ffffff` | `labels.primary` |
| Placeholder | `rgba(60,60,67, 0.3)` | `rgba(235,235,245, 0.3)` | `labels.tertiary` |
| Disabled 텍스트 | `labels.tertiary` + 50% opacity | | |
| 에러 메시지 | `#ff383c` | `#ff4245` | `accents.red` |
| 보조 레이블 | `rgba(60,60,67, 0.6)` | `rgba(235,235,245, 0.7)` | `labels.secondary` |

---

## 5. Typography

| 역할 | 스타일 | 크기 | Weight | Letter Spacing |
|------|--------|------|--------|----------------|
| 입력 텍스트 | Body | 17pt | Regular | -0.43 |
| Placeholder | Body | 17pt | Regular | -0.43 |
| 레이블 (상단) | Subheadline | 15pt | Regular | -0.23 |
| 에러/힌트 메시지 | Caption1 | 12pt | Regular | 0 |
| 카운터 텍스트 | Caption2 | 11pt | Regular | 0.06 |

Dynamic Type 완전 지원 필수. `adjustsFontForContentSizeCategory = true` (UIKit) 또는 `.dynamicTypeSize()` (SwiftUI).

---

## 6. State Transitions

```
Empty ──(탭)──→ Focused (키보드 슬라이드업, 파란 테두리)
Focused ──(입력)──→ Filled (포커스 유지 중)
Focused ──(탭 외부 / Return)──→ Filled 또는 Empty
Filled ──(탭)──→ Focused (커서 재활성화)
Filled ──(유효성 실패)──→ Error (shake 애니메이션 선택적)
Error ──(수정 시작)──→ Focused (에러 테두리 → 파란 테두리)
* ──(비활성화)──→ Disabled
```

### 포커스 획득 시퀀스

1. 필드 탭 → 0ms: `becomeFirstResponder()` 호출
2. 0~25ms: 테두리 색상 crossfade (separator → accents.blue)
3. 0~250ms: 키보드 슬라이드업 (`keyboardSlide: 0.25s`)
4. 뷰 스크롤: 키보드에 의해 가려지는 경우 자동 스크롤 (`UIScrollView.contentInsetAdjustmentBehavior`)

---

## 7. Animation

### 포커스 전환 애니메이션

| 속성 | 값 |
|------|-----|
| 테두리 색상 전환 | 0.2s, `cubic-bezier(0.0, 0, 0.58, 1.0)` (easeOut) |
| 테두리 두께 전환 | 0.5pt → 2pt, 0.2s |
| 키보드 슬라이드 | 0.25s, 키보드 시스템 커브 매칭 |

### 에러 상태 Shake 애니메이션 (선택적)

```
@keyframes shake {
  0%   { transform: translateX(0); }
  15%  { transform: translateX(-6px); }
  30%  { transform: translateX(6px); }
  45%  { transform: translateX(-4px); }
  60%  { transform: translateX(4px); }
  75%  { transform: translateX(-2px); }
  90%  { transform: translateX(2px); }
  100% { transform: translateX(0); }
}
duration: 0.4s, easing: linear
```

### Clear 버튼 (내용 있을 때)

| 속성 | 값 |
|------|-----|
| 아이콘 | SF Symbol `xmark.circle.fill` |
| 크기 | 17pt |
| 색상 | `labels.tertiary` |
| 출현 | fade in 0.1s |
| 위치 | 우측 패딩 내 (trailing edge - 12pt) |

---

## 8. Accessibility

| 속성 | 값 |
|------|-----|
| `accessibilityTraits` | `.none` (TextField 기본 동작) |
| `accessibilityLabel` | 연결된 레이블 또는 placeholder 텍스트 |
| `accessibilityHint` | 입력 형식 가이드 ("이메일 주소를 입력하세요") |
| `accessibilityValue` | 현재 입력된 텍스트 |
| `keyboardType` | 내용에 맞는 키보드 타입 설정 필수 |
| `returnKeyType` | 컨텍스트에 맞게 설정 (`.next`, `.done`, `.search`) |
| `autocorrectionType` | 패스워드 필드: `.no`, 일반: `.yes` |
| `textContentType` | `.emailAddress`, `.password` 등 자동완성 지원 |
| VoiceOver 에러 | 에러 메시지를 `UIAccessibility.post(notification: .announcement, argument:)` |

---

## 9. Framework Notes

### UIKit

```swift
// 기본 단일행 TextField
let textField = UITextField()
textField.placeholder = "이메일 주소"
textField.font = .preferredFont(forTextStyle: .body) // Dynamic Type
textField.adjustsFontForContentSizeCategory = true
textField.backgroundColor = UIColor.secondarySystemBackground
textField.layer.cornerRadius = 10
textField.layer.borderWidth = 0.5
textField.layer.borderColor = UIColor { trait in
    trait.userInterfaceStyle == .dark
        ? UIColor(red: 235/255, green: 235/255, blue: 245/255, alpha: 0.30)
        : UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.29)
}.cgColor
// 좌우 padding 추가
textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
textField.leftViewMode = .always
textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
textField.rightViewMode = .always

// 포커스 시 테두리 변경
func textFieldDidBeginEditing(_ textField: UITextField) {
    UIView.animate(withDuration: 0.2, delay: 0,
                   options: .curveEaseOut) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(hex: "#0088FF").cgColor
    }
}

func textFieldDidEndEditing(_ textField: UITextField) {
    UIView.animate(withDuration: 0.2) {
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.separator.cgColor
    }
}
```

### SwiftUI

```swift
struct IOSTextField: View {
    @Binding var text: String
    let placeholder: String
    var isError: Bool = false
    @FocusState private var isFocused: Bool

    var borderColor: Color {
        if isError { return Color(hex: "#FF383C") }
        if isFocused { return Color(hex: "#0088FF") }
        return Color(UIColor.separator)
    }

    var borderWidth: CGFloat {
        isFocused || isError ? 2 : 0.5
    }

    var body: some View {
        TextField(placeholder, text: $text)
            .focused($isFocused)
            .font(.body)
            .padding(.horizontal, 12)
            .padding(.vertical, 11)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor, lineWidth: borderWidth)
                    .animation(.easeOut(duration: 0.2), value: isFocused)
            )
    }
}

// 다중행
TextEditor(text: $content)
    .font(.body)
    .padding(12)
    .background(Color(UIColor.secondarySystemBackground))
    .cornerRadius(10)
    .frame(minHeight: 88)
```

### Flutter

```dart
class IOSTextField extends StatefulWidget {
  const IOSTextField({
    required this.hintText,
    this.controller,
    this.onChanged,
    this.isError = false,
    this.errorText,
  });
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool isError;
  final String? errorText;

  @override
  State<IOSTextField> createState() => _IOSTextFieldState();
}

class _IOSTextFieldState extends State<IOSTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color borderColor;
    if (widget.isError) {
      borderColor = isDark ? const Color(0xFFFF4245) : const Color(0xFFFF383C);
    } else if (_isFocused) {
      borderColor = isDark ? const Color(0xFF0091FF) : const Color(0xFF0088FF);
    } else {
      borderColor = isDark
          ? const Color(0x4CEBEBF5) // rgba(235,235,245, 0.30)
          : const Color(0x4A3C3C43); // rgba(60,60,67, 0.29)
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF2F2F7),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderColor,
              width: (_isFocused || widget.isError) ? 2 : 0.5,
            ),
          ),
          child: Focus(
            onFocusChange: (focused) => setState(() => _isFocused = focused),
            child: TextField(
              controller: widget.controller,
              onChanged: widget.onChanged,
              style: const TextStyle(fontSize: 17),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: isDark
                      ? const Color(0x4CEBEBF5) // labels.tertiary dark
                      : const Color(0x4C3C3C43), // labels.tertiary light
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 11,
                ),
              ),
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 12),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                fontSize: 12,
                color: isDark
                    ? const Color(0xFFFF4245)
                    : const Color(0xFFFF383C),
              ),
            ),
          ),
      ],
    );
  }
}
```

### CSS / Svelte

```svelte
<script>
  let value = '';
  let focused = false;
  let hasError = false;

  $: borderColor = hasError
    ? 'var(--accent-red)'
    : focused ? 'var(--accent-blue)' : 'var(--separator)';
  $: borderWidth = (focused || hasError) ? '2px' : '0.5px';
</script>

<div class="field-wrapper">
  <input
    type="text"
    bind:value
    placeholder="이메일 주소"
    class="text-field"
    class:error={hasError}
    style:--border-color={borderColor}
    style:--border-width={borderWidth}
    on:focus={() => focused = true}
    on:blur={() => focused = false}
  />
</div>

<style>
  :root {
    --accent-blue: #0088ff;
    --accent-red: #ff383c;
    --separator: rgba(60, 60, 67, 0.29);
    --bg-secondary: #f2f2f7;
    --text-primary: #000000;
    --text-placeholder: rgba(60, 60, 67, 0.3);
  }

  @media (prefers-color-scheme: dark) {
    :root {
      --accent-blue: #0091ff;
      --accent-red: #ff4245;
      --separator: rgba(235, 235, 245, 0.30);
      --bg-secondary: #1c1c1e;
      --text-primary: #ffffff;
      --text-placeholder: rgba(235, 235, 245, 0.3);
    }
  }

  .text-field {
    width: 100%;
    height: 44px;
    padding: 11px 12px;
    background: var(--bg-secondary);
    border: var(--border-width, 0.5px) solid var(--border-color, var(--separator));
    border-radius: 10px;
    color: var(--text-primary);
    font-size: 17px;
    font-family: -apple-system, system-ui, sans-serif;
    letter-spacing: -0.43px;
    outline: none;
    box-sizing: border-box;
    transition:
      border-color 0.2s cubic-bezier(0.0, 0, 0.58, 1.0),
      border-width 0.2s cubic-bezier(0.0, 0, 0.58, 1.0);
  }

  .text-field::placeholder {
    color: var(--text-placeholder);
  }
</style>
```
