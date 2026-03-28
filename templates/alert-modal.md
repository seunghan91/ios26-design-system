# Alert Modal Template

> **References**
> - Components: `../components/specs/alert.md`, `../components/specs/button.md`
> - Tokens: `../tokens/spacing.json`, `../tokens/colors.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md` (Examples page: `0:3329`)
> - Parent: `../PLAN.md`

---

## 1. Overview

Alert Modal은 사용자에게 중요한 정보를 전달하거나 즉각적인 결정을 요구할 때 사용하는 작은 팝업 다이얼로그다. 화면 전체를 dimming 처리하고 중앙에 카드를 띄운다. iOS 26에서 Alert 카드는 Liquid Glass 재질을 기반으로 하되, 기존보다 더 높은 불투명도로 가독성을 유지한다.

**적용 대상**
- 삭제 확인 ("정말 삭제하시겠습니까?")
- 권한 요청 설명 (카메라, 위치 접근 전 커스텀 설명)
- 오류 메시지 (네트워크 오류, 입력 오류)
- 중요 알림 (결제 완료, 전송 완료)

**Alert 대신 다른 패턴을 사용해야 하는 경우**
- 단순 피드백 (수정 저장됨) → Toast / Snackbar
- 긴 설명이 필요한 경우 → Sheet Overlay
- 여러 옵션 선택 → Action Sheet (Sheet Overlay)
- 양식 입력 → Sheet Overlay

---

## 2. Visual Anatomy

```
전체 화면 (Full Screen Overlay):
┌─────────────────────────────────────┐
│                                     │
│   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   │  ← Dimming Overlay
│   ░░  ┌────────────────────┐  ░░   │     rgba(41,41,58, 0.23) Light
│   ░░  │                    │  ░░   │     rgba(18,18,18, 0.56) Dark
│   ░░  │  [타이틀 텍스트]    │  ░░   │     (overlays.alert)
│   ░░  │                    │  ░░   │
│   ░░  │  [메시지 본문 텍스트 │  ░░   │  ← Alert Card
│   ░░  │   2~3줄 설명]       │  ░░   │     width: 270pt
│   ░░  │                    │  ░░   │     corner-radius: 14pt
│   ░░  ├────────────────────┤  ░░   │     Liquid Glass: frost 12pt
│   ░░  │   [버튼1] │ [버튼2] │  ░░   │
│   ░░  └────────────────────┘  ░░   │
│   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   │
│                                     │
└─────────────────────────────────────┘

Alert Card 내부 구조:
┌────────────────────────────────┐
│  상단 패딩: 20pt                │
│                                │
│  제목                           │  17pt SemiBold, Center 정렬
│  (타이틀 최대 2줄)              │  labels.primary
│                                │
│  8pt 간격                      │
│                                │
│  메시지 본문                    │  13pt Regular, Center 정렬
│  (최대 3~4줄 권장)             │  labels.secondary
│                                │
│  20pt 간격                     │
├────────────────────────────────┤ ← Separator (separators.nonOpaque)
│  [버튼 영역]   height: 44pt    │  components.alert.buttonHeight
└────────────────────────────────┘
```

---

## 3. 1-Button vs 2-Button Layout Rules

### 1-Button Layout (확인 단독)

```
┌────────────────────────────────┐
│  제목                           │
│  메시지                         │
├────────────────────────────────┤
│          [확인]                 │  전폭 버튼, 17pt SemiBold
└────────────────────────────────┘

사용 예시:
  - 정보 알림 ("업데이트가 완료되었습니다")
  - 오류 통보 ("인터넷 연결을 확인해주세요")
  - 주의사항 안내
```

### 2-Button Layout (취소 + 확인)

```
┌────────────────────────────────┐
│  제목                           │
│  메시지                         │
├──────────────┬─────────────────┤
│    [취소]    │    [확인]        │  각 50% 폭, 세로 Separator
└──────────────┴─────────────────┘

취소 버튼: 왼쪽 (Regular weight)
확인 버튼: 오른쪽 (SemiBold weight, Accent 색상)

사용 예시:
  - "저장하시겠습니까?" [취소] [저장]
  - "로그아웃하시겠습니까?" [취소] [로그아웃]
```

