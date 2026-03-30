# Sheet Form — iOS 26 페이지 레시피

> **References**
> - Templates: `../../templates/`
> - Components: `../../components/specs/`
> - Tokens: `../../tokens/`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="...")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Sheet 내 폼 화면 (Sheet Form) |
| **용도** | 짧은 데이터 입력 폼 — 이름 / 이메일 / 메모 등 3~5개 필드 |
| **탐색 깊이** | Overlay (Sheet) — 부모 화면 위에 반투명으로 표시 |
| **상태 수** | 초기 / 입력 중 (키보드 활성) / 유효성 통과 / 오류 |
| **iOS 26 특이사항** | Sheet 컨테이너 Liquid Glass, 키보드 avoidance 내장, grabber 표시 |

Sheet Form은 전체 화면 전환 없이 간단한 데이터를 수집할 때 사용한다. iOS 26에서 Sheet는 Liquid Glass 재질 컨테이너에 담기며, 뒤 화면이 흐릿하게 보이면서 depth감이 생긴다. 키보드 등장 시 Sheet가 자동으로 위로 올라가는 avoidance 처리가 필수이다.

---

## 사용된 Template

**`sheet-overlay.md`** — Bottom Sheet + Liquid Glass + Grabber

```
Template 조합:
- Sheet: .medium detent 기본, 키보드 활성 시 .large로 자동 전환
- Toolbar: Sheet 전용 (Cancel 왼쪽, Done 오른쪽, 제목 중앙)
- Content: ScrollView (폼이 길어질 경우 대비)
- 키보드: safeAreaInsets.bottom 자동 처리
```

---

## 컴포넌트 계층 (ASCII 와이어프레임)

```
iPhone 16 Pro (393 × 852 pt) — Sheet .medium detent
┌─────────────────────────────────────────┐
│  ░░░░░░░░  배경 화면 (dimming)  ░░░░░░░  │  ← 배경 (활성 화면 흐림 처리됨)
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │    dimming: rgba(0,0,0, 0.40)
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│                                          │
│  ┌───────────────────────────────────┐  │
│  │         ┄┄┄┄┄┄┄                  │  │  ← Grabber (36×5pt, center, top 8pt)
│  │                                   │  │    Liquid Glass 컨테이너 시작
│  │  [취소]     새 항목 추가    [추가]  │  │  ← Sheet Toolbar
│  │                                   │  │    높이: 44pt
│  │  ─────────────────────────────    │  │    hairline separator
│  │                                   │  │
│  │  이름 *                            │  │  ← 섹션 라벨 (13pt, secondary)
│  │  ┌─────────────────────────────┐  │  │
│  │  │ 홍길동                       │  │  │  ← Text Field #1 (이름)
│  │  └─────────────────────────────┘  │  │    height: 44pt
│  │                                   │  │    placeholder: "이름 입력"
│  │  이메일                            │  │
│  │  ┌─────────────────────────────┐  │  │  ← Text Field #2 (이메일)
│  │  │ example@email.com           │  │  │    keyboardType: .emailAddress
│  │  └─────────────────────────────┘  │  │
│  │  ✗ 올바른 이메일 형식이 아닙니다    │  │  ← 유효성 오류 메시지 (12pt, red)
│  │                                   │  │
│  │  메모                              │  │
│  │  ┌─────────────────────────────┐  │  │  ← Text Field #3 (메모, multiline)
│  │  │ 여기에 메모를 입력하세요...   │  │  │    minHeight: 80pt, maxHeight: 120pt
│  │  │                             │  │  │
│  │  └─────────────────────────────┘  │  │
│  │                                   │  │
│  │  공개 설정                         │  │
│  │  ┌─────────────────────────────┐  │  │  ← Toggle Row
│  │  │  공개로 설정         [Toggle]│  │  │    toggle: ON (blue)
│  │  └─────────────────────────────┘  │  │
│  │  [공개 설정 시 모든 사용자가 볼 수  │  │  ← 설명 텍스트 (12pt, secondary)
│  │   있습니다]                        │  │
│  │                                   │  │
│  └───────────────────────────────────┘  │  ← Sheet 하단 (내부 Safe Area 포함)
└─────────────────────────────────────────┘

키보드 등장 상태 (offset ≈ 346pt):
┌─────────────────────────────────────────┐
│  ┌───────────────────────────────────┐  │  ← Sheet가 위로 밀려 올라감
│  │  [취소]     새 항목 추가    [추가]  │  │
│  │  ─────────────────────────────    │  │
│  │                                   │  │
│  │  이름 *                            │  │
│  │  ┌─────────────────────────────┐  │  │
│  │  │ 홍길동  |                   │  │  │  ← 포커스된 필드 (파란 하이라이트)
│  │  └─────────────────────────────┘  │  │
│  │  이메일                            │  │
│  │  ┌─────────────────────────────┐  │  │
│  │  │ example@email.com           │  │  │
│  │  └─────────────────────────────┘  │  │
│  │  메모                              │  │
│  │  ┌─────────────────────────────┐  │  │  (나머지는 스크롤로 접근)
│  └───────────────────────────────────┘  │
│  ┌─────────────────────────────────────┐│  ← iOS 키보드 (346pt 높이)
│  │  q w e r t y u i o p               ││
│  │  a s d f g h j k l                 ││
│  │  ⇧  z x c v b n m  ⌫              ││
│  │  123  ␣  ⏎                         ││
│  └─────────────────────────────────────┘│
└─────────────────────────────────────────┘

유효성 통과 상태 (Done 버튼 활성화):
│  [취소]     새 항목 추가    [추가 ●]  │  ← "추가" 버튼 파란색으로 변환
```

