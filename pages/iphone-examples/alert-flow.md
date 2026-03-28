# Alert Flow — iOS 26 페이지 레시피

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
| **화면명** | 삭제 확인 Alert 플로우 (Destructive Alert Flow) |
| **용도** | 되돌릴 수 없는 액션(삭제, 탈퇴, 초기화) 전 사용자 의도 확인 |
| **탐색 깊이** | Overlay (Alert) — 모든 화면 위 최상단 표시 |
| **상태 수** | 트리거 대기 → Alert 표시 중 → 확인(삭제 실행) / 취소(원래로 복귀) |
| **iOS 26 특이사항** | Alert 카드 Liquid Glass, spring scale 애니메이션, Destructive 버튼 빨간색 |

삭제 확인 Alert는 가장 흔한 destructive 패턴이다. 사용자가 "삭제" 버튼을 탭하면 확인 Alert를 띄워 실수를 방지한다. iOS 26에서 Alert 카드는 Liquid Glass 소재로 빌드되며, 등장 시 spring scale 애니메이션이 특징이다. 버튼 배치는 2-button horizontal (취소 | 삭제) 또는 2-button vertical (title-aligned) 중 상황에 따라 선택한다.

---

## 사용된 Template

**`alert-modal.md`** — Dimming overlay + Alert Card + Button(destructive + cancel)

```
Template 조합:
- Alert 컨테이너: width 270pt, Liquid Glass, corner-radius 14pt
- Dimming: 전체 화면 rgba(0,0,0, 0.40)
- 버튼 레이아웃: 2개일 때 horizontal, 3개 이상 vertical
- 최상위 z-index (모든 UI 위)
```

---

## 전체 플로우 다이어그램

```
┌─────────────────────────────────────────┐
│           [목록 화면 - 정상 상태]          │
│                                          │
│  ─────────────────────────────────────  │
│  │ 🔴  항목 1 제목               [⋯] │  │  ← 스와이프 → "삭제" 버튼 노출
│  ─────────────────────────────────────  │     또는 롱프레스 컨텍스트 메뉴
│  │ 🟢  항목 2 제목               [⋯] │  │
│  ─────────────────────────────────────  │
│                                          │
└──────────────────────────────────────── ┘
                    │
            스와이프 → "삭제" 탭
                    │
                    ▼
┌─────────────────────────────────────────┐
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │  ← Dimming 오버레이 등장
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░   ┌─────────────────────────┐  ░░  │
│  ░░   │                         │  ░░  │  ← Alert Card (270pt)
│  ░░   │   항목 삭제              │  ░░  │    Liquid Glass (frost 12pt)
│  ░░   │                         │  ░░  │    corner-radius: 14pt
│  ░░   │  이 항목을 삭제하면 복구  │  ░░  │
│  ░░   │  할 수 없습니다. 계속    │  ░░  │    타이틀: 17pt Semibold
│  ░░   │  하시겠습니까?           │  ░░  │    메시지: 13pt Regular
│  ░░   │                         │  ░░  │
│  ░░   ├─────────────┬───────────┤  ░░  │  ← 버튼 구분선 (horizontal)
│  ░░   │    취소     │   삭제    │  ░░  │    취소: 17pt Regular, blue
│  ░░   └─────────────┴───────────┘  ░░  │    삭제: 17pt Semibold, red
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
└─────────────────────────────────────────┘
                    │
        ┌───────────┴───────────┐
   "취소" 탭                "삭제" 탭
        │                       │
        ▼                       ▼
┌──────────────┐       ┌──────────────────┐
│ Alert 닫힘   │       │ 로딩 상태 (선택)  │
│ 원래 목록    │       │ 삭제 API 호출     │
│ 복귀         │       │ 성공: 항목 제거   │
└──────────────┘       │ + 토스트 메시지   │
                       │ 실패: 오류 Alert  │
                       └──────────────────┘
```

---