### 3-Button Layout (세로 배열)

```
┌────────────────────────────────┐
│  제목                           │
│  메시지                         │
├────────────────────────────────┤
│          [저장]                 │  ← Positive Action (SemiBold)
├────────────────────────────────┤
│       [저장 안 함]               │  ← Destructive Action (Red)
├────────────────────────────────┤
│          [취소]                 │  ← Cancel (Regular weight, 항상 마지막)
└────────────────────────────────┘

3개 이상 버튼은 항상 세로 배열
취소 버튼은 항상 맨 아래
```

---

## 4. Destructive Button Placement

파괴적 액션(삭제, 초기화, 계정 탈퇴 등) 버튼의 위치 규칙이다.

### 배치 원칙

```
2-Button (가로 배열):
  [취소]  │  [삭제]   ← Destructive는 오른쪽
                        색상: accents.red (빨강)
                        폰트: SemiBold

3-Button (세로 배열):
  [삭제]             ← Destructive는 맨 위 (또는 두 번째)
  ─────────────────
  [취소]             ← Cancel은 항상 맨 아래
```

### Destructive 버튼 색상

| 상태 | 색상 | 토큰 |
|------|------|------|
| 활성 (Light) | `#ff383c` | `accents.red.light` |
| 활성 (Dark) | `#ff4245` | `accents.red.dark` |
| 비활성 | `rgba(255, 56, 60, 0.5)` | `miscellaneous.buttons.labelDestructiveDisabled.light` |
| 배경 (prominent) | `rgba(255, 56, 60, 0.2)` | `miscellaneous.buttons.bgDestructiveProminent.light` |

### 절대 금지

- Destructive 버튼을 왼쪽에 배치 (실수로 탭할 위험)
- Destructive 버튼을 Cancel보다 아래에 배치
- Destructive 작업에 확인 없이 즉시 실행

---

## 5. Text Field in Alert

Alert 내에 텍스트 입력 필드를 추가하는 패턴이다.

### 레이아웃

```
┌────────────────────────────────┐
│  이름 변경                      │  제목
│  새로운 이름을 입력하세요.       │  메시지 (선택)
│                                │
│  ┌──────────────────────────┐  │
│  │  텍스트 입력...           │  │  ← Text Field (+44pt)
│  └──────────────────────────┘  │  height: 44pt
│                                │
│  ┌──────────────────────────┐  │
│  │  두 번째 필드 (선택)      │  │  ← 추가 Text Field (+44pt)
│  └──────────────────────────┘  │
│                                │
├────────────────────────────────┤
│    [취소]      │    [확인]      │
└────────────────────────────────┘
```

### 높이 계산

```
기본 Alert 높이 (내용 제외): 약 144pt
  - 상단 패딩: 20pt
  - 타이틀: 22pt
  - 간격: 8pt
  - 메시지: 18pt (1줄 기준)
  - 하단 패딩: 20pt
  - 버튼: 44pt
  - 구분선: 1pt
  - 여백: 기타 11pt

Text Field 1개 추가: +44pt
Text Field 2개 추가: +88pt (44pt × 2)
```

### 구현 (UIKit)

```swift
let alert = UIAlertController(
    title: "이름 변경",
    message: "새로운 이름을 입력하세요.",
    preferredStyle: .alert
)

// 텍스트 필드 추가 (한 개당 +44pt 높이 증가)
alert.addTextField { textField in
    textField.placeholder = "이름"
    textField.autocapitalizationType = .words
}

// 두 번째 필드 (선택)
alert.addTextField { textField in
    textField.placeholder = "부제목 (선택)"
}

alert.addAction(UIAlertAction(title: "취소", style: .cancel))
alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
    let name = alert.textFields?.first?.text ?? ""
    // 처리
})

present(alert, animated: true)
```

