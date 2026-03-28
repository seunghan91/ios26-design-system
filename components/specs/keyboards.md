# Keyboards — iOS 26 컴포넌트 스펙

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24674")`

---

## 1. Overview

iOS 26 Keyboard는 소프트웨어 키보드 레이아웃 참조 컴포넌트다. iPhone 24종, iPad 9종, 총 33개 변형이 Figma에 정리되어 있다.

iOS 26의 가장 큰 키보드 변화는 **Liquid Glass 소재 배경** 적용이다. 반투명 유리질 배경으로 아래 콘텐츠가 비쳐 보이며, iOS 26 전반의 머티리얼 언어와 일관성을 유지한다.

| 항목 | 값 |
|------|-----|
| **Figma Node** | `507:24674` — COMPONENT_SET |
| **섹션 그룹** | Keyboards |
| **총 variant 수** | iPhone 24종 + iPad 9종 = 33종 |
| **배경 머티리얼** | Liquid Glass (backdrop-filter: blur + tint) |

---

## 2. iPhone Keyboard 섹션 (24종)

### 2-1. 기본 QWERTY

| 변형 | 특징 |
|------|------|
| **QWERTY Light** | 라이트 모드 표준 영문 키보드 |
| **QWERTY Dark** | 다크 모드 표준 영문 키보드 |
| **QWERTY 한국어** | 천지인 / 두벌식 / 세벌식 레이아웃 포함 |
| **QWERTY 이모지** | 이모지 패널 (최근 사용 + 카테고리 탭) |

### 2-2. 특수 입력 타입

| 변형 | `keyboardType` | 주요 차이 |
|------|---------------|----------|
| **Numeric (숫자패드)** | `.numberPad` | 3×4 숫자 그리드 |
| **Symbol** | `.default` + symbol toggle | `#+= ` 레이어 |
| **Email** | `.emailAddress` | `@`, `.` 키 강조, 스페이스바 축소 |
| **URL** | `.URL` | `/`, `.com` 퀵 키 추가 |
| **Phone** | `.phonePad` | 다이얼패드 스타일 3×4 |
| **Search** | `.webSearch` | 스페이스바→"이동" 리턴 키 |
| **Decimal Pad** | `.decimalPad` | 숫자 + 소수점 |
| **Number & Punctuation** | `.numbersAndPunctuation` | 전체 특수문자 포함 |

### 2-3. 언어별

| 변형 | 특징 |
|------|------|
| **한국어 Light** | 두벌식 레이아웃, 높이 258pt |
| **한국어 Dark** | 두벌식 다크 모드 |
| **Japanese (Kana)** | 가나 그리드 레이아웃 |
| **Chinese (Simplified)** | 병음 / 획수 전환 |
| **Arabic** | RTL 레이아웃 |

### 2-4. 특수 기능

| 변형 | 특징 |
|------|------|
| **QuickType Bar** | 예측 입력 바 포함 레이아웃 |
| **Dictation Active** | 음성 입력 중 상태 |

---

## 3. iPad Keyboard 섹션 (9종)

| 변형 | 특징 |
|------|------|
| **풀사이즈 Light** | 전체 너비, 하드웨어 키보드 유사 레이아웃 |
| **풀사이즈 Dark** | 다크 모드 전체 너비 |
| **분리형 (Split) Light** | 좌/우 분리, 가운데 공간, 엄지 타이핑 |
| **분리형 (Split) Dark** | 다크 모드 분리형 |
| **플로팅 (Floating) Light** | 320pt 너비 고정, 위치 이동 가능 |
| **플로팅 (Floating) Dark** | 다크 모드 플로팅 |
| **언도크 (Undocked) Light** | 화면 하단 고정 해제, 이동 가능 |
| **iPad 한국어** | 두벌식 풀사이즈 |
| **iPad 이모지** | 이모지 패널 풀사이즈 |

---

## 4. 치수 (Dimensions)

### iPhone Portrait