---

## 사용된 Components 목록

| 컴포넌트 | 파일 | 사용 위치 | Variant |
|---------|------|---------|---------|
| Toolbar (Sheet) | `toolbar.md` (_Buttons-Top-Sheets) | Sheet 상단 | Cancel + Title + Done |
| Text Field | `text-field.md` | 이름 / 이메일 / 메모 입력 | Rounded / Multiline |
| Toggle | `toggle.md` | 공개 설정 | Default |
| Button | `button.md` | Done (추가) 버튼 | Primary (tinted) |
| Sheet | `sheet.md` | 전체 컨테이너 | .medium → .large |

---

## 레이아웃 구조

```
Sheet 내부 수직 레이아웃 치수:

Grabber 영역:       13pt (5pt grabber + 4pt 상하 margin)
Toolbar 영역:       44pt
Separator:          1pt (hairline)
Content ScrollView: flex

Text Field 그룹 패딩:
  섹션 라벨 top:    20pt
  섹션 라벨 bottom: 6pt
  섹션 라벨:        13pt Semibold, labels.secondary
  필드 높이:        44pt (단일행) / 80-120pt (다중행)
  필드 사이 간격:    16pt
  오류 메시지 top:  4pt (12pt Regular, accents.red)

Toggle Row:
  height:           44pt
  horizontal-pad:   16pt
  title:            17pt Regular, primary

설명 텍스트:
  top: 6pt
  font: 12pt Regular, labels.secondary
  horizontal-pad:   16pt

Sheet 하단 패딩:    20pt + Safe Area
```

### Text Field 스타일 (iOS 26)

```
기본 상태:
  background: fills.secondary (#f2f2f7 light)
  border: 없음 (filled 스타일)
  corner-radius: 10pt
  padding: 12pt horizontal, 11pt vertical
  placeholder: labels.tertiary
  font: 17pt Regular

포커스 상태:
  border: 2pt, accents.blue (#0088ff)
  배경: 동일
  커서: accents.blue

오류 상태:
  border: 2pt, accents.red (#ff383c)
  오류 메시지: 필드 하단 4pt, 12pt Regular, accents.red
  아이콘: exclamationmark.circle.fill (12pt, red)

비활성 상태:
  opacity: 0.4
  사용자 인터랙션: 없음
```

