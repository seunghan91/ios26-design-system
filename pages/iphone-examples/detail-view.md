# Detail View — iOS 26 페이지 레시피

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
| **화면명** | 상세 화면 (Detail View) |
| **용도** | 기사 / 콘텐츠 상세 — 히어로 이미지 + 긴 텍스트 + 액션 버튼 |
| **탐색 깊이** | 1-depth (목록 화면에서 Push) |
| **상태 수** | 로딩 스켈레톤 / 정상 / 오류 |
| **iOS 26 특이사항** | 스크롤 시 Large Title → Inline Title 전환, Toolbar가 히어로 이미지 위를 투명하게 오버레이 |

콘텐츠 상세 화면의 핵심 패턴은 **히어로 이미지 위로 Navigation Bar가 투명하게 떠있다가**, 스크롤 진행에 따라 점차 불투명한 Liquid Glass로 변환되는 것이다. 이 전환이 iOS 26의 대표적인 비주얼 특징 중 하나이다. 하단에는 공유/북마크 등 주요 액션 버튼이 위치한다.

---

## 사용된 Template

**`standard-screen.md`** (back button 포함) + **`navigation-stack.md`** 전환 패턴

```
Template 조합:
- Navigation Bar: 상단 오버레이 (초기 투명), back button 자동 표시
- Content: ScrollView — 히어로 이미지 먼저, 이후 텍스트 영역
- Tab Bar: 없음 (Detail 화면에서는 숨김 권장)
- Large Title: 스크롤 진행 시 Inline으로 전환 (선택 — 제목이 짧을 때)
```

---

## 컴포넌트 계층 (ASCII 와이어프레임)

```
iPhone 16 Pro (393 × 852 pt)
┌─────────────────────────────────────────┐
│  ← 뒤로  [투명 Toolbar]    [공유] [⋯]   │  ← Navigation Bar (투명, 오버레이 상태)
│                                          │    blur: 0pt  |  배경: 완전 투명
├── 히어로 이미지 영역 (edge-to-edge) ──────┤
│ ████████████████████████████████████████ │  ← 전체 너비 이미지
│ ████████████████████████████████████████ │    높이: 260pt (비율 유지)
│ ████████████████████████████████████████ │    aspect ratio: 16:9 또는 4:3
│ ████████████████████████████████████████ │    contentMode: scaleAspectFill
│ ████████████████████████████████████████ │    하단 그라디언트 오버레이
│ ████████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ │    rgba(0,0,0,0) → rgba(0,0,0,0.45)
│ ████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ │
│ ██████████████  카테고리 태그           ██ │    ← 이미지 위 오버레이 텍스트 (선택)
├── 콘텐츠 영역 (흰 배경 시작) ─────────────┤
│                                          │
│  📍 카테고리 / 섹션                       │  ← 13pt Semibold, accent color
│                                          │
│  기사 제목 또는 콘텐츠 제목이              │  ← 28pt Bold (큰 타이틀)
│  여기에 2~3줄로 표시됩니다               │    lineLimit: 3
│                                          │
│  홍길동 · 2026. 3. 28. · 읽는 데 5분    │  ← 13pt Regular, secondary
│                                          │
│  ─────────────────────────────────────  │  ← 구분선
│                                          │
│  본문 텍스트가 여기서 시작됩니다. iOS 26  │  ← 17pt Regular, lineHeight 1.5
│  은 새로운 디자인 언어인 Liquid Glass를  │    reading width: max 680pt
│  도입했습니다.                           │
│                                          │
│  본문 텍스트 두 번째 단락이 이어집니다.   │
│  중요한 내용을 강조할 때는 Bold 처리를   │
│  사용할 수 있습니다.                     │
│                                          │
│  ┌─────────────────────────────────┐    │  ← 인용구 블록 (선택)
│  │  ❝ 인용구 텍스트를 이렇게       │    │    left-border: 4pt, accent
│  │    강조합니다                   │    │    background: fills.secondary
│  └─────────────────────────────────┘    │
│                                          │
│  [이미지 캡션이 포함된 인라인 이미지]      │
│  ████████████████████████████████████   │
│  사진 설명 텍스트 (13pt, secondary)       │
│                                          │
│  본문 계속...                            │
│                                          │
├── 하단 액션 바 ──────────────────────────┤
│  ┌─────────────────────────────────────┐ │  ← Sticky Bottom Bar (shadow 위)
│  │  [♡ 좋아요]  [🔖 저장]  [공유 →]   │ │    height: 60pt
│  └─────────────────────────────────────┘ │    background: Liquid Glass
│                                          │
│         (하단 Safe Area 34pt)            │
└─────────────────────────────────────────┘

스크롤 진행 후 (offset >= 220pt):
┌─────────────────────────────────────────┐
│  ← 뒤로  기사 제목 (inline)  [공유] [⋯]  │  ← Navigation Bar
│          Liquid Glass background 활성화   │    blur: 12pt, opacity 0.85
│  ─────────────────────────────────────  │
│  (히어로 이미지 스크롤 아웃)               │
│  기사 제목 또는 콘텐츠 제목이              │
│  ...                                     │
```

