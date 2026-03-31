<p align="center">
  <img src="https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96_2x.png" width="80" alt="iOS 26 icon" />
</p>

<h1 align="center">iOS 26 Design System</h1>

<p align="center">
  <strong>가장 완전한 오픈소스 iOS 26 / iPadOS 26 디자인 시스템</strong><br/>
  토큰, 컴포넌트, 템플릿, 섹션, 페이지 — Apple 공식 Figma Community Kit에서 추출
</p>

<p align="center">
  <a href="https://seunghan91.github.io/ios26-design-system/demo/">🔴 라이브 데모</a> ·
  <a href="./README.md">English</a> · <a href="./README.ja.md">日本語</a> · <a href="./README.zh.md">中文</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/iOS_26-Liquid_Glass-007AFF?style=for-the-badge" alt="iOS 26" />
  <img src="https://img.shields.io/badge/프레임워크-4개-34C759?style=for-the-badge" alt="4 frameworks" />
  <img src="https://img.shields.io/badge/컴포넌트-31개-FF9500?style=for-the-badge" alt="31 components" />
  <img src="https://img.shields.io/badge/페이지-48개-FF2D55?style=for-the-badge" alt="48 pages" />
  <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge" alt="MIT" />
</p>

---

## 왜 만들었나

Apple이 WWDC25에서 **Liquid Glass**와 완전히 새로운 디자인 언어를 발표했습니다. 디자이너들은 Figma 키트를 받았지만, **개발자들은 아무것도 받지 못했습니다.**

