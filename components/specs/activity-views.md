> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24670")`

# Activity View (Share Sheet) — Component Spec

## 1. Overview

iOS 26 Activity View(Share Sheet)는 콘텐츠를 공유하거나 다양한 액션을 수행할 수 있는 바텀 시트 컴포넌트다. AirDrop 등 근접 공유 대상을 Contact Row에 표시하고, 앱 아이콘 그리드와 시스템 액션 목록을 제공한다. Liquid Glass 배경 소재를 사용하며, iPhone과 iPad에서 서로 다른 프레젠테이션 방식을 취한다.

| 항목 | 값 |
|------|-----|
| Figma Node | `507:24670` (Activity Views page) |
| UIKit 대응 | `UIActivityViewController` |
| SwiftUI 대응 | `ShareLink` / `.sheet { ActivityView(...) }` |
| Variant 수 | 2 (iPhone / iPad) |
| 배경 소재 | Liquid Glass |

### 내부 컴포넌트 구성 (Figma)
| 컴포넌트 | 역할 |
|---------|------|
| `_Header` | 공유 대상 콘텐츠 미리보기 (URL, 이미지, 텍스트) |
| `_Contact` | AirDrop/연락처 등 근접 공유 대상 아바타 |
| `_Close Button` | 시트 닫기 버튼 (우상단 X 버튼) |
| `_Action` | 앱 아이콘 그리드의 단일 앱 아이템 |
| `_Actions` | 앱 아이콘 그리드 컨테이너 |
| `_Button - Liquid Glass` | 하단 액션 목록의 행 버튼 |

---

## 2. Dimensions

### iPhone (Bottom Sheet)
| 속성 | 값 | 출처 |
|------|-----|------|
| 너비 | 화면 전체 너비 | `spacing.json` > `contentMargin.iphone.fullWidth` |
| cornerRadius (top) | `20pt` | `spacing.json` > `radius.semantic.activitySheet.iphoneTop` |
| 기본 detent | `.medium` (화면 높이 ~50%) | sheet.md 참조 |
| 확장 detent | `.large` (화면 높이 100%) | sheet.md 참조 |
| 헤더 영역 높이 | `~88pt` | `spacing.json` > `components.activityView.headerHeight` |
| Contact Row 높이 | `~88pt` | `spacing.json` > `components.activityView.contactRowHeight` |
| 앱 아이콘 그리드 행 높이 | `~81pt` | `spacing.json` > `components.activityView.appGridRowHeight` |
| 액션 행 높이 | `57pt` | `spacing.json` > `components.activityView.actionRowHeight` |
| 내부 패딩 (수평) | `16pt` | `spacing.json` > `contentMargin.iphone.horizontal` |
| Close 버튼 크기 | `30pt × 30pt` | `spacing.json` > `components.activityView.closeButtonSize` |
| Close 버튼 우측 여백 | `16pt` | — |
| Close 버튼 상단 여백 | `14pt` | — |

### iPad (Popover)
| 속성 | 값 | 출처 |
|------|-----|------|
| Popover 너비 | `320pt` | `spacing.json` > `components.activityView.ipadPopoverWidth` |
| cornerRadius | `14pt` | `spacing.json` > `radius.semantic.popover` |
| 최대 높이 | 화면 높이의 80% | — |
| 화살표 | Popover 방향에 따라 자동 | — |

### 전체 레이아웃 구조 (iPhone)

```
┌─────────────────────────────────────────────┐  ← width: 화면 전체
│                                         [X] │  ← Close Button (30×30pt, top:14 right:16)
│  ┌───────────────────────────────────────┐  │
│  │  📄 콘텐츠 미리보기 (_Header)          │  │  ← ~88pt
│  │  example.com/path/to/article          │  │
│  └───────────────────────────────────────┘  │
├─────────────────────────────────────────────┤  ← separator
│  [👤] [👤] [👤] [👤] [👤]  →              │  ← Contact Row (~88pt)
│  AirDrop  연락처1  연락처2  ...             │
├─────────────────────────────────────────────┤  ← separator
│  ┌────┐  ┌────┐  ┌────┐  ┌────┐  ┌────┐  │
│  │ 앱 │  │ 앱 │  │ 앱 │  │ 앱 │  │ 앱 │  │  ← 앱 아이콘 그리드 (~81pt/행)
│  └────┘  └────┘  └────┘  └────┘  └────┘  │
│  ┌────┐  ┌────┐  ┌────┐  ┌────┐  ┌────┐  │
│  │ 앱 │  │ 앱 │  │ 앱 │  │ 앱 │  │ 앱 │  │
│  └────┘  └────┘  └────┘  └────┘  └────┘  │
├─────────────────────────────────────────────┤  ← separator
│  📋  복사                                   │  ← 액션 행 (57pt) — Liquid Glass Button
├─────────────────────────────────────────────┤
│  🔖  나중에 읽기                             │  ← 57pt
├─────────────────────────────────────────────┤
│  ➕  홈 화면에 추가                          │  ← 57pt
└─────────────────────────────────────────────┘
```

