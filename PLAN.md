# iOS 26 Design System -- Build Plan & Roadmap

## Goal

Figma Community Kit (iOS & iPadOS 26)에서 추출한 데이터를 기반으로,
4개 프레임워크(Svelte, Rails, Svelte+Inertia, Flutter)에서 즉시 사용 가능한
**완전한 디자인 시스템**을 구축한다.

구축 순서: **Tokens > Components > Templates > Sections > Pages**
(Atomic Design의 atoms > molecules > organisms > templates > pages와 동일)

---

## Reference Chain (문서 참조 원칙)

**Figma MCP 접속은 최후의 수단이다.** 이미 추출/정리해둔 로컬 문서를 1차 소스로 사용한다.

```
참조 순서 (위에서 아래로, 위가 우선):

1. tokens/*.json              <-- 토큰 값이 필요할 때
2. components/specs/*.md      <-- 컴포넌트 스펙이 필요할 때
3. templates/*.md             <-- 조합 패턴이 필요할 때
4. ../figma-ios26-pages.md    <-- Node ID, variant 이름이 필요할 때
5. ../ios26-design-guide.md   <-- 전체 개요가 필요할 때
6. Figma MCP (최후 수단)      <-- 위 문서에 없는 정보만
```

**Figma MCP를 사용해야 하는 경우**:
- 문서에 없는 새로운 컴포넌트 발견 시
- 정확한 픽셀 값 검증이 필요할 때
- 스크린샷 캡처가 필요할 때
- Dark mode 등 아직 추출하지 않은 토큰

**모든 문서 상단에 이 레퍼런스 블록을 포함**:
```markdown
> **References**
> - Tokens: `../../tokens/colors.json`, `../../tokens/typography.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="...")`
```

---

## Source

- **Figma File**: `pDmGXdYu2k8xlf1SQoU9PW`
- **URL**: https://www.figma.com/design/pDmGXdYu2k8xlf1SQoU9PW/iOS-and-iPadOS-26--Community-
- **Raw Inventory**: `../figma-ios26-pages.md` (전체 컴포넌트 variant 사전 구조화 완료)
- **Current Guide**: `../ios26-design-guide.md` (Phase 1 초안)

---

## Directory Structure

```
docs/ios26-design/
  PLAN.md                  <-- 이 문서 (계획서 + 로드맵)
  PROGRESS.md              <-- Phase별 진행 상태 추적

  # Phase별 공통 산출물 (framework-agnostic)
  tokens/
    colors.json            <-- Phase 1: 전체 컬러 토큰 (Light + Dark)
    typography.json        <-- Phase 1: 타이포그래피 토큰
    materials.json         <-- Phase 1: Liquid Glass + Blur 토큰
    spacing.json           <-- Phase 1: 간격/레이아웃 토큰
    animations.json        <-- Phase 1: 애니메이션 curve/duration 토큰

  components/
    specs/                 <-- Phase 2: 컴포넌트 상세 스펙
      toolbar.md
      tab-bar.md
      list-row.md
      button.md
      alert.md
      sheet.md
      ...
    screenshots/           <-- Phase 2: Figma 스크린샷 캡처

  templates/               <-- Phase 3: 조합 패턴
    standard-screen.md
    sheet-overlay.md
    ipad-split-view.md
    grouped-list.md
    ...

  sections/                <-- Phase 4: 화면 영역 스펙
    status-bar.md
    navigation-region.md
    content-region.md
    overlay-region.md
    system-region.md

  pages/                   <-- Phase 5: 완성 화면 레시피
    iphone-examples/
    ipad-examples/

  # Framework별 구현체
  svelte/                  <-- Phase 1 완료
  rails/                   <-- Phase 1 완료
  svelte-inertia/          <-- Phase 1 진행 중
  flutter/                 <-- Phase 1 완료
```

---

## Phases

### Phase 1: Design Tokens (완전한 토큰 추출)

**목표**: Figma에서 추출 가능한 모든 디자인 토큰을 JSON으로 저장하고, 4개 프레임워크별 구현체에 반영

**산출물**:
- `tokens/colors.json` -- Light/Dark 모드 전체 (50+ 토큰)
- `tokens/typography.json` -- 11 스타일 x 4 variant + Loose Leading
- `tokens/materials.json` -- Liquid Glass 3 사이즈 + Background Material 5단계 + Scroll Edge
- `tokens/spacing.json` -- 간격, padding, corner radius, safe area
- `tokens/animations.json` -- Spring curves, duration, easing (Apple HIG 기반)

