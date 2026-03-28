# iOS 26 Empty States — Component Spec

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="5518:18111")`

---

## 1. 개요

iOS 26 Empty States는 콘텐츠가 없을 때 사용자에게 상황을 안내하고 다음 행동을 유도하는 UI다. 세 가지 복잡도 단계의 variant를 제공하며, 수직 중앙 정렬로 콘텐츠 영역 중앙에 배치된다.

**사용 시점**:
- 목록이 비어있을 때 (검색 결과 없음, 필터 결과 없음)
- 첫 실행 온보딩 (아직 데이터 없음)
- 오류로 인해 콘텐츠를 불러오지 못할 때
- 권한 미부여로 접근 불가할 때

---

## 2. Variants (3개)

| Variant | 구성 | 사용 시점 |
|---|---|---|
| `Icon Only` | 아이콘 | 보조 화면, 공간 제약 시 |
| `Icon + Text` | 아이콘 + 타이틀 + 설명 | 일반적인 빈 상태 |
| `Icon + Text + Button` | 아이콘 + 타이틀 + 설명 + CTA 버튼 | 사용자 행동 유도 필요 시 |

---

## 3. 치수 & 레이아웃

### 3.1 전체 배치

```
┌───────────────────────────────────────┐
│                                       │
│                 ↕ flex                │  ← 상단 safe area + 상단 여백
│                                       │
│         ┌─────────────────┐           │
│         │                 │           │
│         │   [SF Symbol]   │           │  ← 아이콘 60×60pt
│         │                 │           │
│         └─────────────────┘           │
│                 ↕ 16pt                │
│         ┌─────────────────┐           │
│         │    타이틀 텍스트  │           │  ← Large Title / Title2
│         └─────────────────┘           │
│                 ↕ 8pt                 │
│         ┌─────────────────┐           │
│         │  설명 텍스트      │           │  ← Body, 멀티라인 가능
│         │  (최대 2줄 권장)  │           │
│         └─────────────────┘           │
│                 ↕ 24pt                │
│         ┌─────────────────┐           │
│         │  [  CTA 버튼  ]  │           │  ← Button Content Area (Medium, Filled)
│         └─────────────────┘           │
│                                       │
│                 ↕ flex                │  ← 하단 여백 + safe area
│                                       │
└───────────────────────────────────────┘
  수평 패딩: 40pt (양쪽)
  최대 콘텐츠 너비: 280pt
```

### 3.2 요소별 치수

| 요소 | 치수 / 스펙 |
|---|---|
| 아이콘 | 60×60pt, SF Symbol font-size 60pt |
| 아이콘 → 타이틀 간격 | 16pt |
| 타이틀 → 설명 간격 | 8pt |
| 설명 → 버튼 간격 | 24pt |
| 수평 패딩 | 40pt (양쪽) |
| 최대 콘텐츠 너비 | 280pt |
| 버튼 높이 | 50pt (Medium Filled) |
| 버튼 최소 너비 | 140pt |
| 버튼 코너 반경 | 14pt |
| 전체 수직 배치 | safe area 기준 중앙 정렬 |

---

## 4. 색상 토큰

```json
// ../tokens/colors.json 참조
{
  "emptyState": {
    "icon": "Colors/Label/Tertiary",
    "title": "Colors/Label/Primary",
    "description": "Colors/Label/Secondary",
    "button": {
      "background": "Colors/Tint/Blue",
      "label": "#FFFFFF"
    },
    "background": "transparent"
  }
}
```

- **아이콘**: `Colors/Label/Tertiary` — 배경과 구분되나 강조하지 않는 색상
- **타이틀**: `Colors/Label/Primary` — 가장 강한 텍스트
- **설명**: `Colors/Label/Secondary` — 보조 텍스트
- **버튼 배경**: `Colors/Tint/Blue`
- **버튼 텍스트**: 흰색 `#FFFFFF`

---

## 5. 타이포그래피