### iPad Popover 구조

```
                ↑ (화살표 방향 자동)
┌──────────────────────────────────┐  ← width: 320pt, radius: 14pt
│                              [X] │  ← Close Button
│  📄 콘텐츠 미리보기 (_Header)    │  ← ~88pt
├──────────────────────────────────┤
│  [👤] [👤] [👤] ...  →         │  ← Contact Row
├──────────────────────────────────┤
│  [앱] [앱] [앱] [앱] [앱]       │  ← 앱 그리드 (~81pt/행)
├──────────────────────────────────┤
│  📋  복사                        │  ← 57pt
├──────────────────────────────────┤
│  🔖  나중에 읽기                  │  ← 57pt
└──────────────────────────────────┘
```

---

## 3. Variants

### 3-1. iPhone (Bottom Sheet)
- 화면 하단에서 슬라이드 업하는 Sheet 형태
- 기본 detent: `.medium` (~50% 화면 높이)
- 위로 드래그하면 `.large` (100%) 전환
- Grabber 없음 (Activity View 고유 패턴)
- Close 버튼(X)으로 dismiss

### 3-2. iPad (Popover)
- `UIPopoverPresentationController`로 표시
- 고정 너비 `320pt`
- 트리거 요소 근처에 화살표와 함께 표시
- 배경 탭으로 dismiss
- Cancel 버튼 없음 (배경 탭이 Cancel 역할)
- 스크롤 가능한 단일 컬럼 레이아웃

---

## 4. Sub-Component: `_Header` (콘텐츠 미리보기)

공유 대상 콘텐츠 타입에 따라 헤더 표시 방식이 달라진다.

| 콘텐츠 타입 | 표시 방식 |
|-----------|---------|
| URL | 파비콘 + 사이트명 + URL 축약 |
| 이미지 | 썸네일 미리보기 (최대 3개까지 오버랩) |
| 텍스트 | 텍스트 일부 미리보기 (한 줄) |
| 파일 | 파일 아이콘 + 파일명 |
| 앱 콘텐츠 | 앱 아이콘 + 콘텐츠 제목 |

```
헤더 영역 (URL 타입 예시)
┌─────────────────────────────────────────┐
│  [파비콘]  Apple                         │
│           https://apple.com/kr/...      │  ← 축약 URL
└─────────────────────────────────────────┘
```

---

## 5. Sub-Component: `_Contact` (Contact Row)

AirDrop 및 근접 공유 대상을 수평 스크롤 그리드로 표시한다.

| 속성 | 값 |
|------|-----|
| 아이콘 크기 | `52pt × 52pt` |
| 아이콘 cornerRadius | `9999pt` (원형, `radius.full`) |
| 레이블 폰트 | Caption 2, 11pt, Regular |
| 레이블 최대 줄 수 | 2줄 |
| 항목 간 간격 | `12pt` |
| AirDrop 아이콘 | 시스템 AirDrop 아이콘 (파란색 배경) |

---

## 6. Sub-Component: `_Actions` + `_Action` (앱 아이콘 그리드)

설치된 앱의 공유 Extension을 그리드로 표시한다.

| 속성 | 값 |
|------|-----|
| 아이콘 크기 | `52pt × 52pt` |
| 아이콘 cornerRadius | `12pt` (앱 아이콘 표준) |
| 레이블 폰트 | Caption 2, 11pt, Regular |
| 레이블 컬러 | `labels.primary` |
| 그리드 열 수 | 5열 (iPhone), 6열 (iPad Popover 내 가로 스크롤) |
| 행 높이 | `~81pt` (아이콘 + 레이블 + 여백) |
| 그리드 아이템 간 간격 | 균등 분배 (균등 spacing) |
| 행 간 간격 | `8pt` |
| 좌우 패딩 | `16pt` |