## 컴포넌트 계층 (ASCII 와이어프레임)

```
Alert 카드 상세 해부 (270pt 너비):

┌────────────────────────────────────┐  ← corner-radius 14pt
│                                    │  ← Liquid Glass background
│  [타이틀 텍스트 — 항목 삭제]        │    frost blur: 12pt
│                                    │    배경 fill: fills.glass
│  [메시지 텍스트 — 이 항목을 삭제하  │
│   면 복구할 수 없습니다. 계속하시   │  타이틀 영역 패딩:
│   겠습니까?]                        │    top: 20pt, horizontal: 16pt
│                                    │    bottom: 16pt (메시지 있을 때)
│                                    │
├────────────────────────────────────┤  ← 1pt 구분선, separator color
│                                    │
│    [취소]          │   [삭제]       │  ← 버튼 영역 (44pt 높이)
│                   │                │    취소: 17pt Regular, accents.blue
│                                    │    삭제: 17pt Semibold, accents.red
└────────────────────────────────────┘    버튼 탭 시: 배경 highlighted

버튼 3개 이상일 때 (vertical 레이아웃):
┌────────────────────────────────────┐
│  타이틀                             │
│  메시지                             │
├────────────────────────────────────┤
│          [삭제 (destructive)]       │  ← 17pt Semibold, red, 44pt
├────────────────────────────────────┤
│          [보관함으로 이동]           │  ← 17pt Regular, blue, 44pt
├────────────────────────────────────┤
│          [취소 (cancel)]            │  ← 17pt Semibold, blue, 44pt
└────────────────────────────────────┘
   (Cancel은 항상 맨 아래)

삭제 진행 중 상태 (로딩):
┌────────────────────────────────────┐
│  [타이틀]                           │
│  [메시지]                           │
├────────────────────────────────────┤
│         ◌  삭제 중...               │  ← 버튼 대신 스피너 + 텍스트
└────────────────────────────────────┘

오류 Alert (삭제 실패):
┌────────────────────────────────────┐
│  삭제 실패                          │
│                                    │
│  네트워크 오류가 발생했습니다.       │
│  잠시 후 다시 시도해 주세요.         │
├────────────────────────────────────┤
│                  [확인]             │  ← 단일 버튼 (1-button, centered)
└────────────────────────────────────┘
```

---

## 사용된 Components 목록

| 컴포넌트 | 파일 | 사용 위치 | Variant |
|---------|------|---------|---------|
| Alert | `alert.md` | 삭제 확인 / 오류 알림 | Destructive (2-button) |
| Button (Alert 내) | `button.md` | 취소 버튼 / 삭제 버튼 | Cancel (blue) / Destructive (red) |
| Progress Indicator | `progress-indicators.md` | 삭제 진행 중 상태 | Spinner (Alert 내) |

---

## 레이아웃 구조

```
Alert 치수 (iOS 26 기준):

Alert 카드:
  width: 270pt (고정)
  max-height: 없음 (콘텐츠에 따라 자동 확장)
  corner-radius: 14pt
  shadow: none (Liquid Glass 자체 depth로 대체)

타이틀 영역:
  padding: 20pt top, 16pt horizontal
  타이틀: 17pt Semibold, labels.primary, center
  타이틀 ↔ 메시지 간격: 4pt

메시지 영역:
  padding: 0 top (타이틀 하단 4pt), 16pt horizontal, 16pt bottom
  메시지: 13pt Regular, labels.primary, center
  line-height: 1.4
  max-lines: 없음 (스크롤 없이 확장)

구분선:
  height: 1pt (retina: 0.5pt)
  color: fills.opaque.separator (#c6c6c8 light)

버튼 영역 (2-button horizontal):
  height: 44pt
  width: 절반씩 (135pt)
  세로 구분선: 1pt, separator color

버튼 영역 (vertical):
  각 버튼 height: 44pt
  각 버튼 사이 구분선: 1pt

Alert 위치: 화면 중앙 정렬 (x, y 모두)
Dimming: 전체 화면 rgba(0,0,0, 0.40)
```