```json
// ../tokens/typography.json 참조
{
  "emptyState": {
    "titleLarge": {
      "fontStyle": "Large Title",
      "weight": "Bold",
      "size": "34pt",
      "useCase": "최상위 화면 (탭바 루트 뷰)"
    },
    "titleRegular": {
      "fontStyle": "Title2",
      "weight": "Bold",
      "size": "22pt",
      "useCase": "일반 화면 (목록, 검색 결과)"
    },
    "description": {
      "fontStyle": "Body",
      "weight": "Regular",
      "size": "17pt",
      "lineHeight": "1.5",
      "textAlign": "center"
    },
    "button": {
      "fontStyle": "Body",
      "weight": "Semibold",
      "size": "17pt"
    }
  }
}
```

**타이틀 선택 기준**:
- 앱의 최상위 탭 화면 → `Large Title` (34pt Bold)
- 내비게이션 스택 중간 화면, 검색 결과 → `Title2` (22pt Bold)

---

## 6. 간격 토큰

```json
// ../tokens/spacing.json 참조
{
  "emptyState": {
    "iconSize": 60,
    "iconToTitleSpacing": 16,
    "titleToDescriptionSpacing": 8,
    "descriptionToButtonSpacing": 24,
    "horizontalPadding": 40,
    "maxContentWidth": 280,
    "buttonHeight": 50,
    "buttonMinWidth": 140,
    "buttonCornerRadius": 14,
    "buttonPaddingH": 24
  }
}
```

---

## 7. 애니메이션

```json
// ../tokens/animations.json 참조
{
  "emptyState": {
    "appear": {
      "type": "easeOut",
      "duration": 0.3,
      "icon": {
        "opacity": "0 → 1",
        "scale": "0.9 → 1.0"
      },
      "title": {
        "opacity": "0 → 1",
        "translateY": "8pt → 0",
        "delay": 0.05
      },
      "description": {
        "opacity": "0 → 1",
        "translateY": "8pt → 0",
        "delay": 0.1
      },
      "button": {
        "opacity": "0 → 1",
        "translateY": "8pt → 0",
        "delay": 0.15
      }
    },
    "disappear": {
      "type": "easeIn",
      "duration": 0.2,
      "opacity": "1 → 0",
      "scale": "1.0 → 0.95"
    }
  }
}
```

### 7.1 등장 시퀀스 (Staggered)

각 요소가 순서대로 fade + translateY로 등장한다:

1. **아이콘** (t=0): opacity 0→1, scale 0.9→1.0 (0.3s easeOut)
2. **타이틀** (t=0.05s): opacity 0→1, translateY 8→0pt (0.3s easeOut)
3. **설명** (t=0.1s): opacity 0→1, translateY 8→0pt (0.3s easeOut)
4. **버튼** (t=0.15s): opacity 0→1, translateY 8→0pt (0.3s easeOut)

### 7.2 사라질 때

콘텐츠가 로드되어 Empty State가 사라질 때:
- 전체 opacity 1→0, scale 1.0→0.95 (0.2s easeIn)
- 콘텐츠 리스트는 동시에 fade-in

---

## 8. 상태 정의

| 상태 | 설명 |
|---|---|
| `no-content` | 데이터 없음 (일반 빈 상태) |
| `no-results` | 검색/필터 결과 없음 (다른 아이콘/텍스트) |
| `error` | 네트워크/서버 오류 (재시도 버튼 포함) |
| `no-permission` | 권한 없음 (설정 열기 버튼 포함) |
| `loading-complete` | 로딩 완료 후 비어있음 (appear 애니메이션 트리거) |

---

## 9. 아이콘 가이드라인

### 9.1 권장 SF Symbols

| 상황 | SF Symbol | 설명 |
|---|---|---|
| 목록 없음 | `tray` | 일반 빈 상태 |
| 검색 결과 없음 | `magnifyingglass` | 검색 관련 |
| 즐겨찾기 없음 | `star` | 즐겨찾기 관련 |
| 메시지 없음 | `message` | 메시지 관련 |
| 알림 없음 | `bell` | 알림 관련 |
| 오류 | `exclamationmark.triangle` | 오류 상태 |
| 권한 없음 | `lock` | 접근 제한 |
| 인터넷 없음 | `wifi.slash` | 네트워크 오류 |
| 파일 없음 | `doc` | 파일/문서 관련 |
| 사진 없음 | `photo` | 미디어 관련 |