---

## 사용된 Components 목록

| 컴포넌트 | 파일 | 사용 위치 | Variant |
|---------|------|---------|---------|
| Toolbar (Top) | `toolbar.md` | 상단 — 초기 투명, 스크롤 후 Liquid Glass | Inline (back + trailing buttons) |
| Button | `button.md` | 하단 액션 바 + Toolbar trailing | Borderless (아이콘), Filled (공유) |
| List Row (없음) | — | 이 화면은 자유 레이아웃 | — |
| Progress Indicator | `progress-indicators.md` | 초기 로딩 스켈레톤 | Linear / Shimmer |

---

## 레이아웃 구조

```
Detail View 수직 레이아웃 치수:

┌── Navigation Bar ──────── 44pt (overlay, top=54pt) ──┐
│   초기: 투명 / 스크롤 후: Liquid Glass                  │
├── 히어로 이미지 ──────── 260pt ────────────────────────┤
│   edge-to-edge (좌우 패딩 없음)                         │
│   하단 그라디언트 오버레이 높이: 80pt                    │
├── 콘텐츠 패딩 영역 ────── 20pt top ───────────────────┤
│   horizontal padding: 20pt                             │
│   ├── 카테고리 라벨 ─── 13pt Semibold, accent ─── 20pt  │
│   ├── 대제목 ──────── 28pt Bold, primary ──── 36pt     │
│   │   line-height: 1.3                                 │
│   ├── 메타 정보 ────── 13pt Regular, secondary  32pt   │
│   ├── 구분선 ──────── 1pt, separator color             │
│   └── 본문 ────────── 17pt Regular, primary            │
│       line-height: 1.55                                │
│       문단 간격: 16pt                                  │
│       max-width: 680pt (iPad에서 의미 있음)             │
├── 하단 액션 바 ──────── 60pt (sticky) ────────────────┤
│   background: Liquid Glass (blur 12pt)                 │
│   horizontal-padding: 20pt                             │
│   버튼 간격: equal spacing                              │
└── Safe Area Bottom ─── 34pt ─────────────────────────┘
```

### Toolbar 투명→Liquid Glass 전환 기준

```
scrollOffset.y = 0pt    → Toolbar: alpha 0.0 (완전 투명)
scrollOffset.y = 0~220pt → alpha linear 0.0 → 0.85
scrollOffset.y >= 220pt  → alpha 0.85 (고정), blur 12pt 유지

220pt = 히어로 이미지 높이 260pt - Navigation Bar 높이 44pt
(이미지가 Toolbar 아래로 완전히 사라지는 시점)
```

### 색상 토큰 매핑