---

## 6. Scale + Fade 등장 애니메이션

Alert가 화면에 나타날 때의 애니메이션이다.

### 파라미터

| 항목 | 값 | 토큰 |
|------|-----|------|
| Duration | **0.2s** | `duration.semantic.alertPresent` |
| Easing | `spring.stiff` | `easing.spring.stiff` |
| Scale Start | `0.85` | `transitions.scale.in.from.scale` |
| Scale End | `1.0` | `transitions.scale.in.to.scale` |
| Opacity Start | `0` | `transitions.scale.in.from.opacity` |
| Opacity End | `1` | `transitions.scale.in.to.opacity` |
| Backdrop Duration | **0.2s** | `duration.fast` |

### Spring 파라미터 (native)

```
stiff spring:
  response: 0.25
  dampingRatio: 1.0  ← 바운스 없음 (critically damped)
  → 빠르고 정확하게 안착, 흔들림 없음
```

### CSS 근사값

```css
.alert-card {
    transform: scale(0.85);
    opacity: 0;
    animation: alertPresent 0.2s cubic-bezier(0.5, 0, 0.75, 0) forwards;
    /* animations.json: easing.spring.stiff */
}

@keyframes alertPresent {
    to {
        transform: scale(1);
        opacity: 1;
    }
}

.alert-backdrop {
    opacity: 0;
    animation: backdropFadeIn 0.2s ease-out forwards;
}

@keyframes backdropFadeIn {
    to { opacity: 1; }
}
```

---

## 7. Dismiss 애니메이션

Alert가 닫힐 때의 애니메이션이다.

### 파라미터

| 항목 | 값 | 토큰 |
|------|-----|------|
| Duration | **0.15s** | `duration.semantic.alertDismiss` |
| Easing | `easeIn` | `easing.easeIn` |
| Scale Start | `1.0` | `transitions.scale.out.from.scale` |
| Scale End | `0.85` | `transitions.scale.out.to.scale` |
| Opacity Start | `1` | `transitions.scale.out.from.opacity` |
| Opacity End | `0` | `transitions.scale.out.to.opacity` |

### 등장보다 빠른 이유

Dismiss는 등장(0.2s)보다 빠른 0.15s다. 사용자가 버튼을 탭한 후 즉각적인 반응을 느껴야 하기 때문이다. 느린 dismiss는 앱이 느리다는 인상을 준다.

```css
.alert-card.dismissing {
    animation: alertDismiss 0.15s cubic-bezier(0.42, 0, 1.0, 1.0) forwards;
    /* animations.json: easing.easeIn */
}

@keyframes alertDismiss {
    to {
        transform: scale(0.85);
        opacity: 0;
    }
}
```

---

## 8. Tap Outside to Dismiss — 허용 vs 금지

| 상황 | 탭으로 닫힘? | 근거 |
|------|------------|------|
| 정보 알림 (확인 버튼 1개) | 닫힘 | 별도 결정 불필요 |
| 취소/확인 2개 버튼 | 닫힘 (= 취소와 동일 처리) | 취소 옵션이 있으므로 안전 |
| **파괴적 작업 확인** | **닫히지 않음** | 실수로 dismiss하면 의도가 불명확 |
| 필수 권한 요청 | 닫히지 않음 | 사용자가 명시적으로 선택해야 함 |
| Text Field 입력 중 | 닫히지 않음 | 입력 내용 손실 방지 |

### UIKit 구현

```swift
// UIAlertController는 기본적으로 외부 탭 dismiss 불가
// iOS에서 UIAlertController의 외부 탭 dismiss는 기본 비활성

// 커스텀 Alert View 구현 시 외부 탭 dismiss:
let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backdropTapped))
backdropView.addGestureRecognizer(tapGesture)

@objc func backdropTapped() {
    guard allowsBackdropDismiss else { return }
    dismissAlert(animated: true)
}
```