### 9.2 아이콘 렌더링

```swift
// UIKit
let config = UIImage.SymbolConfiguration(pointSize: 60, weight: .regular)
let image = UIImage(systemName: "tray", withConfiguration: config)
imageView.image = image
imageView.tintColor = .tertiaryLabel

// SwiftUI
Image(systemName: "tray")
    .font(.system(size: 60))
    .foregroundStyle(.tertiary)
    .frame(width: 60, height: 60)
```

---

## 10. 플랫폼별 구현

### 10.1 UIKit (커스텀 UIView)

```swift
import UIKit

class EmptyStateView: UIView {

    enum Variant {
        case iconOnly(systemImage: String)
        case iconText(systemImage: String, title: String, description: String)
        case iconTextButton(systemImage: String, title: String, description: String,
                            buttonTitle: String, action: () -> Void)
    }

    private let stackView = UIStackView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private var ctaButton: UIButton?

    init(variant: Variant) {
        super.init(frame: .zero)
        setupStack()
        configure(variant: variant)
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupStack() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            stackView.widthAnchor.constraint(lessThanOrEqualToConstant: 280)
        ])
    }

    private func configure(variant: Variant) {
        // 아이콘
        let symbolName: String
        switch variant {
        case .iconOnly(let name), .iconText(let name, _, _), .iconTextButton(let name, _, _, _, _):
            symbolName = name
        }

        let config = UIImage.SymbolConfiguration(pointSize: 60, weight: .regular)
        iconImageView.image = UIImage(systemName: symbolName, withConfiguration: config)
        iconImageView.tintColor = .tertiaryLabel
        iconImageView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(iconImageView)
        iconImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true

        if case .iconOnly = variant { return }

        // 타이틀
        stackView.setCustomSpacing(16, after: iconImageView)

        let title: String
        let description: String
        switch variant {
        case .iconText(_, let t, let d), .iconTextButton(_, let t, let d, _, _):
            title = t; description = d
        default: return
        }

        titleLabel.text = title
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        stackView.addArrangedSubview(titleLabel)

        // 설명
        stackView.setCustomSpacing(8, after: titleLabel)

        descriptionLabel.text = description
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        stackView.addArrangedSubview(descriptionLabel)

        // 버튼 (variant 3만)
        guard case .iconTextButton(_, _, _, let buttonTitle, let action) = variant else { return }

        stackView.setCustomSpacing(24, after: descriptionLabel)

        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.title = buttonTitle
        buttonConfig.cornerStyle = .large
        buttonConfig.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 24, bottom: 0, trailing: 24
        )

        let button = UIButton(configuration: buttonConfig)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(greaterThanOrEqualToConstant: 140).isActive = true

        var handler: UIAction.Handler = { _ in action() }
        button.addAction(UIAction(handler: handler), for: .touchUpInside)

        stackView.addArrangedSubview(button)
        ctaButton = button
    }

    func animateIn() {
        let elements: [UIView] = [iconImageView, titleLabel, descriptionLabel, ctaButton].compactMap { $0 }

        elements.forEach { view in
            view.alpha = 0
            view.transform = CGAffineTransform(translationX: 0, y: 8)
                .concatenating(CGAffineTransform(scaleX: 0.9, y: 0.9))
        }

        // 아이콘은 scale 애니메이션
        iconImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)

        for (i, view) in elements.enumerated() {
            let delay = Double(i) * 0.05
            UIView.animate(
                withDuration: 0.3,
                delay: delay,
                options: .curveEaseOut
            ) {
                view.alpha = 1
                view.transform = .identity
            }
        }
    }
}

// 사용 예시
class MyListViewController: UIViewController {
    var emptyStateView: EmptyStateView?

    func showEmptyState() {
        let emptyView = EmptyStateView(variant: .iconTextButton(
            systemImage: "tray",
            title: "항목이 없습니다",
            description: "새 항목을 추가하면 여기에 표시됩니다.",
            buttonTitle: "항목 추가"
        ) { [weak self] in
            self?.addNewItem()
        })

        emptyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyView)
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        emptyStateView = emptyView
        emptyView.animateIn()
    }

    func addNewItem() { /* 항목 추가 로직 */ }
}
```

