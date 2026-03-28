# iPad Popover 메뉴 — iOS 26 iPad 페이지 레시피

> **References**
> - Templates: `../../templates/`
> - Components: `../../components/specs/`
> - Tokens: `../../tokens/`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="...")`

---

## 화면 개요

iPad Popover는 iPad에서 툴바 버튼이나 특정 UI 요소를 탭했을 때 그 위치에 작은 플로팅 패널이 나타나는 컨트롤이다. **iPad-only 패턴**으로, iPhone에서는 동일한 트리거가 자동으로 Bottom Sheet로 폴백된다. iOS 26에서는 Liquid Glass 소재가 Popover 배경에 적용되어 반투명 frosted-glass 효과를 제공한다.

| 항목 | 값 |
|------|-----|
| **적용 디바이스** | iPad (regular horizontal size class) |
| **iPhone 폴백** | Bottom Sheet (UISheetPresentationController) |
| **Popover 기본 너비** | 280~320pt |
| **최대 높이** | 화면 높이의 50% 권장 (내부 스크롤 권장) |
| **Arrow 방향** | 자동 결정 (가장 공간 많은 방향), 수동 override 가능 |
| **Dismiss 방법** | 바깥 영역 탭 / 뒤로 가기 제스처 |

---

## iPad 레이아웃 규칙 (pt 치수)

### Popover 크기
```
기본 너비   : 320pt  (HIG 권장)
최소 너비   : 280pt
최대 너비   : 460pt  (iPad 화면 너비의 절반 이하 권장)
기본 높이   : 콘텐츠에 맞게 자동 조절 (auto)
최대 높이   : 600pt  (그 이상이면 내부 ScrollView 사용)
```

### Popover 내부 레이아웃
```
Arrow 영역     : 12pt (자동, popover 방향에 따라 위/아래/좌/우)
내부 상단 패딩 : 16pt
내부 좌우 패딩 : 0pt  (List Row는 full-width, 버튼은 16pt padding)
내부 하단 패딩 : 8pt  + Safe Area
List Row 높이  : 44pt (standard), 52pt (subtitle 있음)
Divider 높이   : 0.5pt
```

### Arrow 위치 계산
```
트리거 버튼이 Toolbar 상단에 있을 때:
  Arrow 방향 = UP (↑)
  Popover top = toolbar 하단 + 4pt gap

트리거 버튼이 화면 하단에 있을 때:
  Arrow 방향 = DOWN (↓)
  Popover bottom = 버튼 상단 - 4pt gap

트리거 버튼이 화면 좌측에 있을 때:
  Arrow 방향 = LEFT (←)
  Popover left edge = 버튼 우측 + 4pt gap