### Dimming 레이어 토큰

```json
{
  "overlays": {
    "alert": {
      "light": { "hex": "#29293a", "a": 0.23 },
      "dark": { "hex": "#121212", "a": 0.56 }
    }
  }
}
```

### 버튼 색상 토큰

| 버튼 역할 | 텍스트 색 | 폰트 | 배경(기본) | 배경(탭) |
|----------|---------|------|-----------|---------|
| Cancel | `accents.blue.light` | 17pt Regular | 투명 | fills.quaternary |
| Default | `accents.blue.light` | 17pt Semibold | 투명 | fills.quaternary |
| Destructive | `accents.red.light` | 17pt Semibold | 투명 | fills.quaternary (red tint) |

---

## 특이사항 / 커스터마이징 포인트

### Destructive 패턴 설계 원칙
1. **취소를 왼쪽(또는 아래)** 에 배치 — 오른쪽 손엄지 자연스러운 위치가 아닌 곳
2. **삭제(빨간색)를 오른쪽** 에 배치 — 의도적 탭 요구
3. 타이틀에 삭제 대상 명시: "항목 삭제" (일반적) vs "홍길동 삭제" (명확)
4. 메시지는 짧고 명확: 결과 + 되돌릴 수 없음 안내
5. **절대 "OK" / "확인" 같은 모호한 버튼 레이블 사용 금지** — "삭제", "제거", "초기화" 등 동작 명시

### 스와이프 삭제 vs 버튼 탭 삭제
```
스와이프 삭제:
  iOS List Row 오른쪽 스와이프 → "삭제" 빨간 버튼 노출
  탭 → Alert (destructive 확인)
  또는 .destructive() 스와이프 액션 → 직접 삭제 (Alert 없이, 중요하지 않은 항목)

버튼 탭 삭제:
  컨텍스트 메뉴 / 편집 모드 버튼 → Alert
  설정 화면 하단 "계정 삭제" 등 심각한 경우
```

### 삭제 확인 후 처리 패턴
```
성공 시:
  1. Alert 닫기
  2. List에서 Row 애니메이션으로 제거 (slide + fade)
  3. 토스트: "항목이 삭제되었습니다" (2초, 하단)
  4. 빈 상태면 Empty State 표시

실패 시:
  1. 삭제 Alert 닫기
  2. 오류 Alert 표시 (새 Alert)
  3. 오류 내용: 구체적 원인 + 재시도 안내
```

### 다중 삭제 (Batch Delete)
```
타이틀: "3개 항목 삭제"  ← 개수 명시
메시지: "선택한 3개 항목을 모두 삭제합니다. 이 작업은 되돌릴 수 없습니다."
버튼: [취소] | [3개 삭제]  ← 버튼도 개수 포함 (명확성)
```

---

## 애니메이션 시나리오

### 1. Alert 등장 (spring scale)
```
트리거: Alert 표시 요청
Duration: 0.25s
Curve: spring(damping: 0.75, stiffness: 400, initialVelocity: 0)
요소:
  - Alert 카드: scale 0.7→1.0, opacity 0→1
  - Alert 카드: 화면 중앙 정렬 (최종 위치 고정)
  - Dimming 오버레이: opacity 0→0.40 (0.2s, easeIn)
  - 배경 화면: blur 0→4pt (선택, iOS 기본은 없음)
  - 햅틱: .warning (삭제 등 중요) 또는 없음
```

### 2. Alert 버튼 탭 하이라이트
```
트리거: 버튼 touchDown
Duration: 즉시
요소:
  - 버튼 영역 배경: transparent → fills.quaternary (탭 유지 중)
  - touchUp: 배경 복귀 → 액션 실행
  - touchCancel (드래그 아웃): 하이라이트 해제, 액션 없음
```