### SwiftUI Alert

```swift
// SwiftUI .alert는 외부 탭 dismiss를 자동 처리 (취소로 처리)
.alert("제목", isPresented: $showAlert) {
    Button("취소", role: .cancel) { }
    Button("삭제", role: .destructive) { delete() }
} message: {
    Text("이 항목을 삭제하시겠습니까?")
}
```

---

## 9. SwiftUI Alert / UIKit UIAlertController

### SwiftUI — 기본 Alert

```swift
struct ContentView: View {
    @State private var showDeleteAlert = false
    @State private var showNameAlert = false

    var body: some View {
        VStack {
            // 삭제 확인 Alert
            Button("삭제") { showDeleteAlert = true }
                .alert("항목 삭제", isPresented: $showDeleteAlert) {
                    Button("취소", role: .cancel) { }
                    Button("삭제", role: .destructive) {
                        deleteItem()
                    }
                } message: {
                    Text("이 항목을 삭제하면 복구할 수 없습니다.")
                }

            // 텍스트 필드 Alert
            Button("이름 변경") { showNameAlert = true }
        }
        // SwiftUI는 텍스트 필드 Alert도 지원
        .alert("이름 변경", isPresented: $showNameAlert) {
            TextField("새 이름", text: $newName)
            Button("취소", role: .cancel) { }
            Button("저장") { saveName(newName) }
        }
    }
}
```

### UIKit — UIAlertController

```swift
class ViewController: UIViewController {

    // 1-Button Alert (정보 알림)
    func showInfoAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
        // animated: true → scale+fade 애니메이션 (0.2s, stiff spring)
    }

    // 2-Button Destructive Alert
    func showDeleteAlert(item: Item) {
        let alert = UIAlertController(
            title: "\(item.name) 삭제",
            message: "삭제된 항목은 복구할 수 없습니다.",
            preferredStyle: .alert
        )

        // 취소 버튼 (왼쪽)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))

        // Destructive 버튼 (오른쪽)
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive) { _ in
            self.delete(item)
        })

        present(alert, animated: true)
    }

    // 3-Button Alert (세로 배열)
    func showSaveAlert() {
        let alert = UIAlertController(
            title: "변경사항 저장",
            message: "편집 내용을 저장하시겠습니까?",
            preferredStyle: .alert
        )

        // 추가된 순서대로 위→아래 배열
        alert.addAction(UIAlertAction(title: "저장", style: .default) { _ in
            self.save()
        })
        alert.addAction(UIAlertAction(title: "저장 안 함", style: .destructive) { _ in
            self.discardChanges()
        })
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        // .cancel은 자동으로 맨 아래 배치

        present(alert, animated: true)
    }
}
```

### 핵심 토큰 요약

| 항목 | 값 | 토큰 경로 |
|------|-----|----------|
| Alert 카드 폭 | **270pt** | `components.alert.width` |
| 좌우 내부 패딩 | **16pt** | `components.alert.paddingHorizontal` |
| 상하 내부 패딩 | **20pt** | `components.alert.paddingVertical` |
| 버튼 높이 | **44pt** | `components.alert.buttonHeight` |
| Corner Radius | **14pt** | `components.alert.cornerRadius` |
| Backdrop (Light) | `rgba(41,41,58, 0.23)` | `overlays.alert.light` |
| Backdrop (Dark) | `rgba(18,18,18, 0.56)` | `overlays.alert.dark` |
| 등장 Duration | **0.2s** | `duration.semantic.alertPresent` |
| 등장 Easing | spring.stiff | `easing.spring.stiff` |
| Dismiss Duration | **0.15s** | `duration.semantic.alertDismiss` |
| Dismiss Easing | easeIn | `easing.easeIn` |
| Scale 범위 | `0.85 → 1.0` | `transitions.scale.in` |
| Destructive 색 (Light) | `#ff383c` | `accents.red.light` |
| Destructive 색 (Dark) | `#ff4245` | `accents.red.dark` |