이 프로젝트는 그 간극을 메웁니다. 모든 토큰, 모든 컴포넌트 스펙, 모든 레이아웃 규칙을 [공식 Figma Community Kit](https://www.figma.com/community/file/1527721578857867021)에서 추출하여, **4개 프레임워크**에서 **지금 바로** 사용할 수 있는 코드로 변환했습니다.

## 프로젝트 구조

```
ios26-design-system/
├── tokens/                    # 디자인 토큰 (JSON)
│   ├── colors.json            # 79개 변수 × 4모드 (Light/Dark/IC-Light/IC-Dark)
│   ├── typography.json        # 11개 스타일 × 4 변형 + Dynamic Type (7단계)
│   ├── materials.json         # Liquid Glass + Background Material + Scroll Edge
│   ├── spacing.json           # 8pt 그리드, 둥글기, Safe Area, 컴포넌트 치수
│   └── animations.json        # Spring 커브, 지속 시간, Liquid Glass 모핑
│
├── components/specs/          # 31개 컴포넌트 상세 스펙
│   ├── button.md              # 148개 변형 (Content Area + Liquid Glass)
│   ├── tab-bar.md             # iPhone + iPad, Liquid Glass 인디케이터
│   ├── toolbar.md             # Top/Bottom/Sheet/iPad 변형
│   ├── list-row.md            # Row, Swipe, Header, Index Bar
│   ├── sheet.md               # Detent, Liquid Glass 그래버
│   ├── alert.md               # 표준 + 텍스트 필드
│   └── ... (25개 추가)        # Figma 키트의 모든 컴포넌트
│
├── templates/                 # 5개 레이아웃 조합 패턴
│   ├── standard-screen.md     # Status Bar + 네비게이션 + 콘텐츠 + Tab Bar
│   ├── sheet-overlay.md       # Detent 25/50/100%, 키보드 회피
│   ├── navigation-stack.md    # Push/Pop, Large Title 축소
│   ├── tab-bar-layout.md      # Liquid Glass 인디케이터 모핑
│   └── alert-modal.md         # 270pt 카드, scale + fade 애니메이션
│
├── sections/                  # 5개 화면 영역 스펙
│   ├── status-bar.md          # 높이: 54pt (iPhone) / 24pt (iPad)
│   ├── navigation-region.md   # Standard 44pt / Large Title 96pt
│   ├── content-region.md      # Safe Area, 스크롤 동작, 섹션 간격
│   ├── overlay-region.md      # Sheet detent, Alert 위치, 딤밍
│   └── system-region.md       # Home Indicator, Dynamic Island, 키보드
│
├── pages/                     # 48개 완성 화면 레시피
│   ├── iphone-examples/       # 25개 iPhone 화면
│   └── ipad-examples/         # 23개 iPad 화면
│
├── svelte/                    # Svelte 5 구현체
├── svelte-inertia/            # Svelte 5 + Inertia.js + Rails 구현체
├── rails/                     # Rails 8 + Hotwire 구현체
└── flutter/                   # Flutter 3.x 구현체
```

## 프레임워크 지원

| 프레임워크 | 토큰 | 컴포넌트 | 상태 |
|-----------|------|---------|------|
| **Svelte 5** | CSS Custom Properties | Runes mode (`$props()`) | 사용 가능 |
| **Svelte 5 + Inertia.js** | CSS Custom Properties | Svelte 5 + Rails 백엔드 | 사용 가능 |
| **Rails 8 + Hotwire** | CSS + Stimulus | ERB 파셜 + Turbo | 사용 가능 |
| **Flutter 3.x** | Dart 상수 | Material + Cupertino 테마 | 사용 가능 |

## 빠른 시작

### 디자인 토큰 (프레임워크 무관 JSON)

모든 토큰은 `tokens/*.json`에 있으며 어떤 빌드 도구에서든 사용 가능합니다:

```json
// tokens/colors.json — Liquid Glass 블루 액센트
{
  "accents": {
    "blue": {
      "light": "#0088ff",
      "dark": "#0091ff",
      "icLight": "#1e6ef4",
      "icDark": "#5cb8ff"
    }
  }
}
```

### Svelte 5

```css
@import 'ios26/tokens.css';
@import 'ios26/typography.css';
@import 'ios26/materials.css';
```

```svelte
<button class="ios26-button ios26-liquid-glass-sm">
  완료
</button>
```

### Flutter

```dart
import 'theme/ios26/ios26.dart';

MaterialApp(
  theme: iOS26Theme.light(),
  darkTheme: iOS26Theme.dark(),
);
```

### Rails 8

```erb
<%= stylesheet_link_tag "ios26/tokens" %>
<%= render "shared/ios26/toolbar", title: "설정" %>
```

## 컴포넌트 스펙

모든 컴포넌트 스펙에 포함된 항목:

| 항목 | 설명 |
|------|------|
| **치수** | 정확한 width, height, padding (pt 단위) |
| **변형** | 모든 축: Size × Style × State × Mode |
| **토큰 매핑** | 어떤 컬러/타이포그래피 토큰이 어디에 사용되는지 |
| **상태 전환** | Default → Pressed → Disabled |
| **애니메이션** | Spring 커브, 지속 시간, 이징 |
| **접근성** | 최소 44×44pt 터치 타겟, 대비율 |
| **프레임워크별 노트** | 각 프레임워크 구현 힌트 |

### 컴포넌트 목록 (총 31개)

| 분류 | 컴포넌트 |
|------|---------|
| **핵심** | Tab Bar, Toolbar, Button (148개 변형), List Row |
| **피드백** | Alert, Sheet, Notifications, Progress Indicators |
| **컨트롤** | Segmented Control, Toggle, Slider, Stepper, Text Field, Picker |
| **네비게이션** | Sidebar, Menu, Context Menu, Action Sheet, Popover |
| **시스템** | Keyboard, Widget, App Icon, Face ID, Window, System UI |

## Liquid Glass

iOS 26의 핵심 시각 요소입니다. 이 디자인 시스템은 완전한 Liquid Glass 스펙을 포함합니다:

```
Liquid Glass = Frosted blur + Refraction + Depth shadow + Light angle

파라미터 (Figma 변수에서 추출):
├── lightAngle: -45°
├── opacity: 60%
├── refraction: 100%
├── frostRadius: 7px (small) / 12px (medium) / 14px (large)
├── depth: 16
├── splay: 6
└── shadowBlur: 40px (레이어) / 80px (배경)
```

`animations.json`에는 Liquid Glass 모핑 키프레임이 포함되어 있습니다 — 이동 중 늘어나는 "물방울" 탭 인디케이터 애니메이션:

```json
{
  "liquidGlass": {
    "tabIndicator": {
      "duration": 0.45,
      "spring": "snappy",
      "cssApprox": "cubic-bezier(0.34, 1.56, 0.64, 1.0)"
    }
  }
}
```

## 출처

모든 데이터는 Apple의 공식 **iOS & iPadOS 26 Figma Community Kit**에서 추출했습니다.

- **Figma Community Kit**: [iOS & iPadOS 26](https://www.figma.com/community/file/1527721578857867021)
- **Figma File Key**: `pDmGXdYu2k8xlf1SQoU9PW` (Figma API / MCP 접근용)
- **추출 방법**: Figma MCP + 수동 검증
- **모드**: Light, Dark, Increased Contrast Light, Increased Contrast Dark

## 아키텍처

**Atomic Design** 방법론을 따릅니다:

```
Tokens (원자) → Components (분자) → Templates (유기체) → Sections → Pages
```

각 레이어는 하위 레이어를 참조합니다. 컴포넌트 스펙은 토큰 값을 참조하고, 템플릿은 컴포넌트를 조합하며, 페이지는 템플릿을 사용합니다.

## 기여하기

기여를 환영합니다! 도움이 필요한 영역:

- **새 프레임워크**: React Native, SwiftUI 래퍼, Jetpack Compose, Angular
- **다크 모드 개선**: IC (고대비) 모드 검증
- **접근성 감사**: WCAG AAA 준수 확인
- **애니메이션 데모**: 각 프레임워크별 Liquid Glass 라이브 데모
- **추가 페이지**: 실제 앱 화면 레시피 추가

큰 PR을 보내기 전에 이슈를 먼저 열어 논의해 주세요.

## 로드맵

- [ ] NPM 패키지 (`@ios26_design_system/tokens`)
- [ ] pub.dev Dart 패키지
- [ ] Storybook / Histoire 컴포넌트 갤러리
- [ ] 인터랙티브 Liquid Glass 플레이그라운드
- [ ] 토큰 동기화 Figma 플러그인
- [ ] React Native 구현체
- [ ] SwiftUI 래퍼 컴포넌트

## 라이선스

MIT License. [LICENSE](./LICENSE) 참조.

디자인 토큰은 Apple의 공개 Figma Community Kit에서 파생되었습니다. Apple, iOS, iPadOS, Liquid Glass는 Apple Inc.의 상표입니다.

---

<p align="center">
  <a href="https://dcode-labs.com">Dcode Labs</a> 제작<br/>
  <sub>도움이 되셨다면 스타 하나가 다른 분들도 찾는 데 도움됩니다.</sub>
</p>