---

## 7. Sub-Component: `_Button - Liquid Glass` (액션 목록)

시스템 및 앱 액션 행을 표시하는 버튼.

| 속성 | 값 |
|------|-----|
| 높이 | `57pt` |
| 배경 | Liquid Glass (각 행이 독립 카드 또는 그룹 내 구분선 사용) |
| 아이콘 크기 | `29pt × 29pt` |
| 아이콘 배경 | `28pt × 28pt`, cornerRadius `6pt`, `fills.secondary` |
| 레이블 폰트 | Body, 17pt, Regular |
| 레이블 컬러 | `labels.primary` |
| 레이블 좌측 여백 (아이콘 기준) | `12pt` |

```
액션 행 내부 구조 (57pt 높이)
┌────────────────────────────────────────────────────┐
│  ┌────────┐                                         │
│  │  아이콘 │  액션 레이블                             │  ← height: 57pt
│  └────────┘                                         │
│  ↑ 29×29pt                                          │
└────────────────────────────────────────────────────┘
```

---

## 8. Color Tokens

| 역할 | 토큰 경로 | Light | Dark |
|------|----------|-------|------|
| 시트 배경 | Liquid Glass (regularMaterial) | `rgba(250,250,250,0.72)` | `rgba(28,28,30,0.82)` |
| 액션 행 배경 | Liquid Glass 개별 버튼 | `rgba(250,250,250,0.62)` | `rgba(44,44,46,0.72)` |
| 액션 행 텍스트 | `labels.primary` | `#000000 / a:1` | `#ffffff / a:1` |
| 아이콘 배경 | `fills.secondary` | `#f2f2f7` | `#2c2c2e` |
| 구분선 | `separators.nonOpaque` | `#000000 / a:0.12` | `#ffffff / a:0.17` |
| Close 버튼 배경 | `fills.tertiary` (원형) | `#efeff4` | `#3a3a3c` |
| Close 버튼 아이콘 | `labels.secondary` | `#3c3c43 / a:0.6` | `#ebebf5 / a:0.7` |
| Contact 레이블 | `labels.primary` | `#000000` | `#ffffff` |
| 앱 아이콘 레이블 | `labels.primary` | `#000000` | `#ffffff` |
| 오버레이 | `overlays.default` | `#000000 / a:0.2` | `#000000 / a:0.48` |
| Blur (Liquid Glass) | `liquidGlass.regularMaterial.frostRadius` | `blur: 20px` | `blur: 20px` |

### Liquid Glass CSS (시트 배경)

```css
.activity-view-sheet {
  /* Light */
  background: rgba(250, 250, 250, 0.72);
  backdrop-filter: blur(20px) saturate(180%);
  -webkit-backdrop-filter: blur(20px) saturate(180%);

  /* Dark */
  background: rgba(28, 28, 30, 0.82);
  backdrop-filter: blur(20px) saturate(150%);
}

.activity-view-action-button {
  /* Light — 액션 행은 약간 더 불투명 */
  background: rgba(250, 250, 250, 0.62);
  backdrop-filter: blur(12px);

  /* Dark */
  background: rgba(44, 44, 46, 0.72);
}
```

---

## 9. Typography

| 요소 | Style | Font | Weight | Size | Line Height |
|------|-------|------|--------|------|-------------|
| 헤더 사이트명/타이틀 | Subheadline | SF Pro Text | Semibold | 15pt | 20pt |
| 헤더 URL/부제 | Footnote | SF Pro Text | Regular | 13pt | 18pt |
| Contact 레이블 | Caption 2 | SF Pro Text | Regular | 11pt | 13pt |
| 앱 아이콘 레이블 | Caption 2 | SF Pro Text | Regular | 11pt | 13pt |
| 액션 행 레이블 | Body | SF Pro Text | Regular | 17pt | 22pt |

---

## 10. Animation

### Sheet Present (iPhone, 등장)
```yaml
trigger: UIActivityViewController present
duration: 0.5s  # animations.json > duration.semantic.sheetPresent
easing: spring.gentle
spring:
  stiffness: 260
  damping: 32
properties:
  translateY: 100% → 0%
  Liquid Glass blur: 0 → 20px (점진적)
overlay:
  opacity: 0 → 1
  duration: 0.4s
  easing: easeOut
```