### 색상 토큰 매핑

| 요소 | 토큰 | 값 (Light) |
|------|------|-----------|
| Sheet 배경 | Liquid Glass | blur 20pt + fills.glass |
| Toolbar 배경 | Liquid Glass (연속) | blur 12pt |
| 필드 배경 | `fills.secondary` | `#f2f2f7` |
| 라벨 | `labels.secondary` | `#3c3c43 60%` |
| 포커스 border | `accents.blue.light` | `#0088ff` |
| 오류 border | `accents.red.light` | `#ff383c` |
| Done 비활성 | `labels.tertiary` | `#3c3c43 30%` |
| Done 활성 | `accents.blue.light` | `#0088ff` |
| Dimming | overlays.alert | `rgba(0,0,0, 0.40)` |

---

## 특이사항 / 커스터마이징 포인트

### Sheet Detent 전환 전략
```
초기: .medium (화면 하단 절반)
  → 텍스트 필드 포커스 + 키보드 등장
  → Sheet 자동으로 .large로 확장 (키보드 높이 확보)
  → 키보드 닫힘: .medium으로 복귀 (선택)

코드: .presentationDetents([.medium, .large])
     .presentationDragIndicator(.visible)
```

### 키보드 Avoidance 처리
- SwiftUI: `.scrollDismissesKeyboard(.interactively)` 적용
- 포커스된 필드가 키보드 위에 최소 20pt 여백이 확보되도록 자동 스크롤
- 배경 탭 → 키보드 dismiss (`.onTapGesture { UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil) }`)

### 폼 유효성 검사 타이밍
- **실시간 (onChange)**: 입력 중 오류 즉시 표시 — 이메일 형식
- **포커스 이탈 (onSubmit/onFocusLost)**: 필드 떠날 때 검사 — 필수값
- **제출 시 (Done 탭)**: 전체 검사 + 오류 필드로 포커스 이동
- Done 버튼: 모든 필수값 입력 완료 시에만 파란색 활성화

### 비어있는 "추가" 버튼 방지
```swift
// 유효성 조건 예시
var isFormValid: Bool {
    !name.isEmpty
    && name.count >= 2
    && isValidEmail(email)
}
```

### 취소 버튼 동작
- 내용 변경 없음: 즉시 Sheet 닫힘
- 내용 변경 있음: Confirmation Dialog 표시
  → "변경 내용을 삭제하시겠습니까? / 삭제 (Destructive) / 계속 편집 (Cancel)"

---

## 애니메이션 시나리오

### 1. Sheet 등장
```
트리거: 부모 화면에서 버튼 탭
Duration: 0.45s
Curve: spring(damping: 0.8, response: 0.4)
요소:
  - Sheet: y +852pt→0 (bottom-up 슬라이드)
  - Dimming 오버레이: opacity 0→0.40
  - 부모 화면: scale 1.0→0.93 (약간 축소, iOS 기본 동작)
  - Sheet 배경: Liquid Glass blur 0→20pt
```

### 2. 키보드 등장 + Sheet 확장
```
트리거: 텍스트 필드 탭 → 키보드 등장
Duration: 0.35s (키보드 애니메이션과 동기화)
Curve: easeInOut (키보드 curve 따름)
요소:
  - Sheet: height .medium→.large (상단으로 확장)
  - 포커스된 필드: 키보드 위로 스크롤 (자동)
  - 키보드: y +346pt→0 (bottom-up)
```

### 3. 오류 메시지 등장
```
트리거: 유효성 검사 실패
Duration: 0.2s + bounce
Curve: spring(damping: 0.6)
요소:
  - 오류 텍스트: opacity 0→1, height 0→16pt
  - 오류 텍스트: x -4pt→0 (좌우 흔들림 효과)
  - 필드 border: color animated → accents.red
  - 햅틱: .warning
```