```

### iPhone 폴백 — Sheet 치수
```
detent       : .medium (기본), .large (액션 많을 때)
cornerRadius : 16pt
grabber      : 표시 (showsGrabber = true)
```

---

## 컴포넌트 계층 (ASCII 와이어프레임)

### 기본 Popover (Toolbar 상단 + 버튼 탭 후)
```
┌──────────────────────────────────────────────────────────────────┐
│                      STATUS BAR (24pt)                            │
├──────────────────────────────────────────────────────────────────┤
│  TOOLBAR-TOP                                                      │
│  [< Back]    [화면 제목]    [검색🔍]  [공유↑]  [더보기•••]       │
│  Liquid Glass background                                          │
├─────────────────────────────────────────────────────────────────┤
│                                                            ▲      │  ← Arrow (UP)
│                              ┌──────────────────────────┐ │      │
│                              │  POPOVER                 ├─┘      │
│                              │  (Liquid Glass)          │        │
│                              │  ──────────────────────  │        │
│                              │  [🔗] 링크 복사          │        │
│                              │  ──────────────────────  │        │
│                              │  [📤] AirDrop으로 보내기 │        │
│                              │  ──────────────────────  │        │
│                              │  [✉️] 메일로 보내기      │        │
│                              │  ──────────────────────  │        │
│                              │  [💬] 메시지로 보내기    │        │
│                              │  ──────────────────────  │        │
│                              │  [⭐] 즐겨찾기에 추가    │        │
│                              │  ──────────────────────  │        │
│                              │  [🗑️] 삭제           🔴  │        │
│                              └──────────────────────────┘        │
│  CONTENT AREA                                                     │
│  (popover 뒤 배경 — 어둡지 않음, 상호작용 가능)                    │
│                                                                   │
└──────────────────────────────────────────────────────────────────┘
```

### Popover — Arrow DOWN (화면 하단 트리거)
```
┌──────────────────────────────────────────────────────────────────┐
│  CONTENT AREA                                                     │
│                                                                   │
│                     ┌────────────────────────────┐               │
│                     │  POPOVER                   │               │
│                     │  (Liquid Glass)             │               │
│                     │  ─────────────────────────  │               │
│                     │  [Icon] 액션 항목 1          │               │
│                     │  ─────────────────────────  │               │
│                     │  [Icon] 액션 항목 2          │               │
│                     │  ─────────────────────────  │               │
│                     │  [Icon] 액션 항목 3          │               │
│                     └────────────────────────────┘               │
│                                  ▼   ← Arrow DOWN                │
├──────────────────────────────────────────────────────────────────┤
│  TOOLBAR-BOTTOM                                                   │
│  [새 항목+]  [정렬↕]  [필터▼]  [설정⚙️]                          │
└──────────────────────────────────────────────────────────────────┘
```

### Popover — 섹션 구분 + 헤더 있음
```
                     ┌────────────────────────────────┐
                     │  POPOVER (320pt)               │
                     │                                │
                     │  섹션 헤더 (그레이, 12pt)       │
                     │  편집                          │
                     │  ─────────────────────────     │
                     │  [✂️] 잘라내기              │  │
                     │  [📋] 복사                  │  │
                     │  [📌] 붙여넣기              │  │
                     │                                │
                     │  섹션 헤더                      │
                     │  공유                          │
                     │  ─────────────────────────     │
                     │  [↑] 공유하기               │  │
                     │  [🔗] 링크 복사             │  │
                     │                                │
                     │  섹션 헤더                      │
                     │  위험                          │
                     │  ─────────────────────────     │
                     │  [🗑️] 삭제               🔴 │  │  ← destructive (빨강)
                     └────────────────────────────────┘
                                  ▲
```

### iPhone 폴백 — Bottom Sheet
```
┌──────────────────────────────────────┐
│  CONTENT AREA (dim overlay 없음)     │
│                                      │
│  ┌────────────────────────────────┐  │
│  │ ▬  (Grabber)                  │  │
│  │  SHEET (320pt 이하 full-width) │  │
│  │  ─────────────────────────     │  │
│  │  [🔗] 링크 복사                │  │
│  │  [📤] AirDrop으로 보내기       │  │
│  │  [✉️] 메일로 보내기           │  │
│  │  [💬] 메시지로 보내기          │  │
│  │  [⭐] 즐겨찾기에 추가          │  │
│  │  ─────────────────────────     │  │
│  │  [🗑️] 삭제               🔴  │  │
│  │  ─────────────────────────     │  │
│  │  [취소]                        │  │
│  └────────────────────────────────┘  │
└──────────────────────────────────────┘
```

---

## iPhone vs iPad 분기 처리

| 항목 | iPhone | iPad |
|------|--------|------|
| 프레젠테이션 | Bottom Sheet (UISheetPresentationController) | Popover (UIPopoverPresentationController) |
| 배경 어둠 | dim overlay 있음 | 없음 (배경 상호작용 가능) |
| Dismiss | 시트 아래로 스와이프 / 바깥 탭 | 바깥 탭 |
| 화살표 | 없음 | 있음 (트리거 방향) |
| 최대 높이 | .medium / .large detent | 600pt 또는 콘텐츠 높이 |
| 취소 버튼 | 하단 "취소" Row 권장 | 불필요 (바깥 탭으로 닫힘) |

### 자동 폴백 처리 (UIKit)
```swift
// iOS는 size class에 따라 자동으로 sheet ↔ popover 전환
// modalPresentationStyle = .popover 설정 시
// compact에서 자동으로 full-screen / sheet로 변경됨