### 앱 아이콘 그리드 스태거 등장
```yaml
trigger: Sheet가 완전히 자리 잡은 후 (sheet present 완료 시점)
delay_base: 0.05s  # 각 아이콘 순서 × delay_base
duration_per_item: 0.3s
easing: spring.gentle
properties:
  opacity: 0 → 1
  scale: 0.8 → 1.0
  translateY: 8pt → 0  (위로 슬라이드인)
order: 왼쪽→오른쪽, 위→아래 순서
```

### Contact Row 스태거 등장
```yaml
delay_base: 0.03s
duration_per_item: 0.25s
easing: spring.gentle
properties:
  opacity: 0 → 1
  scale: 0.85 → 1.0
```

### Sheet Dismiss (퇴장)
```yaml
trigger: Close 버튼 탭 또는 배경 탭 (iPad)
duration: 0.3s
easing: easeIn
properties:
  translateY: 0% → 100%
overlay:
  opacity: 1 → 0
  duration: 0.25s
```

### CSS 애니메이션 구현

```css
@keyframes activity-slide-up {
  from { transform: translateY(100%); }
  to   { transform: translateY(0); }
}

@keyframes activity-slide-down {
  from { transform: translateY(0); }
  to   { transform: translateY(100%); }
}

@keyframes app-icon-in {
  from {
    opacity: 0;
    transform: scale(0.8) translateY(8px);
  }
  to {
    opacity: 1;
    transform: scale(1) translateY(0);
  }
}

.activity-sheet-enter {
  animation: activity-slide-up 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
}

.app-icon-enter {
  animation: app-icon-in 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94) both;
}

/* 스태거: nth-child로 delay 적용 */
.app-icon:nth-child(1) { animation-delay: 0.05s; }
.app-icon:nth-child(2) { animation-delay: 0.10s; }
.app-icon:nth-child(3) { animation-delay: 0.15s; }
/* ... */
```

---

## 11. UIKit 구현 (`UIActivityViewController`)

```swift
// 기본 사용법
let activityItems: [Any] = [
    URL(string: "https://example.com")!,
    "공유할 텍스트",
    UIImage(named: "shareImage")
]

let activityVC = UIActivityViewController(
    activityItems: activityItems,
    applicationActivities: nil  // 커스텀 액티비티 없음
)

// 특정 액티비티 제외 (선택적)
activityVC.excludedActivityTypes = [
    .addToReadingList,
    .assignToContact
]

// 완료 핸들러
activityVC.completionWithItemsHandler = { activityType, completed, returnedItems, error in
    if completed {
        print("공유 완료: \(String(describing: activityType?.rawValue))")
    }
}

// iPad 필수 설정 — 미설정 시 크래시
if let popover = activityVC.popoverPresentationController {
    popover.sourceView = shareButton
    popover.sourceRect = shareButton.bounds
    popover.permittedArrowDirections = [.up, .down]
}

present(activityVC, animated: true)
```

### 커스텀 UIActivity 추가

```swift
class CustomActivity: UIActivity {
    override var activityTitle: String? { "내 앱 액션" }
    override var activityImage: UIImage? { UIImage(systemName: "star") }
    override class var activityCategory: UIActivity.Category { .action }
    override var activityType: UIActivity.ActivityType? {
        UIActivity.ActivityType("com.myapp.customAction")
    }
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool { true }
    override func perform() {
        // 액션 수행
        activityDidFinish(true)
    }
}

let customActivities = [CustomActivity()]
let activityVC = UIActivityViewController(
    activityItems: activityItems,
    applicationActivities: customActivities
)
```

---

## 12. SwiftUI 구현