### 4. Done 버튼 성공 (Submit)
```
트리거: Done 탭 + 유효성 통과
Duration: 0.3s dismiss
요소:
  - Done 버튼: brief scale 0.9→1.0
  - Sheet: y 0→+852pt (닫힘)
  - 성공 햅틱: .success
  - 부모 화면: scale 0.93→1.0 복귀
```

---

## 프레임워크별 전체 코드 예시

### SwiftUI (iOS 26)

```swift
import SwiftUI

struct AddItemSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var email = ""
    @State private var memo = ""
    @State private var isPublic = true
    @State private var emailError: String? = nil
    @State private var hasChanges = false
    @State private var showDiscardAlert = false
    @FocusState private var focusedField: Field?

    enum Field { case name, email, memo }

    private var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty
        && name.count >= 2
        && (email.isEmpty || isValidEmail(email))
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // ── 이름 필드 ────────────────────
                    fieldLabel("이름", required: true)

                    TextField("이름 입력", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .focused($focusedField, equals: .name)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .email }
                        .onChange(of: name) { hasChanges = true }

                    Spacer().frame(height: 16)

                    // ── 이메일 필드 ──────────────────
                    fieldLabel("이메일", required: false)

                    TextField("example@email.com", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .focused($focusedField, equals: .email)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .memo }
                        .onChange(of: email) {
                            hasChanges = true
                            emailError = email.isEmpty ? nil
                                : (isValidEmail(email) ? nil : "올바른 이메일 형식이 아닙니다")
                        }
                        .overlay(alignment: .trailing) {
                            if let _ = emailError {
                                Image(systemName: "exclamationmark.circle.fill")
                                    .foregroundStyle(.red)
                                    .padding(.trailing, 12)
                            }
                        }

                    if let error = emailError {
                        Label(error, systemImage: "exclamationmark.circle.fill")
                            .font(.caption)
                            .foregroundStyle(.red)
                            .padding(.top, 4)
                            .transition(.opacity.combined(with: .move(edge: .top)))
                    }

                    Spacer().frame(height: 16)

                    // ── 메모 필드 (multiline) ─────────
                    fieldLabel("메모", required: false)

                    TextField("여기에 메모를 입력하세요...", text: $memo, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(3...5)
                        .focused($focusedField, equals: .memo)
                        .submitLabel(.done)
                        .onSubmit { focusedField = nil }
                        .onChange(of: memo) { hasChanges = true }

                    Spacer().frame(height: 24)

                    // ── Toggle ───────────────────────
                    Divider()
                    Toggle("공개로 설정", isOn: $isPublic)
                        .padding(.vertical, 12)
                        .onChange(of: isPublic) { hasChanges = true }
                    Divider()

                    Text("공개 설정 시 모든 사용자가 볼 수 있습니다")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.top, 6)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 40)
                .animation(.spring(damping: 0.75), value: emailError)
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("새 항목 추가")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        if hasChanges {
                            showDiscardAlert = true
                        } else {
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("추가") {
                        submitForm()
                    }
                    .disabled(!isFormValid)
                    .fontWeight(.semibold)
                }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
        .presentationBackground(.regularMaterial)
        .confirmationDialog("변경 내용을 삭제하시겠습니까?",
                            isPresented: $showDiscardAlert,
                            titleVisibility: .visible) {
            Button("변경 내용 삭제", role: .destructive) { dismiss() }
            Button("계속 편집", role: .cancel) {}
        }
    }

    private func fieldLabel(_ text: String, required: Bool) -> some View {
        HStack(spacing: 2) {
            Text(text)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
            if required {
                Text("*")
                    .font(.subheadline)
                    .foregroundStyle(.red)
            }
        }
        .padding(.bottom, 6)
    }

    private func isValidEmail(_ email: String) -> Bool {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return email.range(of: regex, options: .regularExpression) != nil
    }

    private func submitForm() {
        guard isFormValid else { return }
        // 저장 로직
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        dismiss()
    }
}

// 사용 예시 (부모 화면)
struct ParentView: View {
    @State private var showSheet = false

    var body: some View {
        Button("새 항목 추가") {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            AddItemSheet()
        }
    }
}
```