class MoreActionsViewController: UIViewController,
                                  UIPopoverPresentationControllerDelegate {

    func presentActions(from sourceView: UIView, in parent: UIViewController) {
        let vc = ActionsListViewController()
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: 320, height: 264)

        if let ppc = vc.popoverPresentationController {
            ppc.sourceView = sourceView
            ppc.sourceRect = sourceView.bounds
            ppc.permittedArrowDirections = [.up, .down]
            ppc.delegate = self
        }

        parent.present(vc, animated: true)
    }

    // iPhone에서 sheet로 폴백할 때 adaptivePresentationStyle 조정
    func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
    ) -> UIModalPresentationStyle {
        // compact에서는 pageSheet
        return traitCollection.horizontalSizeClass == .compact
            ? .pageSheet
            : .none  // none = popover 유지
    }
}
```

---

## 애니메이션 시나리오

### 1. Popover 등장
```
Trigger  : 툴바 버튼 탭
Duration : 0.22s
Curve    : easeOut

Popover:
  transform: scale(0.85) → scale(1.0)
  opacity  : 0 → 1
  origin   : Arrow 위치 기준 (아래에서 위로 커짐)
```

### 2. Popover 닫힘 (바깥 탭)
```
Duration : 0.18s
Curve    : easeIn

Popover:
  transform: scale(1.0) → scale(0.9)
  opacity  : 1 → 0
```

### 3. 액션 항목 탭
```
Row 하이라이트 (즉시):
  background: .clear → systemFill

Popover 닫힘 (탭 후 0.1s delay):
  opacity: 1 → 0, duration 0.15s

액션 실행:
  닫힘 애니메이션 완료 후 실행
```

### 4. Destructive 액션 확인 (선택적)
```
삭제 항목 탭 시 Alert 표시:
  Alert: "삭제하시겠습니까?" + [삭제(destructive)] [취소(cancel)]
  Popover 닫힘 → Alert 등장 순서
```

---

## 프레임워크별 구현

### SwiftUI — Popover
```swift
// iOS 26 / SwiftUI
struct ToolbarWithPopover: View {
    @State private var showPopover = false

    var body: some View {
        NavigationStack {
            ContentView()
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            showPopover = true
                        } label: {
                            Image(systemName: "ellipsis.circle")
                        }
                        // iPad: popover, iPhone: sheet 자동 분기
                        .popover(isPresented: $showPopover,
                                 arrowEdge: .top) {
                            ActionsPopoverView()
                                .frame(width: 320)
                                .presentationCompactAdaptation(.sheet)
                        }
                    }
                }
        }
    }
}

struct ActionsPopoverView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List {
            Section {
                Label("링크 복사", systemImage: "link")
                    .onTapGesture { copyLink(); dismiss() }
                Label("AirDrop으로 보내기", systemImage: "airplayaudio")
                    .onTapGesture { shareAirDrop(); dismiss() }
                Label("메일로 보내기", systemImage: "envelope")
                    .onTapGesture { sendMail(); dismiss() }
            } header: {
                Text("공유")
            }
            Section {
                Label("삭제", systemImage: "trash")
                    .foregroundStyle(.red)
                    .onTapGesture { deleteItem(); dismiss() }
            }
        }
        .listStyle(.insetGrouped)
    }
}
```

### UIKit — Popover 전체 구현
```swift
// UIKit — 버튼 탭 시 Popover 표시
@objc func moreButtonTapped(_ sender: UIBarButtonItem) {
    let actionsVC = ActionsViewController()
    actionsVC.modalPresentationStyle = .popover
    actionsVC.preferredContentSize = CGSize(width: 320, height: 220)

    guard let ppc = actionsVC.popoverPresentationController else { return }
    ppc.barButtonItem = sender
    ppc.permittedArrowDirections = [.up, .down]
    ppc.delegate = self

    present(actionsVC, animated: true)
}