**작업 목록**:
| # | Task | Source | Status |
|---|------|--------|--------|
| 1.1 | Dark mode 컬러 전체 추출 | Figma `getLocalPaintStyles()` + variables | TODO |
| 1.2 | Spacing/Radius 토큰 추출 | Figma 컴포넌트 padding 분석 | TODO |
| 1.3 | Animation 토큰 정의 | Apple HIG + WWDC 25 참조 | TODO |
| 1.4 | JSON 파일 생성 (5개) | 위 데이터 통합 | TODO |
| 1.5 | 프레임워크별 토큰 파일 업데이트 | svelte/rails/flutter 반영 | TODO |

**완료 기준**:
- [ ] Light + Dark 모든 컬러 토큰이 JSON에 존재
- [ ] 프레임워크별 토큰 파일이 JSON과 1:1 매핑
- [ ] 누락된 토큰 0개

---

### Phase 2: Components (컴포넌트 상세 스펙)

**목표**: 각 UI 컴포넌트의 정확한 치수, 상태, 간격을 문서화하고, 프레임워크별 구현 가이드 완성

**산출물**:
- `components/specs/*.md` -- 컴포넌트별 상세 스펙
- `components/screenshots/` -- Figma 스크린샷
- 프레임워크별 `components.md` 업데이트

**컴포넌트 우선순위** (사용 빈도 기준):

| Priority | Component | Variant 수 | 복잡도 |
|----------|-----------|-----------|--------|
| P0 | Toolbar (Top/Bottom) | 29 | High |
| P0 | Tab Bar (iPhone/iPad) | 16+1 | High -- Liquid Glass animation |
| P0 | List Row / Header | 12 | Medium |
| P0 | Button (Content Area + Liquid Glass) | 144+4 | High |
| P1 | Alert | 2 | Low |
| P1 | Sheet (Full/Inspector/iPad) | 4 | Medium |
| P1 | Segmented Control | 14 | Medium |
| P1 | Notification | 5 | Medium |
| P2 | Pickers (Date/Time) | 2+5 | Medium |
| P2 | Sliders | 5 | Low |
| P2 | Toggles | 2 | Low |
| P2 | Steppers | 3+3 | Low |
| P2 | Text Fields | 4 | Low |
| P2 | Progress Indicators | 11+2 | Low |
| P3 | Popovers (iPad) | 12 | Medium |
| P3 | Context Menu | 4 | Medium |
| P3 | Activity View (Share) | 2+9 | High |
| P3 | Sidebars (iPad) | 12+40+ | High |
| P3 | Keyboards | 33 | Reference only |

**각 컴포넌트 스펙 포함 항목**:
```
1. 개요 + Figma 스크린샷
2. 치수 (width, height, padding, margin)
3. Variant 축 (Size x Style x State x Mode)
4. 컬러 토큰 매핑 (어떤 토큰을 어디에)
5. 타이포그래피 매핑
6. 상태 전환 (Default -> Pressed -> Disabled)
7. 애니메이션 (transition, spring)
8. 접근성 (min touch target 44x44, contrast)
9. 프레임워크별 구현 노트
```

**완료 기준**:
- [ ] P0 컴포넌트 4개 상세 스펙 완료
- [ ] P1 컴포넌트 4개 상세 스펙 완료
- [ ] 각 스펙에 Figma 스크린샷 포함
- [ ] 프레임워크별 구현 가이드 업데이트

---

### Phase 3: Templates (조합 패턴)

**목표**: 컴포넌트를 조합하여 재사용 가능한 화면 패턴을 정의

**산출물**: `templates/*.md`

**템플릿 목록**:

| Template | 구성 요소 | 용도 |
|----------|----------|------|
| Standard iPhone Screen | Toolbar-Top + Content + TabBar | 기본 앱 화면 |
| Sheet Overlay | Grabber + Toolbar-Sheet + Content | 모달 시트 |
| iPad Split View | Sidebar + Toolbar-Top + Content | iPad 마스터-디테일 |
| Grouped List Screen | Toolbar + Sections + Rows + Footers | 설정/폼 화면 |
| Alert Flow | Screen + Dimming + Alert | 확인 다이얼로그 |
| Share Flow | Screen + Dimming + Activity View | 공유 시트 |
| Search Screen | Toolbar + Search Bar + Results List | 검색 화면 |
| Empty State | Toolbar + Empty States component | 빈 상태 |
| Notification Stack | StatusBar + Notifications (1-3) | 알림 표시 |