### 3. Alert 닫힘 (취소 탭)
```
트리거: 취소 버튼 탭
Duration: 0.2s
Curve: easeIn (spring 없이 빠르게)
요소:
  - Alert 카드: scale 1.0→0.85, opacity 1→0
  - Dimming 오버레이: opacity 0.40→0 (0.15s)
  - 부모 화면: 즉시 인터랙티브 복귀
```

### 4. 삭제 후 Row 제거
```
트리거: 삭제 성공 콜백
Duration: 0.3s
Curve: easeOut
요소:
  - Alert 닫힘 (0.2s 먼저)
  - 해당 Row: opacity 1→0, height 자동→0 (collapse)
  - 이후 Row들: 빈 공간 채우며 올라옴 (spring)
  - 토스트 등장: y +20pt→0, opacity 0→1 (Alert 닫힘 후 0.1s 딜레이)
```

### 5. 오류 Alert 전환 (삭제 실패)
```
트리거: API 오류 응답
Duration: 0.3s
요소:
  - 삭제 확인 Alert: 닫힘 (0.2s)
  - 로딩 Alert (있었다면) 닫힘
  - 오류 Alert: spring scale 등장 (0.25s, 딜레이 0.1s)
  - 햅틱: .error
```

---

## 프레임워크별 전체 코드 예시

### SwiftUI (iOS 26)

```swift
import SwiftUI

// 단일 항목 삭제 플로우 전체 구현
struct ItemListView: View {
    @State private var items: [Item] = Item.samples
    @State private var itemToDelete: Item? = nil
    @State private var isDeleting = false
    @State private var showDeleteError = false
    @State private var deleteErrorMessage = ""
    @State private var showSuccessToast = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                List {
                    ForEach(items) { item in
                        ItemRow(item: item)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    itemToDelete = item
                                } label: {
                                    Label("삭제", systemImage: "trash.fill")
                                }
                            }
                    }
                }
                .navigationTitle("항목 목록")

                // 성공 토스트
                if showSuccessToast {
                    ToastView(message: "항목이 삭제되었습니다")
                        .padding(.bottom, 100)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.spring(damping: 0.8), value: showSuccessToast)
        }
        // ── 삭제 확인 Alert ───────────────────────
        .alert("항목 삭제", isPresented: .init(
            get: { itemToDelete != nil && !isDeleting },
            set: { if !$0 { itemToDelete = nil } }
        )) {
            Button("취소", role: .cancel) {
                itemToDelete = nil
            }
            Button("삭제", role: .destructive) {
                guard let target = itemToDelete else { return }
                performDelete(target)
            }
        } message: {
            Text("이 항목을 삭제하면 복구할 수 없습니다. 계속하시겠습니까?")
        }
        // ── 삭제 실패 Alert ───────────────────────
        .alert("삭제 실패", isPresented: $showDeleteError) {
            Button("확인", role: .cancel) {}
        } message: {
            Text(deleteErrorMessage)
        }
    }

    private func performDelete(_ item: Item) {
        isDeleting = true
        UINotificationFeedbackGenerator().notificationOccurred(.warning)

        Task {
            do {
                try await DeleteService.delete(item: item)
                await MainActor.run {
                    withAnimation(.easeOut(duration: 0.3)) {
                        items.removeAll { $0.id == item.id }
                    }
                    itemToDelete = nil
                    isDeleting = false
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                    // 토스트
                    showSuccessToast = true
                    Task {
                        try? await Task.sleep(for: .seconds(2))
                        await MainActor.run {
                            withAnimation { showSuccessToast = false }
                        }
                    }
                }
            } catch {
                await MainActor.run {
                    isDeleting = false
                    itemToDelete = nil
                    deleteErrorMessage = "네트워크 오류가 발생했습니다. 잠시 후 다시 시도해 주세요."
                    showDeleteError = true
                    UINotificationFeedbackGenerator().notificationOccurred(.error)
                }
            }
        }
    }
}

// MARK: - 다중 삭제 Alert 예시
extension ItemListView {
    func batchDeleteAlert(count: Int) -> Alert {
        Alert(
            title: Text("\(count)개 항목 삭제"),
            message: Text("선택한 \(count)개 항목을 모두 삭제합니다. 이 작업은 되돌릴 수 없습니다."),
            primaryButton: .destructive(Text("\(count)개 삭제")) {
                // 다중 삭제 실행
            },
            secondaryButton: .cancel(Text("취소"))
        )
    }
}

// MARK: - 토스트 컴포넌트
struct ToastView: View {
    let message: String

    var body: some View {
        Text(message)
            .font(.subheadline.weight(.medium))
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(.black.opacity(0.75), in: Capsule())
    }
}
```