// UITableView 기반 액션 목록
class ActionsViewController: UITableViewController {
    let actions: [(String, String, Bool)] = [
        ("link", "링크 복사", false),
        ("square.and.arrow.up", "AirDrop으로 보내기", false),
        ("envelope", "메일로 보내기", false),
        ("trash", "삭제", true),  // isDestructive
    ]

    override func tableView(_ tv: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        actions.count
    }

    override func tableView(_ tv: UITableView,
                            cellForRowAt ip: IndexPath) -> UITableViewCell {
        let cell = tv.dequeueReusableCell(withIdentifier: "cell", for: ip)
        let (icon, title, isDestructive) = actions[ip.row]
        var config = cell.defaultContentConfiguration()
        config.text = title
        config.image = UIImage(systemName: icon)
        config.imageProperties.tintColor = isDestructive ? .systemRed : .label
        config.textProperties.color = isDestructive ? .systemRed : .label
        cell.contentConfiguration = config
        return cell
    }
}
```

### Flutter — PopupMenuButton (Popover 대응)
```dart
// Flutter: iPad에서는 DropdownMenu/PopupMenuButton,
// iPhone에서는 showModalBottomSheet 분기

Widget buildToolbarMoreButton(BuildContext context) {
  final isIPad = MediaQuery.of(context).size.shortestSide > 600;

  if (isIPad) {
    // iPad — PopupMenuButton (Popover 유사)
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_horiz),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'copy_link',
          child: ListTile(
            leading: Icon(Icons.link),
            title: Text('링크 복사'),
          ),
        ),
        const PopupMenuItem(
          value: 'share',
          child: ListTile(
            leading: Icon(Icons.ios_share),
            title: Text('공유하기'),
          ),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: ListTile(
            leading: Icon(Icons.delete_outline, color: Colors.red),
            title: Text('삭제', style: TextStyle(color: Colors.red)),
          ),
        ),
      ],
      onSelected: (value) => handleAction(context, value),
    );
  } else {
    // iPhone — Bottom Sheet
    return IconButton(
      icon: const Icon(Icons.more_horiz),
      onPressed: () => showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (_) => const ActionsBottomSheet(),
      ),
    );
  }
}
```

---

## Popover 내 List Row 구성 규칙

### 아이콘 + 레이블 (기본)
```
[SF Symbol]  레이블 텍스트
 20pt icon   16pt regular
 tint: label color (blue / red / label)
```

### 체크 표시 (선택 상태)
```
[SF Symbol]  레이블 텍스트        ✓
 아이콘       텍스트           checkmark
```

### 섹션 구분선
```
Row 그룹 사이 : 0.5pt separator + 8pt 섹션 간 gap
헤더 텍스트   : 12pt, secondary color, uppercase (선택)
```

---

## 토큰 참조

| 토큰 | 값 | 용도 |
|------|-----|------|
| `popover.width` | 320pt | 기본 너비 |
| `popover.minWidth` | 280pt | 최소 너비 |
| `popover.maxHeight` | 600pt | 최대 높이 (초과시 스크롤) |
| `popover.cornerRadius` | 12pt | 모서리 둥글기 |
| `popover.arrowSize` | 12pt | 화살표 크기 |
| `popover.padding.vertical` | 8pt | 내부 상하 패딩 |
| `animation.popoverAppear` | 0.22s easeOut | 등장 |
| `animation.popoverDismiss` | 0.18s easeIn | 닫힘 |
| `color.destructive` | `#FF3B30` | 삭제 액션 색상 |