| 요소 | 토큰 | 값 (Light) |
|------|------|-----------|
| 콘텐츠 배경 | `backgrounds.primary` | `#ffffff` |
| 대제목 | `labels.primary` | `#000000` |
| 메타 정보 | `labels.secondary` | `#3c3c43 60%` |
| 본문 | `labels.primary` | `#000000` |
| 카테고리 | `accents.blue.light` | `#0088ff` |
| 인용구 border | `accents.blue.light` | `#0088ff` |
| 인용구 BG | `backgrounds.secondary` | `#f2f2f7` |
| 하단 바 | Liquid Glass | blur 12pt |
| Toolbar (스크롤) | Liquid Glass | blur 12pt, 85% |

---

## 특이사항 / 커스터마이징 포인트

### 히어로 이미지 edge-to-edge
- `ignoresSafeArea()` / `EdgeInsets.zero` 로 좌우 패딩 제거
- 이미지 로딩 전: Shimmer 스켈레톤 (회색 사각형 + pulse 애니메이션)
- 이미지 aspect ratio 유지하되 최대 높이 300pt 제한 (너무 긴 이미지 방지)

### Navigation Bar 아이콘 색상 (투명 모드)
- 히어로 이미지 밝기에 따라 아이콘 색 자동 조정
  - 밝은 이미지: `labels.primary` (검정)
  - 어두운 이미지: 흰색 (`#ffffff`)
- 또는 아이콘 뒤에 작은 원형 반투명 배경 추가 (pill 스타일)

### 스켈레톤 로딩 상태
```
┌─────────────────────────────────────────┐
│ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ │  ← 이미지 영역 shimmer (260pt)
├─────────────────────────────────────────┤
│                                          │
│  ░░░░░░░░░░░  (카테고리 라벨 스켈레톤)   │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░  (제목 1줄) │
│  ░░░░░░░░░░░░░░░░░░░░░░  (제목 2줄)     │
│  ░░░░░░░░░░░░░░░░░  (메타 정보)         │
│                                          │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  (본문) │
│  ░░░░░░░░░░░░░░░░░░░░░░░░  (본문)       │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  (본문) │
└─────────────────────────────────────────┘
shimmer animation: x -100%→100%, duration 1.2s, repeat
```

### 읽기 진행 표시 (선택)
- Navigation Bar 하단에 1pt 높이 linear progress bar 추가
- scrollOffset / totalContentHeight 비율로 채워짐
- 색: `accents.blue.light`

---

## 애니메이션 시나리오

### 1. 화면 진입 Push 전환
```
트리거: 목록 Row 탭
Duration: 0.4s
Curve: spring(damping: 0.85, response: 0.4)
요소:
  - 화면: x +393pt→0 (right-to-left slide)
  - 히어로 이미지: scale 0.95→1.0 (동시에)
  - Navigation Bar 투명 상태로 진입
```

### 2. Toolbar 투명→Liquid Glass 전환
```
트리거: scrollOffset 0→220pt 연속 변화
Duration: 연속 (인터랙티브)
요소:
  - Toolbar 배경: blur 0→12pt, opacity 0→0.85 (선형 보간)
  - Toolbar 아이콘: color 흰색→labels.primary (밝은 이미지 기준)
  - 경계선(hairline): opacity 0→0.3
```

### 3. 좋아요 버튼 탭
```
트리거: 하트 아이콘 버튼 탭
Duration: 0.3s
Curve: spring(damping: 0.5, stiffness: 400) → bounce 효과
요소:
  - 하트 아이콘: scale 1→1.4→1.0
  - 색: labels.tertiary → accents.red (#ff383c)
  - 미세 진동(haptic): .light impact
```

### 4. 북마크 저장
```
트리거: 북마크 아이콘 탭
Duration: 0.25s
Curve: easeOut
요소:
  - 아이콘: bookmark → bookmark.fill (fill 애니메이션)
  - 색: labels.secondary → accents.blue.light
  - 토스트: "저장됨" (하단 Safe Area 위, 2초 후 fade-out)
```

---

## 프레임워크별 전체 코드 예시

### SwiftUI (iOS 26)