### 10.2 SwiftUI (`ContentUnavailableView`, iOS 17+)

```swift
import SwiftUI

struct EmptyStateDemo: View {
    @State private var items: [String] = []
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List(filteredItems, id: \.self) { item in
                Text(item)
            }
            // iOS 17+: ContentUnavailableView 자동 처리
            .overlay {
                if filteredItems.isEmpty {
                    emptyStateView
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("목록")
        }
    }

    var filteredItems: [String] {
        searchText.isEmpty ? items : items.filter { $0.contains(searchText) }
    }

    @ViewBuilder
    var emptyStateView: some View {
        if !searchText.isEmpty {
            // 검색 결과 없음 - iOS 17 ContentUnavailableView 활용
            ContentUnavailableView.search(text: searchText)

        } else if items.isEmpty {
            // 일반 빈 상태 - Variant 3 (아이콘 + 텍스트 + 버튼)
            ContentUnavailableView {
                Label("항목이 없습니다", systemImage: "tray")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.tertiary, Color.accentColor)
            } description: {
                Text("새 항목을 추가하면 여기에 표시됩니다.")
                    .foregroundStyle(.secondary)
            } actions: {
                Button("항목 추가") {
                    // 액션
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
        }
    }
}

// 커스텀 EmptyStateView (iOS 16 이하 대응 또는 세밀한 제어)
struct CustomEmptyStateView: View {
    let systemImage: String
    let title: String
    var description: String? = nil
    var buttonTitle: String? = nil
    var buttonAction: (() -> Void)? = nil

    @State private var appeared = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 0) {
                // 아이콘
                Image(systemName: systemImage)
                    .font(.system(size: 60))
                    .foregroundStyle(.tertiary)
                    .frame(width: 60, height: 60)
                    .opacity(appeared ? 1 : 0)
                    .scaleEffect(appeared ? 1.0 : 0.9)
                    .animation(.easeOut(duration: 0.3).delay(0), value: appeared)

                // 타이틀
                if !title.isEmpty {
                    Text(title)
                        .font(.title2.bold())
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 16)
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : 8)
                        .animation(.easeOut(duration: 0.3).delay(0.05), value: appeared)
                }

                // 설명
                if let desc = description {
                    Text(desc)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : 8)
                        .animation(.easeOut(duration: 0.3).delay(0.1), value: appeared)
                }

                // CTA 버튼
                if let btnTitle = buttonTitle, let action = buttonAction {
                    Button(action: action) {
                        Text(btnTitle)
                            .font(.body.weight(.semibold))
                            .frame(minWidth: 140, minHeight: 50)
                            .padding(.horizontal, 24)
                    }
                    .buttonStyle(.borderedProminent)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .padding(.top, 24)
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 8)
                    .animation(.easeOut(duration: 0.3).delay(0.15), value: appeared)
                }
            }
            .frame(maxWidth: 280)
            .padding(.horizontal, 40)

            Spacer()
        }
        .onAppear { appeared = true }
    }
}
```

### 10.3 Flutter

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum EmptyStateVariant { iconOnly, iconText, iconTextButton }

class EmptyStateWidget extends StatefulWidget {
  const EmptyStateWidget({
    super.key,
    required this.icon,
    this.title,
    this.description,
    this.buttonLabel,
    this.onButtonTap,
  });

  final IconData icon;
  final String? title;
  final String? description;
  final String? buttonLabel;
  final VoidCallback? onButtonTap;

  @override
  State<EmptyStateWidget> createState() => _EmptyStateWidgetState();
}