```swift
// ShareLink (iOS 16+, 간단한 공유)
struct ShareButton: View {
    let url = URL(string: "https://example.com")!

    var body: some View {
        // 단순 URL 공유
        ShareLink(item: url) {
            Label("공유하기", systemImage: "square.and.arrow.up")
        }

        // 제목 + 메시지 포함
        ShareLink(
            item: url,
            subject: Text("콘텐츠 제목"),
            message: Text("이 콘텐츠를 공유합니다.")
        ) {
            Text("공유")
        }

        // 이미지 공유 (Transferable 프로토콜)
        if let image = UIImage(named: "photo") {
            ShareLink(item: Image(uiImage: image), preview: SharePreview(
                "사진 미리보기",
                image: Image(uiImage: image)
            )) {
                Label("사진 공유", systemImage: "photo")
            }
        }
    }
}

// 직접 Sheet로 UIActivityViewController 래핑 (iOS 15 이하 호환)
struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]?

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

// 사용 예시
struct ContentView: View {
    @State private var showShareSheet = false

    var body: some View {
        Button("공유") { showShareSheet = true }
            .sheet(isPresented: $showShareSheet) {
                ActivityView(
                    activityItems: [URL(string: "https://example.com")!],
                    applicationActivities: nil
                )
                .presentationDetents([.medium, .large])
            }
    }
}
```

---

## 13. Flutter 구현 (share_plus)

```dart
import 'package:share_plus/share_plus.dart';

// 기본 텍스트/URL 공유
// share_plus가 내부적으로 UIActivityViewController (iOS) / Intent.ACTION_SEND (Android) 사용
Future<void> shareContent(BuildContext context) async {
  final box = context.findRenderObject() as RenderBox?;

  final result = await Share.share(
    'https://example.com/article',
    subject: '콘텐츠 제목',
    // iPad용 sharePositionOrigin 설정 (미설정 시 iPad에서 위치 이상)
    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  );

  if (result.status == ShareResultStatus.success) {
    print('공유 성공: ${result.raw}');
  }
}

// 파일 공유
Future<void> shareFile(BuildContext context) async {
  final box = context.findRenderObject() as RenderBox?;

  await Share.shareXFiles(
    [XFile('/path/to/file.pdf')],
    text: '파일을 공유합니다.',
    subject: '파일 제목',
    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  );
}

// 커스텀 바텀시트 (iOS 네이티브 스타일 근사 구현)
Future<void> showCustomShareSheet(BuildContext context) async {
  await showCupertinoModalPopup<void>(
    context: context,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground.resolveFrom(context)
            .withOpacity(0.72),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),  // activitySheet.iphoneTop
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 헤더
            _ActivityHeader(url: 'https://example.com'),
            const Divider(height: 1),
            // Contact Row (AirDrop 근사)
            _ContactRow(),
            const Divider(height: 1),
            // 앱 아이콘 그리드
            _AppGrid(actions: shareActions),
            const Divider(height: 1),
            // 시스템 액션 목록
            ..._buildActionList(context),
          ],
        ),
      ),
    ),
  );
}
```

---

## 14. Svelte/Web 구현 (Web Share API + 폴백 UI)