### Flutter (Cupertino)

```dart
// alert_flow_example.dart
import 'package:flutter/cupertino.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({super.key});

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  final List<String> _items = ['항목 1', '항목 2', '항목 3'];
  bool _isDeleting = false;

  Future<void> _showDeleteAlert(BuildContext context, int index) async {
    final confirmed = await showCupertinoDialog<bool>(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('항목 삭제'),
        content: const Text('이 항목을 삭제하면 복구할 수 없습니다. 계속하시겠습니까?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('취소'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('삭제'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await _performDelete(index);
    }
  }

  Future<void> _performDelete(int index) async {
    setState(() => _isDeleting = true);
    try {
      // API 호출 시뮬레이션
      await Future.delayed(const Duration(milliseconds: 800));
      if (mounted) {
        setState(() {
          _items.removeAt(index);
          _isDeleting = false;
        });
        // 토스트 표시 (third-party 또는 직접 구현)
        _showSuccessToast();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isDeleting = false);
        _showErrorAlert();
      }
    }
  }

  void _showErrorAlert() {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('삭제 실패'),
        content: const Text('네트워크 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showSuccessToast() {
    // 간단한 SnackBar 스타일 토스트 (패키지 없이)
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (_) => Positioned(
        bottom: 100,
        left: 0,
        right: 0,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: CupertinoColors.black.withOpacity(0.75),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '항목이 삭제되었습니다',
              style: TextStyle(color: CupertinoColors.white, fontSize: 14),
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 2), entry.remove);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        largeTitle: Text('항목 목록'),
      ),
      child: SafeArea(
        child: CupertinoListSection.insetGrouped(
          children: List.generate(_items.length, (index) {
            return CupertinoListTile.notched(
              title: Text(_items[index]),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _showDeleteAlert(context, index),
                child: const Icon(
                  CupertinoIcons.trash,
                  color: CupertinoColors.destructiveRed,
                  size: 20,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
```

---

## 추가 Alert 변형 패턴

### 계정 삭제 (심각한 Destructive)
```
타이틀: "계정을 삭제하시겠습니까?"
메시지: "계정을 삭제하면 모든 데이터와 구매 내역이 영구적으로 삭제됩니다.
         이 작업은 되돌릴 수 없습니다."
버튼 (vertical):
  [계정 삭제] → Destructive (red, bold)
  [취소]       → Cancel (blue, bold)

추가 보호 (선택):
  삭제 전 비밀번호 재확인 Sheet 표시
```

### 초기화 확인 (Reset)
```
타이틀: "앱 설정 초기화"
메시지: "모든 설정이 기본값으로 되돌아갑니다."
버튼: [취소] | [초기화]
  초기화: Destructive → orange 또는 red (설계 선택)
```

### 3-button Alert (보관 + 삭제 + 취소)
```
타이틀: "항목 처리"
메시지: "이 항목을 어떻게 처리하시겠습니까?"
버튼 (vertical):
  [영구 삭제]     → Destructive (red)
  [보관함으로 이동] → Default (blue)
  [취소]          → Cancel (blue, bold, 항상 맨 아래)
```