| 키보드 타입 | 너비 | 높이 | 비고 |
|-----------|------|------|------|
| QWERTY (기본) | 화면 너비 100% | **216pt** | 안전 기본값 |
| 한국어 / 이모지 | 화면 너비 100% | **258pt** | 행 추가됨 |
| 숫자패드 / 전화 | 화면 너비 100% | **216pt** | 그리드 3열 |
| QuickType 포함 | 화면 너비 100% | **260pt** | 예측 바 44pt 추가 |

### iPhone Landscape

| 키보드 타입 | 너비 | 높이 |
|-----------|------|------|
| 모든 타입 | 화면 너비 100% | **162pt** |

### iPad

| 키보드 타입 | 너비 | 높이 (11") | 높이 (13") |
|-----------|------|-----------|-----------|
| 풀사이즈 | 화면 너비 100% | **265pt** | **304pt** |
| 분리형 | 화면 너비 100% | **265pt** | **304pt** |
| 플로팅 | **320pt** (고정) | **254pt** | **254pt** |
| 언도크 | 화면 너비 100% | **265pt** | **304pt** |

---

## 5. 내부 구조 — 키 치수

### iPhone 키 치수

| 요소 | 높이 | 너비 | 코너 반경 |
|------|------|------|---------|
| 일반 문자 키 | **42pt** | ~42pt | 5pt |
| 스페이스바 | 42pt | 가변 (~50%) | 5pt |
| 리턴/Shift/Delete | 42pt | ~52pt | 5pt |
| 패딩 (키 간격) | — | 6pt 수직 / 6pt 수평 | — |
| 키보드 상단 패딩 | 12pt | — | — |
| 키보드 하단 패딩 | 4pt + Safe Area | — | — |

### iPad 키 치수

| 요소 | 높이 | 너비 |
|------|------|------|
| 일반 문자 키 | **56pt** | ~68pt |
| 스페이스바 | 56pt | 가변 |
| 기능 키 | 56pt | ~82pt |

### QuickType 예측 바

| 요소 | 높이 | 배경 |
|------|------|------|
| QuickType bar | **44pt** | Liquid Glass (얇은 tint) |

---

## 6. 색상 & 머티리얼

### 키보드 배경

| 모드 | 소재 | 토큰 |
|------|------|------|
| Light | Liquid Glass — `systemChromeMaterial` | `colors.backgrounds.tertiary` @ 72% |
| Dark | Liquid Glass Dark | `colors.backgrounds.base` @ 64% |

> `backdrop-filter: blur(40px)` 적용. iOS 26에서 키보드 아래 콘텐츠가 흐릿하게 투과됨.

### 키 색상

| 키 종류 | Light 배경 | Dark 배경 | 레이블 |
|--------|-----------|----------|-------|
| 문자 키 (primary) | `#FFFFFF` | `rgba(105,105,120,0.64)` | `colors.labels.primary` |
| 기능 키 (secondary) | `rgba(172,177,192,1)` | `rgba(43,46,53,1)` | `colors.labels.primary` |
| 스페이스바 | `#FFFFFF` | `rgba(105,105,120,0.64)` | `colors.labels.primary` |
| 리턴 키 | 기능 키와 동일 | 기능 키와 동일 | `colors.labels.primary` |
| 리턴 키 (Go/Search) | `accents.blue` | `accents.blue` | `#FFFFFF` |

### 키 그림자 (iOS 26)

```
box-shadow: 0px 1px 0px rgba(0, 0, 0, 0.35);
```

---

## 7. 타이포그래피

| 요소 | 폰트 | 크기 | 굵기 |
|------|------|------|------|
| 문자 키 레이블 | SF Pro | 23pt | Regular |
| 숫자/특수 키 레이블 | SF Pro | 16pt | Regular |
| 기능 키 (Shift 등) 레이블 | SF Pro | 15pt | Regular |
| QuickType 예측어 | SF Pro | 16pt | Regular |
| QuickType 선택어 (중앙) | SF Pro | 16pt | **Semibold** |

---

## 8. 애니메이션

`animations.json`의 semantic 키 참조:

| 이벤트 | duration | curve | 비고 |
|--------|----------|-------|------|
| 키보드 올라옴 (`keyboardWillShow`) | `0.35s` | `spring` `damping=0.85` | iOS 26 기본값 |
| 키보드 내려감 (`keyboardWillHide`) | `0.25s` | `easeIn` | |
| 키 눌림 (press highlight) | `0.08s` | `easeOut` | |
| 팝업 글자 표시 | `0.1s` | `spring` | |
| QuickType 갱신 | `0.15s` | `easeInOut` | |
| Liquid Glass 리플렉션 shift | `0.3s` | `easeInOut` | 배경 색 변화 시 |

---

## 9. 개발자 구현 가이드

### 9-1. UIKit (Swift)

```swift
// 키보드 올라옴/내려감 감지
override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(
        self,
        selector: #selector(keyboardWillShow(_:)),
        name: UIResponder.keyboardWillShowNotification,
        object: nil
    )
    NotificationCenter.default.addObserver(
        self,
        selector: #selector(keyboardWillHide(_:)),
        name: UIResponder.keyboardWillHideNotification,
        object: nil
    )
}

@objc func keyboardWillShow(_ notification: Notification) {
    guard let keyboardFrame = notification.userInfo?[
        UIResponder.keyboardFrameEndUserInfoKey
    ] as? CGRect else { return }

    let keyboardHeight = keyboardFrame.height
    // keyboardLayoutGuide를 사용하면 자동 처리됨 (iOS 15+)
}

// keyboardLayoutGuide 사용 (iOS 15+, 권장)
override func viewDidLoad() {
    super.viewDidLoad()
    NSLayoutConstraint.activate([
        textField.bottomAnchor.constraint(
            equalTo: view.keyboardLayoutGuide.topAnchor,
            constant: -16
        )
    ])
}

// 키보드 타입 설정
textField.keyboardType = .emailAddress
textField.keyboardType = .URL
textField.keyboardType = .numberPad
textField.returnKeyType = .search
textField.textContentType = .username // QuickType 힌트

// 키보드 해제
textField.resignFirstResponder()
// 또는
view.endEditing(true)
```

### 9-2. SwiftUI

```swift
struct ContentView: View {
    @State private var text = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack {
            TextField("이메일 입력", text: $text)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .submitLabel(.done)
                .focused($isFocused)
                .onSubmit {
                    isFocused = false
                }
        }
        // 키보드 올라올 때 아래 콘텐츠 밀어올리기
        .ignoresSafeArea(.keyboard, edges: .bottom)
        // 또는 키보드와 같이 올라가도록:
        // .safeAreaInset(edge: .bottom) { ... }
    }
}

// 키보드 높이 감지 (필요한 경우)
struct KeyboardAdaptive: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(
                NotificationCenter.default.publisher(
                    for: UIResponder.keyboardWillShowNotification
                )
            ) { notification in
                if let frame = notification.userInfo?[
                    UIResponder.keyboardFrameEndUserInfoKey
                ] as? CGRect {
                    keyboardHeight = frame.height
                }
            }
            .onReceive(
                NotificationCenter.default.publisher(
                    for: UIResponder.keyboardWillHideNotification
                )
            ) { _ in
                keyboardHeight = 0
            }
    }
}
```

### 9-3. Flutter

```dart
// 키보드 높이 감지
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // viewInsets.bottom = 키보드 높이
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      // resizeToAvoidBottomInset: true (기본값) → 자동으로 올라감
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        // 스크롤로 키보드 avoidance
        padding: EdgeInsets.only(bottom: keyboardHeight),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: '이메일'),
            ),
          ],
        ),
      ),
    );
  }
}

// 키보드 타입 매핑
// TextInputType.text           → QWERTY 기본
// TextInputType.emailAddress   → Email 키보드
// TextInputType.url            → URL 키보드
// TextInputType.number         → 숫자패드
// TextInputType.phone          → 전화 키보드
// TextInputType.multiline      → 리턴 키 = 개행

// 키보드 수동 해제
FocusScope.of(context).unfocus();
// 또는
FocusManager.instance.primaryFocus?.unfocus();
```