```svelte
<script lang="ts">
  import { fly, fade } from 'svelte/transition';
  import { cubicOut } from 'svelte/easing';
  import { onMount } from 'svelte';

  export let open = false;
  export let shareData: ShareData = {};

  // shareData: { title, text, url, files }

  let canNativeShare = false;

  onMount(() => {
    // Web Share API 지원 여부 확인
    canNativeShare = typeof navigator.share === 'function';
  });

  async function triggerShare() {
    if (canNativeShare) {
      try {
        await navigator.share(shareData);
        console.log('공유 성공');
      } catch (err) {
        if ((err as Error).name !== 'AbortError') {
          // AbortError는 사용자가 취소한 것 — 무시
          console.error('공유 실패:', err);
          // 폴백 UI 표시
          open = true;
        }
      }
    } else {
      // Web Share API 미지원 → 커스텀 폴백 UI
      open = true;
    }
  }

  // 폴백 액션 목록
  const fallbackActions = [
    {
      icon: '📋',
      label: '링크 복사',
      action: async () => {
        await navigator.clipboard.writeText(shareData.url ?? '');
        open = false;
      }
    },
    {
      icon: '✉️',
      label: '이메일로 공유',
      action: () => {
        window.open(`mailto:?subject=${encodeURIComponent(shareData.title ?? '')}&body=${encodeURIComponent(shareData.url ?? '')}`);
        open = false;
      }
    },
    {
      icon: '💬',
      label: 'SMS로 공유',
      action: () => {
        window.open(`sms:?body=${encodeURIComponent((shareData.title ?? '') + ' ' + (shareData.url ?? ''))}`);
        open = false;
      }
    }
  ];
</script>

<!-- 네이티브 공유 트리거 버튼 -->
<button on:click={triggerShare} aria-label="공유하기">
  공유하기
</button>

<!-- 폴백 UI (Web Share API 미지원 환경) -->
{#if open}
  <!-- 오버레이 -->
  <!-- svelte-ignore a11y-click-events-have-key-events -->
  <div
    class="activity-overlay"
    role="button"
    tabindex="-1"
    transition:fade={{ duration: 300 }}
    on:click={() => (open = false)}
    aria-label="닫기"
  />

  <!-- Activity Sheet 본체 -->
  <div
    class="activity-sheet"
    role="dialog"
    aria-modal="true"
    aria-label="공유 옵션"
    transition:fly={{ y: '100%', duration: 500, easing: cubicOut }}
  >
    <!-- Close 버튼 -->
    <button
      class="activity-close"
      on:click={() => (open = false)}
      aria-label="닫기"
    >
      ✕
    </button>

    <!-- 헤더: 콘텐츠 미리보기 -->
    {#if shareData.url || shareData.title}
      <div class="activity-header">
        <div class="activity-header-icon">🔗</div>
        <div class="activity-header-info">
          <p class="activity-header-title">{shareData.title ?? '공유'}</p>
          {#if shareData.url}
            <p class="activity-header-url">{shareData.url}</p>
          {/if}
        </div>
      </div>
      <div class="activity-separator" role="separator" />
    {/if}

    <!-- 액션 목록 -->
    <div class="activity-actions">
      {#each fallbackActions as action, i}
        {#if i > 0}
          <div class="activity-separator" role="separator" />
        {/if}
        <button class="activity-action-row" on:click={action.action}>
          <span class="activity-action-icon-wrap">
            <span class="activity-action-icon">{action.icon}</span>
          </span>
          <span class="activity-action-label">{action.label}</span>
        </button>
      {/each}
    </div>
  </div>
{/if}

<style>
  .activity-overlay {
    position: fixed;
    inset: 0;
    background: rgba(0, 0, 0, 0.2);
    z-index: 100;
  }

  .activity-sheet {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    border-radius: 20px 20px 0 0;  /* activitySheet.iphoneTop */
    background: rgba(250, 250, 250, 0.72);
    backdrop-filter: blur(20px) saturate(180%);
    -webkit-backdrop-filter: blur(20px) saturate(180%);
    z-index: 101;
    overflow: hidden;
    padding-bottom: env(safe-area-inset-bottom);
  }

  .activity-close {
    position: absolute;
    top: 14px;
    right: 16px;
    width: 30px;
    height: 30px;
    border-radius: 50%;
    background: rgba(239, 239, 244, 1);  /* fills.tertiary light */
    border: none;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
    color: rgba(60, 60, 67, 0.6);  /* labels.secondary light */
  }

  .activity-header {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 20px 16px 16px;
  }

  .activity-header-icon {
    font-size: 24px;
    flex-shrink: 0;
  }

  .activity-header-title {
    font-size: 15px;
    font-weight: 600;
    line-height: 20px;
    margin: 0 0 2px;
    color: #000000;
  }

  .activity-header-url {
    font-size: 13px;
    font-weight: 400;
    line-height: 18px;
    margin: 0;
    color: rgba(60, 60, 67, 0.6);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }

  .activity-separator {
    height: 1px;
    background: rgba(0, 0, 0, 0.12);
    margin: 0;
  }

  .activity-action-row {
    display: flex;
    align-items: center;
    width: 100%;
    height: 57px;  /* components.activityView.actionRowHeight */
    padding: 0 16px;
    gap: 12px;
    background: transparent;
    border: none;
    cursor: pointer;
    text-align: left;
  }

  .activity-action-row:active {
    background: rgba(0, 0, 0, 0.06);
  }

  .activity-action-icon-wrap {
    width: 29px;
    height: 29px;
    border-radius: 6px;
    background: #f2f2f7;  /* fills.secondary light */
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    font-size: 16px;
  }

  .activity-action-label {
    font-size: 17px;
    font-weight: 400;
    line-height: 22px;
    color: #000000;
  }

  /* Dark mode */
  @media (prefers-color-scheme: dark) {
    .activity-sheet {
      background: rgba(28, 28, 30, 0.82);
    }
    .activity-close {
      background: rgba(58, 58, 60, 1);
      color: rgba(235, 235, 245, 0.7);
    }
    .activity-header-title,
    .activity-action-label {
      color: #ffffff;
    }
    .activity-header-url {
      color: rgba(235, 235, 245, 0.7);
    }
    .activity-separator {
      background: rgba(255, 255, 255, 0.17);
    }
    .activity-action-row:active {
      background: rgba(255, 255, 255, 0.08);
    }
    .activity-action-icon-wrap {
      background: #2c2c2e;
    }
    .activity-overlay {
      background: rgba(0, 0, 0, 0.48);
    }
  }

  /* Reduce Motion */
  @media (prefers-reduced-motion: reduce) {
    .activity-sheet {
      transition: opacity 0.2s ease-out;
    }
  }
</style>
```