**각 템플릿 포함 항목**:
```
1. 와이어프레임 (ASCII + 스크린샷)
2. 컴포넌트 조합 규칙 (순서, 간격)
3. 반응형 규칙 (iPhone vs iPad)
4. 스크롤 동작 (large title collapse, scroll edge effect)
5. 전환 애니메이션 (push, sheet present, fade)
6. 프레임워크별 레이아웃 코드
```

**완료 기준**:
- [ ] 9개 템플릿 스펙 완료
- [ ] 프레임워크별 레이아웃 코드 포함
- [ ] iPhone/iPad 양쪽 커버

---

### Phase 4: Sections (화면 영역 스펙)

**목표**: 화면을 구성하는 5개 영역의 정확한 레이아웃 규칙 정의

**산출물**: `sections/*.md`

| Section | 핵심 스펙 |
|---------|----------|
| Status Bar | 높이 (iPhone 54pt, iPad 24pt), 콘텐츠, 색상 규칙 |
| Navigation Region | Toolbar 높이 (44/96pt), large title 동작, back 버튼 규칙 |
| Content Region | Safe area insets, scroll 동작, section 간격, 최소 row 높이 |
| Overlay Region | Sheet detents, Alert 위치, Context Menu 배치, 딤밍 규칙 |
| System Region | Home Indicator (5x134pt), Dynamic Island, Keyboard 높이 |

**완료 기준**:
- [ ] 5개 영역 스펙 완료
- [ ] 모든 pt 값이 Figma에서 검증됨
- [ ] 프레임워크별 safe area / inset 처리 가이드

---

### Phase 5: Pages (완성 화면 레시피)

**목표**: Figma Examples 페이지의 45개 화면을 분석하고, 재현 가능한 레시피로 문서화

**산출물**: `pages/iphone-examples/`, `pages/ipad-examples/`

**작업**:
| # | Task |
|---|------|
| 5.1 | iPhone Examples 25개 스크린샷 캡처 + 분석 |
| 5.2 | iPad Examples 20개 스크린샷 캡처 + 분석 |
| 5.3 | 각 화면을 Template + Components로 분해 |
| 5.4 | 프레임워크별 전체 화면 코드 예제 (주요 5개) |

**각 페이지 레시피 포함 항목**:
```
1. Figma 스크린샷
2. 사용된 Template 이름
3. 사용된 Components 목록 (node ID 포함)
4. 레이아웃 구조 (계층)
5. 특이 사항 / 커스터마이징 포인트
```

**완료 기준**:
- [ ] 45개 화면 분석 완료
- [ ] 주요 5개 화면 프레임워크별 코드 예제
- [ ] 모든 화면이 Template + Components로 분해 가능

---

## Timeline

```
Phase 1: Tokens        ████████░░  현재 80% -> 100% 목표
Phase 2: Components    ░░░░░░░░░░  P0 4개 -> P1 4개 -> P2/P3
Phase 3: Templates     ░░░░░░░░░░  Phase 2 P0 완료 후 시작
Phase 4: Sections      ░░░░░░░░░░  Phase 2/3 병행 가능
Phase 5: Pages         ░░░░░░░░░░  Phase 3/4 완료 후 시작
```

**의존성**:
```
Phase 1 (Tokens) ──> Phase 2 (Components) ──> Phase 3 (Templates)
                                           ──> Phase 4 (Sections)
                                                      |
                                                      v
                                               Phase 5 (Pages)
```

---

## Quality Gates

각 Phase 완료 시 검증:

1. **Figma 일치성**: 추출한 값이 Figma 원본과 일치하는지 스크린샷 비교
2. **프레임워크 동작**: 각 프레임워크에서 토큰/컴포넌트가 올바르게 렌더링
3. **Dark Mode**: Light/Dark 양쪽 토큰이 빠짐없이 정의
4. **접근성**: WCAG AA 대비율 4.5:1, 터치 타겟 44x44pt 준수
5. **크로스 참조**: 상위 Level에서 하위 Level 토큰을 정확히 참조

---

## Conventions

- **Node ID 표기**: `nodeId` 형식 (예: `507:24689`)
- **토큰 이름**: Figma 로컬 스타일 이름 그대로 (예: `Colors/Blue`, `Labels/Primary`)
- **프레임워크별 매핑**: JSON 토큰 -> CSS var / Dart const / ERB helper
- **스크린샷**: `get_screenshot(fileKey, nodeId)` 로 캡처, `components/screenshots/` 저장
- **커밋**: Phase별 완료 시 커밋 (예: `docs: complete Phase 1 - design tokens`)