### 9-4. Svelte / Web (CSS)

```typescript
// CSS 환경 변수로 키보드 높이 사용 (iOS Safari 15.4+)
// env(keyboard-inset-height) — Virtual Keyboard API

// styles.css
.input-container {
  /* 키보드가 올라왔을 때 컨테이너 위치 조정 */
  padding-bottom: env(keyboard-inset-height, 0px);
  transition: padding-bottom 0.25s ease;
}

/* iOS Safari에서 안전 영역 + 키보드 결합 */
.fixed-bottom {
  bottom: max(
    env(safe-area-inset-bottom, 0px),
    env(keyboard-inset-height, 0px)
  );
}
```

```typescript
// Svelte: visualViewport API로 키보드 감지
<script lang="ts">
  import { onMount, onDestroy } from 'svelte';

  let keyboardHeight = 0;

  function onViewportResize() {
    if (window.visualViewport) {
      // 레이아웃 뷰포트 높이 - 비주얼 뷰포트 높이 = 키보드 높이
      keyboardHeight = window.innerHeight - window.visualViewport.height;
    }
  }

  onMount(() => {
    window.visualViewport?.addEventListener('resize', onViewportResize);
  });

  onDestroy(() => {
    window.visualViewport?.removeEventListener('resize', onViewportResize);
  });
</script>

<div style="padding-bottom: {keyboardHeight}px;">
  <input type="email" />
</div>
```

### 9-5. Rails (Hotwire / Stimulus)

```javascript
// Stimulus Controller
// app/javascript/controllers/keyboard_avoidance_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]

  connect() {
    if (window.visualViewport) {
      window.visualViewport.addEventListener(
        "resize", this.handleViewportResize.bind(this)
      )
    }
  }

  disconnect() {
    window.visualViewport?.removeEventListener(
      "resize", this.handleViewportResize.bind(this)
    )
  }

  handleViewportResize() {
    const keyboardHeight =
      window.innerHeight - window.visualViewport.height
    this.formTarget.style.marginBottom = `${keyboardHeight}px`
  }
}
```

---

## 10. 주의 사항 & 엣지 케이스

| 상황 | 처리 방법 |
|------|---------|
| 외장 키보드 연결 (iPad) | 소프트웨어 키보드 숨겨짐, `keyboardWillHide` 호출됨 |
| 스테이지 매니저 (iPadOS 16+) | 윈도우 크기 변경 → `keyboardLayoutGuide` 자동 대응 |
| 플로팅 키보드 (iPad) | `keyboardFrameEnd` 위치가 화면 하단이 아닐 수 있음 |
| 한국어 IME 조합 중 | `textField(_:shouldChangeCharactersIn:)` 조합 완료 전 호출 주의 |
| `returnKeyType = .search` | 빈 텍스트일 때 비활성화 여부: `enablesReturnKeyAutomatically = true` |
| 다크모드 전환 | `traitCollectionDidChange` → 키보드 소재 자동 갱신 |
| Liquid Glass 밑 스크롤 콘텐츠 | `scrollView.contentInsetAdjustmentBehavior = .automatic` 권장 |

---

## 11. iPhone 키보드 높이 빠른 참조

> 레이아웃 계산 시 하드코딩 금지. 반드시 API로 동적 감지할 것.
> 아래 값은 **대략적인 참고값**이며 기기/iOS 버전마다 다를 수 있음.

| 기기 | Portrait | Landscape | 한국어 Portrait |
|------|----------|-----------|--------------|
| iPhone 16 (393pt) | 291pt | 162pt | 303pt |
| iPhone 16 Pro (393pt) | 291pt | 162pt | 303pt |
| iPhone SE 3rd (375pt) | 253pt | 162pt | 271pt |
| iPhone 16 Plus (430pt) | 301pt | 162pt | 313pt |

> Safe Area inset 포함 값. 실제 키 영역은 ≈ 216pt / 258pt.