---

## 15. Accessibility

| 항목 | 요구사항 |
|------|---------|
| 최소 탭 타겟 | 액션 행 `57pt`, Close 버튼 `30pt` (최소 44pt 미달 — HIG 예외 허용 영역) |
| Close 버튼 | `accessibilityLabel = "닫기"`, `accessibilityTraits = .button` |
| VoiceOver role | 시트 컨테이너: `UIAccessibilityTraitNone`, 액션 행: `UIAccessibilityTraitButton` |
| VoiceOver 포커스 | 시트 등장 시 첫 번째 액션 아이템으로 자동 포커스 |
| 앱 아이콘 accessibilityLabel | 앱 이름 명시 (e.g. "메시지로 공유") |
| Contact 아이콘 | 연락처 이름 + "에게 AirDrop" 형식 |
| 스크롤 접근성 | Contact Row, 앱 그리드 수평 스크롤 — `UIScrollView` accessibility 자동 지원 |
| Dynamic Type | 액션 행 텍스트 `.body` ~ `.accessibilityExtraExtraLarge`, 행 높이 자동 확장 |
| Reduce Motion | 슬라이드 업 + 스태거 비활성화 → fade only |
| 색상 대비 | 액션 텍스트 vs 배경: 4.5:1 이상 (WCAG AA) |
| 키보드 탐색 (iPadOS) | Tab으로 액션 간 이동, Escape로 dismiss |
| 오버레이 | `isAccessibilityElement = false` — 탭은 가능하나 VoiceOver 탐색에서 제외 |

---

## 16. iPhone vs iPad 동작 차이 요약

| 항목 | iPhone | iPad |
|------|--------|------|
| 프레젠테이션 | Bottom Sheet (.medium → .large) | Popover (고정 너비 320pt) |
| cornerRadius | `20pt` (top) | `14pt` (전체) |
| Dismiss 방법 | Close 버튼 또는 아래 스와이프 | 배경 탭 또는 Close 버튼 |
| Cancel 버튼 | 없음 (Close X 버튼 사용) | 없음 (배경 탭 역할) |
| 너비 | 화면 전체 | `320pt` |
| 화살표 | 없음 | 있음 (트리거 방향) |
| `popoverPresentationController` | 불필요 | **필수** (미설정 시 크래시) |

---

## 17. Web Share API 지원 현황 (2026년 기준)

| 브라우저/환경 | 지원 | 비고 |
|-------------|------|------|
| iOS Safari 15.4+ | ✅ | `navigator.share()` + 파일 지원 |
| Android Chrome | ✅ | 완전 지원 |
| macOS Safari | ✅ | macOS 12.1+ |
| Windows Chrome | ✅ | Windows 10+ |
| Firefox (데스크톱) | ❌ | 미지원 — 폴백 UI 필수 |
| 크롬 (데스크톱) | ✅ | Windows/macOS 지원 |

```typescript
// 안전한 Web Share API 사용 패턴
async function safeShare(data: ShareData): Promise<boolean> {
  // 1. API 존재 여부 확인
  if (!navigator.share) return false;

  // 2. 파일 공유 시 canShare() 확인
  if (data.files && !navigator.canShare?.(data)) return false;

  try {
    await navigator.share(data);
    return true;
  } catch (err) {
    // AbortError: 사용자 취소 (정상)
    if (err instanceof Error && err.name === 'AbortError') return false;
    throw err;  // 기타 에러는 상위로 전달
  }
}
```