class _EmptyStateWidgetState extends State<EmptyStateWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _opacities;
  late List<Animation<Offset>> _offsets;
  late Animation<double> _iconScale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // 4개 요소 각각의 지연 시간
    final delays = [0.0, 0.1, 0.2, 0.3];

    _opacities = delays.map((delay) => Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(delay, delay + 0.6, curve: Curves.easeOut),
      ),
    )).toList();

    _offsets = delays.map((delay) => Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(delay, delay + 0.6, curve: Curves.easeOut),
      ),
    )).toList();

    _iconScale = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.6, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 280),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 아이콘
              FadeTransition(
                opacity: _opacities[0],
                child: ScaleTransition(
                  scale: _iconScale,
                  child: Icon(
                    widget.icon,
                    size: 60,
                    color: CupertinoColors.tertiaryLabel.resolveFrom(context),
                  ),
                ),
              ),

              // 타이틀
              if (widget.title != null) ...[
                const SizedBox(height: 16),
                FadeTransition(
                  opacity: _opacities[1],
                  child: SlideTransition(
                    position: _offsets[1],
                    child: Text(
                      widget.title!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.label,
                      ),
                    ),
                  ),
                ),
              ],

              // 설명
              if (widget.description != null) ...[
                const SizedBox(height: 8),
                FadeTransition(
                  opacity: _opacities[2],
                  child: SlideTransition(
                    position: _offsets[2],
                    child: Text(
                      widget.description!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        color: CupertinoColors.secondaryLabel,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],

              // CTA 버튼
              if (widget.buttonLabel != null && widget.onButtonTap != null) ...[
                const SizedBox(height: 24),
                FadeTransition(
                  opacity: _opacities[3],
                  child: SlideTransition(
                    position: _offsets[3],
                    child: CupertinoButton.filled(
                      onPressed: widget.onButtonTap,
                      borderRadius: BorderRadius.circular(14),
                      minSize: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        widget.buttonLabel!,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// 사용 예시
class MyListPage extends StatelessWidget {
  final List<String> items;
  const MyListPage({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return EmptyStateWidget(
        icon: CupertinoIcons.tray,
        title: '항목이 없습니다',
        description: '새 항목을 추가하면 여기에 표시됩니다.',
        buttonLabel: '항목 추가',
        onButtonTap: () {
          // 추가 로직
        },
      );
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, i) => ListTile(title: Text(items[i])),
    );
  }
}
```

### 10.4 Svelte

```svelte
<script lang="ts">
  import { onMount } from 'svelte';
  import { fly, fade, scale } from 'svelte/transition';

  interface EmptyStateProps {
    icon: string;          // SF Symbol 이름 또는 이모지/SVG 경로
    title?: string;
    description?: string;
    buttonLabel?: string;
    onButtonClick?: () => void;
  }

  let {
    icon,
    title,
    description,
    buttonLabel,
    onButtonClick,
  }: EmptyStateProps = $props();

  let mounted = $state(false);
  onMount(() => {
    // 다음 프레임에 마운트 처리 (애니메이션 트리거)
    requestAnimationFrame(() => { mounted = true; });
  });
</script>

<div
  style="
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100%;
    min-height: 300px;
    padding: 40px;
  "
>
  <div
    style="
      display: flex;
      flex-direction: column;
      align-items: center;
      max-width: 280px;
      width: 100%;
    "
  >
    <!-- 아이콘 -->
    {#if mounted}
      <div
        in:scale={{ start: 0.9, duration: 300, easing: (t) => t }}
        in:fade={{ duration: 300 }}
        style="
          font-size: 60px;
          line-height: 1;
          color: var(--color-label-tertiary);
          width: 60px;
          height: 60px;
          display: flex;
          align-items: center;
          justify-content: center;
        "
      >
        {icon}
      </div>
    {/if}

    <!-- 타이틀 -->
    {#if title && mounted}
      <p
        in:fly={{ y: 8, duration: 300, delay: 50 }}
        in:fade={{ duration: 300, delay: 50 }}
        style="
          margin: 16px 0 0;
          font-size: 22px;
          font-weight: 700;
          color: var(--color-label-primary);
          text-align: center;
          line-height: 1.3;
        "
      >
        {title}
      </p>
    {/if}

    <!-- 설명 -->
    {#if description && mounted}
      <p
        in:fly={{ y: 8, duration: 300, delay: 100 }}
        in:fade={{ duration: 300, delay: 100 }}
        style="
          margin: 8px 0 0;
          font-size: 17px;
          font-weight: 400;
          color: var(--color-label-secondary);
          text-align: center;
          line-height: 1.5;
        "
      >
        {description}
      </p>
    {/if}

    <!-- CTA 버튼 -->
    {#if buttonLabel && onButtonClick && mounted}
      <button
        in:fly={{ y: 8, duration: 300, delay: 150 }}
        in:fade={{ duration: 300, delay: 150 }}
        onclick={onButtonClick}
        style="
          margin-top: 24px;
          height: 50px;
          min-width: 140px;
          padding: 0 24px;
          font-size: 17px;
          font-weight: 600;
          color: #FFFFFF;
          background: var(--color-tint-blue);
          border: none;
          border-radius: 14px;
          cursor: pointer;
          transition: opacity 0.15s ease, transform 0.1s ease;

          &:hover { opacity: 0.9; }
          &:active { transform: scale(0.97); }
        "
      >
        {buttonLabel}
      </button>
    {/if}
  </div>
</div>
```

---

## 11. 다크모드 대응

| 토큰 | 라이트 | 다크 |
|---|---|---|
| `Colors/Label/Tertiary` | rgba(60,60,67,0.3) | rgba(235,235,245,0.3) |
| `Colors/Label/Primary` | rgba(0,0,0,1) | rgba(255,255,255,1) |
| `Colors/Label/Secondary` | rgba(60,60,67,0.6) | rgba(235,235,245,0.6) |
| `Colors/Tint/Blue` | #007AFF | #0A84FF |

---

## 12. 콘텐츠 가이드라인

### 12.1 좋은 텍스트 패턴

| 상황 | 타이틀 | 설명 |
|---|---|---|
| 빈 받은 편지함 | "받은 편지함이 비어 있습니다" | "새 메시지가 도착하면 여기에 표시됩니다." |
| 검색 결과 없음 | "결과 없음" | "'홍길동' 검색 결과가 없습니다. 다른 키워드를 시도해 보세요." |
| 즐겨찾기 없음 | "즐겨찾기가 없습니다" | "자주 사용하는 항목을 즐겨찾기에 추가하세요." |
| 오류 | "불러오지 못했습니다" | "잠시 후 다시 시도해 주세요." |

### 12.2 피해야 할 패턴

- "데이터가 없습니다" → 너무 기술적
- "Empty" → 영어 그대로 사용 금지
- 3줄 이상의 긴 설명 → 2줄 이내로 압축
- 느낌표 남용 → 차분한 톤 유지

---

## 13. 접근성

- **VoiceOver**: 아이콘 `accessibilityLabel` 설정 (예: "빈 받은 편지함 아이콘")
- **Dynamic Type**: 타이틀/설명 텍스트 Dynamic Type 지원, `adjustsFontForContentSizeCategory = true`
- **최소 터치 타겟**: CTA 버튼 최소 44×44pt (버튼 높이 50pt로 이미 충족)
- **색상 대비**: 타이틀 `Colors/Label/Primary` ≥ 4.5:1, 설명 `Colors/Label/Secondary` ≥ 3:1
- **감소된 모션**: `UIAccessibility.isReduceMotionEnabled` 확인 시 애니메이션 대신 즉시 표시

```swift
// 감소된 모션 대응
if UIAccessibility.isReduceMotionEnabled {
    emptyStateView.alpha = 1
    emptyStateView.transform = .identity
} else {
    emptyStateView.animateIn()
}
```

---

## 14. 체크리스트

- [ ] 아이콘 60×60pt, `Colors/Label/Tertiary` 색상
- [ ] 아이콘→타이틀 16pt 간격
- [ ] 타이틀→설명 8pt 간격
- [ ] 설명→버튼 24pt 간격
- [ ] 수평 패딩 40pt, 최대 너비 280pt
- [ ] Staggered 등장 애니메이션 (0.05s 간격)
- [ ] CTA 버튼 높이 50pt, 코너 반경 14pt
- [ ] Safe area 기준 수직 중앙 정렬
- [ ] 다크모드 토큰 대응
- [ ] Dynamic Type 지원
- [ ] 감소된 모션 대응 (`isReduceMotionEnabled`)
- [ ] VoiceOver 아이콘 레이블 설정
- [ ] 3개 variant (Icon Only / Icon+Text / Icon+Text+Button) 구현