```swift
import SwiftUI

struct DetailView: View {
    let item: ContentItem
    @State private var scrollOffset: CGFloat = 0
    @State private var isLiked = false
    @State private var isBookmarked = false
    @Environment(\.dismiss) private var dismiss

    // 스크롤 offset에 따른 Toolbar 투명도 (0pt~220pt)
    private var toolbarOpacity: Double {
        min(scrollOffset / 220.0, 1.0)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            // 메인 스크롤 콘텐츠
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // 히어로 이미지 (edge-to-edge)
                    GeometryReader { geo in
                        AsyncImage(url: item.heroImageURL) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ShimmerRect(height: 260)
                        }
                        .frame(width: geo.size.width, height: 260)
                        .clipped()
                        .overlay(alignment: .bottom) {
                            // 하단 그라디언트
                            LinearGradient(
                                colors: [.clear, .black.opacity(0.45)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .frame(height: 80)
                        }
                    }
                    .frame(height: 260)

                    // 콘텐츠 영역
                    VStack(alignment: .leading, spacing: 0) {
                        // 카테고리
                        Text(item.category.uppercased())
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.blue)
                            .padding(.top, 20)

                        // 대제목
                        Text(item.title)
                            .font(.system(size: 28, weight: .bold))
                            .lineSpacing(4)
                            .padding(.top, 8)

                        // 메타 정보
                        Text("\(item.authorName) · \(item.publishedDate) · 읽는 데 \(item.readMinutes)분")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .padding(.top, 12)

                        Divider()
                            .padding(.top, 16)
                            .padding(.bottom, 20)

                        // 본문
                        Text(item.body)
                            .font(.body)
                            .lineSpacing(8)

                        // 하단 여백 (sticky bar 높이 + safe area)
                        Spacer().frame(height: 100)
                    }
                    .padding(.horizontal, 20)
                }
                // 스크롤 offset 추적
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                scrollOffset = -geo.frame(in: .named("scroll")).minY
                            }
                            .onChange(of: geo.frame(in: .named("scroll")).minY) { _, newY in
                                scrollOffset = -newY
                            }
                    }
                )
            }
            .coordinateSpace(name: "scroll")
            .ignoresSafeArea(edges: .top)

            // 하단 액션 바 (sticky)
            bottomActionBar
                .background(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.08), radius: 8, y: -2)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .fontWeight(.semibold)
                }
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: { shareItem() }) {
                    Image(systemName: "square.and.arrow.up")
                }
                Menu {
                    Button("링크 복사") {}
                    Button("신고하기", role: .destructive) {}
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .toolbarBackground(
            toolbarOpacity > 0.1 ? .ultraThinMaterial : .hidden,
            for: .navigationBar
        )
    }

    private var bottomActionBar: some View {
        HStack(spacing: 0) {
            // 좋아요
            Button(action: {
                withAnimation(.spring(damping: 0.5, blendDuration: 0.3)) {
                    isLiked.toggle()
                }
            }) {
                Label(
                    isLiked ? "좋아요 취소" : "좋아요",
                    systemImage: isLiked ? "heart.fill" : "heart"
                )
                .foregroundStyle(isLiked ? .red : .secondary)
            }
            .frame(maxWidth: .infinity)

            // 북마크
            Button(action: {
                withAnimation(.easeOut(duration: 0.25)) {
                    isBookmarked.toggle()
                }
            }) {
                Label(
                    isBookmarked ? "저장됨" : "저장",
                    systemImage: isBookmarked ? "bookmark.fill" : "bookmark"
                )
                .foregroundStyle(isBookmarked ? .blue : .secondary)
            }
            .frame(maxWidth: .infinity)

            // 공유
            Button(action: shareItem) {
                Label("공유", systemImage: "square.and.arrow.up")
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 20)
        .frame(height: 60)
    }

    private func shareItem() {
        let activityVC = UIActivityViewController(
            activityItems: [item.shareURL as Any],
            applicationActivities: nil
        )
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first?
            .rootViewController?.present(activityVC, animated: true)
    }
}
```
